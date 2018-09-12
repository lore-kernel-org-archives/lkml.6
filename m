Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EABDC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 21:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050CE2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 21:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UL6Og1Bg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050CE2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbeIMC5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 22:57:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38507 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbeIMC5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 22:57:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id u11-v6so1607017plq.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 14:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wLlo4MkG2gzWLef8oEkdDZsivwKYDtYx+sRT2bhIMWg=;
        b=UL6Og1Bgkm1lnajt+eeVIA0no6oqNynE4QNfA/xHekyKZDHLSe0Qim9OnTqZ+M0ckm
         7cq8faQ7kiEqWzAgpTS0t/qDTTVGGVL+CQUuAHdPJPyx9GzW5xNXreTdWmseQm/MoaC2
         OodWKRRrKisp2XkMkE4QYl6g/+Iu9VSo/TEFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wLlo4MkG2gzWLef8oEkdDZsivwKYDtYx+sRT2bhIMWg=;
        b=mRVtDv+XJ7QGYBSFRF2+mdUYnYoCz9EMAdOsSt67DBkYVveRteeAzKgc6cao5WmC/1
         +gwqIXKj2HWvpWroukEMdCb6Oc480bn9W8UzC74kq+dNqdmV2CDExaxAs47dpaiQ/Pb9
         Y0xJtddAcRYw9qYHdP1hy0MqiBfa7uA9oo4y66tRb2HIMGkIFOJjQz1BSpEGYxJEgUR5
         C06w9zgBzTru1DRNS1O/FvovDI19n6lr91neeDAgw2esCMqrHMl0wFggYkzxto+Yflng
         vWk0Io/KDsxzJedSRLtE0nJKQqXhQ/mAF10P9sLTlzw5ugKJQfeAXoLWbRsXEfKeENqV
         GaGQ==
X-Gm-Message-State: APzg51APUyNN2p2GVXdt8VeavDZaFg5DVsam84lsSscJQsrBRAYv8OEE
        NLbnI/K9nW6zlzWe7JOsPD2DSw==
X-Google-Smtp-Source: ANB0VdYXL0SejTItPJ8oEHEMA7reJ4rVfGVuAu/gAiBV5GKAx1CcPOjEhIVCx8qoEgEm1c3QXNmaAw==
X-Received: by 2002:a17:902:bd95:: with SMTP id q21-v6mr4283567pls.284.1536789075027;
        Wed, 12 Sep 2018 14:51:15 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id a15-v6sm3192543pfe.32.2018.09.12.14.51.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 14:51:14 -0700 (PDT)
Date:   Wed, 12 Sep 2018 14:51:13 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Raju P L S S S N <rplsssn@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, ilina@codeaurora.org
Subject: Re: [PATCH v2 4/6] drivers: qcom: rpmh-rsc: clear active mode
 configuration for waketcs
Message-ID: <20180912215113.GJ22824@google.com>
References: <1532685889-31345-1-git-send-email-rplsssn@codeaurora.org>
 <1532685889-31345-5-git-send-email-rplsssn@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1532685889-31345-5-git-send-email-rplsssn@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 03:34:47PM +0530, Raju P L S S S N wrote:
