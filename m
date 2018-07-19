Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77ECCC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3533C20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3533C20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731654AbeGSOoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:44:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42404 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731442AbeGSOob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:44:31 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6pmPNEiYkfxG; Thu, 19 Jul 2018 16:01:11 +0200 (CEST)
Received: from nazgul.tnic (77-85-109-49.ip.btc-net.bg [77.85.109.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 359931EC0136;
        Thu, 19 Jul 2018 16:01:11 +0200 (CEST)
Date:   Thu, 19 Jul 2018 16:01:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tyler Baicar <tbaicar@codeaurora.org>, james.morse@arm.com
Cc:     mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
Message-ID: <20180719140102.GB25185@nazgul.tnic>
References: <1531762009-15112-1-git-send-email-tbaicar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1531762009-15112-1-git-send-email-tbaicar@codeaurora.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 01:26:49PM -0400, Tyler Baicar wrote:
> Enable per-layer error reporting for ARM systems so that the error
> counters are incremented per-DIMM.
> 
> On ARM systems that use firmware first error handling it is understood
> that card=channel and module=DIMM on that channel. Populate that
> information and enable per layer error reporting for ARM systems so that
> the EDAC error counters are incremented based on DIMM number as per the
> SMBIOS table rather than just incrementing the noinfo counters on the
> memory controller.

I guess.

James?

> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> ---
>  drivers/edac/ghes_edac.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 473aeec..e4c8b6e 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -213,9 +213,18 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  	strcpy(e->label, "unknown label");
>  	e->msg = pvt->msg;
>  	e->other_detail = pvt->other_detail;
> -	e->top_layer = -1;
> -	e->mid_layer = -1;
> -	e->low_layer = -1;

<----- newline here.

> +	if ((IS_ENABLED(CONFIG_ARM) || IS_ENABLED(CONFIG_ARM64))
> +	    && (mem_err->validation_bits & CPER_MEM_VALID_CARD)
> +	    && (mem_err->validation_bits & CPER_MEM_VALID_MODULE)) {
> +		e->top_layer = mem_err->card;
> +		e->mid_layer = mem_err->module;
> +		e->low_layer = -1;
> +		e->enable_per_layer_report = true;
> +	} else {
> +		e->top_layer = -1;
> +		e->mid_layer = -1;
> +		e->low_layer = -1;
> +	}

ditto.

>  	*pvt->other_detail = '\0';
>  	*pvt->msg = '\0';
>  
> -- 

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
