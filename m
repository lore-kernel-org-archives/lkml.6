Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5020C46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9692238D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="w2PvEfGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9692238D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbeHIWo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 18:44:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34434 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeHIWo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 18:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=196blxaXAjcf60qfgh9vD98JcWaKc1QGZxYAllOkGjw=; b=w2PvEfGagPkbigG8F1z3dgtbQZ
        cVXP+tQ2DUfbfHEg0eANMe40lKFonUPc2uyFvsMpIO5jbJHtJyPiGqg+E8kewlxaDhEUjGDe18btA
        z/ViKmCUftn//3rj436GjaeV4bG8diLborSv7RGBZeDes1zlzeFE8tVhpwfm5u6w4uzIBBKfBfwQM
        fgf9pXD+twixvTyiL8Ap9kWDpnlCmhFwy9M2jXf3Mi7idS24pmKD0voRAXBFddiy9SDhvtBDWlPWR
        TS0fnys+QEVNhvyPliwN1eEmTnkzQ6iq1U7NQQVqfcuCrujSHM1orMz/ur6XJ0+DpCaYTRe/BZsUw
        /eOZ7Mnw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fnrNf-0005kI-4j; Thu, 09 Aug 2018 20:17:59 +0000
Subject: Re: [PATCH v2 5/7] mhi_bus: core: add support to get external modem
 time
To:     Sujeev Dias <sdias@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Tony Truong <truong@codeaurora.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
 <1531166894-30984-1-git-send-email-sdias@codeaurora.org>
 <1531166894-30984-6-git-send-email-sdias@codeaurora.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4be7b101-f777-8f35-eaea-60ab60a05a49@infradead.org>
Date:   Thu, 9 Aug 2018 13:17:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1531166894-30984-6-git-send-email-sdias@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2018 01:08 PM, Sujeev Dias wrote:
> For accurate synchronizations between external modem and
> host processor, mhi host will capture modem time relative
> to host time. Client may use time measurements for adjusting
> any drift between host and modem.
> 
> Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
> Reviewed-by: Tony Truong <truong@codeaurora.org>
> Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/bus/mhi.txt |   7 +
>  Documentation/mhi.txt                         |  41 ++++
>  drivers/bus/mhi/core/mhi_init.c               | 111 +++++++++++
>  drivers/bus/mhi/core/mhi_internal.h           |  57 +++++-
>  drivers/bus/mhi/core/mhi_main.c               | 263 +++++++++++++++++++++++++-
>  drivers/bus/mhi/core/mhi_pm.c                 |   7 +
>  include/linux/mhi.h                           |   7 +
>  7 files changed, 486 insertions(+), 7 deletions(-)
> 

Hi,

More corrections for you...


> diff --git a/Documentation/mhi.txt b/Documentation/mhi.txt
> index 1c501f1..9287899 100644
> --- a/Documentation/mhi.txt
> +++ b/Documentation/mhi.txt
> @@ -137,6 +137,47 @@ Example Operation for data transfer:
>  8. Host wakes up and check event ring for completion event
>  9. Host update the Event[i].ctxt.WP to indicate processed of completion event.
>  
> +Time sync
> +---------
> +To synchronize two applications between host and external modem, MHI provide

                                                                        provides

> +native support to get external modems free running timer value in a fast
> +reliable method. MHI clients do not need to create client specific methods to
> +get modem time.
> +
> +When client requests modem time, MHI host will automatically capture host time
> +at that moment so clients are able to do accurate drift adjustment.
> +
> +Example:
> +
> +Client request time @ time T1
> +
> +Host Time: Tx
> +Modem Time: Ty
> +
> +Client request time @ time T2
> +Host Time: Txx
> +Modem Time: Tyy
> +
> +Then drift is:
> +Tyy - Ty + <drift> == Txx - Tx
> +
> +Clients are free to implement their own drift algorithms, what MHI host provide

                                                 algorithms. What MHI host provides

> +is a way to accurately correlate host time with external modem time.
> +
> +To avoid link level latencies, controller must support capabilities to disable
> +any link level latency.
> +
> +During Time capture host will:
> +	1. Capture host time
> +	2. Trigger doorbell to capture modem time
> +
> +It's important time between Step 2 to Step 1 is deterministic as possible.

