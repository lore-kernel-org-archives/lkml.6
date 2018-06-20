Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A490C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A32208B7
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A32208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754220AbeFTP0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:26:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:14304 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754077AbeFTP0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:26:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 08:26:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,248,1526367600"; 
   d="scan'208";a="65787731"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.135])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jun 2018 08:26:05 -0700
Message-ID: <1529508365.9779.63.camel@intel.com>
Subject: Re: [PATCH v11 09/13] x86, sgx: basic routines for enclave page
 cache
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
Date:   Wed, 20 Jun 2018 08:26:05 -0700
In-Reply-To: <20180608171216.26521-10-jarkko.sakkinen@linux.intel.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
         <20180608171216.26521-10-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-08 at 19:09 +0200, Jarkko Sakkinen wrote:
> SGX has a set of data structures to maintain information about the enclaves
> and their security properties. BIOS reserves a fixed size region of
> physical memory for these structures by setting Processor Reserved Memory
> Range Registers (PRMRR). This memory area is called Enclave Page Cache
> (EPC).
> 
> This commit implements the basic routines to allocate and free pages from
> different EPC banks. There is also a swapper thread ksgxswapd for EPC pages
> that gets woken up by sgx_alloc_page() when we run below the low watermark.
> The swapper thread continues swapping pages up until it reaches the high
> watermark.
> 
> Each subsystem that uses SGX must provide a set of callbacks for EPC
> pages that are used to reclaim, block and write an EPC page. Kernel
> takes the responsibility of maintaining LRU cache for them.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  arch/x86/include/asm/sgx.h      |  67 +++++
>  arch/x86/include/asm/sgx_arch.h | 224 ++++++++++++++++
>  arch/x86/kernel/cpu/intel_sgx.c | 443 +++++++++++++++++++++++++++++++-
>  3 files changed, 732 insertions(+), 2 deletions(-)
>  create mode 100644 arch/x86/include/asm/sgx_arch.h

...

> diff --git a/arch/x86/kernel/cpu/intel_sgx.c b/arch/x86/kernel/cpu/intel_sgx.c
> index db6b315334f4..ae2b5c5b455f 100644
> --- a/arch/x86/kernel/cpu/intel_sgx.c
> +++ b/arch/x86/kernel/cpu/intel_sgx.c
> @@ -14,14 +14,439 @@
>  #include <linux/freezer.h>
>  #include <linux/highmem.h>
>  #include <linux/kthread.h>
> +#include <linux/pagemap.h>
>  #include <linux/ratelimit.h>
>  #include <linux/sched/signal.h>
> +#include <linux/shmem_fs.h>
>  #include <linux/slab.h>
>  
> +#define SGX_NR_TO_SCAN	16
> +#define SGX_NR_LOW_PAGES 32
> +#define SGX_NR_HIGH_PAGES 64
> +
>  bool sgx_enabled __ro_after_init = false;
>  EXPORT_SYMBOL(sgx_enabled);
> +bool sgx_lc_enabled __ro_after_init;
> +EXPORT_SYMBOL(sgx_lc_enabled);
> +atomic_t sgx_nr_free_pages = ATOMIC_INIT(0);
> +EXPORT_SYMBOL(sgx_nr_free_pages);
> +struct sgx_epc_bank sgx_epc_banks[SGX_MAX_EPC_BANKS];
> +EXPORT_SYMBOL(sgx_epc_banks);
> +int sgx_nr_epc_banks;
> +EXPORT_SYMBOL(sgx_nr_epc_banks);
> +LIST_HEAD(sgx_active_page_list);
> +EXPORT_SYMBOL(sgx_active_page_list);
> +DEFINE_SPINLOCK(sgx_active_page_list_lock);
> +EXPORT_SYMBOL(sgx_active_page_list_lock);

I don't think we should be exporting anything other than sgx_enabled
and sgx_lc_enabled.  The only external use of a symbol that can't be
trivially (re)moved is in the driver's sgx_pm_suspend() in sgx_main.c,
which uses the sgx_active_page_list to invalidate enclaves.  And that
behavior seems unsafe, e.g. an enclave could theoretically have zero
pages on the active list and so could be missed in the suspend flow.

> +static struct task_struct *ksgxswapd_tsk;
> +static DECLARE_WAIT_QUEUE_HEAD(ksgxswapd_waitq);
