Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752427AbeCZPbD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 11:31:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50432 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752374AbeCZPbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 11:31:01 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E141D603AF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Mon, 26 Mar 2018 09:30:59 -0600
From: Lina Iyer <ilina@codeaurora.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/10] drivers: qcom: rpmh: add support for batch RPMH
 request
Message-ID: <20180326153059.GB22084@codeaurora.org>
References: <20180302164317.10554-1-ilina@codeaurora.org>
 <20180302164317.10554-10-ilina@codeaurora.org>
 <152054637377.219802.5175262314364284431@swboyd.mtv.corp.google.com>
 <20180308225540.GB3577@codeaurora.org>
 <152121964417.179821.6748540781312701645@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <152121964417.179821.6748540781312701645@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16 2018 at 11:00 -0600, Stephen Boyd wrote:
>Quoting Lina Iyer (2018-03-08 14:55:40)
>> On Thu, Mar 08 2018 at 14:59 -0700, Stephen Boyd wrote:
>> >Quoting Lina Iyer (2018-03-02 08:43:16)
>> >> @@ -343,6 +346,146 @@ int rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
>> >>  }
>> >>  EXPORT_SYMBOL(rpmh_write);
>> >>
>> >> +static int cache_batch(struct rpmh_client *rc,
>> >> +                     struct rpmh_request **rpm_msg, int count)
>> >> +{
>> >> +       struct rpmh_ctrlr *rpm = rc->ctrlr;
>> >> +       unsigned long flags;
>> >> +       int ret = 0;
>> >> +       int index = 0;
>> >> +       int i;
>> >> +
>> >> +       spin_lock_irqsave(&rpm->lock, flags);
>> >> +       while (rpm->batch_cache[index])
>> >
>> >If batch_cache is full.
>> >And if adjacent memory has bits set....
>> >
>> >This loop can go forever?
>> >
>> >Please add bounds.
>> >
>> How so? The if() below will ensure that it will not exceed bounds.
>
>Right, the if below will make sure we don't run off the end, but unless
>rpm->batch_cache has a sentinel at the end we can't guarantee we won't
>run off the end of the array and into some other portion of memory that
>also has a bit set in a word. And then we may read into some unallocated
>space. Or maybe I missed something.
>
The rpmh_write_batch checks to make sure the number of requests do not
exceed the max and would not exceed the value. This is ensured by the
write_batch request.
A write_batch follows an invalidate and therefore would ensure that that
the batch_cache does not overflow, but I can add a simple check, though
its unnecessary with the general use of this API.

>>
>> >> +               index++;
>> >> +       if (index + count >=  2 * RPMH_MAX_REQ_IN_BATCH) {
>> >> +               ret = -ENOMEM;
>> >> +               goto fail;
>> >> +       }
>> >> +
>> >> +       for (i = 0; i < count; i++)
>> >> +               rpm->batch_cache[index + i] = rpm_msg[i];
>> >> +fail:
>> >> +       spin_unlock_irqrestore(&rpm->lock, flags);
>> >> +
>> >> +       return ret;
>> >> +}
>> >> +
>>
>> >> + * @state: Active/sleep set
>> >> + * @cmd: The payload data
>> >> + * @n: The array of count of elements in each batch, 0 terminated.
>> >> + *
>> >> + * Write a request to the mailbox controller without caching. If the request
>> >> + * state is ACTIVE, then the requests are treated as completion request
>> >> + * and sent to the controller immediately. The function waits until all the
>> >> + * commands are complete. If the request was to SLEEP or WAKE_ONLY, then the
>> >> + * request is sent as fire-n-forget and no ack is expected.
>> >> + *
>> >> + * May sleep. Do not call from atomic contexts for ACTIVE_ONLY requests.
>> >> + */
>> >> +int rpmh_write_batch(struct rpmh_client *rc, enum rpmh_state state,
>> >> +                   struct tcs_cmd *cmd, int *n)
>> >
>> >I'm lost why n is a pointer, and cmd is not a double pointer if n stays
>> >as a pointer. Are there clients calling this API with a contiguous chunk
>> >of commands but then they want to break that chunk up into many
>> >requests?
>> >
>> That is correct. Clients want to provide a big buffer that this API will
>> break it up into requests specified in *n.
>
>Is that for bus scaling?
>
Yes.

>> >> +               /* For those unsent requests, spoof tx_done */
>> >
>> >Why? Comments shouldn't say what the code is doing, but explain why
>> >things don't make sense.
>> >
>> Will remove..
>>
>
>Oh, I was hoping for more details, not less.
Hmm.. I thought it was fairly obvious that we spoof tx_done so we could
complete when the wait_count reaches 0. I will add that to the comments.

Thanks,
Lina
