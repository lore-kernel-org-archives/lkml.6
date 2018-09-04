Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E70C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C6B2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C6B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeIDXlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:41:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:48036 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbeIDXlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:41:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 12:14:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,330,1531810800"; 
   d="scan'208";a="260670318"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.20])
  by fmsmga006.fm.intel.com with ESMTP; 04 Sep 2018 12:14:25 -0700
Date:   Tue, 4 Sep 2018 12:14:25 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Fengguang Wu <fengguang.wu@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Peng DongX <dongx.peng@intel.com>,
        Liu Jingqi <jingqi.liu@intel.com>,
        Dong Eddie <eddie.dong@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Brendan Gregg <bgregg@netflix.com>, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 5/5] [PATCH 5/5] kvm-ept-idle: enable module
Message-ID: <20180904191424.GC5869@linux.intel.com>
References: <20180901112818.126790961@intel.com>
 <20180901124811.703808090@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180901124811.703808090@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 01, 2018 at 07:28:23PM +0800, Fengguang Wu wrote:
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
> ---
>  arch/x86/kvm/Kconfig  | 11 +++++++++++
>  arch/x86/kvm/Makefile |  4 ++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 1bbec387d289..4c6dec47fac6 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -96,6 +96,17 @@ config KVM_MMU_AUDIT
>  	 This option adds a R/W kVM module parameter 'mmu_audit', which allows
>  	 auditing of KVM MMU events at runtime.
>  
> +config KVM_EPT_IDLE
> +	tristate "KVM EPT idle page tracking"

KVM_MMU_IDLE_INTEL might be a more user friendly name, I doubt that
all Kconfig users would immediately associate EPT with Intel's two
dimensional paging.  And it meshes nicely with KVM_MMU_IDLE as a base
name if we ever want to move common functionality to its own module,
as well as all of the other KVM_MMU_* nomenclature.

> +	depends on KVM_INTEL
> +	depends on PROC_PAGE_MONITOR
> +	---help---
> +	  Provides support for walking EPT to get the A bits on Intel
> +	  processors equipped with the VT extensions.
> +
> +	  To compile this as a module, choose M here: the module
> +	  will be called kvm-ept-idle.
> +
>  # OK, it's a little counter-intuitive to do this, but it puts it neatly under
>  # the virtualization menu.
>  source drivers/vhost/Kconfig
> diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
> index dc4f2fdf5e57..5cad0590205d 100644
> --- a/arch/x86/kvm/Makefile
> +++ b/arch/x86/kvm/Makefile
> @@ -19,6 +19,10 @@ kvm-y			+= x86.o mmu.o emulate.o i8259.o irq.o lapic.o \
>  kvm-intel-y		+= vmx.o pmu_intel.o
>  kvm-amd-y		+= svm.o pmu_amd.o
>  
> +kvm-ept-idle-y		+= ept_idle.o
> +
>  obj-$(CONFIG_KVM)	+= kvm.o
>  obj-$(CONFIG_KVM_INTEL)	+= kvm-intel.o
>  obj-$(CONFIG_KVM_AMD)	+= kvm-amd.o
> +
> +obj-$(CONFIG_KVM_EPT_IDLE)	+= kvm-ept-idle.o
> -- 
> 2.15.0
> 
> 
> 