> From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
> 
> For RSCs that have sleep & wake TCS but no dedicated active TCS, wake
> TCS can be re-purposed to send active requests. Once the active requests
> are sent and response is received, the active mode configuration needs
> to be cleared so that controller can use wake TCS for sending wake
> requests in 'solver' state while executing low power modes.
> 
> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> ---
>  drivers/soc/qcom/rpmh-rsc.c | 77 +++++++++++++++++++++++++++++++--------------
>  1 file changed, 54 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index 42d0041..19616c9 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -199,6 +199,42 @@ static const struct tcs_request *get_req_from_tcs(struct rsc_drv *drv,
>  	return NULL;
>  }
>  
> +static void __tcs_trigger(struct rsc_drv *drv, int tcs_id, bool trigger)
> +{
> +	u32 enable;
> +
> +	/*
> +	 * HW req: Clear the DRV_CONTROL and enable TCS again
> +	 * While clearing ensure that the AMC mode trigger is cleared
> +	 * and then the mode enable is cleared.
> +	 */
> +	enable = read_tcs_reg(drv, RSC_DRV_CONTROL, tcs_id, 0);
> +	enable &= ~TCS_AMC_MODE_TRIGGER;
> +	write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
> +	enable &= ~TCS_AMC_MODE_ENABLE;
> +	write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
> +
> +	if (trigger) {
> +		/* Enable the AMC mode on the TCS and then trigger the TCS */
> +		enable = TCS_AMC_MODE_ENABLE;
> +		write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
> +		enable |= TCS_AMC_MODE_TRIGGER;
> +		write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
> +	}
> +}
> +
> +static inline void enable_tcs_irq(struct rsc_drv *drv, int tcs_id, bool enable)
> +{
> +	u32 data;
> +
> +	data = read_tcs_reg(drv, RSC_DRV_IRQ_ENABLE, 0, 0);
> +	if (enable)
> +		data |= BIT(tcs_id);
> +	else
> +		data &= ~BIT(tcs_id);
> +	write_tcs_reg(drv, RSC_DRV_IRQ_ENABLE, 0, data);
> +}
> +
>  /**
>   * tcs_tx_done: TX Done interrupt handler
>   */
> @@ -235,6 +271,21 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
>  		}
>  
>  		trace_rpmh_tx_done(drv, i, req, err);
> +
> +		/*
> +		 * if wake tcs was re-purposed for sending active
> +		 * votes, clear AMC trigger & enable modes and
> +		 * disable interrupt for this TCS
> +		 */
> +		if (!drv->tcs[ACTIVE_TCS].num_tcs) {
> +			__tcs_trigger(drv, i, false);
> +			/*
> +			 * Disable interrupt for this TCS to avoid being
> +			 * spammed with interrupts coming when the solver
> +			 * sends its wake votes.
> +			 */
> +			enable_tcs_irq(drv, i, false);
> +		}
>  skip:
>  		/* Reclaim the TCS */
>  		write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, i, 0);
> @@ -282,28 +333,6 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
>  	write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, tcs_id, cmd_enable);
>  }
>  
> -static void __tcs_trigger(struct rsc_drv *drv, int tcs_id)
> -{
> -	u32 enable;
> -
> -	/*
> -	 * HW req: Clear the DRV_CONTROL and enable TCS again
> -	 * While clearing ensure that the AMC mode trigger is cleared
> -	 * and then the mode enable is cleared.
> -	 */
> -	enable = read_tcs_reg(drv, RSC_DRV_CONTROL, tcs_id, 0);
> -	enable &= ~TCS_AMC_MODE_TRIGGER;
> -	write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
> -	enable &= ~TCS_AMC_MODE_ENABLE;
> -	write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
> -
> -	/* Enable the AMC mode on the TCS and then trigger the TCS */
> -	enable = TCS_AMC_MODE_ENABLE;
> -	write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
> -	enable |= TCS_AMC_MODE_TRIGGER;
> -	write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
> -}
> -
>  static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
>  				  const struct tcs_request *msg)
>  {
> @@ -374,10 +403,12 @@ static int tcs_write(struct rsc_drv *drv, const struct tcs_request *msg)
>  
>  	tcs->req[tcs_id - tcs->offset] = msg;
>  	set_bit(tcs_id, drv->tcs_in_use);
> +	if (msg->state == RPMH_ACTIVE_ONLY_STATE && tcs->type != ACTIVE_TCS)
> +		enable_tcs_irq(drv, tcs_id, true);

You might want to add a short comment here. In the context of this
patch it is (relatively) clear that the wake TCS is re-purposed for
active requests, and the interrupt is disabled by default for
non-active TCSes. However on it's own this isn't necessarily
evident without looking through the code.

>  	spin_unlock(&drv->lock);
>  
>  	__tcs_buffer_write(drv, tcs_id, 0, msg);
> -	__tcs_trigger(drv, tcs_id);
> +	__tcs_trigger(drv, tcs_id, true);
>  
>  done_write:
>  	spin_unlock_irqrestore(&tcs->lock, flags);

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
