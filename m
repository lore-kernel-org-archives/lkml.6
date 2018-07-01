Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C64C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791FC257AA
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791FC257AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030608AbeGARyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:54:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35052 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030543AbeGAQbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:31:48 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6239192B;
        Sun,  1 Jul 2018 16:31:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Estrin <alex.estrin@intel.com>,
        Don Dutile <ddutile@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.14 059/157] IB/qib: Fix DMA api warning with debug kernel
Date:   Sun,  1 Jul 2018 18:22:11 +0200
Message-Id: <20180701160855.578814792@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

commit 0252f73334f9ef68868e4684200bea3565a4fcee upstream.

The following error occurs in a debug build when running MPI PSM:

[  307.415911] WARNING: CPU: 4 PID: 23867 at lib/dma-debug.c:1158
check_unmap+0x4ee/0xa20
[  307.455661] ib_qib 0000:05:00.0: DMA-API: device driver failed to check map
error[device address=0x00000000df82b000] [size=4096 bytes] [mapped as page]
[  307.517494] Modules linked in:
[  307.531584]  ib_isert iscsi_target_mod ib_srpt target_core_mod rpcrdma
sunrpc ib_srp scsi_transport_srp scsi_tgt ib_iser libiscsi ib_ipoib
scsi_transport_iscsi rdma_ucm ib_ucm ib_uverbs ib_umad rdma_cm ib_cm iw_cm
ib_qib intel_powerclamp coretemp rdmavt intel_rapl iosf_mbi kvm_intel kvm
irqbypass crc32_pclmul ghash_clmulni_intel ipmi_ssif ib_core aesni_intel sg
ipmi_si lrw gf128mul dca glue_helper ipmi_devintf iTCO_wdt gpio_ich hpwdt
iTCO_vendor_support ablk_helper hpilo acpi_power_meter cryptd ipmi_msghandler
ie31200_edac shpchp pcc_cpufreq lpc_ich pcspkr ip_tables xfs libcrc32c sd_mod
crc_t10dif crct10dif_generic mgag200 i2c_algo_bit drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops ttm ahci crct10dif_pclmul crct10dif_common
drm crc32c_intel libahci tg3 libata serio_raw ptp i2c_core
[  307.846113]  pps_core dm_mirror dm_region_hash dm_log dm_mod
[  307.866505] CPU: 4 PID: 23867 Comm: mpitests-IMB-MP Kdump: loaded Not
tainted 3.10.0-862.el7.x86_64.debug #1
[  307.911178] Hardware name: HP ProLiant DL320e Gen8, BIOS J05 11/09/2013
[  307.944206] Call Trace:
[  307.956973]  [<ffffffffbd9e915b>] dump_stack+0x19/0x1b
[  307.982201]  [<ffffffffbd2a2f58>] __warn+0xd8/0x100
[  308.005999]  [<ffffffffbd2a2fdf>] warn_slowpath_fmt+0x5f/0x80
[  308.034260]  [<ffffffffbd5f667e>] check_unmap+0x4ee/0xa20
[  308.060801]  [<ffffffffbd41acaa>] ? page_add_file_rmap+0x2a/0x1d0
[  308.090689]  [<ffffffffbd5f6c4d>] debug_dma_unmap_page+0x9d/0xb0
[  308.120155]  [<ffffffffbd4082e0>] ? might_fault+0xa0/0xb0
[  308.146656]  [<ffffffffc07761a5>] qib_tid_free.isra.14+0x215/0x2a0 [ib_qib]
[  308.180739]  [<ffffffffc0776bf4>] qib_write+0x894/0x1280 [ib_qib]
[  308.210733]  [<ffffffffbd540b00>] ? __inode_security_revalidate+0x70/0x80
[  308.244837]  [<ffffffffbd53c2b7>] ? security_file_permission+0x27/0xb0
[  308.266025] qib_ib0.8006: multicast join failed for
ff12:401b:8006:0000:0000:0000:ffff:ffff, status -22
[  308.323421]  [<ffffffffbd46f5d3>] vfs_write+0xc3/0x1f0
[  308.347077]  [<ffffffffbd492a5c>] ? fget_light+0xfc/0x510
[  308.372533]  [<ffffffffbd47045a>] SyS_write+0x8a/0x100
[  308.396456]  [<ffffffffbd9ff355>] system_call_fastpath+0x1c/0x21

