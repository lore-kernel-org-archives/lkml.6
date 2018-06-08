Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id wyfUGo8gGlvzSAAAmS7hNA
	; Fri, 08 Jun 2018 06:22:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5BF0A608BA; Fri,  8 Jun 2018 06:22:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D1872606FA;
	Fri,  8 Jun 2018 06:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D1872606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751116AbeFHGWE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 02:22:04 -0400
Received: from muru.com ([72.249.23.125]:46294 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750837AbeFHGWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 02:22:02 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6E4A68080;
        Fri,  8 Jun 2018 06:24:32 +0000 (UTC)
Date: Thu, 7 Jun 2018 23:21:58 -0700
From: Tony Lindgren <tony@atomide.com>
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, mark.rutland@arm.com, paul@pwsan.com,
        t-kristo@ti.com, robh+dt@kernel.org, bcousson@baylibre.com
Subject: Re: [PATCH v3 4/6] bus: ti-sysc: Add support for software reset
Message-ID: <20180608062158.GI5738@atomide.com>
References: <20180606060826.14671-1-faiz_abbas@ti.com>
 <20180606060826.14671-5-faiz_abbas@ti.com>
 <20180607073530.GH5738@atomide.com>
 <a169ba7f-53f2-cf9a-a9ee-daffd6b53279@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a169ba7f-53f2-cf9a-a9ee-daffd6b53279@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [180607 10:24]:
> Hi,
> 
> On Thursday 07 June 2018 01:05 PM, Tony Lindgren wrote:
> > * Faiz Abbas <faiz_abbas@ti.com> [180606 06:14]:
> >> +static int sysc_reset(struct sysc *ddata)
> >> +{
> >> +	int offset = ddata->offsets[SYSC_SYSCONFIG];
> >> +	int val = sysc_read(ddata, offset);
> >> +
> >> +	val |= (0x1 << ddata->cap->regbits->srst_shift);
> >> +	sysc_write(ddata, offset, val);
> >> +
> >> +	/* Poll on reset status */
> >> +	if (ddata->cfg.quirks & SYSC_QUIRK_RESET_STATUS) {
> >> +		offset = ddata->offsets[SYSC_SYSSTATUS];
> >> +
> >> +		return readl_poll_timeout(ddata->module_va + offset, val,
> >> +				(val & ddata->cfg.syss_mask) == 0x0,
> >> +				100, MAX_MODULE_SOFTRESET_WAIT);
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> > 
> > I wonder if we should also add SYSS_QUIRK_RESET_STATUS in
> > addition to SYSC_QUIRK_RESET status to make it easy to
> > read the right register?
> 
> I assumed SYSC_QUIRK is the prefix to indicate the ti-sysc driver not
> the register. Are there layouts in which the reset status bit is in the
> sysconfig register rather than the sysstatus register?

Yes we can have reset status bit in either syss or syssconfig register.
We detect that in sysc_init_syss_mask() but we should also set something
at that point to make it clear which reset to use. But as we don't need
the quirk flag, it's probably set a function pointer after the detection.
So how about let's have two functions sysc_reset() and sysc_syss_reset()
and then we can implement sysc_syss_reset() in a separate patch after
testing it when we have a non-platform data using example for
sysc_syss_reset().

Regards,

Tony
