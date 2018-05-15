Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeEOMoA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 08:44:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:62409 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751626AbeEOMn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 08:43:59 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="39473320"
Date: Tue, 15 May 2018 20:42:53 +0800
From: kbuild test robot <lkp@intel.com>
To: Lianbo Jiang <lijiang@redhat.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, thomas.lendacky@amd.com, dyoung@redhat.com
Subject: Re: [PATCH 2/2] support kdump when AMD secure memory encryption is
 active
Message-ID: <201805152012.X4ibR2wV%fengguang.wu@intel.com>
References: <20180515015133.4363-3-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515015133.4363-3-lijiang@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lianbo,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.17-rc5 next-20180514]
[cannot apply to tip/x86/core]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Lianbo-Jiang/support-kdump-for-AMD-secure-memory-encryption-sme/20180515-135732
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/iommu/amd_iommu_init.c:899:27: sparse: incorrect type in assignment (different address spaces) @@    expected struct dev_table_entry *old_devtb @@    got truct dev_table_entry *old_devtb @@
   drivers/iommu/amd_iommu_init.c:899:27:    expected struct dev_table_entry *old_devtb
   drivers/iommu/amd_iommu_init.c:899:27:    got void [noderef] <asn:2>*
   drivers/iommu/amd_iommu_init.c:1740:39: sparse: expression using sizeof(void)
   drivers/iommu/amd_iommu_init.c:1740:39: sparse: expression using sizeof(void)
   drivers/iommu/amd_iommu_init.c:1750:49: sparse: expression using sizeof(void)
   drivers/iommu/amd_iommu_init.c:1750:49: sparse: expression using sizeof(void)
   drivers/iommu/amd_iommu_init.c:2950:18: sparse: symbol 'get_amd_iommu' was not declared. Should it be static?
   drivers/iommu/amd_iommu_init.c:2969:4: sparse: symbol 'amd_iommu_pc_get_max_banks' was not declared. Should it be static?
   drivers/iommu/amd_iommu_init.c:2980:6: sparse: symbol 'amd_iommu_pc_supported' was not declared. Should it be static?
   drivers/iommu/amd_iommu_init.c:2986:4: sparse: symbol 'amd_iommu_pc_get_max_counters' was not declared. Should it be static?
   drivers/iommu/amd_iommu_init.c:3035:5: sparse: symbol 'amd_iommu_pc_get_reg' was not declared. Should it be static?
   drivers/iommu/amd_iommu_init.c:3044:5: sparse: symbol 'amd_iommu_pc_set_reg' was not declared. Should it be static?

vim +899 drivers/iommu/amd_iommu_init.c

   854	
   855	
   856	static bool copy_device_table(void)
   857	{
   858		u64 int_ctl, int_tab_len, entry = 0, last_entry = 0;
   859		struct dev_table_entry *old_devtb = NULL;
   860		u32 lo, hi, devid, old_devtb_size;
   861		phys_addr_t old_devtb_phys;
   862		struct amd_iommu *iommu;
   863		u16 dom_id, dte_v, irq_v;
   864		gfp_t gfp_flag;
   865		u64 tmp;
   866	
   867		if (!amd_iommu_pre_enabled)
   868			return false;
   869	
   870		pr_warn("Translation is already enabled - trying to copy translation structures\n");
   871		for_each_iommu(iommu) {
   872			/* All IOMMUs should use the same device table with the same size */
   873			lo = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET);
   874			hi = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET + 4);
   875			entry = (((u64) hi) << 32) + lo;
   876			if (last_entry && last_entry != entry) {
   877				pr_err("IOMMU:%d should use the same dev table as others!\n",
   878					iommu->index);
   879				return false;
   880			}
   881			last_entry = entry;
   882	
   883			old_devtb_size = ((entry & ~PAGE_MASK) + 1) << 12;
   884			if (old_devtb_size != dev_table_size) {
   885				pr_err("The device table size of IOMMU:%d is not expected!\n",
   886					iommu->index);
   887				return false;
   888			}
   889		}
   890	
   891		old_devtb_phys = entry & PAGE_MASK;
   892		if (sme_active() && is_kdump_kernel())
   893			old_devtb_phys = __sme_clr(old_devtb_phys);
   894		if (old_devtb_phys >= 0x100000000ULL) {
   895			pr_err("The address of old device table is above 4G, not trustworthy!\n");
   896			return false;
   897		}
   898		if (sme_active() && is_kdump_kernel())
 > 899			old_devtb = ioremap_encrypted(old_devtb_phys,
   900						dev_table_size);
   901		else
   902			old_devtb = memremap(old_devtb_phys,
   903						dev_table_size, MEMREMAP_WB);
   904		if (!old_devtb)
   905			return false;
   906	
   907		gfp_flag = GFP_KERNEL | __GFP_ZERO | GFP_DMA32;
   908		old_dev_tbl_cpy = (void *)__get_free_pages(gfp_flag,
   909					get_order(dev_table_size));
   910		if (old_dev_tbl_cpy == NULL) {
   911			pr_err("Failed to allocate memory for copying old device table!\n");
   912			return false;
   913		}
   914	
   915		for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
   916			old_dev_tbl_cpy[devid] = old_devtb[devid];
   917			dom_id = old_devtb[devid].data[1] & DEV_DOMID_MASK;
   918			dte_v = old_devtb[devid].data[0] & DTE_FLAG_V;
   919	
   920			if (dte_v && dom_id) {
   921				old_dev_tbl_cpy[devid].data[0] = old_devtb[devid].data[0];
   922				old_dev_tbl_cpy[devid].data[1] = old_devtb[devid].data[1];
   923				__set_bit(dom_id, amd_iommu_pd_alloc_bitmap);
   924				/* If gcr3 table existed, mask it out */
   925				if (old_devtb[devid].data[0] & DTE_FLAG_GV) {
   926					tmp = DTE_GCR3_VAL_B(~0ULL) << DTE_GCR3_SHIFT_B;
   927					tmp |= DTE_GCR3_VAL_C(~0ULL) << DTE_GCR3_SHIFT_C;
   928					old_dev_tbl_cpy[devid].data[1] &= ~tmp;
   929					tmp = DTE_GCR3_VAL_A(~0ULL) << DTE_GCR3_SHIFT_A;
   930					tmp |= DTE_FLAG_GV;
   931					old_dev_tbl_cpy[devid].data[0] &= ~tmp;
   932				}
   933			}
   934	
   935			irq_v = old_devtb[devid].data[2] & DTE_IRQ_REMAP_ENABLE;
   936			int_ctl = old_devtb[devid].data[2] & DTE_IRQ_REMAP_INTCTL_MASK;
   937			int_tab_len = old_devtb[devid].data[2] & DTE_IRQ_TABLE_LEN_MASK;
   938			if (irq_v && (int_ctl || int_tab_len)) {
   939				if ((int_ctl != DTE_IRQ_REMAP_INTCTL) ||
   940				    (int_tab_len != DTE_IRQ_TABLE_LEN)) {
   941					pr_err("Wrong old irq remapping flag: %#x\n", devid);
   942					return false;
   943				}
   944	
   945			        old_dev_tbl_cpy[devid].data[2] = old_devtb[devid].data[2];
   946			}
   947		}
   948		memunmap(old_devtb);
   949	
   950		return true;
   951	}
   952	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
