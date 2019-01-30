Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FECAC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D138B218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbfA3X0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:26:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfA3X0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:26:52 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C957A7FC9;
        Wed, 30 Jan 2019 22:07:00 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-116-165.phx2.redhat.com [10.3.116.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DB3F608EB;
        Wed, 30 Jan 2019 22:07:00 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 1/2] tpm: don't return bool from update_timeouts
Date:   Wed, 30 Jan 2019 15:06:58 -0700
Message-Id: <20190130220659.10102-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 30 Jan 2019 22:07:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set tpm_chip->timeouts_adjusted directly in the update_timeouts
code instead of returning bool. In case of tpm read failing
print warning that the read failed and continue on.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/char/tpm/tpm1-cmd.c     |  3 +--
 drivers/char/tpm/tpm_tis_core.c | 15 +++++++++------
 include/linux/tpm.h             |  2 +-
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 6f306338953b..bda9a16b44f6 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -380,8 +380,7 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
 	 * of misreporting.
 	 */
 	if (chip->ops->update_timeouts)
-		chip->timeout_adjusted =
-			chip->ops->update_timeouts(chip, timeout_eff);
+		chip->ops->update_timeouts(chip, timeout_eff);
 
 	if (!chip->timeout_adjusted) {
 		/* Restore default if chip reported 0 */
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index bf7e49cfa643..45e29fd1f5d7 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -521,35 +521,38 @@ static const struct tis_vendor_timeout_override vendor_timeout_overrides[] = {
 			(TIS_SHORT_TIMEOUT*1000), (TIS_SHORT_TIMEOUT*1000) } },
 };
 
-static bool tpm_tis_update_timeouts(struct tpm_chip *chip,
+static void tpm_tis_update_timeouts(struct tpm_chip *chip,
 				    unsigned long *timeout_cap)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	int i, rc;
 	u32 did_vid;
 
+	chip->timeout_adjusted = false;
+
 	if (chip->ops->clk_enable != NULL)
 		chip->ops->clk_enable(chip, true);
 
 	rc = tpm_tis_read32(priv, TPM_DID_VID(0), &did_vid);
-	if (rc < 0)
+	if (rc < 0) {
+		dev_warn(&chip->dev, "%s: failed to read did_vid: %d\n",
+			 __func__, rc);
 		goto out;
+	}
 
 	for (i = 0; i != ARRAY_SIZE(vendor_timeout_overrides); i++) {
 		if (vendor_timeout_overrides[i].did_vid != did_vid)
 			continue;
 		memcpy(timeout_cap, vendor_timeout_overrides[i].timeout_us,
 		       sizeof(vendor_timeout_overrides[i].timeout_us));
-		rc = true;
+		chip->timeout_adjusted = true;
 	}
 
-	rc = false;
-
 out:
 	if (chip->ops->clk_enable != NULL)
 		chip->ops->clk_enable(chip, false);
 
-	return rc;
+	return;
 }
 
 /*
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index b49a55cf775f..13563b8c0c3a 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -41,7 +41,7 @@ struct tpm_class_ops {
 	int (*send) (struct tpm_chip *chip, u8 *buf, size_t len);
 	void (*cancel) (struct tpm_chip *chip);
 	u8 (*status) (struct tpm_chip *chip);
-	bool (*update_timeouts)(struct tpm_chip *chip,
+	void (*update_timeouts)(struct tpm_chip *chip,
 				unsigned long *timeout_cap);
 	int (*go_idle)(struct tpm_chip *chip);
 	int (*cmd_ready)(struct tpm_chip *chip);
-- 
2.20.1.98.gecbdaf0899

