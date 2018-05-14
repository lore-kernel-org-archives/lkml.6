Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbeENT7e (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 15:59:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33606 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbeENT7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 15:59:32 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 51FD1601EA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Mon, 14 May 2018 13:59:29 -0600
From: Lina Iyer <ilina@codeaurora.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, rplsssn@codeaurora.org
Subject: Re: [PATCH v8 09/10] drivers: qcom: rpmh: add support for batch RPMH
 request
Message-ID: <20180514195929.GA22950@codeaurora.org>
References: <20180509170159.29682-1-ilina@codeaurora.org>
 <20180509170159.29682-10-ilina@codeaurora.org>
 <CAD=FV=Xvi8V43+J9v-mosU5WUDQtabg8gUbrkn6SCoNEYFtjUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAD=FV=Xvi8V43+J9v-mosU5WUDQtabg8gUbrkn6SCoNEYFtjUQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Doug,

Will explain only the key points now.

On Fri, May 11 2018 at 14:19 -0600, Doug Anderson wrote:
>Hi,
>
>On Wed, May 9, 2018 at 10:01 AM, Lina Iyer <ilina@codeaurora.org> wrote:
>>  /**
>> @@ -77,12 +82,14 @@ struct rpmh_request {
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
>> +       const struct rpmh_request *batch_cache[RPMH_MAX_BATCH_CACHE];
>
>I'm pretty confused about why the "batch_cache" is separate from the
>normal cache.  As far as I can tell the purpose of the two is the same
>but you have two totally separate code paths and data structures.
>
Due to a hardware limitation, requests made by bus drivers must be set
up in the sleep and wake TCS first before setting up the requests from
other drivers. Bus drivers use batch mode for any and all RPMH
communication. Hence their request are the only ones in the batch_cache.


>>  };
>>
>>  static struct rpmh_ctrlr rpmh_rsc[RPMH_MAX_CTRLR];
>> @@ -133,6 +140,7 @@ void rpmh_tx_done(const struct tcs_request *msg, int r)
>>         struct rpmh_request *rpm_msg = container_of(msg, struct rpmh_request,
>>                                                     msg);
>>         struct completion *compl = rpm_msg->completion;
>> +       atomic_t *wc = rpm_msg->wait_count;
>>
>>         rpm_msg->err = r;
>>
>> @@ -143,8 +151,13 @@ void rpmh_tx_done(const struct tcs_request *msg, int r)
>>         kfree(rpm_msg->free);
>>
>>         /* Signal the blocking thread we are done */
>> -       if (compl)
>> -               complete(compl);
>> +       if (!compl)
>> +               return;
>
>The comment above this "if" block no longer applies to the line next
>to it after your patch.  ...but below I suggest you get rid of
>"wait_count", so maybe this part of the patch will go away.
>
>
>> +static int cache_batch(struct rpmh_ctrlr *ctrlr,
>> +                      struct rpmh_request **rpm_msg, int count)
>> +{
>> +       unsigned long flags;
>> +       int ret = 0;
>> +       int index = 0;
>> +       int i;
>> +
>> +       spin_lock_irqsave(&ctrlr->lock, flags);
>> +       while (index < RPMH_MAX_BATCH_CACHE && ctrlr->batch_cache[index])
>> +               index++;
>> +       if (index + count >= RPMH_MAX_BATCH_CACHE) {
>> +               ret = -ENOMEM;
>> +               goto fail;
>> +       }
>> +
>> +       for (i = 0; i < count; i++)
>> +               ctrlr->batch_cache[index + i] = rpm_msg[i];
>> +fail:
>
>Nit: this label is for both failure and normal exit, so call it "exit".
>
>
>> +       spin_unlock_irqrestore(&ctrlr->lock, flags);
>> +
>> +       return ret;
>> +}
>
>As part of my overall confusion about why the batch cache is different
>than the normal one: for the normal use case you still call
>rpmh_rsc_write_ctrl_data() for things you put in your cache, but you
>don't for the batch cache.  I still haven't totally figured out what
>rpmh_rsc_write_ctrl_data() does, but it seems strange that you don't
>do it for the batch cache but you do for the other one.
>
>
flush_batch does write to the controller using
rpmh_rsc_write_ctrl_data()

Thanks,
Lina

>> +/**
>> + * rpmh_write_batch: Write multiple sets of RPMH commands and wait for the
>> + * batch to finish.
>> + *
>> + * @dev: the device making the request
>> + * @state: Active/sleep set
>> + * @cmd: The payload data
>> + * @n: The array of count of elements in each batch, 0 terminated.
>> + *
>> + * Write a request to the RSC controller without caching. If the request
>> + * state is ACTIVE, then the requests are treated as completion request
>> + * and sent to the controller immediately. The function waits until all the
>> + * commands are complete. If the request was to SLEEP or WAKE_ONLY, then the
>> + * request is sent as fire-n-forget and no ack is expected.
>> + *
>> + * May sleep. Do not call from atomic contexts for ACTIVE_ONLY requests.
>> + */
>> +int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
>> +                    const struct tcs_cmd *cmd, u32 *n)
>> +{
>> +       struct rpmh_request *rpm_msg[RPMH_MAX_REQ_IN_BATCH] = { NULL };
>> +       DECLARE_COMPLETION_ONSTACK(compl);
>> +       atomic_t wait_count = ATOMIC_INIT(0);
>> +       struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
>> +       int count = 0;
>> +       int ret, i;
>> +
>> +       if (IS_ERR(ctrlr) || !cmd || !n)
>> +               return -EINVAL;
>> +
>> +       while (n[count++] > 0)
>> +               ;
>> +       count--;
>> +       if (!count || count > RPMH_MAX_REQ_IN_BATCH)
>> +               return -EINVAL;
>> +
>> +       for (i = 0; i < count; i++) {
>> +               rpm_msg[i] = __get_rpmh_msg_async(state, cmd, n[i]);
>> +               if (IS_ERR_OR_NULL(rpm_msg[i])) {
>
>Just "IS_ERR".  It's never NULL.
>
>...also add a i-- somewhere in here or you're going to be kfree()ing
>your error value, aren't you?
>
>
>> +                       ret = PTR_ERR(rpm_msg[i]);
>> +                       for (; i >= 0; i--)
>> +                               kfree(rpm_msg[i]->free);
>> +                       return ret;
>> +               }
>> +               cmd += n[i];
>> +       }
>> +
>> +       if (state != RPMH_ACTIVE_ONLY_STATE)
>> +               return cache_batch(ctrlr, rpm_msg, count);
>
>Don't you need to free rpm_msg items in this case?
>
>
>> +
>> +       atomic_set(&wait_count, count);
>> +
>> +       for (i = 0; i < count; i++) {
>> +               rpm_msg[i]->completion = &compl;
>> +               rpm_msg[i]->wait_count = &wait_count;
>> +               ret = rpmh_rsc_send_data(ctrlr->drv, &rpm_msg[i]->msg);
>> +               if (ret) {
>> +                       int j;
>> +
>> +                       pr_err("Error(%d) sending RPMH message addr=%#x\n",
>> +                              ret, rpm_msg[i]->msg.cmds[0].addr);
>> +                       for (j = i; j < count; j++)
>> +                               rpmh_tx_done(&rpm_msg[j]->msg, ret);
>
>You're just using rpmh_tx_done() to free memory?  Note that you'll
>probably do your error handling in this function a favor if you rename
>__get_rpmh_msg_async() to __fill_rpmh_msg() and remove the memory
>allocation from there.  Then you can do one big allocation of the
>whole array in rpmh_write_batch() and then you'll only have one free
>at the end...
>
>
>
>> +                       break;
>
>"break" seems wrong here.  You'll end up waiting for the completion,
>then I guess timing out, then returning -ETIMEDOUT?
>
>
>> +               }
>> +       }
>> +
>> +       ret = wait_for_completion_timeout(&compl, RPMH_TIMEOUT_MS);
>
>The "wait_count" abstraction is confusing and I believe it's not
>needed.  I think you can remove it and change the above to this
>(untested) code:
>
>time_left = RPMH_TIMEOUT_MS;
>for (i = 0; i < count; i++) {
>  time_left = wait_for_completion_timeout(&compl, time_left);
>  if (!time_left)
>    return -ETIMEDOUT;
>}
>
>...specifically completions are additive, so just wait "count" times
>and then the reader doesn't need to learn your new wait_count
>abstraction and try to reason about it.
>
>...and, actually, I argue in other replies that this should't use a
>timeout, so even cleaner:
>
>for (i = 0; i < count; i++)
>  wait_for_completion(&compl);
>
>
>Once you do that, you can also get rid of the need to pre-count "n",
>so all your loops turn into:
>
>for (i = 0; n[i]; i++)
>
>
>I suppose you might want to get rid of "RPMH_MAX_REQ_IN_BATCH" and
>dynamically allocate your array too, but that seems sane.  As per
>above it seems like you should just dynamically allocate a whole array
>of "struct rpmh_request" items at once anyway.
>
>---
>
>> +       return (ret > 0) ? 0 : -ETIMEDOUT;
>> +
>> +}
>> +EXPORT_SYMBOL(rpmh_write_batch);
>
>Perhaps an even simpler thing than taking all my advice above: can't
>you just add a optional completion to rpmh_write_async()?  That would
>just be stuffed into rpm_msg.
>
>Now your batch code would just be a bunch of calls to
>rpmh_write_async() with an equal number of wait_for_completion() calls
>at the end.  Is there a reason that wouldn't work?  You'd get rid of
>_a lot_ of code.
>
>
>-Doug
