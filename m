Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751082AbeCHWzo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 17:55:44 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54670 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeCHWzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 17:55:42 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F3F0B6022C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Thu, 8 Mar 2018 15:55:40 -0700
From: Lina Iyer <ilina@codeaurora.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/10] drivers: qcom: rpmh: add support for batch RPMH
 request
Message-ID: <20180308225540.GB3577@codeaurora.org>
References: <20180302164317.10554-1-ilina@codeaurora.org>
 <20180302164317.10554-10-ilina@codeaurora.org>
 <152054637377.219802.5175262314364284431@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <152054637377.219802.5175262314364284431@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08 2018 at 14:59 -0700, Stephen Boyd wrote:
>Quoting Lina Iyer (2018-03-02 08:43:16)
>> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
>> index a02d9f685b2b..19e84b031c0d 100644
>> --- a/drivers/soc/qcom/rpmh.c
>> +++ b/drivers/soc/qcom/rpmh.c
>> @@ -22,6 +22,7 @@
>>
>>  #define RPMH_MAX_MBOXES                        2
>>  #define RPMH_TIMEOUT                   (10 * HZ)
>> +#define RPMH_MAX_REQ_IN_BATCH          10
>
>Is 10 some software limit? Or hardware always has 10 available?
>
Arbitary s/w limit.

