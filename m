Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7BCC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 00:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1838A20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 00:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hLaXA0m6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1838A20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439210AbeKWKqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 05:46:24 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:42546 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733280AbeKWKqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 05:46:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EV/6CX4YVSwrMAUO/QgiUIJuemdrfVOOgyIUmTRV2Ac=; b=hLaXA0m6dnZBpZhx9dHaGlOnI
        YpCawVkU9gl8f4s00SKB94xqz9lFdDBKJ//Dz1A1SjA+/B5XRokZ9KKW4VJRjTpfYO60nx73PgoEc
        xlqO3MtTbDtM6ZjAiuqOFBjuLpa9PCEvVlQjAugpQbhVrtyXB0O2NjsSnu+x024fkGocI=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:40483)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gPyxS-0004o7-JH; Fri, 23 Nov 2018 00:04:30 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gPyxP-0007me-Tu; Fri, 23 Nov 2018 00:04:28 +0000
Date:   Fri, 23 Nov 2018 00:04:25 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.9 09/15] ARM: make lookup_processor_type()
 non-__init
Message-ID: <20181123000425.GN30658@n2100.armlinux.org.uk>
References: <20181122195621.13776-1-sashal@kernel.org>
 <20181122195621.13776-9-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122195621.13776-9-sashal@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This, and your patch 11 aren't fixes on their own.  They're part of a
rework for the "ARM: spectre-v2: per-CPU vtables to work around
big.Little systems" patch.  It doesn't make sense to back port these
without that patch, even though they can be applied without.

On Thu, Nov 22, 2018 at 02:56:15PM -0500, Sasha Levin wrote:
> From: Russell King <rmk+kernel@armlinux.org.uk>
> 
> [ Upstream commit 899a42f836678a595f7d2bc36a5a0c2b03d08cbc ]
> 
> Move lookup_processor_type() out of the __init section so it is callable
> from (eg) the secondary startup code during hotplug.
> 
> Reviewed-by: Julien Thierry <julien.thierry@arm.com>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/arm/kernel/head-common.S | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
> index 8733012d231f..7e662bdd5cb3 100644
> --- a/arch/arm/kernel/head-common.S
> +++ b/arch/arm/kernel/head-common.S
> @@ -122,6 +122,9 @@ __mmap_switched_data:
>  	.long	init_thread_union + THREAD_START_SP @ sp
>  	.size	__mmap_switched_data, . - __mmap_switched_data
>  
> +	__FINIT
> +	.text
> +
>  /*
>   * This provides a C-API version of __lookup_processor_type
>   */
> @@ -133,9 +136,6 @@ ENTRY(lookup_processor_type)
>  	ldmfd	sp!, {r4 - r6, r9, pc}
>  ENDPROC(lookup_processor_type)
>  
> -	__FINIT
> -	.text
> -
>  /*
>   * Read processor ID register (CP#15, CR0), and look up in the linker-built
>   * supported processor list.  Note that we can't use the absolute addresses
> -- 
> 2.17.1
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
