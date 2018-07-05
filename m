Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17CFC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751D223FF6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751D223FF6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753926AbeGEPsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:48:04 -0400
Received: from muru.com ([72.249.23.125]:50450 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753677AbeGEPsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:48:02 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B2900813A;
        Thu,  5 Jul 2018 15:50:59 +0000 (UTC)
Date:   Thu, 5 Jul 2018 08:47:58 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        bcousson@baylibre.com, paul@pwsan.com, t-kristo@ti.com,
        mark.rutland@arm.com
Subject: Re: [PATCH v4 4/6] bus: ti-sysc: Add support for software reset
Message-ID: <20180705154758.GA112168@atomide.com>
References: <20180705142319.19583-1-faiz_abbas@ti.com>
 <20180705142319.19583-5-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705142319.19583-5-faiz_abbas@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [180705 14:24]:
> +static int sysc_reset(struct sysc *ddata)
> +{
> +	int offset = ddata->offsets[SYSC_SYSCONFIG];
> +	int val = sysc_read(ddata, offset);

Can you please just warn and return early for now if no
syss_mask is specified? Otherwise we'll have mysterious
errors if somebody leaves out "ti,hwmods" for module types
we do not yet support reset for.

> +	val |= (0x1 << ddata->cap->regbits->srst_shift);
> +	sysc_write(ddata, offset, val);
> +
> +	/* Poll on reset status */
> +	if (ddata->cfg.syss_mask) {
> +		offset = ddata->offsets[SYSC_SYSSTATUS];
> +
> +		return readl_poll_timeout(ddata->module_va + offset, val,
> +				(val & ddata->cfg.syss_mask) == 0x0,
> +				100, MAX_MODULE_SOFTRESET_WAIT);
> +	}
> +
> +	return 0;
> +}
> +

Otherwise looks good to me.

Thanks,

Tony
