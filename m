Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C4AC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 00:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D857208E8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 00:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D857208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732330AbeGKANR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 20:13:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:42258 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732262AbeGKANR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 20:13:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 17:11:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,336,1526367600"; 
   d="scan'208";a="73793923"
Received: from mgcarrol-mobl1.amr.corp.intel.com (HELO [10.252.202.182]) ([10.252.202.182])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2018 17:11:43 -0700
Subject: Re: [RFC PATCH v2 22/27] x86/cet/ibt: User-mode indirect branch
 tracking support
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
 <20180710222639.8241-23-yu-cheng.yu@intel.com>
From:   Dave Hansen <dave.hansen@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@linux.intel.com; keydata=
 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
 z5cecg==
Message-ID: <3a7e9ce4-03c6-cc28-017b-d00108459e94@linux.intel.com>
Date:   Tue, 10 Jul 2018 17:11:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180710222639.8241-23-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is this feature *integral* to shadow stacks?  Or, should it just be in a
different series?

> diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
> index d9ae3d86cdd7..71da2cccba16 100644
> --- a/arch/x86/include/asm/cet.h
> +++ b/arch/x86/include/asm/cet.h
> @@ -12,7 +12,10 @@ struct task_struct;
>  struct cet_status {
>  	unsigned long	shstk_base;
>  	unsigned long	shstk_size;
> +	unsigned long	ibt_bitmap_addr;
> +	unsigned long	ibt_bitmap_size;
>  	unsigned int	shstk_enabled:1;
> +	unsigned int	ibt_enabled:1;
>  };

Is there a reason we're not using pointers here?  This seems like the
kind of place that we probably want __user pointers.


> +static unsigned long ibt_mmap(unsigned long addr, unsigned long len)
> +{
> +	struct mm_struct *mm = current->mm;
> +	unsigned long populate;
> +
> +	down_write(&mm->mmap_sem);
> +	addr = do_mmap(NULL, addr, len, PROT_READ | PROT_WRITE,
> +		       MAP_ANONYMOUS | MAP_PRIVATE,
> +		       VM_DONTDUMP, 0, &populate, NULL);
> +	up_write(&mm->mmap_sem);
> +
> +	if (populate)
> +		mm_populate(addr, populate);
> +
> +	return addr;
> +}

We're going to have to start consolidating these at some point.  We have
at least three of them now, maybe more.

> +int cet_setup_ibt_bitmap(void)
> +{
> +	u64 r;
> +	unsigned long bitmap;
> +	unsigned long size;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_IBT))
> +		return -EOPNOTSUPP;
> +
> +	size = TASK_SIZE_MAX / PAGE_SIZE / BITS_PER_BYTE;

Just a note: this table is going to be gigantic on 5-level paging
systems, and userspace won't, by default use any of that extra address
space.  I think it ends up being a 512GB allocation in a 128TB address
space.

Is that a problem?

On 5-level paging systems, maybe we should just stick it up in the high
part of the address space.

> +	bitmap = ibt_mmap(0, size);
> +
> +	if (bitmap >= TASK_SIZE_MAX)
> +		return -ENOMEM;
> +
> +	bitmap &= PAGE_MASK;

We're page-aligning the result of an mmap()?  Why?

> +	rdmsrl(MSR_IA32_U_CET, r);
> +	r |= (MSR_IA32_CET_LEG_IW_EN | bitmap);
> +	wrmsrl(MSR_IA32_U_CET, r);

Comments, please.  What is this doing, logically?  Also, why are we
OR'ing the results into this MSR?  What are we trying to preserve?

> +	current->thread.cet.ibt_bitmap_addr = bitmap;
> +	current->thread.cet.ibt_bitmap_size = size;
> +	return 0;
> +}
> +
> +void cet_disable_ibt(void)
> +{
> +	u64 r;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_IBT))
> +		return;

Does this need a check for being already disabled?

