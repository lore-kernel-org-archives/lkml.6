Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbeCJXN6 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 18:13:58 -0500
Received: from mga04.intel.com ([192.55.52.120]:38884 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751194AbeCJXN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 18:13:57 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,452,1515484800";
   d="gz'50?scan'50,208,50";a="26960815"
Date: Sun, 11 Mar 2018 07:13:43 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: mm/percpu.c:2723:2: warning: #warning "the CRIS architecture has
 physical and virtual addresses confused"
Message-ID: <201803110739.0J5VoDiT%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3266b5bd97eaa72793df0b6e5a106c69ccc166c4
commit: abee210500ed15a22787009d9210b9a34911afcc percpu: hack to let the CRIS architecture to boot until they clean up
date:   3 months ago
config: cris-etrax-100lx_v2_defconfig (attached as .config)
compiler: cris-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout abee210500ed15a22787009d9210b9a34911afcc
        # save the attached .config to linux build tree
        make.cross ARCH=cris 

All warnings (new ones prefixed by >>):

   mm/percpu.c: In function 'setup_per_cpu_areas':
>> mm/percpu.c:2723:2: warning: #warning "the CRIS architecture has physical and virtual addresses confused" [-Wcpp]
    #warning "the CRIS architecture has physical and virtual addresses confused"
     ^~~~~~~

vim +2723 mm/percpu.c

  2688	
  2689	/*
  2690	 * UP percpu area setup.
  2691	 *
  2692	 * UP always uses km-based percpu allocator with identity mapping.
  2693	 * Static percpu variables are indistinguishable from the usual static
  2694	 * variables and don't require any special preparation.
  2695	 */
  2696	void __init setup_per_cpu_areas(void)
  2697	{
  2698		const size_t unit_size =
  2699			roundup_pow_of_two(max_t(size_t, PCPU_MIN_UNIT_SIZE,
  2700						 PERCPU_DYNAMIC_RESERVE));
  2701		struct pcpu_alloc_info *ai;
  2702		void *fc;
  2703	
  2704		ai = pcpu_alloc_alloc_info(1, 1);
  2705		fc = memblock_virt_alloc_from_nopanic(unit_size,
  2706						      PAGE_SIZE,
  2707						      __pa(MAX_DMA_ADDRESS));
  2708		if (!ai || !fc)
  2709			panic("Failed to allocate memory for percpu areas.");
  2710		/* kmemleak tracks the percpu allocations separately */
  2711		kmemleak_free(fc);
  2712	
  2713		ai->dyn_size = unit_size;
  2714		ai->unit_size = unit_size;
  2715		ai->atom_size = unit_size;
  2716		ai->alloc_size = unit_size;
  2717		ai->groups[0].nr_units = 1;
  2718		ai->groups[0].cpu_map[0] = 0;
  2719	
  2720		if (pcpu_setup_first_chunk(ai, fc) < 0)
  2721			panic("Failed to initialize percpu areas.");
  2722	#ifdef CONFIG_CRIS
> 2723	#warning "the CRIS architecture has physical and virtual addresses confused"
  2724	#else
  2725		pcpu_free_alloc_info(ai);
  2726	#endif
  2727	}
  2728	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--7AUc2qLy4jB3hD7Z
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--7AUc2qLy4jB3hD7Z--
