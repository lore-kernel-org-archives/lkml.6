Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F421DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0DC20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Vu4AMeTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0DC20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbeIJQkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:40:19 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:41934 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbeIJQkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:40:19 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 2E6CC24E1541;
        Mon, 10 Sep 2018 04:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536579998; bh=KL9dSsMzvVhaSU8BO7RxdrtOX/4+JRFC/3+pQf8Dsmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vu4AMeTFy4HR4/cSM7teJN2LFydZw7q/kzsguP4LGARIt3mBnyVARoWW7oS4onXuu
         mytYwQ5kjahCKvSWYRD20EA6U5zSVrC8ibawERUx4IkV39wUCwl7h50scVb63UNN2G
         6gXKzWPzI04jVFpX9t/zl+iZVP+ledl+wHW0QgEoWzAbJvXqA1/HWT06+lCd0qrBJF
         4y9nzlpc/H6Cd45M8noEc9TPjeBaWfBoBe9fJ19PHEL3x/ZqQNoV0VgVg68NtOilMP
         P/PYJjR1xrspotEFimW/u0spF308pHJ7jayxiQpEXUNTUwGarEnRKcwf5xdRFhsqNe
         AE9gPjqVjzg6g==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.37])
        by mailhost.synopsys.com (Postfix) with ESMTP id 47CB45578;
        Mon, 10 Sep 2018 04:46:35 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-mtd@lists.infradead.org
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2 1/2] mtd: spi-nor: Add support of sst26wf* flash ICs protection ops
Date:   Mon, 10 Sep 2018 14:46:27 +0300
Message-Id: <20180910114628.19156-2-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180910114628.19156-1-Eugeniy.Paltsev@synopsys.com>
References: <20180910114628.19156-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sst26wf flash series block protection implementation differs
from other SST series, so add specific implementation
flash_lock/flash_unlock/flash_is_locked functions for sst26wf
flash ICs.

NOTE:
this patch is basically following mine u-boot commit port:
http://git.denx.de/?p=u-boot.git;a=commitdiff;h=3d4fed87a5fa3ffedf64ff2811cd95c5ac4503ac

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
Changes v1->v2:
 * Check return value of {read | write}_reg callbacks.

 drivers/mtd/spi-nor/spi-nor.c | 177 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h   |   4 +
 2 files changed, 181 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index d9c368c44194..d0e7c85b6002 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -598,6 +598,177 @@ static int write_sr_and_check(struct spi_nor *nor, u8 status_new, u8 mask)
 	return ((ret & mask) != (status_new & mask)) ? -EIO : 0;
 }
 
