Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751345AbeBUWH6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 17:07:58 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:37486 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbeBUWHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 17:07:55 -0500
X-Google-Smtp-Source: AG47ELsXp482/bWQ2rbRVmQ0dyx76J+HJBJ3KzYVT95ZNEds4JHXcpp7OcypNtw5TjDBBubZdveg1g==
MIME-Version: 1.0
In-Reply-To: <20180215173507.10989-8-ilina@codeaurora.org>
References: <20180215173507.10989-1-ilina@codeaurora.org> <20180215173507.10989-8-ilina@codeaurora.org>
From: Evan Green <evgreen@chromium.org>
Date: Wed, 21 Feb 2018 14:07:11 -0800
X-Gmail-Original-Message-ID: <CAE=gft60w5=_FXbozN7ebYSO7r++0KFuBHEQmgki8O=A51-89g@mail.gmail.com>
Message-ID: <CAE=gft60w5=_FXbozN7ebYSO7r++0KFuBHEQmgki8O=A51-89g@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] drivers: qcom: rpmh: cache sleep/wake state requests
To: Lina Iyer <ilina@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lina,

On Thu, Feb 15, 2018 at 9:35 AM, Lina Iyer <ilina@codeaurora.org> wrote:
> Active state requests are sent immediately to the mailbox controller,
> while sleep and wake state requests are cached in this driver to avoid
> taxing the mailbox controller repeatedly. The cached values will be sent
> to the controller when the rpmh_flush() is called.
>
> Generally, flushing is a system PM activity and may be called from the
> system PM drivers when the system is entering suspend or deeper sleep
> modes during cpuidle.
>
> Also allow invalidating the cached requests, so they may be re-populated
> again.
>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  drivers/soc/qcom/rpmh.c | 213 +++++++++++++++++++++++++++++++++++++++++++++++-
>  include/soc/qcom/rpmh.h |  10 +++
>  2 files changed, 222 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index d95ea3fa8b67..671bc03ad77a 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -6,11 +6,13 @@
>  #include <linux/atomic.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> +#include <linux/list.h>
>  #include <linux/mailbox_client.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> +#include <linux/spinlock.h>
>  #include <linux/types.h>
>  #include <linux/wait.h>
>
> @@ -35,6 +37,22 @@
>                 .rc = rc,                               \
>         }
>
> +
> +/**
> + * cache_req : the request object for caching
> + *
> + * @addr: the address of the resource
> + * @sleep_val: the sleep vote
> + * @wake_val: the wake vote
> + * @list: linked list obj
> + */
> +struct cache_req {
> +       u32 addr;
> +       u32 sleep_val;
> +       u32 wake_val;
> +       struct list_head list;
> +};
> +
>  /**
>   * rpmh_request: the message to be sent to rpmh-rsc
>   *
> @@ -57,9 +75,15 @@ struct rpmh_request {
>   * rpmh_ctrlr: our representation of the controller
>   *
>   * @drv: the controller instance
> + * @cache: the list of cached requests
> + * @lock: synchronize access to the controller data
> + * @dirty: was the cache updated since flush
>   */
>  struct rpmh_ctrlr {
>         struct rsc_drv *drv;
> +       struct list_head cache;
> +       spinlock_t lock;
> +       bool dirty;
>  };
>
>  /**
> @@ -123,17 +147,91 @@ static int wait_for_tx_done(struct rpmh_client *rc,
>         return (ret > 0) ? 0 : -ETIMEDOUT;
>  }
>
> +static struct cache_req *__find_req(struct rpmh_client *rc, u32 addr)
> +{
> +       struct cache_req *p, *req = NULL;
> +
> +       list_for_each_entry(p, &rc->ctrlr->cache, list) {
> +               if (p->addr == addr) {
> +                       req = p;
> +                       break;
> +               }
> +       }
> +
> +       return req;
> +}
> +
> +static struct cache_req *cache_rpm_request(struct rpmh_client *rc,
> +                                         enum rpmh_state state,
> +                                         struct tcs_cmd *cmd)
> +{
> +       struct cache_req *req;
> +       struct rpmh_ctrlr *rpm = rc->ctrlr;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&rpm->lock, flags);
> +       req = __find_req(rc, cmd->addr);
> +       if (req)
> +               goto existing;
> +
> +       req = kzalloc(sizeof(*req), GFP_ATOMIC);
> +       if (!req) {
> +               req = ERR_PTR(-ENOMEM);
> +               goto unlock;
> +       }
> +
> +       req->addr = cmd->addr;
> +       req->sleep_val = req->wake_val = UINT_MAX;

So UINT_MAX is really never a valid value to write? Maybe it would be
good to at least print some sort of complaint if somebody sends down a
request with this value. Otherwise the request is silently ignored and
would be quite challenging to track down.

> +       INIT_LIST_HEAD(&req->list);
> +       list_add_tail(&req->list, &rpm->cache);
> +
> +existing:
> +       switch (state) {
> +       case RPMH_ACTIVE_ONLY_STATE:
> +               if (req->sleep_val != UINT_MAX)
> +                       req->wake_val = cmd->data;
> +               break;
> +       case RPMH_WAKE_ONLY_STATE:
> +               req->wake_val = cmd->data;
> +               break;
> +       case RPMH_SLEEP_STATE:
> +               req->sleep_val = cmd->data;
> +               break;
> +       default:
> +               break;
> +       };
> +
> +       rpm->dirty = true;
> +unlock:
> +       spin_unlock_irqrestore(&rpm->lock, flags);
> +
> +       return req;
> +}
> +
>  /**
> - * __rpmh_write: send the RPMH request
> + * __rpmh_write: Cache and send the RPMH request
>   *
>   * @rc: The RPMH client
>   * @state: Active/Sleep request type
>   * @rpm_msg: The data that needs to be sent (payload).
> + *
> + * Cache the RPMH request and send if the state is ACTIVE_ONLY.
> + * SLEEP/WAKE_ONLY requests are not sent to the controller at
> + * this time. Use rpmh_flush() to send them to the controller.
>   */
>  static int __rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
>                        struct rpmh_request *rpm_msg)
>  {
>         int ret = -EFAULT;
> +       struct cache_req *req;
> +       int i;
> +
> +       /* Cache the request in our store and link the payload */
> +       for (i = 0; i < rpm_msg->msg.num_payload; i++) {
> +               req = cache_rpm_request(rc, state, &rpm_msg->msg.payload[i]);
> +               if (IS_ERR(req))
> +                       return PTR_ERR(req);
> +       }
>
>         rpm_msg->msg.state = state;
>
> @@ -150,6 +248,10 @@ static int __rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
>                                 "Error in RPMH request addr=0x%x, data=0x%x\n",
>                                 rpm_msg->msg.payload[0].addr,
>                                 rpm_msg->msg.payload[0].data);
> +       } else {
> +               ret = rpmh_rsc_write_ctrl_data(rc->ctrlr->drv, &rpm_msg->msg);
> +               /* Clean up our call by spoofing tx_done */
> +               rpmh_tx_done(&rpm_msg->msg, ret);
>         }
>
>         return ret;
> @@ -189,6 +291,113 @@ int rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
>  }
>  EXPORT_SYMBOL(rpmh_write);
>
> +static int is_req_valid(struct cache_req *req)
> +{
> +       return (req->sleep_val != UINT_MAX &&
> +              req->wake_val != UINT_MAX &&
> +              req->sleep_val != req->wake_val);
> +}
> +
> +static int send_single(struct rpmh_client *rc, enum rpmh_state state,
> +                     u32 addr, u32 data)
> +{
> +       DEFINE_RPMH_MSG_ONSTACK(rc, state, NULL, NULL, rpm_msg);
> +
> +       /* Wake sets are always complete and sleep sets are not */
> +       rpm_msg.msg.is_complete = (state == RPMH_WAKE_ONLY_STATE);
> +       rpm_msg.cmd[0].addr = addr;
> +       rpm_msg.cmd[0].data = data;
> +       rpm_msg.msg.num_payload = 1;
> +       rpm_msg.msg.is_complete = false;
> +
> +       return rpmh_rsc_write_ctrl_data(rc->ctrlr->drv, &rpm_msg.msg);
> +}
> +
> +/**
> + * rpmh_flush: Flushes the buffered active and sleep sets to TCS
> + *
> + * @rc: The RPMh handle got from rpmh_get_dev_channel
> + *
> + * This function is generally called from the sleep code from the last CPU
> + * that is powering down the entire system.
> + *
> + * Returns -EBUSY if the controller is busy, probably waiting on a response
> + * to a RPMH request sent earlier.
> + */
> +int rpmh_flush(struct rpmh_client *rc)
> +{
> +       struct cache_req *p;
> +       struct rpmh_ctrlr *rpm = rc->ctrlr;
> +       int ret;
> +       unsigned long flags;
> +
> +       if (IS_ERR_OR_NULL(rc))
> +               return -EINVAL;
> +
> +       spin_lock_irqsave(&rpm->lock, flags);
> +       if (!rpm->dirty) {
> +               pr_debug("Skipping flush, TCS has latest data.\n");
> +               spin_unlock_irqrestore(&rpm->lock, flags);
> +               return 0;
> +       }
> +       spin_unlock_irqrestore(&rpm->lock, flags);
> +
> +       /*
> +        * Nobody else should be calling this function other than system PM,,
> +        * hence we can run without locks.
> +        */
> +       list_for_each_entry(p, &rc->ctrlr->cache, list) {
> +               if (!is_req_valid(p)) {
> +                       pr_debug("%s: skipping RPMH req: a:0x%x s:0x%x w:0x%x",
> +                               __func__, p->addr, p->sleep_val, p->wake_val);
> +                       continue;
> +               }
> +               ret = send_single(rc, RPMH_SLEEP_STATE, p->addr, p->sleep_val);
> +               if (ret)
> +                       return ret;
> +               ret = send_single(rc, RPMH_WAKE_ONLY_STATE, p->addr,
> +                                               p->wake_val);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       spin_lock_irqsave(&rpm->lock, flags);
> +       rpm->dirty = false;
> +       spin_unlock_irqrestore(&rpm->lock, flags);
> +

I've got some questions on the locking in this function.

I understand that the lock protects the list, and I'm surmising that
you don't want to hold the lock across send_single (even though
there's another lock in there that's held for most of that time, so I
think you could). I'm still a newbie to Linux in general, so I'll pose
this as a question: is it generally okay in Linux to traverse across a
list that may have items concurrently added to it? You're never
removing items from this list, so I think there are no actual bugs,
but it does seem like it relies on the implementation details of the
list. And if you ever did remove items from the list, this would bite
you.

Also, why do you need to acquire the lock just to set dirty to false?
Right now it looks like there's a race where someone could add an
element to this list just after you've terminated this loop (but
before you have the lock), but then the dirty = false here clobbers
their dirty = true, and the item is never sent during future flushes.

