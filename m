Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932375AbeE3UpJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:45:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:42642 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932225AbeE3UpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:45:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,461,1520924400";
   d="scan'208";a="52016139"
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: stable@vger.kernel.org
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sonny Rao <sonnyrao@chromium.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <james.l.morris@oracle.com>,
        Peter Huewe <peterhuewe@gmx.de>, Marcel Selhorst <tpmdd@selhorst.net>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        tpmdd-devel@lists.sourceforge.net (moderated list:TPM DEVICE DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] tpm: do not suspend/resume if power stays on
Date: Wed, 30 May 2018 23:44:39 +0300
Message-Id: <20180530204440.27299-2-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180530204440.27299-1-jarkko.sakkinen@linux.intel.com>
References: <20180530204440.27299-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

commit b5d0ebc99bf5d0801a5ecbe958caa3d68b8eaee8 upstream

The suspend/resume behavior of the TPM can be controlled by setting
"powered-while-suspended" in the DTS. This is useful for the cases
when hardware does not power-off the TPM.

Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: James Morris <james.l.morris@oracle.com>
---
 drivers/char/tpm/tpm-chip.c      | 12 ++++++++++++
 drivers/char/tpm/tpm-interface.c |  3 +++
 drivers/char/tpm/tpm.h           |  1 +
 3 files changed, 16 insertions(+)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index a0d9ac6b6cc9..a8d7220f613c 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -324,8 +324,20 @@ static void tpm1_chip_unregister(struct tpm_chip *chip)
  */
 int tpm_chip_register(struct tpm_chip *chip)
 {
+#ifdef CONFIG_TCG_IBMVTPM
+	struct device_node *np;
+#endif
 	int rc;
 
+#ifdef CONFIG_TCG_IBMVTPM
+	np = of_find_node_by_name(NULL, "vtpm");
+	if (!np)
+		return -ENODEV;
+	if (of_property_read_bool(np, "powered-while-suspended"))
+		chip->flags |= TPM_CHIP_FLAG_ALWAYS_POWERED;
+	of_node_put(np);
+#endif
+
 	rc = tpm1_chip_register(chip);
 	if (rc)
 		return rc;
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index aaa5fa95dede..247dd2b6504a 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -931,6 +931,9 @@ int tpm_pm_suspend(struct device *dev)
 	if (chip == NULL)
 		return -ENODEV;
 
+	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
+		return 0;
+
 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
 		tpm2_shutdown(chip, TPM2_SU_STATE);
 		return 0;
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 772d99b3a8e4..36e1abda00f9 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -168,6 +168,7 @@ struct tpm_vendor_specific {
 enum tpm_chip_flags {
 	TPM_CHIP_FLAG_REGISTERED	= BIT(0),
 	TPM_CHIP_FLAG_TPM2		= BIT(1),
+	TPM_CHIP_FLAG_ALWAYS_POWERED	= BIT(5),
 };
 
 struct tpm_chip {
-- 
2.17.0
