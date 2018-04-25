Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754163AbeDYXlz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 19:41:55 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37626 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753677AbeDYXlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 19:41:51 -0400
X-Google-Smtp-Source: AB8JxZpb8eQH4FWM1u7bDxb04X45SpmkialV++miCDp1DhZ0sHVsQDZQTBl16Uec+JUl8Jzqi/VKKA==
Date: Wed, 25 Apr 2018 16:41:49 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org
Subject: Re: [PATCH v6 09/10] drivers: qcom: rpmh: add support for batch RPMH
 request
Message-ID: <20180425234149.GE243180@google.com>
References: <20180419221635.17849-1-ilina@codeaurora.org>
 <20180419221635.17849-10-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180419221635.17849-10-ilina@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 04:16:34PM -0600, Lina Iyer wrote:
> Platform drivers need make a lot of resource state requests at the same
> time, say, at the start or end of an usecase. It can be quite
> inefficient to send each request separately. Instead they can give the
> RPMH library a batch of requests to be sent and wait on the whole
> transaction to be complete.
> 
> rpmh_write_batch() is a blocking call that can be used to send multiple
> RPMH command sets. Each RPMH command set is set asynchronously and the
> API blocks until all the command sets are complete and receive their
> tx_done callbacks.
> 
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
> 
> Changes in v6:
> 	- replace rpmh_client with device *
> Changes in v4:
> 	- reorganize rpmh_write_batch()
> 	- introduce wait_count here, instead of patch#4
> ---
>  drivers/soc/qcom/rpmh.c | 155 +++++++++++++++++++++++++++++++++++++++-
>  include/soc/qcom/rpmh.h |   8 +++
>  2 files changed, 161 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index b56445a05e23..c5962c692aac 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -21,6 +21,7 @@
>  #include "rpmh-internal.h"
>  
>  #define RPMH_TIMEOUT_MS			msecs_to_jiffies(10000)
> +#define RPMH_MAX_REQ_IN_BATCH		10
>  
>  #define DEFINE_RPMH_MSG_ONSTACK(dev, s, q, name)	\
>  	struct rpmh_request name = {			\
> @@ -34,6 +35,7 @@
>  		.completion = q,			\
>  		.dev = dev,				\
>  		.free = NULL,				\
> +		.wait_count = NULL,			\
>  	}
>  
>  /**
> @@ -60,6 +62,7 @@ struct cache_req {
>   * @dev: the device making the request
>   * @err: err return from the controller
>   * @free: the request object to be freed at tx_done
> + * @wait_count: count of waiters for this completion
>   */
>  struct rpmh_request {
>  	struct tcs_request msg;
> @@ -68,6 +71,7 @@ struct rpmh_request {
>  	const struct device *dev;
>  	int err;
>  	struct rpmh_request *free;
> +	atomic_t *wait_count;
>  };
>  
>  /**
> @@ -77,12 +81,14 @@ struct rpmh_request {
>   * @cache: the list of cached requests
>   * @lock: synchronize access to the controller data
>   * @dirty: was the cache updated since flush
> + * @batch_cache: Cache sleep and wake requests sent as batch
>   */
>  struct rpmh_ctrlr {
>  	struct rsc_drv *drv;
>  	struct list_head cache;
>  	spinlock_t lock;
>  	bool dirty;
> +	const struct rpmh_request *batch_cache[2 * RPMH_MAX_REQ_IN_BATCH];
>  };
>

<snip>

> +static int cache_batch(struct rpmh_ctrlr *ctrlr,
> +		       struct rpmh_request **rpm_msg, int count)
> +{
> +	unsigned long flags;
> +	int ret = 0;
> +	int index = 0;
> +	int i;
> +
> +	spin_lock_irqsave(&ctrlr->lock, flags);
> +	while (ctrlr->batch_cache[index])
> +		index++;

This will access memory beyond 'batch_cache' when the cache is full.

<snip>

> +static void invalidate_batch(struct rpmh_ctrlr *ctrlr)
> +{
> +	unsigned long flags;
> +	int index = 0;
> +	int i;
> +
> +	spin_lock_irqsave(&ctrlr->lock, flags);
> +	while (ctrlr->batch_cache[index])
> +		index++;

Same as above. Also, why loop twice?

> +	for (i = 0; i < index; i++) {
> +		kfree(ctrlr->batch_cache[i]->free);
> +		ctrlr->batch_cache[i] = NULL;
> +	}

<snip>

> +/**
> + * rpmh_write_batch: Write multiple sets of RPMH commands and wait for the
> + * batch to finish.
> + *
> + * @dev: the device making the request
> + * @state: Active/sleep set
> + * @cmd: The payload data
> + * @n: The array of count of elements in each batch, 0 terminated.

nit: in this driver 'n' is usually associated with the command offset
within a TCS. Since it isn't an overly descriptive name it may already
cost the reader a while to commit that to his/her memory, and now
we are overloading 'n' with a different meaning (I also noticed this in
another patch of this series, but didn't comment).

> + * Write a request to the RSC controller without caching. If the request
> + * state is ACTIVE, then the requests are treated as completion request
> + * and sent to the controller immediately. The function waits until all the
> + * commands are complete. If the request was to SLEEP or WAKE_ONLY, then the
> + * request is sent as fire-n-forget and no ack is expected.
> + *
> + * May sleep. Do not call from atomic contexts for ACTIVE_ONLY requests.
> + */
> +int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
> +		     const struct tcs_cmd *cmd, u32 *n)
> +{
> +	struct rpmh_request *rpm_msg[RPMH_MAX_REQ_IN_BATCH] = { NULL };
> +	DECLARE_COMPLETION_ONSTACK(compl);
> +	atomic_t wait_count = ATOMIC_INIT(0);
> +	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
> +	int count = 0;
> +	int ret, i;
> +
> +	if (IS_ERR(ctrlr) || !cmd || !n)
> +		return -EINVAL;
> +
> +	while (n[count++] > 0)
> +		;
> +	count--;
> +	if (!count || count > RPMH_MAX_REQ_IN_BATCH)
> +		return -EINVAL;
> +
> +	for (i = 0; i < count; i++) {
> +		rpm_msg[i] = __get_rpmh_msg_async(state, cmd, n[i]);
> +		if (IS_ERR_OR_NULL(rpm_msg[i])) {
> +			ret = PTR_ERR(rpm_msg[i]);
> +			for (; i >= 0; i--)
> +				kfree(rpm_msg[i]->free);
> +			return ret;
> +		}
> +		cmd += n[i];
> +	}
> +
> +	if (state != RPMH_ACTIVE_ONLY_STATE)
> +		return cache_batch(ctrlr, rpm_msg, count);
> +
> +	atomic_set(&wait_count, count);
> +
> +	for (i = 0; i < count; i++) {
> +		rpm_msg[i]->completion = &compl;
> +		rpm_msg[i]->wait_count = &wait_count;
> +		ret = rpmh_rsc_send_data(ctrlr->drv, &rpm_msg[i]->msg);
> +		if (ret) {
> +			int j;
> +
> +			pr_err("Error(%d) sending RPMH message addr=%#x\n",
> +			       ret, rpm_msg[i]->msg.cmds[0].addr);
> +			for (j = i; j < count; j++)
> +				rpmh_tx_done(&rpm_msg[j]->msg, ret);
> +			break;
> +		}
> +	}
> +
> +	ret = wait_for_completion_timeout(&compl, RPMH_TIMEOUT_MS);
> +	return (ret > 0) ? 0 : -ETIMEDOUT;
> +
> +}
> +EXPORT_SYMBOL(rpmh_write_batch);
> +
>  static int is_req_valid(struct cache_req *req)
>  {
>  	return (req->sleep_val != UINT_MAX &&
> @@ -375,6 +520,11 @@ int rpmh_flush(const struct device *dev)
>  		return 0;
>  	}
>  
> +	/* First flush the cached batch requests */
> +	ret = flush_batch(ctrlr);
> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * Nobody else should be calling this function other than system PM,,
                                                                            ~
Remove extra comma.
