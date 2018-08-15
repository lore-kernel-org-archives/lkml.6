Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE6EC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36BA9216E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36BA9216E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbeHOKjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 06:39:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48233 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeHOKjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 06:39:20 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9699A8064D; Wed, 15 Aug 2018 09:48:13 +0200 (CEST)
Date:   Wed, 15 Aug 2018 09:48:12 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv5 19/19] x86: Introduce CONFIG_X86_INTEL_MKTME
Message-ID: <20180815074812.GB28093@xo-6d-61-c0.localdomain>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
 <20180717112029.42378-20-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717112029.42378-20-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

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
> index b6f1785c2176..023a22568c06 100644
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
> +	  transparent memory encryption in upcoming Intel platforms.
> +
> +	  MKTME is built on top of TME. TME allows encryption of the entirety
> +	  of system memory using a single key. MKTME allows having multiple
> +	  encryption domains, each having own key -- different memory pages can
> +	  be encrypted with different keys.
> +
>  # Common NUMA Features
>  config NUMA
>  	bool "Numa Memory Allocation and Scheduler Support"

Would it be good to provide documentation, or link to documentation, explaining
what security guarantees this is supposed to provide, and what disadvantages (if any)
it has? I guess  it costs a bit of performance...

I see that TME helps with cold boot attacks.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
