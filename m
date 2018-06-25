Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79EEC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 04:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF5725450
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 04:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2NFBSDbb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF5725450
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751155AbeFYEnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 00:43:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750927AbeFYEnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 00:43:16 -0400
Received: from localhost (unknown [223.226.41.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 847EA2539D;
        Mon, 25 Jun 2018 04:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529901795;
        bh=wulRDZqE22izajbCSGbSkuB9XyWgGePeWVkN4IxDDnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2NFBSDbbovESjJrMpqBTowXecorl7HRfGEWuZc8r/RrZV1uutqhYVcBAQYl06ctud
         EUDV8zHuHoqIOvTRme/sgTVmKRnYJfVTI1XNgrDbksD3GTfwOBzOFrXLsC3eUjG7fd
         j/PqvfzxsFSQUL8hBw0U6qElDp2akqm3x0i6Ix1Y=
Date:   Mon, 25 Jun 2018 10:13:06 +0530
From:   Vinod <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     gregkh@linuxfoundation.org, broonie@kernel.org,
        sdharia@quicinc.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        ctatlor97@gmail.com
Subject: Re: [PATCH 2/2] slimbus: ngd: add stream support
Message-ID: <20180625044306.GA2404@vkoul-mobl>
References: <20180621134009.27116-1-srinivas.kandagatla@linaro.org>
 <20180621134009.27116-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621134009.27116-3-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-06-18, 14:40, Srinivas Kandagatla wrote:

> +	if (txn->mt == SLIM_MSG_MT_CORE &&
> +		(txn->mc == SLIM_MSG_MC_CONNECT_SOURCE ||
> +		txn->mc == SLIM_MSG_MC_CONNECT_SINK ||
> +		txn->mc == SLIM_MSG_MC_DISCONNECT_PORT)) {
> +
> +		txn->mt = SLIM_MSG_MT_DEST_REFERRED_USER;
> +		if (txn->mc == SLIM_MSG_MC_CONNECT_SOURCE)
> +			txn->mc = SLIM_USR_MC_CONNECT_SRC;
> +		else if (txn->mc == SLIM_MSG_MC_CONNECT_SINK)
> +			txn->mc = SLIM_USR_MC_CONNECT_SINK;
> +		else if (txn->mc == SLIM_MSG_MC_DISCONNECT_PORT)
> +			txn->mc = SLIM_USR_MC_DISCONNECT_PORT;

How about a switch case for this

> +		i = 0;
> +		wbuf[i++] = txn->la;
> +		la = SLIM_LA_MGR;
> +		wbuf[i++] = txn->msg->wbuf[0];
> +		if (txn->mc != SLIM_USR_MC_DISCONNECT_PORT)
> +			wbuf[i++] = txn->msg->wbuf[1];
> +
> +		txn->comp = &done;
> +		ret = slim_alloc_txn_tid(sctrl, txn);
> +		if (ret) {
> +			dev_err(ctrl->dev, "Unable to allocate TID\n");
> +			return ret;
> +		}
> +
> +		wbuf[i++] = txn->tid;
> +
> +		txn->msg->num_bytes = i;
> +		txn->msg->wbuf = wbuf;
> +		txn->msg->rbuf = rbuf;
> +		txn->rl = txn->msg->num_bytes + 4;
> +	}
> +
>  	/* HW expects length field to be excluded */
>  	txn->rl--;
>  	puc = (u8 *)pbuf;
> @@ -830,6 +869,19 @@ static int qcom_slim_ngd_xfer_msg(struct slim_controller *sctrl,
>  		return -ETIMEDOUT;
>  	}
>  
> +	if (txn->mt == SLIM_MSG_MT_DEST_REFERRED_USER &&
> +		(txn->mc == SLIM_USR_MC_CONNECT_SRC ||
> +		 txn->mc == SLIM_USR_MC_CONNECT_SINK ||
> +		 txn->mc == SLIM_USR_MC_DISCONNECT_PORT)) {

how about precalculate this check and use:
        bool something = txn->mt == SLIM_MSG_MT_DEST_REFERRED_USER &&
                              txn->mc == SLIM_USR_MC_CONNECT_SRC ||
                              txn->mc == SLIM_USR_MC_CONNECT_SINK ||
                              txn->mc == SLIM_USR_MC_DISCONNECT_PORT;

and then use in this case and previous one, make code better to read

        if (something) {
> +		timeout = wait_for_completion_timeout(&done, HZ);
> +		if (!timeout) {
> +			dev_err(sctrl->dev, "TX timed out:MC:0x%x,mt:0x%x",
> +				txn->mc, txn->mt);
> +			return -ETIMEDOUT;
> +		}
> +
> +	}
> +

[...]

> +		struct slim_port *port = &rt->ports[i];
> +
> +		if (txn.msg->num_bytes == 0) {
> +			int seg_interval = SLIM_SLOTS_PER_SUPERFRAME/rt->ratem;
> +			int exp;
> +
> +			wbuf[txn.msg->num_bytes++] = sdev->laddr;
> +			wbuf[txn.msg->num_bytes] = rt->bps >> 2 |
> +						   (port->ch.aux_fmt << 6);
> +
> +			/* Data channel segment interval not multiple of 3 */
> +			exp = seg_interval % 3;
> +			if (exp)
> +				wbuf[txn.msg->num_bytes] |= BIT(5);
> +
> +			txn.msg->num_bytes++;
> +			wbuf[txn.msg->num_bytes++] = exp << 4 | rt->prot;
> +
> +			if (rt->prot == SLIM_PROTO_ISO)
> +				wbuf[txn.msg->num_bytes++] =
> +						port->ch.prrate |
> +						SLIM_CHANNEL_CONTENT_FL;
> +			else
> +				wbuf[txn.msg->num_bytes++] =  port->ch.prrate;
> +
> +			ret = slim_alloc_txn_tid(ctrl, &txn);
> +			if (ret) {
> +				dev_err(&sdev->dev, "Fail to allocate TID\n");
> +				return -ENXIO;
> +			}
> +			wbuf[txn.msg->num_bytes++] = txn.tid;
> +		}
> +		wbuf[txn.msg->num_bytes++] = port->ch.id;
> +	}
> +
> +	txn.mc = SLIM_USR_MC_DEF_ACT_CHAN;
> +	txn.rl = txn.msg->num_bytes + 4;
> +	ret = qcom_slim_ngd_xfer_msg_sync(ctrl, &txn);
> +	if (ret) {
> +		slim_free_txn_tid(ctrl, &txn);
> +		dev_err(&sdev->dev, "TX timed out:MC:0x%x,mt:0x%x", txn.mc,
> +				txn.mt);
> +		return ret;
> +	}
> +
> +	txn.mc = SLIM_USR_MC_RECONFIG_NOW;
> +	txn.msg->num_bytes = 2;
> +	wbuf[1] = sdev->laddr;
> +	txn.rl = txn.msg->num_bytes + 4;
> +
> +	ret = slim_alloc_txn_tid(ctrl, &txn);
> +	if (ret) {

what about tid allocated in previous loop.. they are not freed here on
error and seems to be overwritten by this allocation.
-- 
~Vinod
