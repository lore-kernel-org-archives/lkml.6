Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD84C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7D120684
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hPU2NQko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7D120684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbeIZCLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:11:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36728 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbeIZCLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:
        Subject:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rI9L9Ysotx9sweG9M3x1y3ki+CsTgXRWHQNspMZtW1I=; b=hPU2NQko1PZ+XGann7Fafgz5h
        ysPCgV2ZYUKskKhSyCj45OcycM0Mzx+GVk7MQt3gURfQ80x31v7Pk0KbhKLkLPPsDx/xRuXj+XM8c
        1B3vxvfwvSUNwz6JSMQCTOUnf9kc+Htj1Z43+K4BbTpDIeysYaFTboFINoqLfWzM/Dgf3A6gKXTbU
        biRsZvc6i1ZQZK30cD8blxVxhctVVtr/W+jlV0hzUkrteLx2i7eICf05rItJ2KzLPUiUk6ivZ1rKg
        ZXPQ2l1P0UPf50gikO+QLfxQmmpri+Weq5BLnEQ+Q0ATlRxWKIllzZEuvaxLK1nnX9bJmYRN7kvWQ
        GgpYBDyMw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g4tXE-0000kX-BI; Tue, 25 Sep 2018 20:02:36 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v14 10/19] x86/sgx: Detect Intel SGX
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, linux-sgx@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20180925130845.9962-1-jarkko.sakkinen@linux.intel.com>
 <20180925130845.9962-11-jarkko.sakkinen@linux.intel.com>
Message-ID: <7ea823ce-d6ee-1ff0-efb4-3ca93536fb7e@infradead.org>
Date:   Tue, 25 Sep 2018 13:02:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180925130845.9962-11-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/18 6:06 AM, Jarkko Sakkinen wrote:
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 1a0be022f91d..b47e1a144409 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1913,6 +1913,23 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
>  
>  	  If unsure, say y.
>  
> +config INTEL_SGX_CORE
> +	bool "Intel SGX core functionality"
> +	depends on X86_64 && CPU_SUP_INTEL
> +	help
> +	Intel Software Guard eXtensions (SGX) CPU feature that allows ring 3
> +	applications to create enclaves: private regions of memory that are
> +	architecturally protected from unauthorized access and/or modification.
> +
> +	This option enables kernel recognition of SGX, high-level management
> +	of the Enclave Page Cache (EPC), tracking and writing of SGX Launch
> +	Enclave Hash MSRs, and allows for virtualization of SGX via KVM. By
> +	itself, this option does not provide SGX support to userspace.
> +
> +	For details, see Documentation/x86/intel_sgx.rst
> +
> +	If unsure, say N.
> +

Hi,
coding-style.rst says that help text should be indented with
one tab + 2 spaces.

thanks.

-- 
~Randy
