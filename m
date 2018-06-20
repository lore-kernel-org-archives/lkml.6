Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57114C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F211C20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F211C20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753276AbeFTNMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:12:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:39366 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750852AbeFTNMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:12:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 06:12:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,247,1526367600"; 
   d="scan'208";a="66176686"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.135])
  by orsmga001.jf.intel.com with ESMTP; 20 Jun 2018 06:12:35 -0700
Message-ID: <1529500355.9779.51.camel@intel.com>
Subject: Re: [PATCH v11 08/13] x86, sgx: added ENCLS wrappers
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     dave.hansen@intel.com, nhorman@redhat.com, npmccallum@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:INTEL SGX" <intel-sgx-kernel-dev@lists.01.org>
Date:   Wed, 20 Jun 2018 06:12:35 -0700
In-Reply-To: <20180608171216.26521-9-jarkko.sakkinen@linux.intel.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
         <20180608171216.26521-9-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-08 at 19:09 +0200, Jarkko Sakkinen wrote:
> This commit adds wrappers for Intel(R) SGX ENCLS opcode functionality.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  arch/x86/include/asm/sgx.h | 198 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 198 insertions(+)
> 
> diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
> index fa3e6e0eb8af..a2f727f85b91 100644
> --- a/arch/x86/include/asm/sgx.h
> +++ b/arch/x86/include/asm/sgx.h
> @@ -10,6 +10,10 @@
>  #ifndef _ASM_X86_SGX_H
>  #define _ASM_X86_SGX_H
>  
> +#include <asm/sgx_arch.h>
> +#include <asm/asm.h>
> +#include <linux/bitops.h>
> +#include <linux/err.h>
>  #include <linux/types.h>
>  
>  #define SGX_CPUID 0x12
> @@ -20,6 +24,200 @@ enum sgx_cpuid {
>  	SGX_CPUID_EPC_BANKS	= 2,
>  };
>  
> +enum sgx_commands {

This should be something like "sgx_encls_leafs" and probably moved
to sgx_arch.h (as Dave alluded to, these are architectural values).
"sgx_commands" is not accurate (they're only the cpl0 "commands")
and will have collision issues in the future, e.g. with the ENCLV
instruction and its leafs.

> +	ECREATE	= 0x0,
> +	EADD	= 0x1,
> +	EINIT	= 0x2,
> +	EREMOVE	= 0x3,
> +	EDGBRD	= 0x4,
> +	EDGBWR	= 0x5,
> +	EEXTEND	= 0x6,

Even though it's not used in the code (yet...), I think ELDB,
leaf 0x7, should be defined here for completeness.

> +	ELDU	= 0x8,
> +	EBLOCK	= 0x9,
> +	EPA	= 0xA,
> +	EWB	= 0xB,
> +	ETRACK	= 0xC,
> +	EAUG	= 0xD,
> +	EMODPR	= 0xE,
> +	EMODT	= 0xF,
> +};

