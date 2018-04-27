Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758113AbeD0LvO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 07:51:14 -0400
Received: from mga18.intel.com ([134.134.136.126]:2566 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757661AbeD0LvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 07:51:10 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,335,1520924400";
   d="scan'208";a="223877468"
Date: Fri, 27 Apr 2018 19:50:33 +0800
From: kbuild test robot <lkp@intel.com>
To: kys@linuxonhyperv.com
Cc: kbuild-all@01.org, x86@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        olaf@aepfle.de, apw@canonical.com, jasowang@redhat.com,
        tglx@linutronix.de, hpa@zytor.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com,
        "K. Y. Srinivasan" <kys@microsoft.com>
Subject: Re: [PATCH 5/5] X86: Hyper-V: Consolidate the allocation of the
 hypercall input page
Message-ID: <201804271914.wez0PRbS%fengguang.wu@intel.com>
References: <20180425181250.8740-5-kys@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425181250.8740-5-kys@linuxonhyperv.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivasan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on v4.17-rc2]
[also build test WARNING on next-20180426]
[cannot apply to tip/x86/core]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/kys-linuxonhyperv-com/X86-Hyper-V-APIC-enlightenments/20180427-114416
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> arch/x86/hyperv/mmu.c:86:22: sparse: incorrect type in initializer (different address spaces) @@    expected void const [noderef] <asn:3>*__vpp_verify @@    got const [noderef] <asn:3>*__vpp_verify @@
   arch/x86/hyperv/mmu.c:86:22:    expected void const [noderef] <asn:3>*__vpp_verify
   arch/x86/hyperv/mmu.c:86:22:    got void [noderef] <asn:3>**<noident>
   arch/x86/hyperv/mmu.c:171:22: sparse: incorrect type in initializer (different address spaces) @@    expected void const [noderef] <asn:3>*__vpp_verify @@    got const [noderef] <asn:3>*__vpp_verify @@
   arch/x86/hyperv/mmu.c:171:22:    expected void const [noderef] <asn:3>*__vpp_verify
   arch/x86/hyperv/mmu.c:171:22:    got void [noderef] <asn:3>**<noident>

vim +86 arch/x86/hyperv/mmu.c

    65	
    66	static void hyperv_flush_tlb_others(const struct cpumask *cpus,
    67					    const struct flush_tlb_info *info)
    68	{
    69		int cpu, vcpu, gva_n, max_gvas;
    70		struct hv_flush_pcpu **flush_pcpu;
    71		struct hv_flush_pcpu *flush;
    72		u64 status = U64_MAX;
    73		unsigned long flags;
    74	
    75		trace_hyperv_mmu_flush_tlb_others(cpus, info);
    76	
    77		if (!hv_hypercall_pg)
    78			goto do_native;
    79	
    80		if (cpumask_empty(cpus))
    81			return;
    82	
    83		local_irq_save(flags);
    84	
    85		flush_pcpu = (struct hv_flush_pcpu **)
  > 86			     this_cpu_ptr(hyperv_pcpu_input_arg);
    87	
    88		flush = *flush_pcpu;
    89	
    90		if (unlikely(!flush)) {
    91			local_irq_restore(flags);
    92			goto do_native;
    93		}
    94	
    95		if (info->mm) {
    96			/*
    97			 * AddressSpace argument must match the CR3 with PCID bits
    98			 * stripped out.
    99			 */
   100			flush->address_space = virt_to_phys(info->mm->pgd);
   101			flush->address_space &= CR3_ADDR_MASK;
   102			flush->flags = 0;
   103		} else {
   104			flush->address_space = 0;
   105			flush->flags = HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES;
   106		}
   107	
   108		flush->processor_mask = 0;
   109		if (cpumask_equal(cpus, cpu_present_mask)) {
   110			flush->flags |= HV_FLUSH_ALL_PROCESSORS;
   111		} else {
   112			for_each_cpu(cpu, cpus) {
   113				vcpu = hv_cpu_number_to_vp_number(cpu);
   114				if (vcpu >= 64)
   115					goto do_native;
   116	
   117				__set_bit(vcpu, (unsigned long *)
   118					  &flush->processor_mask);
   119			}
   120		}
   121	
   122		/*
   123		 * We can flush not more than max_gvas with one hypercall. Flush the
   124		 * whole address space if we were asked to do more.
   125		 */
   126		max_gvas = (PAGE_SIZE - sizeof(*flush)) / sizeof(flush->gva_list[0]);
   127	
   128		if (info->end == TLB_FLUSH_ALL) {
   129			flush->flags |= HV_FLUSH_NON_GLOBAL_MAPPINGS_ONLY;
   130			status = hv_do_hypercall(HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE,
   131						 flush, NULL);
   132		} else if (info->end &&
   133			   ((info->end - info->start)/HV_TLB_FLUSH_UNIT) > max_gvas) {
   134			status = hv_do_hypercall(HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE,
   135						 flush, NULL);
   136		} else {
   137			gva_n = fill_gva_list(flush->gva_list, 0,
   138					      info->start, info->end);
   139			status = hv_do_rep_hypercall(HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST,
   140						     gva_n, 0, flush, NULL);
   141		}
   142	
   143		local_irq_restore(flags);
   144	
   145		if (!(status & HV_HYPERCALL_RESULT_MASK))
   146			return;
   147	do_native:
   148		native_flush_tlb_others(cpus, info);
   149	}
   150	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
