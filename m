Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933347AbeBVQ6J (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:58:09 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49832 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933093AbeBVQ6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:58:07 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 075C6607C6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Thu, 22 Feb 2018 16:58:05 +0000
From: Lina Iyer <ilina@codeaurora.org>
To: Evan Green <evgreen@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] drivers: qcom: rpmh: cache sleep/wake state
 requests
Message-ID: <20180222165805.GA7098@codeaurora.org>
References: <20180215173507.10989-1-ilina@codeaurora.org>
 <20180215173507.10989-8-ilina@codeaurora.org>
 <CAE=gft60w5=_FXbozN7ebYSO7r++0KFuBHEQmgki8O=A51-89g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAE=gft60w5=_FXbozN7ebYSO7r++0KFuBHEQmgki8O=A51-89g@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21 2018 at 22:07 +0000, Evan Green wrote:
>Hi Lina,
>
>On Thu, Feb 15, 2018 at 9:35 AM, Lina Iyer <ilina@codeaurora.org> wrote:
[...]
>> +static struct cache_req *cache_rpm_request(struct rpmh_client *rc,
>> +                                         enum rpmh_state state,
>> +                                         struct tcs_cmd *cmd)
>> +{
>> +       struct cache_req *req;
>> +       struct rpmh_ctrlr *rpm = rc->ctrlr;
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(&rpm->lock, flags);
>> +       req = __find_req(rc, cmd->addr);
>> +       if (req)
>> +               goto existing;
>> +
>> +       req = kzalloc(sizeof(*req), GFP_ATOMIC);
>> +       if (!req) {
>> +               req = ERR_PTR(-ENOMEM);
>> +               goto unlock;
>> +       }
>> +
>> +       req->addr = cmd->addr;
>> +       req->sleep_val = req->wake_val = UINT_MAX;
>
>So UINT_MAX is really never a valid value to write? Maybe it would be
>good to at least print some sort of complaint if somebody sends down a
>request with this value. Otherwise the request is silently ignored and
>would be quite challenging to track down.
>
Yes, UINT_MAX is a invalid value. I have not encountered anything in the
spec that points to hold UINT_MAX as a valid value.
It would also be quite inefficient to validate each input. Drivers
generally know what they are doing. These are data sent to the hardware
and there is a general understanding that incorrect data may fail
silently.

>> +/**
>> + * rpmh_flush: Flushes the buffered active and sleep sets to TCS
>> + *
>> + * @rc: The RPMh handle got from rpmh_get_dev_channel
>> + *
>> + * This function is generally called from the sleep code from the last CPU
>> + * that is powering down the entire system.
>> + *
>> + * Returns -EBUSY if the controller is busy, probably waiting on a response
>> + * to a RPMH request sent earlier.
>> + */
>> +int rpmh_flush(struct rpmh_client *rc)
>> +{
>> +       struct cache_req *p;
>> +       struct rpmh_ctrlr *rpm = rc->ctrlr;
>> +       int ret;
>> +       unsigned long flags;
>> +
>> +       if (IS_ERR_OR_NULL(rc))
>> +               return -EINVAL;
>> +
>> +       spin_lock_irqsave(&rpm->lock, flags);
>> +       if (!rpm->dirty) {
>> +               pr_debug("Skipping flush, TCS has latest data.\n");
>> +               spin_unlock_irqrestore(&rpm->lock, flags);
>> +               return 0;
>> +       }
>> +       spin_unlock_irqrestore(&rpm->lock, flags);
>> +
>> +       /*
>> +        * Nobody else should be calling this function other than system PM,,
>> +        * hence we can run without locks.
>> +        */
>> +       list_for_each_entry(p, &rc->ctrlr->cache, list) {
>> +               if (!is_req_valid(p)) {
>> +                       pr_debug("%s: skipping RPMH req: a:0x%x s:0x%x w:0x%x",
>> +                               __func__, p->addr, p->sleep_val, p->wake_val);
>> +                       continue;
>> +               }
>> +               ret = send_single(rc, RPMH_SLEEP_STATE, p->addr, p->sleep_val);
>> +               if (ret)
>> +                       return ret;
>> +               ret = send_single(rc, RPMH_WAKE_ONLY_STATE, p->addr,
>> +                                               p->wake_val);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       spin_lock_irqsave(&rpm->lock, flags);
>> +       rpm->dirty = false;
>> +       spin_unlock_irqrestore(&rpm->lock, flags);
>> +
>
>I've got some questions on the locking in this function.
>
>I understand that the lock protects the list, and I'm surmising that
>you don't want to hold the lock across send_single (even though
>there's another lock in there that's held for most of that time, so I
>think you could). I'm still a newbie to Linux in general, so I'll pose
>this as a question: is it generally okay in Linux to traverse across a
>list that may have items concurrently added to it? You're never
>removing items from this list, so I think there are no actual bugs,
>but it does seem like it relies on the implementation details of the
>list. And if you ever did remove items from the list, this would bite
>you.
>
It is generally not advisable to traverse a list if the list is being
modified externally. The reason why it is okay here, is the context of
this function call. The only caller of this function will be a system PM
driver. As noted in the comments, this is called when the last CPU is
powering down and in such a context, there are no other active users of
this library.

>Also, why do you need to acquire the lock just to set dirty to false?
>Right now it looks like there's a race where someone could add an
>element to this list just after you've terminated this loop (but
>before you have the lock), but then the dirty = false here clobbers
>their dirty = true, and the item is never sent during future flushes.
>
>I think it would be safer and faster to set dirty = false before
>iterating through the list (either within the lock or outside of it
>given that this is the only place that reads or clears dirty). That
>way if new elements sneak in you know that they will either be flushed
>already or dirty will be true for them on a subsequent flush.
>
->dirty will be accessed as a u32 and so does not require a lock per-se.
The lock here guarantees a certain system state when the flag is
changed. While in this function it is not needed since, there will be no
active threads changing the system state. I could possibly remove the
lock in this function.

>> +       return 0;
>> +}
>> +EXPORT_SYMBOL(rpmh_flush);
>> +
>> +/**
>> + * rpmh_invalidate: Invalidate all sleep and active sets
>> + * sets.
>> + *
>> + * @rc: The RPMh handle got from rpmh_get_dev_channel
>> + *
>> + * Invalidate the sleep and active values in the TCS blocks.
>> + */
>> +int rpmh_invalidate(struct rpmh_client *rc)
>> +{
>> +       struct rpmh_ctrlr *rpm = rc->ctrlr;
>> +       int ret;
>> +       unsigned long flags;
>> +
>> +       if (IS_ERR_OR_NULL(rc))
>> +               return -EINVAL;
>> +
>> +       spin_lock_irqsave(&rpm->lock, flags);
>> +       rpm->dirty = true;
>> +       spin_unlock_irqrestore(&rpm->lock, flags);
>
>I don't think the lock acquire/release provides anything here, can't
>you just set dirty = true?
>
It helps synchronize to the state of the controller.

>So rpmh_invalidate clears any pending requests in the hardware, but
>all the cached address/data pairs are all still in the cache, right?
>As soon as someone else adds a new request and sets dirty to true, all
>of these old ones get resent as well at flush, right? Is that the
>desired behavior? Does anyone ever need to remove an address/data pair
>from the RPMh's to-do list?
>
Drivers overwrite their requests and I have not had a requirement to
remove their previous votes. Removing from the controller's registers is
good enough to not send the data. If a driver calls invalidate, it is
generally followed by a new sleep/wake request.

Thanks,
Lina
>> +
>> +       do {
>> +               ret = rpmh_rsc_invalidate(rc->ctrlr->drv);
>> +       } while (ret == -EAGAIN);
>> +
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL(rpmh_invalidate);
>> +
