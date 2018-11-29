Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD276C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EA42146F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YHAAUkCA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74EA42146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388097AbeK3BeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:34:03 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:38620 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733011AbeK3BeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:34:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DehWX6OOHeem0oPNt/ksg5cDAitXz57Bscw5J9Q9iA0=; b=YHAAUkCAlnRSFw/YEc827ltwH
        dZLh2UbkL6It2Z6pSI1+vVmgdcdj6nTADjcJsk+DLccIYp55SzGaxuEo32uumHGu91rqZMBx+4EAI
        a2F3+ZVeVaLiXKPryD2ZgDofkQbiOd1h6z3suxiqPoYD8tcZ4+fXXd/5raQS/Hgo6y0uI=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:55124)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gSNIn-0002j1-1d; Thu, 29 Nov 2018 14:28:25 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gSNIj-0001BZ-2b; Thu, 29 Nov 2018 14:28:21 +0000
Date:   Thu, 29 Nov 2018 14:28:18 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Julien Thierry <julien.thierry@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 3.18 14/83] ARM: make lookup_processor_type() non-__init
Message-ID: <20181129142817.GW30658@n2100.armlinux.org.uk>
References: <20181129140138.002176596@linuxfoundation.org>
 <20181129140138.869602566@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129140138.869602566@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As I've already fed back to Sascha about this, this patch on its own
does not fix anything, and is not a stable kernel candidate without
a patch that makes use of it (iow, the spectre fixes.)  It is a
preparatory patch for mainline commit 383fb3ee8024.

Every commit in:

$ git rev-list v4.16..383fb3ee8024

are the ARM spectre fixes, which are being back-ported by David Long.

Please do not cherry-pick commits from within this series for _any_
stable kernel, but please wait for David to send you the back-ported
patches.

Thanks.

On Thu, Nov 29, 2018 at 03:11:32PM +0100, Greg Kroah-Hartman wrote:
> 3.18-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
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
> 
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