> +	rdmsrl(MSR_IA32_U_CET, r);
> +	r &= ~(MSR_IA32_CET_ENDBR_EN | MSR_IA32_CET_LEG_IW_EN |
> +	       MSR_IA32_CET_NO_TRACK_EN);
> +	wrmsrl(MSR_IA32_U_CET, r);
> +	current->thread.cet.ibt_enabled = 0;
> +}

What's the locking for current->thread.cet?

> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 705467839ce8..c609c9ce5691 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -413,7 +413,8 @@ __setup("nopku", setup_disable_pku);
>  
>  static __always_inline void setup_cet(struct cpuinfo_x86 *c)
>  {
> -	if (cpu_feature_enabled(X86_FEATURE_SHSTK))
> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK) ||
> +	    cpu_feature_enabled(X86_FEATURE_IBT))
>  		cr4_set_bits(X86_CR4_CET);
>  }
>  
> @@ -434,6 +435,23 @@ static __init int setup_disable_shstk(char *s)
>  __setup("no_cet_shstk", setup_disable_shstk);
>  #endif
>  
> +#ifdef CONFIG_X86_INTEL_BRANCH_TRACKING_USER
> +static __init int setup_disable_ibt(char *s)
> +{
> +	/* require an exact match without trailing characters */
> +	if (strlen(s))
> +		return 0;
> +
> +	if (!boot_cpu_has(X86_FEATURE_IBT))
> +		return 1;
> +
> +	setup_clear_cpu_cap(X86_FEATURE_IBT);
> +	pr_info("x86: 'no_cet_ibt' specified, disabling Branch Tracking\n");
> +	return 1;
> +}
> +__setup("no_cet_ibt", setup_disable_ibt);
> +#endif
>  /*
>   * Some CPU features depend on higher CPUID levels, which may not always
>   * be available due to CPUID level capping or broken virtualization
> diff --git a/arch/x86/kernel/elf.c b/arch/x86/kernel/elf.c
> index 233f6dad9c1f..42e08d3b573e 100644
> --- a/arch/x86/kernel/elf.c
> +++ b/arch/x86/kernel/elf.c
> @@ -15,6 +15,7 @@
>  #include <linux/fs.h>
>  #include <linux/uaccess.h>
>  #include <linux/string.h>
> +#include <linux/compat.h>
>  
>  /*
>   * The .note.gnu.property layout:
> @@ -222,7 +223,8 @@ int arch_setup_features(void *ehdr_p, void *phdr_p,
>  
>  	struct elf64_hdr *ehdr64 = ehdr_p;
>  
> -	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
> +	if (!cpu_feature_enabled(X86_FEATURE_SHSTK) &&
> +	    !cpu_feature_enabled(X86_FEATURE_IBT))
>  		return 0;
>  
>  	if (ehdr64->e_ident[EI_CLASS] == ELFCLASS64) {
> @@ -250,6 +252,9 @@ int arch_setup_features(void *ehdr_p, void *phdr_p,
>  	current->thread.cet.shstk_enabled = 0;
>  	current->thread.cet.shstk_base = 0;
>  	current->thread.cet.shstk_size = 0;
> +	current->thread.cet.ibt_enabled = 0;
> +	current->thread.cet.ibt_bitmap_addr = 0;
> +	current->thread.cet.ibt_bitmap_size = 0;
>  	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
>  		if (shstk) {
>  			err = cet_setup_shstk();
> @@ -257,6 +262,15 @@ int arch_setup_features(void *ehdr_p, void *phdr_p,
>  				goto out;
>  		}
>  	}
> +
> +	if (cpu_feature_enabled(X86_FEATURE_IBT)) {
> +		if (ibt) {
> +			err = cet_setup_ibt();
> +			if (err < 0)
> +				goto out;
> +		}
> +	}

You introduced 'ibt' before it was used.  Please wait to introduce it
until you actually use it to make it easier to review.

Also, what's wrong with:

	if (cpu_feature_enabled(X86_FEATURE_IBT) && ibt) {
		...
	}

?