It's important that the time between Step 1 and Step 2 is as deterministic as possible.


> +Therefore, MHI host will:
> +	1. Disable any MHI related to low power modes.
> +	2. Disable preemption
> +	3. Request bus master to disable any link level latencies. Controller
> +	should disable all low power modes such as L0s, L1, L1ss.
> +
>  MHI States
>  ----------
>  

> diff --git a/drivers/bus/mhi/core/mhi_internal.h b/drivers/bus/mhi/core/mhi_internal.h
> index 1167d75..47d258a 100644
> --- a/drivers/bus/mhi/core/mhi_internal.h
> +++ b/drivers/bus/mhi/core/mhi_internal.h
> @@ -128,6 +128,30 @@
>  #define MHIDATALIMIT_HIGHER_MHIDATALIMIT_HIGHER_MASK (0xFFFFFFFF)
>  #define MHIDATALIMIT_HIGHER_MHIDATALIMIT_HIGHER_SHIFT (0)

ugh.  Way too long for a name.


> diff --git a/drivers/bus/mhi/core/mhi_main.c b/drivers/bus/mhi/core/mhi_main.c
> index 3e7077a8..8a0a7e1 100644
> --- a/drivers/bus/mhi/core/mhi_main.c
> +++ b/drivers/bus/mhi/core/mhi_main.c
> @@ -53,6 +53,40 @@ int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
>  	return 0;
>  }
>  
> +int mhi_get_capability_offset(struct mhi_controller *mhi_cntrl,
> +			      u32 capability,
> +			      u32 *offset)
> +{
> +	u32 cur_cap, next_offset;
> +	int ret;
> +
> +	/* get the 1st supported capability offset */
> +	ret = mhi_read_reg_field(mhi_cntrl, mhi_cntrl->regs, MISC_OFFSET,
> +				 MISC_CAP_MASK, MISC_CAP_SHIFT, offset);
> +	if (ret)
> +		return ret;
> +	do {
> +		ret = mhi_read_reg_field(mhi_cntrl, mhi_cntrl->regs, *offset,
> +					 CAP_CAPID_MASK, CAP_CAPID_SHIFT,
> +					 &cur_cap);
> +		if (ret)
> +			return ret;
> +
> +		if (cur_cap == capability)
> +			return 0;
> +
> +		ret = mhi_read_reg_field(mhi_cntrl, mhi_cntrl->regs, *offset,
> +					 CAP_NEXT_CAP_MASK, CAP_NEXT_CAP_SHIFT,
> +					 &next_offset);
> +		if (ret)
> +			return ret;
> +
> +		*offset += next_offset;
> +	} while (next_offset);
> +
> +	return -ENXIO;
> +}
> +
>  void mhi_write_reg(struct mhi_controller *mhi_cntrl,
>  		   void __iomem *base,
>  		   u32 offset,
> @@ -547,6 +581,42 @@ static void mhi_assign_of_node(struct mhi_controller *mhi_cntrl,
>  	}
>  }
>  
> +static void mhi_create_time_sync_dev(struct mhi_controller *mhi_cntrl)
> +{
> +	struct mhi_device *mhi_dev;
> +	struct mhi_timesync *mhi_tsync = mhi_cntrl->mhi_tsync;
> +	int ret;
> +
> +	if (!mhi_tsync || !mhi_tsync->db)
> +		return;
> +
> +	if (mhi_cntrl->ee != MHI_EE_AMSS)
> +		return;
> +
> +	mhi_dev = mhi_alloc_device(mhi_cntrl);
> +	if (!mhi_dev)
> +		return;
> +
> +	mhi_dev->dev_type = MHI_TIMESYNC_TYPE;
> +	mhi_dev->chan_name = "TIME_SYNC";
> +	dev_set_name(&mhi_dev->dev, "%04x_%02u.%02u.%02u_%s", mhi_dev->dev_id,
> +		     mhi_dev->domain, mhi_dev->bus, mhi_dev->slot,
> +		     mhi_dev->chan_name);
> +
> +	/* add if there is a matching DT node */
> +	mhi_assign_of_node(mhi_cntrl, mhi_dev);
> +
> +	ret = device_add(&mhi_dev->dev);
> +	if (ret) {
> +		dev_err(mhi_cntrl->dev, "Failed to register dev for  chan:%s\n",
> +			mhi_dev->chan_name);
> +		mhi_dealloc_device(mhi_cntrl, mhi_dev);
> +		return;
> +	}
> +
> +	mhi_cntrl->tsync_dev = mhi_dev;
> +}
> +
>  /* bind mhi channels into mhi devices */
>  void mhi_create_devices(struct mhi_controller *mhi_cntrl)
>  {
> @@ -555,6 +625,13 @@ void mhi_create_devices(struct mhi_controller *mhi_cntrl)
>  	struct mhi_device *mhi_dev;
>  	int ret;
>  
> +	/*
> +	 * we need to create time sync device before creating other
> +	 * devices, because client may try to capture time during
> +	 * clint probe.

	   client

> +	 */
> +	mhi_create_time_sync_dev(mhi_cntrl);
> +
>  	mhi_chan = mhi_cntrl->mhi_chan;
>  	for (i = 0; i < mhi_cntrl->max_chan; i++, mhi_chan++) {
>  		if (!mhi_chan->configured || mhi_chan->ee != mhi_cntrl->ee)
> @@ -753,16 +830,26 @@ static void mhi_process_cmd_completion(struct mhi_controller *mhi_cntrl,
>  	struct mhi_ring *mhi_ring = &cmd_ring->ring;
>  	struct mhi_tre *cmd_pkt;
>  	struct mhi_chan *mhi_chan;
> +	struct mhi_timesync *mhi_tsync;
> +	enum mhi_cmd_type type;
>  	u32 chan;
>  
>  	cmd_pkt = mhi_to_virtual(mhi_ring, ptr);
>  
> -	chan = MHI_TRE_GET_CMD_CHID(cmd_pkt);
> -	mhi_chan = &mhi_cntrl->mhi_chan[chan];
> -	write_lock_bh(&mhi_chan->lock);
> -	mhi_chan->ccs = MHI_TRE_GET_EV_CODE(tre);
> -	complete(&mhi_chan->completion);
> -	write_unlock_bh(&mhi_chan->lock);
> +	type = MHI_TRE_GET_CMD_TYPE(cmd_pkt);
> +
> +	if (type == MHI_CMD_TYPE_TSYNC) {
> +		mhi_tsync = mhi_cntrl->mhi_tsync;
> +		mhi_tsync->ccs = MHI_TRE_GET_EV_CODE(tre);
> +		complete(&mhi_tsync->completion);
> +	} else {
> +		chan = MHI_TRE_GET_CMD_CHID(cmd_pkt);
> +		mhi_chan = &mhi_cntrl->mhi_chan[chan];
> +		write_lock_bh(&mhi_chan->lock);
> +		mhi_chan->ccs = MHI_TRE_GET_EV_CODE(tre);
> +		complete(&mhi_chan->completion);
> +		write_unlock_bh(&mhi_chan->lock);
> +	}
>  
>  	mhi_del_ring_element(mhi_cntrl, mhi_ring);
>  }
> @@ -929,6 +1016,73 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
>  	return count;
>  }
>  
> +int mhi_process_tsync_event_ring(struct mhi_controller *mhi_cntrl,
> +				 struct mhi_event *mhi_event,
> +				 u32 event_quota)
> +{
> +	struct mhi_tre *dev_rp, *local_rp;
> +	struct mhi_ring *ev_ring = &mhi_event->ring;
> +	struct mhi_event_ctxt *er_ctxt =
> +		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
> +	struct mhi_timesync *mhi_tsync = mhi_cntrl->mhi_tsync;
> +	int count = 0;
> +	u32 sequence;
> +	u64 remote_time;
> +
> +	if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state))) {
> +		read_unlock_bh(&mhi_cntrl->pm_lock);
> +		return -EIO;
> +	}
> +
> +	dev_rp = mhi_to_virtual(ev_ring, er_ctxt->rp);
> +	local_rp = ev_ring->rp;
> +
> +	while (dev_rp != local_rp) {
> +		struct tsync_node *tsync_node;
> +
> +		sequence = MHI_TRE_GET_EV_SEQ(local_rp);
> +		remote_time = MHI_TRE_GET_EV_TIME(local_rp);
> +
> +		do {
> +			spin_lock_irq(&mhi_tsync->lock);
> +			tsync_node = list_first_entry_or_null(&mhi_tsync->head,
> +						      struct tsync_node, node);
> +
> +			if (unlikely(!tsync_node))
> +				break;
> +
> +			list_del(&tsync_node->node);
> +			spin_unlock_irq(&mhi_tsync->lock);
> +
> +			/*
> +			 * device may not able to process all time sync commands
> +			 * host issue and only process last command it receive
> +			 */
> +			if (tsync_node->sequence == sequence) {
> +				tsync_node->cb_func(tsync_node->mhi_dev,
> +						    sequence,
> +						    tsync_node->local_time,
> +						    remote_time);
> +				kfree(tsync_node);
> +			} else {
> +				kfree(tsync_node);
> +			}
> +		} while (true);
> +
> +		mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
> +		local_rp = ev_ring->rp;
> +		dev_rp = mhi_to_virtual(ev_ring, er_ctxt->rp);
> +		count++;
> +	}
> +
> +	read_lock_bh(&mhi_cntrl->pm_lock);
> +	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl->pm_state)))
> +		mhi_ring_er_db(mhi_event);
> +	read_unlock_bh(&mhi_cntrl->pm_lock);
> +
> +	return count;
> +}
> +
>  void mhi_ev_task(unsigned long data)
>  {
>  	struct mhi_event *mhi_event = (struct mhi_event *)data;
> @@ -1060,6 +1214,12 @@ int mhi_send_cmd(struct mhi_controller *mhi_cntrl,
>  		cmd_tre->dword[0] = MHI_TRE_CMD_START_DWORD0;
>  		cmd_tre->dword[1] = MHI_TRE_CMD_START_DWORD1(chan);
>  		break;
> +	case MHI_CMD_TIMSYNC_CFG:
> +		cmd_tre->ptr = MHI_TRE_CMD_TSYNC_CFG_PTR;
> +		cmd_tre->dword[0] = MHI_TRE_CMD_TSYNC_CFG_DWORD0;
> +		cmd_tre->dword[1] = MHI_TRE_CMD_TSYNC_CFG_DWORD1
> +			(mhi_cntrl->mhi_tsync->er_index);
> +		break;
>  	}
>  
>  	/* queue to hardware */
> @@ -1437,3 +1597,94 @@ int mhi_poll(struct mhi_device *mhi_dev,
>  	return ret;
>  }
>  EXPORT_SYMBOL(mhi_poll);
> +
> +/**
> + * mhi_get_remote_time - Get external modem time relative to host time
> + * Trigger event to capture modem time, also capture host time so client
> + * can do a relative drift comparision.
> + * Recommended only tsync device calls this method and do not call this
> + * from atomic context
> + * @mhi_dev: Device associated with the channels
> + * @sequence:unique sequence id track event
> + * @cb_func: callback function to call back
> + */
> +int mhi_get_remote_time(struct mhi_device *mhi_dev,
> +			u32 sequence,
> +			void (*cb_func)(struct mhi_device *mhi_dev,
> +					u32 sequence,
> +					u64 local_time,
> +					u64 remote_time))
> +{
> +	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
> +	struct mhi_timesync *mhi_tsync = mhi_cntrl->mhi_tsync;
> +	struct tsync_node *tsync_node;
> +	int ret;
> +
> +	/* not all devices support time feature */
> +	if (!mhi_tsync)
> +		return -EIO;
> +
> +	/* tsync db can only be rung in M0 state */
> +	ret = __mhi_device_get_sync(mhi_cntrl);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * technically we can use GFP_KERNEL, but wants to avoid

	                                          want

> +	 * # of times scheduling out
> +	 */




-- 
~Randy