I think it would be safer and faster to set dirty = false before
iterating through the list (either within the lock or outside of it
given that this is the only place that reads or clears dirty). That
way if new elements sneak in you know that they will either be flushed
already or dirty will be true for them on a subsequent flush.

> +       return 0;
> +}
> +EXPORT_SYMBOL(rpmh_flush);
> +
> +/**
> + * rpmh_invalidate: Invalidate all sleep and active sets
> + * sets.
> + *
> + * @rc: The RPMh handle got from rpmh_get_dev_channel
> + *
> + * Invalidate the sleep and active values in the TCS blocks.
> + */
> +int rpmh_invalidate(struct rpmh_client *rc)
> +{
> +       struct rpmh_ctrlr *rpm = rc->ctrlr;
> +       int ret;
> +       unsigned long flags;
> +
> +       if (IS_ERR_OR_NULL(rc))
> +               return -EINVAL;
> +
> +       spin_lock_irqsave(&rpm->lock, flags);
> +       rpm->dirty = true;
> +       spin_unlock_irqrestore(&rpm->lock, flags);

I don't think the lock acquire/release provides anything here, can't
you just set dirty = true?

So rpmh_invalidate clears any pending requests in the hardware, but
all the cached address/data pairs are all still in the cache, right?
As soon as someone else adds a new request and sets dirty to true, all
of these old ones get resent as well at flush, right? Is that the
desired behavior? Does anyone ever need to remove an address/data pair
from the RPMh's to-do list?

> +
> +       do {
> +               ret = rpmh_rsc_invalidate(rc->ctrlr->drv);
> +       } while (ret == -EAGAIN);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL(rpmh_invalidate);
> +
>  static struct rpmh_ctrlr *get_rpmh_ctrlr(struct platform_device *pdev)
>  {
>         int i;
> @@ -210,6 +419,8 @@ static struct rpmh_ctrlr *get_rpmh_ctrlr(struct platform_device *pdev)
>                 if (rpmh_rsc[i].drv == NULL) {
>                         ctrlr = &rpmh_rsc[i];
>                         ctrlr->drv = drv;
> +                       spin_lock_init(&ctrlr->lock);
> +                       INIT_LIST_HEAD(&ctrlr->cache);
>                         break;
>                 }
>         }
> diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
> index 53cc145990c2..a3f1246ce49a 100644
> --- a/include/soc/qcom/rpmh.h
> +++ b/include/soc/qcom/rpmh.h
> @@ -17,6 +17,10 @@ int rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
>
>  struct rpmh_client *rpmh_get_client(struct platform_device *pdev);
>
> +int rpmh_flush(struct rpmh_client *rc);
> +
> +int rpmh_invalidate(struct rpmh_client *rc);
> +
>  void rpmh_release(struct rpmh_client *rc);
>
>  #else
> @@ -28,6 +32,12 @@ static inline int rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
>  static inline struct rpmh_client *rpmh_get_client(struct platform_device *pdev)
>  { return ERR_PTR(-ENODEV); }
>
> +static inline int rpmh_flush(struct rpmh_client *rc)
> +{ return -ENODEV; }
> +
> +static inline int rpmh_invalidate(struct rpmh_client *rc)
> +{ return -ENODEV; }
> +
>  static inline void rpmh_release(struct rpmh_client *rc) { }
>  #endif /* CONFIG_QCOM_RPMH */
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
