Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1893AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 00:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C757D20824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 00:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="N79U+GQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C757D20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407911AbeKWKox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 05:44:53 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:42524 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733280AbeKWKox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 05:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ll3zPgcCCM4R39XQddVEV5ht/ea+SLtI7ptO9BB4KaQ=; b=N79U+GQ/2RuIeNCS7YQ2b5XM7
        N5ELXADkeeMIeYmC2b2IS26csAJwWV4iC701TfE3pqweeBWh4XyPXwfhzY5sD90b1TSaQoiLwoZ0z
        WH41aIXyC4aCkwYgsxpbwRhAMQ6E30Y+13qbZftivY7EoXnCLB2q/Z5niNutnCTMfV1EA=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:40460)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gPyvz-0004nd-Av; Fri, 23 Nov 2018 00:02:59 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gPyvw-0007lX-KR; Fri, 23 Nov 2018 00:02:56 +0000
Date:   Fri, 23 Nov 2018 00:02:54 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 10/21] ARM: make lookup_processor_type()
 non-__init
Message-ID: <20181123000254.GM30658@n2100.armlinux.org.uk>
References: <20181122195452.13520-1-sashal@kernel.org>
 <20181122195452.13520-10-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122195452.13520-10-sashal@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

We need to keep track of which Spectre patches have been backported
and which haven't.  David Long has been doing the backport work,
which doesn't include all the patches in my present spectre branch.
You've picked up the last five, meaning there's a bunch in the middle
of the entire series which haven't yet been considered - for example,
the Spectre variant 1.1 patches.

The entire series of 32-bit ARM Spectre patches can be listed in
mainline via:

$ git log v4.16..383fb3ee8024

where almost all of those need to be applied to stable kernels, with
possible manual back-porting where they don't apply.

On Thu, Nov 22, 2018 at 02:54:41PM -0500, Sasha Levin wrote:
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
