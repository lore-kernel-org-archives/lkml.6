Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809D8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB9620693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l0e8rHQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB9620693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbeGRFpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 01:45:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59038 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725728AbeGRFpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 01:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5K9tPEqAy8PZSrCoKX62EWhTeQINIW/ixDh0w3IobDE=; b=l0e8rHQuQwSpo70mt0TOfu3Jxy
        8Idx71eVQRtvjiRy66i19WpvFEMq1CpZs2gHQAUgX9IxGGWhktN/TyplkoCkF/m0B7rVLbpsDQEBR
        diXA+MlfYR8GxoPQ+x2lUijgE+FpTXEJRszxmFOM5MXEV/UkRbRsX+0Vngjl7msBck0/yG/SD2Prm
        eEcSECKTW4d/G5shTpBBbU9r5+oV7f/iKVF19Oh+0QVSzfQkFj4L4jPzNjNrk9SfquSF5FZJmUvZz
        IyPhCZrwEhaZwFbUxENRJt01NHYjp0pFptnlBRFOked0xX+aVDcfoDPyI4eWE6nHdv1Rodajd61b+
        pjAE9CDQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffeiB-0007Zt-0B; Wed, 18 Jul 2018 05:09:15 +0000
Subject: Re: [PATCH] random: add a config option to trust the CPU's hwrng
To:     Theodore Ts'o <tytso@mit.edu>, linux-crypto@vger.kernel.org,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Cc:     labbott@redhat.com
References: <20180718014344.1309-1-tytso@mit.edu>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ec07bf22-31aa-638e-b40b-4f3efb1b77b5@infradead.org>
Date:   Tue, 17 Jul 2018 22:09:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180718014344.1309-1-tytso@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/17/2018 06:43 PM, Theodore Ts'o wrote:
> This gives the user building their own kernel (or a Linux
> distribution) the option of deciding whether or not to trust the CPU's
> hardware random number generator (e.g., RDRAND for x86 CPU's) as being
> correctly implemented and not having a back door introduced (perhaps
> courtesy of a Nation State's law enforcement or intelligence
> agencies).
> 
> This will prevent getrandom(2) from blocking, if there is a
> willingness to trust the CPU manufacturer.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
> 
>  I'm not sure Linux distro's will thank us for this.  The problem is
>  trusting the CPU manfuacturer can be an emotional / political issue.
> 
>  For example, assume that China has decided that as a result of the
>  "death sentence" that the US government threatened to impose on ZTE
>  after they were caught introducing privacy violating malware on US
>  comsumers, that they needed to be self-sufficient in their technology
>  sector, and so they decided the needed to produce their own CPU.
> 
>  Even if I were convinced that Intel hadn't backdoored RDRAND (or an
>  NSA agent backdoored RDRAND for them) such that the NSA had a NOBUS
>  (nobody but us) capability to crack RDRAND generated numbers, if we
>  made a change to unconditionally trust RDRAND, then I didn't want the
>  upstream kernel developers to have to answer the question, "why are
>  you willing to trust Intel, but you aren't willing to trust a company
>  owned and controlled by a PLA general?"  (Or a company owned and
>  controlled by one of Putin's Oligarchs, if that makes you feel
>  better.)
> 
>  With this patch, we don't put ourselves in this position --- but we
>  do put the Linux distro's in this position intead.  The upside is it
>  gives the choice to each person building their own Linux kernel to
>  decide whether trusting RDRAND is worth it to avoid hangs due to
>  userspace trying to get cryptographic-grade entropy early in the boot
>  process.  (Note: I trust RDRAND more than I do Jitter Entropy.)
> 
>  drivers/char/Kconfig  | 14 ++++++++++++++
>  drivers/char/random.c | 11 ++++++++++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 212f447938ae..fe2930c4ecf0 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -554,3 +554,17 @@ config ADI
>  
>  endmenu
>  

Hi Ted,

In case you go further with this:


> +config RANDOM_TRUST_CPU
> +       bool "Trust the CPU manufacturer to initialize Linux's CRNG"
> +       depends on (X86 || X86_64 || X86_32 || S390 || PPC)

	depends on X86 || S390 || PPC
should be sufficient.

> +       default n
> +       help

and all 4 lines above should be indented with one tab instead of spaces.

> +	Assume that CPU manufacurer (e.g., Intel or AMD for RDSEED or

	                manufacturer

> +	RDRAND, IBM for the S390 and Power PC architectures) is trustworthy
> +	for the purposes of initializing Linux's CRNG.  Since this is not
> +	something that can be indepedently audited, this amounts to trusting

	                      independently

> +	that CPU manufacturer (perhaps with the insistance or requirement

	                                        insistence

> +	of a Nation State's intelligence or law enforcement agencies)
> +	has not installed a hidden back door to compromise the CPU's
> +	random number generation facilities.


-- 
~Randy
