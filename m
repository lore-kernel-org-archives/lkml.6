Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 153B1C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1D4208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1D4208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754766AbeFNIPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:15:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:24708 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754631AbeFNIPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:15:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 01:15:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,222,1526367600"; 
   d="scan'208";a="49814386"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.43])
  by orsmga006.jf.intel.com with ESMTP; 14 Jun 2018 01:15:03 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Alex Lemberg <Alex.Lemberg@wdc.com>,
        Avri Altman <Avri.Altman@wdc.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH resend] scsi: ufs: ufshcd_dump_regs to use memcpy_fromio
Date:   Thu, 14 Jun 2018 11:14:09 +0300
Message-Id: <20180614081409.29780-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ufshcd_dump_regs should use memcpy_fromio to read host registers
instead of directly accessing using memcpy.
The same function is utilized in ufs-qcom.

Elminite compilation warning
drivers/scsi/ufs/ufshcd.c:356:9: warning: incorrect type in argument 6 (different address spaces)
drivers/scsi/ufs/ufshcd.c:356:9:    expected void const *buf
drivers/scsi/ufs/ufshcd.c:356:9:    got void [noderef] <asn:2>*mmio_base

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/scsi/ufs/ufs-qcom.c | 21 ++++++---------------
 drivers/scsi/ufs/ufshcd.c   | 35 ++++++++++++++++++++++++-----------
 drivers/scsi/ufs/ufshcd.h   |  3 +++
 3 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index 2b38db2eeafa..77ac98ea80d4 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -50,19 +50,10 @@ static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
 static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
 						       u32 clk_cycles);
 
-static void ufs_qcom_dump_regs(struct ufs_hba *hba, int offset, int len,
-		char *prefix)
-{
-	print_hex_dump(KERN_ERR, prefix,
-			len > 4 ? DUMP_PREFIX_OFFSET : DUMP_PREFIX_NONE,
-			16, 4, (void __force *)hba->mmio_base + offset,
-			len * 4, false);
-}
-
 static void ufs_qcom_dump_regs_wrapper(struct ufs_hba *hba, int offset, int len,
-		char *prefix, void *priv)
+				       const char *prefix, void *priv)
 {
-	ufs_qcom_dump_regs(hba, offset, len, prefix);
+	ufshcd_dump_regs(hba, offset, len * 4, prefix);
 }
 
 static int ufs_qcom_get_connected_tx_lanes(struct ufs_hba *hba, u32 *tx_lanes)
@@ -1431,7 +1422,7 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
 
 static void ufs_qcom_print_hw_debug_reg_all(struct ufs_hba *hba,
 		void *priv, void (*print_fn)(struct ufs_hba *hba,
-		int offset, int num_regs, char *str, void *priv))
+		int offset, int num_regs, const char *str, void *priv))
 {
 	u32 reg;
 	struct ufs_qcom_host *host;
@@ -1613,7 +1604,7 @@ int ufs_qcom_testbus_config(struct ufs_qcom_host *host)
 
 static void ufs_qcom_testbus_read(struct ufs_hba *hba)
 {
-	ufs_qcom_dump_regs(hba, UFS_TEST_BUS, 1, "UFS_TEST_BUS ");
+	ufshcd_dump_regs(hba, UFS_TEST_BUS, 4, "UFS_TEST_BUS ");
 }
 
 static void ufs_qcom_print_unipro_testbus(struct ufs_hba *hba)
@@ -1639,8 +1630,8 @@ static void ufs_qcom_print_unipro_testbus(struct ufs_hba *hba)
 
 static void ufs_qcom_dump_dbg_regs(struct ufs_hba *hba)
 {
-	ufs_qcom_dump_regs(hba, REG_UFS_SYS1CLK_1US, 16,
-			"HCI Vendor Specific Registers ");
+	ufshcd_dump_regs(hba, REG_UFS_SYS1CLK_1US, 16 * 4,
+			 "HCI Vendor Specific Registers ");
 
 	/* sleep a bit intermittently as we are dumping too much data */
 	ufs_qcom_print_hw_debug_reg_all(hba, NULL, ufs_qcom_dump_regs_wrapper);
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index d0a1674915a1..972fa85e2b24 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -99,8 +99,29 @@
 		_ret;                                                   \
 	})
 
-#define ufshcd_hex_dump(prefix_str, buf, len) \
-print_hex_dump(KERN_ERR, prefix_str, DUMP_PREFIX_OFFSET, 16, 4, buf, len, false)
+#define ufshcd_hex_dump(prefix_str, buf, len) do {                       \
+	size_t __len = (len);                                            \
+	print_hex_dump(KERN_ERR, prefix_str,                             \
+		       __len > 4 ? DUMP_PREFIX_OFFSET : DUMP_PREFIX_NONE,\
+		       16, 4, buf, __len, false);                        \
+} while (0)
+
+int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
+		     const char *prefix)
+{
+	u8 *regs;
+
+	regs = kzalloc(len, GFP_KERNEL);
+	if (!regs)
+		return -ENOMEM;
+
+	memcpy_fromio(regs, hba->mmio_base + offset, len);
+	ufshcd_hex_dump(prefix, regs, len);
+	kfree(regs);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ufshcd_dump_regs);
 
 enum {
 	UFSHCD_MAX_CHANNEL	= 0,
@@ -376,15 +397,7 @@ static void ufshcd_print_uic_err_hist(struct ufs_hba *hba,
 
 static void ufshcd_print_host_regs(struct ufs_hba *hba)
 {
-	/*
-	 * hex_dump reads its data without the readl macro. This might
-	 * cause inconsistency issues on some platform, as the printed
-	 * values may be from cache and not the most recent value.
-	 * To know whether you are looking at an un-cached version verify
-	 * that IORESOURCE_MEM flag is on when xxx_get_resource() is invoked
-	 * during platform/pci probe function.
-	 */
-	ufshcd_hex_dump("host regs: ", hba->mmio_base, UFSHCI_REG_SPACE_SIZE);
+	ufshcd_dump_regs(hba, 0, UFSHCI_REG_SPACE_SIZE, "host_regs: ");
 	dev_err(hba->dev, "hba->ufs_version = 0x%x, hba->capabilities = 0x%x\n",
 		hba->ufs_version, hba->capabilities);
 	dev_err(hba->dev,
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 8110dcd04d22..aad959ba3d9b 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -1022,4 +1022,7 @@ static inline u8 ufshcd_scsi_to_upiu_lun(unsigned int scsi_lun)
 		return scsi_lun & UFS_UPIU_MAX_UNIT_NUM_ID;
 }
 
+int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
+		     const char *prefix);
+
 #endif /* End of Header */
-- 
2.14.4

