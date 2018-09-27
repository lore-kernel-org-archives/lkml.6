Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209BDC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC744216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3O3JdOU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC744216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbeI0W03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:26:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38804 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbeI0W02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=E96MNFcFy+7043YMSx0fhWNFynk52K/oUh5k2l6uvEw=; b=3O3JdOU0TAjOSlS4Ko4jyoYiMh
        As7PSH2RGuB4mzEExi3AFuHiWgbZidOoBpaiKy1WNu1eSQBqjd00hKqrW2eb9zKkPpLn+qug1Oren
        7zZ5LKVjX0nuFvUeOoh9zlHawBVw3Ec9BKLJ7O3uYSMrDPOk7BAegy/Ndq2ywTu06jUv1LwhJBiBg
        PssWOUWBwxLnW7+AbERon8mKjPaIgjBM2anYLiOHxTNaJ744RBOU7paJZe/mSlNKzLzwCgPTGw9Rl
        wBLHaNy1Elu/TqM/8YxJa26yTGUd2H+s8GfzHUbGOrbEdqM1+A8Apic44pVd2fQZVAUWCRphL6f/y
        RQd4o5rA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=vortex.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5Yon-00086n-CF; Thu, 27 Sep 2018 16:07:29 +0000
Subject: Re: [PATCH] Reduce boot header size with 1 byte
To:     xyproto@archlinux.org, linux-kernel@vger.kernel.org
References: <20180927134117.15371-1-xyproto@archlinux.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <52c315b1-e151-d728-9743-47e3189df8c9@infradead.org>
Date:   Thu, 27 Sep 2018 09:07:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180927134117.15371-1-xyproto@archlinux.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/18 6:41 AM, xyproto@archlinux.org wrote:
> From: Alexander F. Rødseth <xyproto@archlinux.org>
> 
> Only ah needs to be set to 0 before calling interrupt 0x16 for waiting
> for a keypress.
> 
> This patch changes the line that uses xor so that it only zeroes "ah" instead of "ax".
> This saves a byte.
> 
> Signed-off-by: Alexander F. Rødseth <xyproto@archlinux.org>

Hi,

You should Cc: the X86 maintainers on this patch.
Otherwise it will just be lost in the ether.

thanks.

> ---
>  arch/x86/boot/header.S | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index 850b8762e889..905cb96f43d4 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -71,14 +71,15 @@ msg_loop:
>  	jmp	msg_loop
>  
>  bs_die:
> -	# Allow the user to press a key, then reboot
> -	xorw	%ax, %ax
> +	# Allow the user to press a key
> +	xorb	%ah, %ah
>  	int	$0x16
> +
> +	# Boostrap by reading sector 1, head 0, track 0 from drive
>  	int	$0x19
>  
> -	# int 0x19 should never return.  In case it does anyway,
> -	# invoke the BIOS reset code...
> -	ljmp	$0xf000,$0xfff0
> +	# If boostrap somehow did not work, invoke the BIOS reset code
> +	ljmp	$0xf000, $0xfff0
>  
>  #ifdef CONFIG_EFI_STUB
>  	.org	0x3c
> 


-- 
~Randy
