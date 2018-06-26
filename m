Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D64DC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429BA26E44
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p6qxqzYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429BA26E44
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933703AbeFZRaU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:30:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754269AbeFZRaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nK+Q9POQieGeHOLuFdzQnSUW/oPGj9vKh+kArdqxhMA=; b=p6qxqzYW+EVLJVvD5Gmjc8XGl
        hPzx8xsBjE3JfcA0CQrTiJedNVD/q6AF50QNQQrM3Z/VIIvZEqclMP8PN9PS4kfO7k+h4HfzWg3fH
        YF2a/TVSjmA/Rwg6zih3cNjp1ApO0Fr8LBSrFj7dK+eqaal2LzfRr8j+NA0n2z3dYn37hbY0fsd5T
        VakqDLtLnWbz+9N50904KFRgciYYOpftkatFgDCXMsBV1hJM/b9K9pS86ObQEwk5+r3NTA/VGEoXB
        cTwWaf0nUYpOhbezvFrZDJk+pRYh6OIMPwPIhSI3UNiBgutodCWb4ymd2YmD/dXItZKwCJS++iDzD
        ECvZWeHAA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXrnB-00088x-Lp; Tue, 26 Jun 2018 17:30:13 +0000
Subject: Re: [PATCHv4 18/18] x86: Introduce CONFIG_X86_INTEL_MKTME
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20180626142245.82850-1-kirill.shutemov@linux.intel.com>
 <20180626142245.82850-19-kirill.shutemov@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ecf92475-93b4-295c-f1fc-7efba4843d98@infradead.org>
Date:   Tue, 26 Jun 2018 10:30:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180626142245.82850-19-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/26/2018 07:22 AM, Kirill A. Shutemov wrote:
> Add new config option to enabled/disable Multi-Key Total Memory
> Encryption support.
> 
> MKTME uses MEMORY_PHYSICAL_PADDING to reserve enough space in per-KeyID
> direct mappings for memory hotplug.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/Kconfig | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index fa5e1ec09247..9a843bd63108 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1523,6 +1523,23 @@ config ARCH_USE_MEMREMAP_PROT
>  	def_bool y
>  	depends on AMD_MEM_ENCRYPT
>  
> +config X86_INTEL_MKTME
> +	bool "Intel Multi-Key Total Memory Encryption"
> +	select DYNAMIC_PHYSICAL_MASK
> +	select PAGE_EXTENSION
> +	depends on X86_64 && CPU_SUP_INTEL
> +	---help---
> +	  Say yes to enable support for Multi-Key Total Memory Encryption.
> +	  This requires an Intel processor that has support of the feature.
> +
> +	  Multikey Total Memory Encryption (MKTME) is a technology that allows
> +	  transparent memory encryption in and upcoming Intel platforms.

huh?  Maybe drop the "and"?

> +
> +	  MKTME is built on top of TME. TME allows encryption of the entirety
> +	  of system memory using a single key. MKTME allows having multiple
> +	  encryption domains, each having own key -- different memory pages can
> +	  be encrypted with different keys.
> +
>  # Common NUMA Features
>  config NUMA
>  	bool "Numa Memory Allocation and Scheduler Support"
> @@ -2199,7 +2216,7 @@ config RANDOMIZE_MEMORY
>  
>  config MEMORY_PHYSICAL_PADDING
>  	hex "Physical memory mapping padding" if EXPERT
> -	depends on RANDOMIZE_MEMORY
> +	depends on RANDOMIZE_MEMORY || X86_INTEL_MKTME
>  	default "0xa" if MEMORY_HOTPLUG
>  	default "0x0"
>  	range 0x1 0x40 if MEMORY_HOTPLUG
> 


-- 
~Randy