>>
>>  #define DEFINE_RPMH_MSG_ONSTACK(rc, s, q, c, name)     \
>>         struct rpmh_request name = {                    \
>> @@ -81,12 +82,14 @@ struct rpmh_request {
>>   * @cache: the list of cached requests
>>   * @lock: synchronize access to the controller data
>>   * @dirty: was the cache updated since flush
>> + * @batch_cache: Cache sleep and wake requests sent as batch
>>   */
>>  struct rpmh_ctrlr {
>>         struct rsc_drv *drv;
>>         struct list_head cache;
>>         spinlock_t lock;
>>         bool dirty;
>> +       struct rpmh_request *batch_cache[2 * RPMH_MAX_REQ_IN_BATCH];
>
>Can it be const?
>
Yes, fixed.

>>  };
>>
>>  /**
>> @@ -343,6 +346,146 @@ int rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
>>  }
>>  EXPORT_SYMBOL(rpmh_write);
>>
>> +static int cache_batch(struct rpmh_client *rc,
>> +                     struct rpmh_request **rpm_msg, int count)
>> +{
>> +       struct rpmh_ctrlr *rpm = rc->ctrlr;
>> +       unsigned long flags;
>> +       int ret = 0;
>> +       int index = 0;
>> +       int i;
>> +
>> +       spin_lock_irqsave(&rpm->lock, flags);
>> +       while (rpm->batch_cache[index])
>
>If batch_cache is full.
>And if adjacent memory has bits set....
>
>This loop can go forever?
>
>Please add bounds.
>
How so? The if() below will ensure that it will not exceed bounds.

>> +               index++;
>> +       if (index + count >=  2 * RPMH_MAX_REQ_IN_BATCH) {
>> +               ret = -ENOMEM;
>> +               goto fail;
>> +       }
>> +
>> +       for (i = 0; i < count; i++)
>> +               rpm->batch_cache[index + i] = rpm_msg[i];
>> +fail:
>> +       spin_unlock_irqrestore(&rpm->lock, flags);
>> +
>> +       return ret;
>> +}
>> +
>[...]
>> +static void invalidate_batch(struct rpmh_client *rc)
>> +{
>> +       struct rpmh_ctrlr *rpm = rc->ctrlr;
>> +       unsigned long flags;
>> +       int index = 0;
>> +       int i;
>> +
>> +       spin_lock_irqsave(&rpm->lock, flags);
>> +       while (rpm->batch_cache[index])
>> +               index++;
>> +       for (i = 0; i < index; i++) {
>> +               kfree(rpm->batch_cache[i]->free);
>> +               rpm->batch_cache[i] = NULL;
>> +       }
>> +       spin_unlock_irqrestore(&rpm->lock, flags);
>> +}
>> +
>> +/**
>> + * rpmh_write_batch: Write multiple sets of RPMH commands and wait for the
>> + * batch to finish.
>> + *
>> + * @rc: The RPMh handle got from rpmh_get_dev_channel
>
>Is the API called rpmh_get_dev_channel()?
>
Old code. Will fix in this and other places.

>> + * @state: Active/sleep set
>> + * @cmd: The payload data
>> + * @n: The array of count of elements in each batch, 0 terminated.
>> + *
>> + * Write a request to the mailbox controller without caching. If the request
>> + * state is ACTIVE, then the requests are treated as completion request
>> + * and sent to the controller immediately. The function waits until all the
>> + * commands are complete. If the request was to SLEEP or WAKE_ONLY, then the
>> + * request is sent as fire-n-forget and no ack is expected.
>> + *
>> + * May sleep. Do not call from atomic contexts for ACTIVE_ONLY requests.
>> + */
>> +int rpmh_write_batch(struct rpmh_client *rc, enum rpmh_state state,
>> +                   struct tcs_cmd *cmd, int *n)
>
>I'm lost why n is a pointer, and cmd is not a double pointer if n stays
>as a pointer. Are there clients calling this API with a contiguous chunk
>of commands but then they want to break that chunk up into many
>requests?
>
That is correct. Clients want to provide a big buffer that this API will
break it up into requests specified in *n.

>Maybe I've lost track of commands and requests and how they
>differ.
>

>> +{
>> +       struct rpmh_request *rpm_msg[RPMH_MAX_REQ_IN_BATCH] = { NULL };
>> +       DECLARE_COMPLETION_ONSTACK(compl);
>> +       atomic_t wait_count = ATOMIC_INIT(0); /* overwritten */
>> +       int count = 0;
>> +       int ret, i, j;
>> +
>> +       if (IS_ERR_OR_NULL(rc) || !cmd || !n)
>> +               return -EINVAL;
>> +
>> +       while (n[count++] > 0)
>> +               ;
>> +       count--;
>> +       if (!count || count > RPMH_MAX_REQ_IN_BATCH)
>> +               return -EINVAL;
>> +
>> +       /* Create async request batches */
>> +       for (i = 0; i < count; i++) {
>> +               rpm_msg[i] = __get_rpmh_msg_async(rc, state, cmd, n[i]);
>> +               if (IS_ERR_OR_NULL(rpm_msg[i])) {
>> +                       for (j = 0 ; j < i; j++)
>
>Weird space before that ;
>
Ok.
>Also, why not use 'i' again and decrement? ret could be assigned
>PTR_ERR() value and make the next potential problem go away.
>
Ok
>> +                               kfree(rpm_msg[j]->free);
>
>I hope rpm_msg[j]->free doesn't point to rpm_msg[i] here.
>
It doesn't.
>> +                       return PTR_ERR(rpm_msg[i]);
>> +               }
>> +               cmd += n[i];
>> +       }
>> +
>> +       /* Send if Active and wait for the whole set to complete */
>> +       if (state == RPMH_ACTIVE_ONLY_STATE) {
>> +               might_sleep();
>> +               atomic_set(&wait_count, count);
>
>Aha, here's the wait counter.
>
:)
I am removing it from the earlier patch and introducing the wait_count
here. Not bad as I though.

>> +               for (i = 0; i < count; i++) {
>> +                       rpm_msg[i]->completion = &compl;
>> +                       rpm_msg[i]->wait_count = &wait_count;
>
>But then we just assign the same count and completion to each rpm_msg?
>Why? Can't we just put the completion on the final one and have the
>completion called there?
>
The order of the responses is not gauranteed to be sequential and in the
order it was sent. So we have to do this.

>> +                       /* Bypass caching and write to mailbox directly */
>> +                       ret = rpmh_rsc_send_data(rc->ctrlr->drv,
>> +                                               &rpm_msg[i]->msg);
>> +                       if (ret < 0) {
>> +                               pr_err(
>> +                               "Error(%d) sending RPMH message addr=0x%x\n",
>> +                               ret, rpm_msg[i]->msg.payload[0].addr);
>> +                               break;
>> +                       }
>> +               }
>> +               /* For those unsent requests, spoof tx_done */
>
>Why? Comments shouldn't say what the code is doing, but explain why
>things don't make sense.
>
Will remove..

Thanks,
Lina
