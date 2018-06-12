Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AEBABC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517872086E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LRnTKc9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517872086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933406AbeFLTma (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 15:42:30 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38504 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932926AbeFLTm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 15:42:28 -0400
Received: by mail-pl0-f65.google.com with SMTP id b14-v6so74250pls.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 12:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z8tWk21EbOUM/7yZ5vR3wRSPVlC0AC0/fpwGfzSWhBw=;
        b=LRnTKc9JGdpVFvBJGWoEKakKeI7x5wmyY91s7ETf0OZRNJ8VU/566aD/APqA2xbp9T
         Y0uz5ACH75A9J8i/FAJ3tH33d2CCFv+HNrDrEdXyWTlxD1t6G7gJmU5Ymx8LVF4JwR/3
         v/laIeor7dn6LObzouDA81jQ06YuTayLbri1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z8tWk21EbOUM/7yZ5vR3wRSPVlC0AC0/fpwGfzSWhBw=;
        b=WgF2oimKt+uvqAND1E74oZbEFs4oGtkfBzCF7qUggD03sJAJ2MM5cwNAmmpZU33E49
         B004XrdQftWM6RAco9byzVtsZxItN2jZJU1jPVvCXD7xAKGk2Vjk9MPGJMDgaHmpDPwF
         JImGtDJj1TJsIhq0Bv+I6UvLSbhzxteKVaz+LJC1DK304OmNjsAJSBFSyI25HNkh8977
         JB0WGB57YPW5WHvCfhbaA6qqmCUjbkUdtIEwQcYwSCaMVkeQ6A5ebC9NiegHLZjLughz
         kche0ArwaWAlOP/3TVAZ5cmP2OnZCXZsqZtdLjPXPFX5IU4gsqrccyeky4igjhWara5f
         uGHQ==
X-Gm-Message-State: APt69E2ADxiLYdWmfxQc8XO/+gcZbnYyZmBnwMLyHP/su3/8bBMrvYvH
        jS5IXtVZ2NDR4NJIDqjfGSQpBg==
X-Google-Smtp-Source: ADUXVKIM32OBXh+QET25RX4/WJJvLm/SvSlCvYX15vJN++BjrD0eV6y49lL5k2QUL2LY8B2qjmkvLQ==
X-Received: by 2002:a17:902:981:: with SMTP id 1-v6mr1870103pln.11.1528832548029;
        Tue, 12 Jun 2018 12:42:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id j127-v6sm1150382pgc.10.2018.06.12.12.42.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 12:42:26 -0700 (PDT)
Date:   Tue, 12 Jun 2018 12:42:26 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] soc: qcom: Add RPMh Power domain driver
Message-ID: <20180612194226.GI88063@google.com>
References: <20180612044052.4402-1-rnayak@codeaurora.org>
 <20180612044052.4402-7-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180612044052.4402-7-rnayak@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 12, 2018 at 10:10:51AM +0530, Rajendra Nayak wrote:
> The RPMh Power domain driver aggregates the corner votes from various
> consumers for the ARC resources and communicates it to RPMh.
> 
> We also add data for all power domains on sdm845 SoC as part of the patch.
> The driver can be extended to support other SoCs which support RPMh
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/soc/qcom/Kconfig                |   9 +
>  drivers/soc/qcom/Makefile               |   1 +
>  drivers/soc/qcom/rpmhpd.c               | 427 ++++++++++++++++++++++++
>  include/dt-bindings/power/qcom-rpmhpd.h |  31 ++
>  4 files changed, 468 insertions(+)
>  create mode 100644 drivers/soc/qcom/rpmhpd.c
>  create mode 100644 include/dt-bindings/power/qcom-rpmhpd.h
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 5c54931a7b99..7cb7eba2b997 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -74,6 +74,15 @@ config QCOM_RMTFS_MEM
>  
>  	  Say y here if you intend to boot the modem remoteproc.
>  
> +config QCOM_RPMHPD
> +	tristate "Qualcomm RPMh Power domain driver"
> +	depends on QCOM_RPMH && QCOM_COMMAND_DB
> +	help
> +	  QCOM RPMh Power domain driver to support power-domains with
> +	  performance states. The driver communicates a performance state
> +	  value to RPMh which then translates it into corresponding voltage
> +	  for the voltage rail.
> +
>  config QCOM_RPMPD
>  	tristate "Qualcomm RPM Power domain driver"
>  	depends on MFD_QCOM_RPM && QCOM_SMD_RPM
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 9550c170de93..499513f63bef 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -16,3 +16,4 @@ obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
>  obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
>  obj-$(CONFIG_QCOM_APR) += apr.o
>  obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
> +obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> new file mode 100644
> index 000000000000..7083ec1590ff
> --- /dev/null
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -0,0 +1,427 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2018, The Linux Foundation. All rights reserved.*/
> +
> +#include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_domain.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
> +#include <soc/qcom/cmd-db.h>
> +#include <soc/qcom/rpmh.h>
> +#include <dt-bindings/power/qcom-rpmhpd.h>
> +
> +#define domain_to_rpmhpd(domain) container_of(domain, struct rpmhpd, pd)
> +
> +#define DEFINE_RPMHPD_AO(_platform, _name, _active)			\
> +	static struct rpmhpd _platform##_##_active;			\
> +	static struct rpmhpd _platform##_##_name = {			\
> +		.pd = {	.name = #_name,	},				\
> +		.peer = &_platform##_##_active,				\
> +		.res_name = #_name".lvl",				\
> +		.valid_state_mask = (BIT(RPMH_ACTIVE_ONLY_STATE) |	\
> +					BIT(RPMH_WAKE_ONLY_STATE) |	\
> +					BIT(RPMH_SLEEP_STATE)),		\
> +	};								\
> +	static struct rpmhpd _platform##_##_active = {			\
> +		.pd = { .name = #_active, },				\
> +		.peer = &_platform##_##_name,				\
> +		.active_only = true,					\
> +		.res_name = #_name".lvl",				\
> +		.valid_state_mask = (BIT(RPMH_ACTIVE_ONLY_STATE) |	\
> +					BIT(RPMH_WAKE_ONLY_STATE) |	\
> +					BIT(RPMH_SLEEP_STATE)),		\
> +	}
> +
> +#define DEFINE_RPMHPD(_platform, _name)					\
> +	static struct rpmhpd _platform##_##_name = {			\
> +		.pd = { .name = #_name, },				\
> +		.res_name = #_name".lvl",				\
> +		.valid_state_mask = BIT(RPMH_ACTIVE_ONLY_STATE),	\
> +	}

Perhaps describe briefly the concept of an AO (active-only) and a peer
domain. It is not necessarily evident why an AO domain would have
WAKE_ONLY and SLEEP_ONLY as valid states, while the non-AO domain has
ACTIVE_ONLY as it's only state.

> +/*
> + * This function is used to aggregate the votes across the active only
> + * resources and its peers. The aggregated votes are send to RPMh as

s/send/sent/

> + * ACTIVE_ONLY votes (which take effect immediately), as WAKE_ONLY votes
> + * (applied by RPMh on system wakeup) and as SLEEP votes (applied by RPMh
> + * on system sleep).
> + * We send ACTIVE_ONLY votes for resources without any peers. For others,
> + * which have an active only peer, all 3 Votes are sent.

s/Votes/votes/

> +static int rpmhpd_probe(struct platform_device *pdev)
> +{
> +	int i, ret;
> +	size_t num;

nit: naming this num_pds would slightly improve readability (e.g. make
it evident that the for loop iterates over the PDs).

> +	struct genpd_onecell_data *data;
> +	struct rpmhpd **rpmhpds;
> +	const struct rpmhpd_desc *desc;
> +
> +	desc = of_device_get_match_data(&pdev->dev);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	rpmhpds = desc->rpmhpds;
> +	num = desc->num_pds;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->domains = devm_kcalloc(&pdev->dev, num, sizeof(*data->domains),
> +				     GFP_KERNEL);

Check for NULL?

Thanks

Matthias