+/*
+ * sst26wf016/sst26wf032/sst26wf064 have next block protection:
+ * 4x   - 8  KByte blocks - read & write protection bits - upper addresses
+ * 1x   - 32 KByte blocks - write protection bits
+ * rest - 64 KByte blocks - write protection bits
+ * 1x   - 32 KByte blocks - write protection bits
+ * 4x   - 8  KByte blocks - read & write protection bits - lower addresses
+ *
+ * We'll support only per 64k lock/unlock so lower and upper 64 KByte region
+ * will be treated as single block.
+ */
+#define SST26_BPR_8K_NUM		4
+#define SST26_MAX_BPR_REG_LEN		(18 + 1)
+#define SST26_BOUND_REG_SIZE		((32 + SST26_BPR_8K_NUM * 8) * SZ_1K)
+
+enum lock_ctl {
+	SST26_CTL_LOCK,
+	SST26_CTL_UNLOCK,
+	SST26_CTL_CHECK
+};
+
+static bool sst26_process_bpr(u32 bpr_size, u8 *cmd, u32 bit, enum lock_ctl ctl)
+{
+	switch (ctl) {
+	case SST26_CTL_LOCK:
+		cmd[bpr_size - (bit / 8) - 1] |= BIT(bit % 8);
+		break;
+	case SST26_CTL_UNLOCK:
+		cmd[bpr_size - (bit / 8) - 1] &= ~BIT(bit % 8);
+		break;
+	case SST26_CTL_CHECK:
+		return !!(cmd[bpr_size - (bit / 8) - 1] & BIT(bit % 8));
+	}
+
+	return false;
+}
+
+/*
+ * Lock, unlock or check lock status of the flash region of the flash (depending
+ * on the lock_ctl value)
+ */
+static int sst26_lock_ctl(struct spi_nor *nor, loff_t ofs, uint64_t len, enum lock_ctl ctl)
+{
+	struct mtd_info *mtd = &nor->mtd;
+	u32 i, bpr_ptr, rptr_64k, lptr_64k, bpr_size;
+	bool lower_64k = false, upper_64k = false;
+	u8 bpr_buff[SST26_MAX_BPR_REG_LEN] = {};
+	int ret;
+
+	/* Check length and offset for 64k alignment */
+	if ((ofs & (SZ_64K - 1)) || (len & (SZ_64K - 1))) {
+		dev_err(nor->dev, "length or offset is not 64KiB allighned\n");
+		return -EINVAL;
+	}
+
+	if (ofs + len > mtd->size) {
+		dev_err(nor->dev, "range is more than device size: %#llx + %#llx > %#llx\n",
+			ofs, len, mtd->size);
+		return -EINVAL;
+	}
+
+	/* SST26 family has only 16 Mbit, 32 Mbit and 64 Mbit IC */
+	if (mtd->size != SZ_2M &&
+	    mtd->size != SZ_4M &&
+	    mtd->size != SZ_8M)
+		return -EINVAL;
+
+	bpr_size = 2 + (mtd->size / SZ_64K / 8);
+
+	ret = nor->read_reg(nor, SPINOR_OP_READ_BPR, bpr_buff, bpr_size);
+	if (ret < 0) {
+		dev_err(nor->dev, "fail to read block-protection register\n");
+		return ret;
+	}
+
+	rptr_64k = min_t(u32, ofs + len, mtd->size - SST26_BOUND_REG_SIZE);
+	lptr_64k = max_t(u32, ofs, SST26_BOUND_REG_SIZE);
+
+	upper_64k = ((ofs + len) > (mtd->size - SST26_BOUND_REG_SIZE));
+	lower_64k = (ofs < SST26_BOUND_REG_SIZE);
+
+	/* Lower bits in block-protection register are about 64k region */
+	bpr_ptr = lptr_64k / SZ_64K - 1;
+
+	/* Process 64K blocks region */
+	while (lptr_64k < rptr_64k) {
+		if (sst26_process_bpr(bpr_size, bpr_buff, bpr_ptr, ctl))
+			return EACCES;
+
+		bpr_ptr++;
+		lptr_64k += SZ_64K;
+	}
+
+	/* 32K and 8K region bits in BPR are after 64k region bits */
+	bpr_ptr = (mtd->size - 2 * SST26_BOUND_REG_SIZE) / SZ_64K;
+
+	/* Process lower 32K block region */
+	if (lower_64k)
+		if (sst26_process_bpr(bpr_size, bpr_buff, bpr_ptr, ctl))
+			return EACCES;
+
+	bpr_ptr++;
+
+	/* Process upper 32K block region */
+	if (upper_64k)
+		if (sst26_process_bpr(bpr_size, bpr_buff, bpr_ptr, ctl))
+			return EACCES;
+
+	bpr_ptr++;
+
+	/* Process lower 8K block regions */
+	for (i = 0; i < SST26_BPR_8K_NUM; i++) {
+		if (lower_64k)
+			if (sst26_process_bpr(bpr_size, bpr_buff, bpr_ptr, ctl))
+				return EACCES;
+
+		/* In 8K area BPR has both read and write protection bits */
+		bpr_ptr += 2;
+	}
+
+	/* Process upper 8K block regions */
+	for (i = 0; i < SST26_BPR_8K_NUM; i++) {
+		if (upper_64k)
+			if (sst26_process_bpr(bpr_size, bpr_buff, bpr_ptr, ctl))
+				return EACCES;
+
+		/* In 8K area BPR has both read and write protection bits */
+		bpr_ptr += 2;
+	}
+
+	/* If we check region status we don't need to write BPR back */
+	if (ctl == SST26_CTL_CHECK)
+		return 0;
+
+	ret = nor->write_reg(nor, SPINOR_OP_WRITE_BPR, bpr_buff, bpr_size);
+	if (ret < 0) {
+		dev_err(nor->dev, "fail to write block-protection register\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int sst26_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	return sst26_lock_ctl(nor, ofs, len, SST26_CTL_UNLOCK);
+}
+
+static int sst26_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	return sst26_lock_ctl(nor, ofs, len, SST26_CTL_LOCK);
+}
+
+/*
+ * Returns EACCES (positive value) if region is locked, 0 if region is unlocked,
+ * and negative on errors.
+ */
+static int sst26_is_locked(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	/*
+	 * is_locked function is used for check before reading or erasing flash
+	 * region, so offset and length might be not 64k allighned, so adjust
+	 * them to be 64k allighned as sst26_lock_ctl works only with 64k
+	 * allighned regions.
+	 */
+	ofs -= ofs & (SZ_64K - 1);
+	len = len & (SZ_64K - 1) ? (len & ~(SZ_64K - 1)) + SZ_64K : len;
+
+	return sst26_lock_ctl(nor, ofs, len, SST26_CTL_CHECK);
+}
+
 static void stm_get_locked_range(struct spi_nor *nor, u8 sr, loff_t *ofs,
 				 uint64_t *len)
 {
@@ -2872,6 +3043,12 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 		nor->flash_is_locked = stm_is_locked;
 	}
 
+	if (JEDEC_MFR(info) == SNOR_MFR_SST && info->id[1] == 0x26) {
+		nor->flash_lock = sst26_lock;
+		nor->flash_unlock = sst26_unlock;
+		nor->flash_is_locked = sst26_is_locked;
+	}
+
 	if (nor->flash_lock && nor->flash_unlock && nor->flash_is_locked) {
 		mtd->_lock = spi_nor_lock;
 		mtd->_unlock = spi_nor_unlock;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index e60da0d34cc1..246014a73f83 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -93,6 +93,10 @@
 #define SPINOR_OP_WRDI		0x04	/* Write disable */
 #define SPINOR_OP_AAI_WP	0xad	/* Auto address increment word program */
 
+/* Used for SST26* flashes only. */
+#define SPINOR_OP_READ_BPR	0x72	/* Read block protection register */
+#define SPINOR_OP_WRITE_BPR	0x42	/* Write block protection register */
+
 /* Used for S3AN flashes only */
 #define SPINOR_OP_XSE		0x50	/* Sector erase */
 #define SPINOR_OP_XPP		0x82	/* Page program */
-- 
2.14.4

