Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753687AbeCPRAt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:00:49 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33889 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbeCPRAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:00:46 -0400
X-Google-Smtp-Source: AG47ELuvQSjCtEr38SPJL7vgnmDE21rKhW4Qbtp8ZGbv3N1zwus39p1/9fjszr3aKXA/AvbmiiIiCg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Lina Iyer <ilina@codeaurora.org>
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180308225540.GB3577@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org
References: <20180302164317.10554-1-ilina@codeaurora.org>
 <20180302164317.10554-10-ilina@codeaurora.org>
 <152054637377.219802.5175262314364284431@swboyd.mtv.corp.google.com>
 <20180308225540.GB3577@codeaurora.org>
Message-ID: <152121964417.179821.6748540781312701645@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 09/10] drivers: qcom: rpmh: add support for batch RPMH request
Date: Fri, 16 Mar 2018 10:00:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2GIFQsV031560

Quoting Lina Iyer (2018-03-08 14:55:40)
> On Thu, Mar 08 2018 at 14:59 -0700, Stephen Boyd wrote:
> >Quoting Lina Iyer (2018-03-02 08:43:16)
> >> @@ -343,6 +346,146 @@ int rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
> >>  }
> >>  EXPORT_SYMBOL(rpmh_write);
> >>
> >> +static int cache_batch(struct rpmh_client *rc,
> >> +                     struct rpmh_request **rpm_msg, int count)
> >> +{
> >> +       struct rpmh_ctrlr *rpm = rc->ctrlr;
> >> +       unsigned long flags;
> >> +       int ret = 0;
> >> +       int index = 0;
> >> +       int i;
> >> +
> >> +       spin_lock_irqsave(&rpm->lock, flags);
> >> +       while (rpm->batch_cache[index])
> >
> >If batch_cache is full.
> >And if adjacent memory has bits set....
> >
> >This loop can go forever?
> >
> >Please add bounds.
> >
> How so? The if() below will ensure that it will not exceed bounds.

Right, the if below will make sure we don't run off the end, but unless
rpm->batch_cache has a sentinel at the end we can't guarantee we won't
run off the end of the array and into some other portion of memory that
also has a bit set in a word. And then we may read into some unallocated
space. Or maybe I missed something.

> 
> >> +               index++;
> >> +       if (index + count >=  2 * RPMH_MAX_REQ_IN_BATCH) {
> >> +               ret = -ENOMEM;
> >> +               goto fail;
> >> +       }
> >> +
> >> +       for (i = 0; i < count; i++)
> >> +               rpm->batch_cache[index + i] = rpm_msg[i];
> >> +fail:
> >> +       spin_unlock_irqrestore(&rpm->lock, flags);
> >> +
> >> +       return ret;
> >> +}
> >> +
> 
> >> + * @state: Active/sleep set
> >> + * @cmd: The payload data
> >> + * @n: The array of count of elements in each batch, 0 terminated.
> >> + *
> >> + * Write a request to the mailbox controller without caching. If the request
> >> + * state is ACTIVE, then the requests are treated as completion request
> >> + * and sent to the controller immediately. The function waits until all the
> >> + * commands are complete. If the request was to SLEEP or WAKE_ONLY, then the
> >> + * request is sent as fire-n-forget and no ack is expected.
> >> + *
> >> + * May sleep. Do not call from atomic contexts for ACTIVE_ONLY requests.
> >> + */
> >> +int rpmh_write_batch(struct rpmh_client *rc, enum rpmh_state state,
> >> +                   struct tcs_cmd *cmd, int *n)
> >
> >I'm lost why n is a pointer, and cmd is not a double pointer if n stays
> >as a pointer. Are there clients calling this API with a contiguous chunk
> >of commands but then they want to break that chunk up into many
> >requests?
> >
> That is correct. Clients want to provide a big buffer that this API will
> break it up into requests specified in *n.

Is that for bus scaling?

> >> +                       return PTR_ERR(rpm_msg[i]);
> >> +               }
> >> +               cmd += n[i];
> >> +       }
> >> +
> >> +       /* Send if Active and wait for the whole set to complete */
> >> +       if (state == RPMH_ACTIVE_ONLY_STATE) {
> >> +               might_sleep();
> >> +               atomic_set(&wait_count, count);
> >
> >Aha, here's the wait counter.
> >
> :)
> I am removing it from the earlier patch and introducing the wait_count
> here. Not bad as I though.

Thanks!

> 
> >> +               for (i = 0; i < count; i++) {
> >> +                       rpm_msg[i]->completion = &compl;
> >> +                       rpm_msg[i]->wait_count = &wait_count;
> >
> >But then we just assign the same count and completion to each rpm_msg?
> >Why? Can't we just put the completion on the final one and have the
> >completion called there?
> >
> The order of the responses is not gauranteed to be sequential and in the
> order it was sent. So we have to do this.

OK! That is sad.

> 
> >> +                       /* Bypass caching and write to mailbox directly */
> >> +                       ret = rpmh_rsc_send_data(rc->ctrlr->drv,
> >> +                                               &rpm_msg[i]->msg);
> >> +                       if (ret < 0) {
> >> +                               pr_err(
> >> +                               "Error(%d) sending RPMH message addr=0x%x\n",
> >> +                               ret, rpm_msg[i]->msg.payload[0].addr);
> >> +                               break;
> >> +                       }
> >> +               }
> >> +               /* For those unsent requests, spoof tx_done */
> >
> >Why? Comments shouldn't say what the code is doing, but explain why
> >things don't make sense.
> >
> Will remove..
> 

Oh, I was hoping for more details, not less.
