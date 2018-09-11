Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65907C4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F4520865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AeZ6e66b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F4520865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbeILEDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:03:35 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46528 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725738AbeILEDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:03:35 -0400
Received: by mail-pl1-f193.google.com with SMTP id t19-v6so12009312ply.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 16:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6jvIH1/RpXbUD3Cd0einF5JG9jeA+nElx1adpF6R5Ro=;
        b=AeZ6e66buNGXS5xsU32gM2R2Gq9xOKVKhgL5X/SK00hyiAjTbFYGrwd81TH4tVuy/N
         bgAioOtgcGGABnR04QJ10Z/rhx/w1006x1KjEoaDdP9t29gT5hJu4PDT3WQMThVwrstj
         ahl5go7cz9GBFxn/KeHhlnsmjP8rwDpiaC9a8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6jvIH1/RpXbUD3Cd0einF5JG9jeA+nElx1adpF6R5Ro=;
        b=WDnagUSkkDtUIx2IGA4+Lk4KXpGGhOEp35BhEr2Nybbg3VwSEoB+BAa/AZZOnGf9If
         DNtwQ+3uNVqtsYKOeMs7l1t59IA2fLj+7LdOYS+4nnH0vgbMiogNKzIkmGKyhX3m4iUD
         M+vz0y02+DY0lTF2sYSMTnMAF4+22oDWk/huXO0VcpCtwO1B+Nip2O6/N/VNriFLWXhG
         scZZxVyi1oOAm0CQQ1/42lgXaVJZVToaO1NsS91YeF003SusxXE8E04t95XeFaS6h5SX
         yEvuQVmtKXM6a9EVljUF01INUbJ5O4y1vip/cxDpTob/aux1xmCP54aXxzySw5jMbAHn
         z71A==
X-Gm-Message-State: APzg51AxP7Gz8EbarQEz6Azk2AGe/ksRxSX2uvUTeOQyMvynQ0IwsDoz
        6RHX7qPcnTrtorTmN/NSExQ1pg==
X-Google-Smtp-Source: ANB0VdbacWXx+saxVrVpqV7amqLruUnkuzKy5Z8WtZKSqvpGjbIkNAHU1Q39VKdaPVxXgUmUzSfbBA==
X-Received: by 2002:a17:902:c7:: with SMTP id a65-v6mr29168836pla.264.1536706924809;
        Tue, 11 Sep 2018 16:02:04 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id d6-v6sm42332620pgt.66.2018.09.11.16.02.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 16:02:04 -0700 (PDT)
Date:   Tue, 11 Sep 2018 16:02:03 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Raju P L S S S N <rplsssn@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, ilina@codeaurora.org
Subject: Re: [PATCH v2 3/6] drivers: qcom: rpmh: disallow active requests in
 solver mode
Message-ID: <20180911230203.GI22824@google.com>
References: <1532685889-31345-1-git-send-email-rplsssn@codeaurora.org>
 <1532685889-31345-4-git-send-email-rplsssn@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1532685889-31345-4-git-send-email-rplsssn@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raju/Lina,

On Fri, Jul 27, 2018 at 03:34:46PM +0530, Raju P L S S S N wrote:
> From: Lina Iyer <ilina@codeaurora.org>
> 
> Controllers may be in 'solver' state, where they could be in autonomous
> mode executing low power modes for their hardware and as such are not
> available for sending active votes. Device driver may notify RPMH API
> that the controller is in solver mode and when in such mode, disallow
> requests from platform drivers for state change using the RSC.
> 
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> ---
>  drivers/soc/qcom/rpmh-internal.h |  2 ++
>  drivers/soc/qcom/rpmh.c          | 59 ++++++++++++++++++++++++++++++++++++++++
>  include/soc/qcom/rpmh.h          |  5 ++++
>  3 files changed, 66 insertions(+)
> 
> diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
> index 4ff43bf..6cd2f78 100644
> --- a/drivers/soc/qcom/rpmh-internal.h
> +++ b/drivers/soc/qcom/rpmh-internal.h
> @@ -72,12 +72,14 @@ struct rpmh_request {
>   * @cache_lock: synchronize access to the cache data
>   * @dirty: was the cache updated since flush
>   * @batch_cache: Cache sleep and wake requests sent as batch
> + * @in_solver_mode: Controller is busy in solver mode
>   */
>  struct rpmh_ctrlr {
>  	struct list_head cache;
>  	spinlock_t cache_lock;
>  	bool dirty;
>  	struct list_head batch_cache;
> +	bool in_solver_mode;
>  };
>  
>  /**
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index 2382276..0d276fd 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -5,6 +5,7 @@
>  
>  #include <linux/atomic.h>
>  #include <linux/bug.h>
> +#include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
> @@ -75,6 +76,50 @@ static struct rpmh_ctrlr *get_rpmh_ctrlr(const struct device *dev)
>  	return &drv->client;
>  }
>  
> +static int check_ctrlr_state(struct rpmh_ctrlr *ctrlr, enum rpmh_state state)
> +{
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	/* Do not allow setting active votes when in solver mode */
> +	spin_lock_irqsave(&ctrlr->cache_lock, flags);
> +	if (ctrlr->in_solver_mode && state == RPMH_ACTIVE_ONLY_STATE)
> +		ret = -EBUSY;
> +	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
> +
> +	return ret;
> +}
> +
> +/**
> + * rpmh_mode_solver_set: Indicate that the RSC controller hardware has
> + * been configured to be in solver mode
> + *
> + * @dev: the device making the request
> + * @enable: Boolean value indicating if the controller is in solver mode.
> + *
> + * When solver mode is enabled, passthru API will not be able to send wake
> + * votes, just awake and active votes.
> + */
> +int rpmh_mode_solver_set(const struct device *dev, bool enable)
> +{
> +	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
> +	unsigned long flags;
> +
> +	for (;;) {
> +		spin_lock_irqsave(&ctrlr->cache_lock, flags);
> +		if (rpmh_rsc_ctrlr_is_idle(ctrlr_to_drv(ctrlr))) {
> +			ctrlr->in_solver_mode = enable;

As commented on '[v2,1/6] drivers: qcom: rpmh-rsc: return if the
controller is idle', this seems potentially
racy. _is_idle() could report the controller as idle, even though some
TCSes are in use (after _is_idle() visited them).

Additional locking may be needed or a comment if this situation should
never happen on a sane system (I don't know enough about RPMh and its
clients to judge if this is the case).
