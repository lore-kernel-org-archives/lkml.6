Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3539916256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA19E20894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EA/h80vv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA19E20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbeG3Rx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:53:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53714 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbeG3Rx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xZBrz5ToQWG8+o4OIXs1moVLnTDYBtGWf3mZpASMw4Q=; b=EA/h80vvzPaKJYCtV6sOCLTc5
        FzDoh/hr9rWw1wYe6IV4cVRguR28wF4wbLsuj1g4srisgRs20bH3V5jINEGyLJSCDI2k9DSP+wwSs
        llaV5F2fdR+x6lfALB0CeVE08DenjZaeglSGglT0ZTzuvwzkvu2828if9aOJGAIFWQg4zH9YINwCr
        fgjlVJlDbLjiIkEwknv4wCVgQ9MHXL2oAyE4T3teF3O8VjbqCrJ7AIpLjf1NIcG3sC7EUvHU1QZPz
        cAO2SsxB7zWZGBbJ9ecco6b6qa7Il+uEA9M+91Tr6ooswb5AD/S5LOrDs3PP+cn863HNZeb4FaTmp
        jIkzdKBuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkArc-0004yH-Cp; Mon, 30 Jul 2018 16:17:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D039120275F3E; Mon, 30 Jul 2018 18:17:38 +0200 (CEST)
Date:   Mon, 30 Jul 2018 18:17:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jacek Tomaka <jacekt@dugeo.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        Jacek Tomaka <jacek.tomaka@poczta.fm>
Subject: Re: [PATCH v2] perf/x86/intel: Add support for MISPREDICT bit on
 Knights Landing cpus
Message-ID: <20180730161738.GL2494@hirez.programming.kicks-ass.net>
References: <20180730142813.13451-1-jacekt@dugeo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730142813.13451-1-jacekt@dugeo.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 10:28:13PM +0800, Jacek Tomaka wrote:
> From: Jacek Tomaka <jacek.tomaka@poczta.fm>
> 
> Problem: perf did not show branch predicted/mispredicted bit in brstack.
> 
> Output of perf -F brstack for profile collected
> 
> Before: 
> 0x4fdbcd/0x4fdc03/-/-/-/0
> 0x45f4c1/0x4fdba0/-/-/-/0
> 0x45f544/0x45f4bb/-/-/-/0
> 0x45f555/0x45f53c/-/-/-/0
> 0x7f66901cc24b/0x45f555/-/-/-/0
> 0x7f66901cc22e/0x7f66901cc23d/-/-/-/0
> 0x7f66901cc1ff/0x7f66901cc20f/-/-/-/0
> 0x7f66901cc1e8/0x7f66901cc1fc/-/-/-/0
> 
> After: 
> 0x4fdbcd/0x4fdc03/P/-/-/0
> 0x45f4c1/0x4fdba0/P/-/-/0
> 0x45f544/0x45f4bb/P/-/-/0
> 0x45f555/0x45f53c/P/-/-/0
> 0x7f66901cc24b/0x45f555/P/-/-/0
> 0x7f66901cc22e/0x7f66901cc23d/P/-/-/0 
> 0x7f66901cc1ff/0x7f66901cc20f/P/-/-/0
> 0x7f66901cc1e8/0x7f66901cc1fc/P/-/-/0
> 
> Cause: 
> As mentioned in Software Development Manual vol 3, 17.4.8.1,
> IA32_PERF_CAPABILITIES[5:0] indicates the format of the address that is
> stored in the LBR stack. Knights Landing reports 1 (LBR_FORMAT_LIP) as
> its format. Despite that, registers containing FROM address of the branch,
> do have MISPREDICT bit but because of the format indicated in
> IA32_PERF_CAPABILITIES[5:0], LBR did not read MISPREDICT bit.
> 
> Solution: 
> Teach LBR about above Knights Landing quirk and make it read MISPREDICT bit.
> ---
>  arch/x86/events/intel/lbr.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index cf372b9055..043aa09f3a 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -19,7 +19,7 @@ enum {
>  	LBR_FORMAT_MAX_KNOWN    = LBR_FORMAT_TIME,
>  };
>  
> -static const enum {
> +static enum {
>  	LBR_EIP_FLAGS		= 1,
>  	LBR_TSX			= 2,
>  } lbr_desc[LBR_FORMAT_MAX_KNOWN + 1] = {
> @@ -1230,4 +1230,8 @@ void intel_pmu_lbr_init_knl(void)
>  
>  	x86_pmu.lbr_sel_mask = LBR_SEL_MASK;
>  	x86_pmu.lbr_sel_map  = snb_lbr_sel_map;
> +
> +	/* Knights Landing does have MISPREDICT bit */
> +	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_LIP)
> +		lbr_desc[LBR_FORMAT_LIP] |= LBR_EIP_FLAGS;
>  }

So why not set lbr_format to LBR_FORMAT_EIP_FLAGS ?
