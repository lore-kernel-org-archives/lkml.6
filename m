Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5371EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F3B2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F3B2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731626AbeKLGAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:00:32 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52424 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731283AbeKLGAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:00:32 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt6-0000oM-OD; Sun, 11 Nov 2018 19:59:16 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsQ-0001TC-8Y; Sun, 11 Nov 2018 19:58:34 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Doug Ledford" <dledford@redhat.com>,
        "Don Dutile" <ddutile@redhat.com>,
        "Alex Estrin" <alex.estrin@intel.com>,
        "Mike Marciniszyn" <mike.marciniszyn@intel.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.27520526@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 084/366] IB/qib: Fix DMA api warning with debug kernel
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

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

Reviewed-by: Alex Estrin <alex.estrin@intel.com>
Tested-by: Don Dutile <ddutile@redhat.com>
Reviewed-by: Don Dutile <ddutile@redhat.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/hw/qib/qib.h            |  3 +--
 drivers/infiniband/hw/qib/qib_file_ops.c   | 10 +++++++---
 drivers/infiniband/hw/qib/qib_user_pages.c | 20 ++++++++++++--------
 3 files changed, 20 insertions(+), 13 deletions(-)

--- a/drivers/infiniband/hw/qib/qib.h
+++ b/drivers/infiniband/hw/qib/qib.h
@@ -1452,8 +1452,7 @@ u64 qib_sps_ints(void);
 /*
  * dma_addr wrappers - all 0's invalid for hw
  */
-dma_addr_t qib_map_page(struct pci_dev *, struct page *, unsigned long,
-			  size_t, int);
+int qib_map_page(struct pci_dev *d, struct page *p, dma_addr_t *daddr);
 const char *qib_get_unit_name(int unit);
 
 /*
--- a/drivers/infiniband/hw/qib/qib_file_ops.c
+++ b/drivers/infiniband/hw/qib/qib_file_ops.c
@@ -359,6 +359,8 @@ static int qib_tid_update(struct qib_ctx
 		goto done;
 	}
 	for (i = 0; i < cnt; i++, vaddr += PAGE_SIZE) {
+		dma_addr_t daddr;
+
 		for (; ntids--; tid++) {
 			if (tid == tidcnt)
 				tid = 0;
@@ -375,12 +377,14 @@ static int qib_tid_update(struct qib_ctx
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
@@ -98,23 +98,27 @@ bail:
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

