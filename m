Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id qQITOR7gGFuIBgAAmS7hNA
	; Thu, 07 Jun 2018 07:35:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C2766608BA; Thu,  7 Jun 2018 07:35:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4FE87605A2;
	Thu,  7 Jun 2018 07:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4FE87605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753405AbeFGHff (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 03:35:35 -0400
Received: from muru.com ([72.249.23.125]:46244 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752336AbeFGHfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 03:35:34 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 221728080;
        Thu,  7 Jun 2018 07:38:03 +0000 (UTC)
Date: Thu, 7 Jun 2018 00:35:30 -0700
From: Tony Lindgren <tony@atomide.com>
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, mark.rutland@arm.com, paul@pwsan.com,
        t-kristo@ti.com, robh+dt@kernel.org, bcousson@baylibre.com
Subject: Re: [PATCH v3 4/6] bus: ti-sysc: Add support for software reset
Message-ID: <20180607073530.GH5738@atomide.com>
References: <20180606060826.14671-1-faiz_abbas@ti.com>
 <20180606060826.14671-5-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606060826.14671-5-faiz_abbas@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [180606 06:14]:
> +static int sysc_reset(struct sysc *ddata)
> +{
> +	int offset = ddata->offsets[SYSC_SYSCONFIG];
> +	int val = sysc_read(ddata, offset);
> +
> +	val |= (0x1 << ddata->cap->regbits->srst_shift);
> +	sysc_write(ddata, offset, val);
> +
> +	/* Poll on reset status */
> +	if (ddata->cfg.quirks & SYSC_QUIRK_RESET_STATUS) {
> +		offset = ddata->offsets[SYSC_SYSSTATUS];
> +
> +		return readl_poll_timeout(ddata->module_va + offset, val,
> +				(val & ddata->cfg.syss_mask) == 0x0,
> +				100, MAX_MODULE_SOFTRESET_WAIT);
> +	}
> +
> +	return 0;
> +}

I wonder if we should also add SYSS_QUIRK_RESET_STATUS in
addition to SYSC_QUIRK_RESET status to make it easy to
read the right register?

Then we can add support for SYSC_QUIRK_RESET_STATUS later on
when tested and return error for now.

Regards,

Tony
