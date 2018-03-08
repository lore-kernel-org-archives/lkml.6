Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751143AbeCHV7k (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 16:59:40 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36842 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbeCHV7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 16:59:35 -0500
X-Google-Smtp-Source: AG47ELvSWomoUUMi6DR7UaLR0yySj6Sdw2Y/0O0M4voYhR1+V5Zy+psiwpwwD2uj0hltL111NdgFbQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Lina Iyer <ilina@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180302164317.10554-10-ilina@codeaurora.org>
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
References: <20180302164317.10554-1-ilina@codeaurora.org>
 <20180302164317.10554-10-ilina@codeaurora.org>
Message-ID: <152054637377.219802.5175262314364284431@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 09/10] drivers: qcom: rpmh: add support for batch RPMH request
Date: Thu, 08 Mar 2018 13:59:33 -0800
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w28LxlYk004585

Quoting Lina Iyer (2018-03-02 08:43:16)
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index a02d9f685b2b..19e84b031c0d 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -22,6 +22,7 @@
>  
>  #define RPMH_MAX_MBOXES                        2
>  #define RPMH_TIMEOUT                   (10 * HZ)
> +#define RPMH_MAX_REQ_IN_BATCH          10

Is 10 some software limit? Or hardware always has 10 available?

>  
>  #define DEFINE_RPMH_MSG_ONSTACK(rc, s, q, c, name)     \
>         struct rpmh_request name = {                    \
> @@ -81,12 +82,14 @@ struct rpmh_request {
>   * @cache: the list of cached requests
>   * @lock: synchronize access to the controller data
>   * @dirty: was the cache updated since flush
> + * @batch_cache: Cache sleep and wake requests sent as batch
>   */
>  struct rpmh_ctrlr {
>         struct rsc_drv *drv;
>         struct list_head cache;
>         spinlock_t lock;
>         bool dirty;
> +       struct rpmh_request *batch_cache[2 * RPMH_MAX_REQ_IN_BATCH];

Can it be const?

>  };
>  
>  /**
> @@ -343,6 +346,146 @@ int rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
>  }
>  EXPORT_SYMBOL(rpmh_write);
>  
> +static int cache_batch(struct rpmh_client *rc,
> +                     struct rpmh_request **rpm_msg, int count)
> +{
> +       struct rpmh_ctrlr *rpm = rc->ctrlr;
> +       unsigned long flags;
> +       int ret = 0;
> +       int index = 0;
> +       int i;
> +
> +       spin_lock_irqsave(&rpm->lock, flags);
> +       while (rpm->batch_cache[index])

If batch_cache is full.
And if adjacent memory has bits set....

This loop can go forever?

Please add bounds.

> +               index++;
> +       if (index + count >=  2 * RPMH_MAX_REQ_IN_BATCH) {
> +               ret = -ENOMEM;
> +               goto fail;
> +       }
> +
> +       for (i = 0; i < count; i++)
> +               rpm->batch_cache[index + i] = rpm_msg[i];
> +fail:
> +       spin_unlock_irqrestore(&rpm->lock, flags);
> +
> +       return ret;
> +}
> +
[...]
> +static void invalidate_batch(struct rpmh_client *rc)
> +{
> +       struct rpmh_ctrlr *rpm = rc->ctrlr;
> +       unsigned long flags;
> +       int index = 0;
> +       int i;
> +
> +       spin_lock_irqsave(&rpm->lock, flags);
> +       while (rpm->batch_cache[index])
> +               index++;
> +       for (i = 0; i < index; i++) {
> +               kfree(rpm->batch_cache[i]->free);
> +               rpm->batch_cache[i] = NULL;
> +       }
> +       spin_unlock_irqrestore(&rpm->lock, flags);
> +}
> +
> +/**
> + * rpmh_write_batch: Write multiple sets of RPMH commands and wait for the
> + * batch to finish.
> + *
> + * @rc: The RPMh handle got from rpmh_get_dev_channel

Is the API called rpmh_get_dev_channel()?

> + * @state: Active/sleep set
> + * @cmd: The payload data
> + * @n: The array of count of elements in each batch, 0 terminated.
> + *
> + * Write a request to the mailbox controller without caching. If the request
> + * state is ACTIVE, then the requests are treated as completion request
> + * and sent to the controller immediately. The function waits until all the
> + * commands are complete. If the request was to SLEEP or WAKE_ONLY, then the
> + * request is sent as fire-n-forget and no ack is expected.
> + *
> + * May sleep. Do not call from atomic contexts for ACTIVE_ONLY requests.
> + */
> +int rpmh_write_batch(struct rpmh_client *rc, enum rpmh_state state,
> +                   struct tcs_cmd *cmd, int *n)

I'm lost why n is a pointer, and cmd is not a double pointer if n stays
as a pointer. Are there clients calling this API with a contiguous chunk
of commands but then they want to break that chunk up into many
requests? Maybe I've lost track of commands and requests and how they
differ.

> +{
> +       struct rpmh_request *rpm_msg[RPMH_MAX_REQ_IN_BATCH] = { NULL };
> +       DECLARE_COMPLETION_ONSTACK(compl);
> +       atomic_t wait_count = ATOMIC_INIT(0); /* overwritten */
> +       int count = 0;
> +       int ret, i, j;
> +
> +       if (IS_ERR_OR_NULL(rc) || !cmd || !n)
> +               return -EINVAL;
> +
> +       while (n[count++] > 0)
> +               ;
> +       count--;
> +       if (!count || count > RPMH_MAX_REQ_IN_BATCH)
> +               return -EINVAL;
> +
> +       /* Create async request batches */
> +       for (i = 0; i < count; i++) {
> +               rpm_msg[i] = __get_rpmh_msg_async(rc, state, cmd, n[i]);
> +               if (IS_ERR_OR_NULL(rpm_msg[i])) {
> +                       for (j = 0 ; j < i; j++)

Weird space before that ;

Also, why not use 'i' again and decrement? ret could be assigned
PTR_ERR() value and make the next potential problem go away.

> +                               kfree(rpm_msg[j]->free);

I hope rpm_msg[j]->free doesn't point to rpm_msg[i] here.

> +                       return PTR_ERR(rpm_msg[i]);
> +               }
> +               cmd += n[i];
> +       }
> +
> +       /* Send if Active and wait for the whole set to complete */
> +       if (state == RPMH_ACTIVE_ONLY_STATE) {
> +               might_sleep();
> +               atomic_set(&wait_count, count);

Aha, here's the wait counter.

> +               for (i = 0; i < count; i++) {
> +                       rpm_msg[i]->completion = &compl;
> +                       rpm_msg[i]->wait_count = &wait_count;

But then we just assign the same count and completion to each rpm_msg?
Why? Can't we just put the completion on the final one and have the
completion called there?

> +                       /* Bypass caching and write to mailbox directly */
> +                       ret = rpmh_rsc_send_data(rc->ctrlr->drv,
> +                                               &rpm_msg[i]->msg);
> +                       if (ret < 0) {
> +                               pr_err(
> +                               "Error(%d) sending RPMH message addr=0x%x\n",
> +                               ret, rpm_msg[i]->msg.payload[0].addr);
> +                               break;
> +                       }
> +               }
> +               /* For those unsent requests, spoof tx_done */

Why? Comments shouldn't say what the code is doing, but explain why
things don't make sense.

> +               for (j = i; j < count; j++)
> +                       rpmh_tx_done(&rpm_msg[j]->msg, ret);
> +               return wait_for_tx_done(rc, &compl, cmd[0].addr, cmd[0].data);
> +       }
> +
> +       /*
> +        * Cache sleep/wake data in store.
> +        * But flush batch first before flushing all other data.
> +        */
> +       return cache_batch(rc, rpm_msg, count);