The code calls a qib_map_page() which has never correctly tested for a
mapping error.

Fix by testing for pci_dma_mapping_error() in all cases and properly
handling the failure in the caller.

Additionally, streamline qib_map_page() arguments to satisfy just
the single caller.

Cc: <stable@vger.kernel.org>
Reviewed-by: Alex Estrin <alex.estrin@intel.com>
Tested-by: Don Dutile <ddutile@redhat.com>
Reviewed-by: Don Dutile <ddutile@redhat.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/qib/qib.h            |    3 +--
 drivers/infiniband/hw/qib/qib_file_ops.c   |   10 +++++++---
 drivers/infiniband/hw/qib/qib_user_pages.c |   20 ++++++++++++--------
 3 files changed, 20 insertions(+), 13 deletions(-)

--- a/drivers/infiniband/hw/qib/qib.h
+++ b/drivers/infiniband/hw/qib/qib.h
@@ -1448,8 +1448,7 @@ u64 qib_sps_ints(void);
 /*
  * dma_addr wrappers - all 0's invalid for hw
  */
-dma_addr_t qib_map_page(struct pci_dev *, struct page *, unsigned long,
-			  size_t, int);
+int qib_map_page(struct pci_dev *d, struct page *p, dma_addr_t *daddr);
 const char *qib_get_unit_name(int unit);
 const char *qib_get_card_name(struct rvt_dev_info *rdi);
 struct pci_dev *qib_get_pci_dev(struct rvt_dev_info *rdi);
--- a/drivers/infiniband/hw/qib/qib_file_ops.c
+++ b/drivers/infiniband/hw/qib/qib_file_ops.c
@@ -364,6 +364,8 @@ static int qib_tid_update(struct qib_ctx
 		goto done;
 	}
 	for (i = 0; i < cnt; i++, vaddr += PAGE_SIZE) {
+		dma_addr_t daddr;
+
 		for (; ntids--; tid++) {
 			if (tid == tidcnt)
 				tid = 0;
@@ -380,12 +382,14 @@ static int qib_tid_update(struct qib_ctx
 			ret = -ENOMEM;
 			break;
 		}
+		ret = qib_map_page(dd->pcidev, pagep[i], &daddr);
+		if (ret)
+			break;
+
 		tidlist[i] = tid + tidoff;
 		/* we "know" system pages and TID pages are same size */
 		dd->pageshadow[ctxttid + tid] = pagep[i];
-		dd->physshadow[ctxttid + tid] =
-			qib_map_page(dd->pcidev, pagep[i], 0, PAGE_SIZE,
-				     PCI_DMA_FROMDEVICE);
+		dd->physshadow[ctxttid + tid] = daddr;
 		/*
 		 * don't need atomic or it's overhead
 		 */
--- a/drivers/infiniband/hw/qib/qib_user_pages.c
+++ b/drivers/infiniband/hw/qib/qib_user_pages.c
@@ -99,23 +99,27 @@ bail:
  *
  * I'm sure we won't be so lucky with other iommu's, so FIXME.
  */
-dma_addr_t qib_map_page(struct pci_dev *hwdev, struct page *page,
-			unsigned long offset, size_t size, int direction)
+int qib_map_page(struct pci_dev *hwdev, struct page *page, dma_addr_t *daddr)
 {
 	dma_addr_t phys;
 
-	phys = pci_map_page(hwdev, page, offset, size, direction);
+	phys = pci_map_page(hwdev, page, 0, PAGE_SIZE, PCI_DMA_FROMDEVICE);
+	if (pci_dma_mapping_error(hwdev, phys))
+		return -ENOMEM;
 
-	if (phys == 0) {
-		pci_unmap_page(hwdev, phys, size, direction);
-		phys = pci_map_page(hwdev, page, offset, size, direction);
+	if (!phys) {
+		pci_unmap_page(hwdev, phys, PAGE_SIZE, PCI_DMA_FROMDEVICE);
+		phys = pci_map_page(hwdev, page, 0, PAGE_SIZE,
+				    PCI_DMA_FROMDEVICE);
+		if (pci_dma_mapping_error(hwdev, phys))
+			return -ENOMEM;
 		/*
 		 * FIXME: If we get 0 again, we should keep this page,
 		 * map another, then free the 0 page.
 		 */
 	}
-
-	return phys;
+	*daddr = phys;
+	return 0;
 }
 
 /**


