Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E232BC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97664208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97664208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755368AbeFNTK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 15:10:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:43197 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754660AbeFNTK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 15:10:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 12:10:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,224,1526367600"; 
   d="scan'208";a="47170317"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jun 2018 12:10:25 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fTXdY-000QzQ-U7; Fri, 15 Jun 2018 03:10:24 +0800
Date:   Fri, 15 Jun 2018 03:24:19 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, thomas.lendacky@amd.com,
        dyoung@redhat.com
Subject: Re: [PATCH 2/2 V2] Support kdump when AMD secure memory encryption
 is active
Message-ID: <201806150155.KM1fUaJB%fengguang.wu@intel.com>
References: <20180614084748.9617-3-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614084748.9617-3-lijiang@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lianbo,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.17 next-20180614]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Lianbo-Jiang/Support-kdump-for-AMD-secure-memory-encryption-sme/20180614-164938
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


vim +904 drivers/iommu/amd_iommu_init.c

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
   892		/*
   893		 *  When sme enable in the first kernel, old_devtb_phys includes the
   894		 *  memory encryption mask(sme_me_mask), we must remove the memory
   895		 *  encryption mask to obtain the true physical address in kdump mode.
   896		 */
   897		if (mem_encrypt_active() && is_kdump_kernel())
   898			old_devtb_phys = __sme_clr(old_devtb_phys);
   899		if (old_devtb_phys >= 0x100000000ULL) {
   900			pr_err("The address of old device table is above 4G, not trustworthy!\n");
   901			return false;
   902		}
   903		if (mem_encrypt_active() && is_kdump_kernel())
 > 904			old_devtb = (void *)ioremap_encrypted(old_devtb_phys,
   905							     dev_table_size);
   906		else
   907			old_devtb = memremap(old_devtb_phys,
   908					    dev_table_size, MEMREMAP_WB);
   909		if (!old_devtb)
   910			return false;
   911	
   912		gfp_flag = GFP_KERNEL | __GFP_ZERO | GFP_DMA32;
   913		old_dev_tbl_cpy = (void *)__get_free_pages(gfp_flag,
   914					get_order(dev_table_size));
   915		if (old_dev_tbl_cpy == NULL) {
   916			pr_err("Failed to allocate memory for copying old device table!\n");
   917			return false;
   918		}
   919	
   920		for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
   921			old_dev_tbl_cpy[devid] = old_devtb[devid];
   922			dom_id = old_devtb[devid].data[1] & DEV_DOMID_MASK;
   923			dte_v = old_devtb[devid].data[0] & DTE_FLAG_V;
   924	
   925			if (dte_v && dom_id) {
   926				old_dev_tbl_cpy[devid].data[0] = old_devtb[devid].data[0];
   927				old_dev_tbl_cpy[devid].data[1] = old_devtb[devid].data[1];
   928				__set_bit(dom_id, amd_iommu_pd_alloc_bitmap);
   929				/* If gcr3 table existed, mask it out */
   930				if (old_devtb[devid].data[0] & DTE_FLAG_GV) {
   931					tmp = DTE_GCR3_VAL_B(~0ULL) << DTE_GCR3_SHIFT_B;
   932					tmp |= DTE_GCR3_VAL_C(~0ULL) << DTE_GCR3_SHIFT_C;
   933					old_dev_tbl_cpy[devid].data[1] &= ~tmp;
   934					tmp = DTE_GCR3_VAL_A(~0ULL) << DTE_GCR3_SHIFT_A;
   935					tmp |= DTE_FLAG_GV;
   936					old_dev_tbl_cpy[devid].data[0] &= ~tmp;
   937				}
   938			}
   939	
   940			irq_v = old_devtb[devid].data[2] & DTE_IRQ_REMAP_ENABLE;
   941			int_ctl = old_devtb[devid].data[2] & DTE_IRQ_REMAP_INTCTL_MASK;
   942			int_tab_len = old_devtb[devid].data[2] & DTE_IRQ_TABLE_LEN_MASK;
   943			if (irq_v && (int_ctl || int_tab_len)) {
   944				if ((int_ctl != DTE_IRQ_REMAP_INTCTL) ||
   945				    (int_tab_len != DTE_IRQ_TABLE_LEN)) {
   946					pr_err("Wrong old irq remapping flag: %#x\n", devid);
   947					return false;
   948				}
   949	
   950			        old_dev_tbl_cpy[devid].data[2] = old_devtb[devid].data[2];
   951			}
   952		}
   953		memunmap(old_devtb);
   954	
   955		return true;
   956	}
   957	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
