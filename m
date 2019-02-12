Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103C7C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7632184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="wzJS7IgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfBLHPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:15:19 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:37649 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfBLHOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:14:40 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x1C7DPdQ019269;
        Tue, 12 Feb 2019 16:13:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x1C7DPdQ019269
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549955608;
        bh=ihNbLBMtgE/zJu/k8HCGhdOaZjsPbiFnKTP5gCB7XuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wzJS7IgEHpXoyyUyx4hkJ4XFkZ90FNdm1QPP6/lrY38h0B+Zmf/QMjaxUR7AaJVU4
         rYkYBo7OYzUo12abe+rjckymZvS8Ypku/IppoBbt69l7mzN9U4GuXl350nIfrT/MKJ
         521RElPveetp/YawBhDlQA/5KfOkZkdqhvTBuRpLhR02ey4MVO7igbT9rfs0zJFR5C
         UPuiiJR2errII0t2HwhhMWdCOAwOXI09YNfrAnWpldSbv+R3t6HhJCRRkn9nSGmank
         YzgSpRDPXYmVAV6ap8SKxQqumWZeWszWUD331FdGi6ssRyg6Y+K2lwgAAM7CUG0IZO
         QzdKE7X6fKVOA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2 02/10] mtd: rawnand: denali: refactor syndrome layout handling for raw access
Date:   Tue, 12 Feb 2019 16:12:54 +0900
Message-Id: <1549955582-30346-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549955582-30346-1-git-send-email-yamada.masahiro@socionext.com>
References: <1549955582-30346-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Denali IP adopts the syndrome page layout (payload and ECC are
interleaved). The *_page_raw() and *_oob() callbacks are complicated
because they must hide the underlying layout used by the hardware,
and always return contiguous in-band and out-of-band data.

Currently, similar code is duplicated to reorganize the data layout.
For example, denali_read_page_raw() and denali_write_page_raw() look
almost the same.

The idea for refactoring is to split the code into two parts:
  [1] conversion of page layout
  [2] what to do at every ECC chunk boundary

For [1], I wrote denali_raw_payload_op() and denali_raw_oob_op().
They manipulate data for the Denali controller's specific page layout
of in-band, out-of-band, respectively.

The difference between write and read is just the operation at
ECC chunk boundaries. For example, denali_read_oob() calls
nand_change_read_column_op(), whereas denali_write_oob() calls
nand_change_write_column_op(). So, I implemented [2] as a callback
passed into [1].

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 drivers/mtd/nand/raw/denali.c | 354 +++++++++++++++++++-----------------------
 1 file changed, 163 insertions(+), 191 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 4ac1314..9287f4f 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -608,159 +608,210 @@ static int denali_data_xfer(struct nand_chip *chip, void *buf, size_t size,
 		return denali_pio_xfer(denali, buf, size, page, write);
 }
 
-static void denali_oob_xfer(struct mtd_info *mtd, struct nand_chip *chip,
-			    int page, int write)
+typedef int denali_change_column_callback(void *buf, unsigned int offset,
+					  unsigned int len, void *priv);
+
+static int denali_raw_payload_op(struct nand_chip *chip, void *buf,
+				 denali_change_column_callback *cb, void *priv)
 {
-	struct denali_nand_info *denali = mtd_to_denali(mtd);
+	struct denali_nand_info *denali = to_denali(chip);
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+	int writesize = mtd->writesize;
+	int oob_skip = denali->oob_skip_bytes;
+	int ret, i, pos, len;
+
+	for (i = 0; i < ecc->steps; i++) {
+		pos = i * (ecc->size + ecc->bytes);
+		len = ecc->size;
+
+		if (pos >= writesize) {
+			pos += oob_skip;
+		} else if (pos + len > writesize) {
+			/* This chunk overwraps the BBM area. Must be split */
+			ret = cb(buf, pos, writesize - pos, priv);
+			if (ret)
+				return ret;
+
+			buf += writesize - pos;
+			len -= writesize - pos;
+			pos = writesize + oob_skip;
+		}
+
+		ret = cb(buf, pos, len, priv);
+		if (ret)
+			return ret;
+
+		buf += len;
+	}
+
+	return 0;
+}
+
+static int denali_raw_oob_op(struct nand_chip *chip, void *buf,
+			     denali_change_column_callback *cb, void *priv)
+{
+	struct denali_nand_info *denali = to_denali(chip);
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int writesize = mtd->writesize;
 	int oobsize = mtd->oobsize;
-	uint8_t *bufpoi = chip->oob_poi;
-	int ecc_steps = chip->ecc.steps;
-	int ecc_size = chip->ecc.size;
-	int ecc_bytes = chip->ecc.bytes;
 	int oob_skip = denali->oob_skip_bytes;
-	size_t size = writesize + oobsize;
-	int i, pos, len;
+	int ret, i, pos, len;
 
 	/* BBM at the beginning of the OOB area */
-	if (write)
-		nand_prog_page_begin_op(chip, page, writesize, bufpoi,
-					oob_skip);
-	else
-		nand_read_page_op(chip, page, writesize, bufpoi, oob_skip);
-	bufpoi += oob_skip;
+	ret = cb(buf, writesize, oob_skip, priv);
+	if (ret)
+		return ret;
 
-	/* OOB ECC */
-	for (i = 0; i < ecc_steps; i++) {
-		pos = ecc_size + i * (ecc_size + ecc_bytes);
-		len = ecc_bytes;
+	buf += oob_skip;
 
-		if (pos >= writesize)
-			pos += oob_skip;
-		else if (pos + len > writesize)
-			len = writesize - pos;
+	for (i = 0; i < ecc->steps; i++) {
+		pos = ecc->size + i * (ecc->size + ecc->bytes);
 
-		if (write)
-			nand_change_write_column_op(chip, pos, bufpoi, len,
-						    false);
+		if (i == ecc->steps - 1)
+			/* The last chunk includes OOB free */
+			len = writesize + oobsize - pos - oob_skip;
 		else
-			nand_change_read_column_op(chip, pos, bufpoi, len,
-						   false);
-		bufpoi += len;
-		if (len < ecc_bytes) {
-			len = ecc_bytes - len;
-			if (write)
-				nand_change_write_column_op(chip, writesize +
-							    oob_skip, bufpoi,
-							    len, false);
-			else
-				nand_change_read_column_op(chip, writesize +
-							   oob_skip, bufpoi,
-							   len, false);
-			bufpoi += len;
+			len = ecc->bytes;
+
+		if (pos >= writesize) {
+			pos += oob_skip;
+		} else if (pos + len > writesize) {
+			/* This chunk overwraps the BBM area. Must be split */
+			ret = cb(buf, pos, writesize - pos, priv);
+			if (ret)
+				return ret;
+
+			buf += writesize - pos;
+			len -= writesize - pos;
+			pos = writesize + oob_skip;
 		}
+
+		ret = cb(buf, pos, len, priv);
+		if (ret)
+			return ret;
+
+		buf += len;
 	}
 
-	/* OOB free */
-	len = oobsize - (bufpoi - chip->oob_poi);
-	if (write)
-		nand_change_write_column_op(chip, size - len, bufpoi, len,
-					    false);
-	else
-		nand_change_read_column_op(chip, size - len, bufpoi, len,
-					   false);
+	return 0;
+}
+
+static int denali_memcpy_in(void *buf, unsigned int offset, unsigned int len,
+			    void *priv)
+{
+	memcpy(buf, priv + offset, len);
+	return 0;
 }
 
 static int denali_read_page_raw(struct nand_chip *chip, uint8_t *buf,
 				int oob_required, int page)
 {
+	struct denali_nand_info *denali = to_denali(chip);
 	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct denali_nand_info *denali = mtd_to_denali(mtd);
-	int writesize = mtd->writesize;
-	int oobsize = mtd->oobsize;
-	int ecc_steps = chip->ecc.steps;
-	int ecc_size = chip->ecc.size;
-	int ecc_bytes = chip->ecc.bytes;
 	void *tmp_buf = denali->buf;
-	int oob_skip = denali->oob_skip_bytes;
-	size_t size = writesize + oobsize;
-	int ret, i, pos, len;
+	size_t size = mtd->writesize + mtd->oobsize;
+	int ret;
+
+	if (!buf)
+		return -EINVAL;
 
 	ret = denali_data_xfer(chip, tmp_buf, size, page, 1, 0);
 	if (ret)
 		return ret;
 
-	/* Arrange the buffer for syndrome payload/ecc layout */
-	if (buf) {
-		for (i = 0; i < ecc_steps; i++) {
-			pos = i * (ecc_size + ecc_bytes);
-			len = ecc_size;
-
-			if (pos >= writesize)
-				pos += oob_skip;
-			else if (pos + len > writesize)
-				len = writesize - pos;
-
-			memcpy(buf, tmp_buf + pos, len);
-			buf += len;
-			if (len < ecc_size) {
-				len = ecc_size - len;
-				memcpy(buf, tmp_buf + writesize + oob_skip,
-				       len);
-				buf += len;
-			}
-		}
-	}
+	ret = denali_raw_payload_op(chip, buf, denali_memcpy_in, tmp_buf);
+	if (ret)
+		return ret;
 
 	if (oob_required) {
-		uint8_t *oob = chip->oob_poi;
-
-		/* BBM at the beginning of the OOB area */
-		memcpy(oob, tmp_buf + writesize, oob_skip);
-		oob += oob_skip;
-
-		/* OOB ECC */
-		for (i = 0; i < ecc_steps; i++) {
-			pos = ecc_size + i * (ecc_size + ecc_bytes);
-			len = ecc_bytes;
-
-			if (pos >= writesize)
-				pos += oob_skip;
-			else if (pos + len > writesize)
-				len = writesize - pos;
-
-			memcpy(oob, tmp_buf + pos, len);
-			oob += len;
-			if (len < ecc_bytes) {
-				len = ecc_bytes - len;
-				memcpy(oob, tmp_buf + writesize + oob_skip,
-				       len);
-				oob += len;
-			}
-		}
-
-		/* OOB free */
-		len = oobsize - (oob - chip->oob_poi);
-		memcpy(oob, tmp_buf + size - len, len);
+		ret = denali_raw_oob_op(chip, chip->oob_poi, denali_memcpy_in,
+					tmp_buf);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
 }
 
-static int denali_read_oob(struct nand_chip *chip, int page)
+static int denali_memcpy_out(void *buf, unsigned int offset, unsigned int len,
+			     void *priv)
+{
+	memcpy(priv + offset, buf, len);
+	return 0;
+}
+
+static int denali_write_page_raw(struct nand_chip *chip, const uint8_t *buf,
+				 int oob_required, int page)
 {
+	struct denali_nand_info *denali = to_denali(chip);
 	struct mtd_info *mtd = nand_to_mtd(chip);
+	void *tmp_buf = denali->buf;
+	size_t size = mtd->writesize + mtd->oobsize;
+	int ret;
 
-	denali_oob_xfer(mtd, chip, page, 0);
+	if (!buf)
+		return -EINVAL;
 
-	return 0;
+	/*
+	 * Fill the buffer with 0xff first except the full page transfer.
+	 * This simplifies the logic.
+	 */
+	if (!oob_required)
+		memset(tmp_buf, 0xff, size);
+
+	ret = denali_raw_payload_op(chip, (void *)buf, denali_memcpy_out,
+				    tmp_buf);
+	if (ret)
+		return ret;
+
+	if (oob_required) {
+		ret = denali_raw_oob_op(chip, chip->oob_poi, denali_memcpy_out,
+					tmp_buf);
+		if (ret)
+			return ret;
+	}
+
+	return denali_data_xfer(chip, tmp_buf, size, page, 1, 1);
+}
+
+static int denali_change_read_column_op(void *buf, unsigned int offset,
+					unsigned int len, void *priv)
+{
+	return nand_change_read_column_op(priv, offset, buf, len, false);
+}
+
+static int denali_read_oob(struct nand_chip *chip, int page)
+{
+	int ret;
+
+	ret = nand_read_page_op(chip, page, 0, NULL, 0);
+	if (ret)
+		return ret;
+
+	return denali_raw_oob_op(chip, chip->oob_poi,
+				 denali_change_read_column_op, chip);
+}
+
+static int denali_change_write_column_op(void *buf, unsigned int offset,
+					 unsigned int len, void *priv)
+{
+	return nand_change_write_column_op(priv, offset, buf, len, false);
 }
 
 static int denali_write_oob(struct nand_chip *chip, int page)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
+	int ret;
 
-	denali_oob_xfer(mtd, chip, page, 1);
+	ret = nand_prog_page_begin_op(chip, page, 0, NULL, 0);
+	if (ret)
+		return ret;
+
+	ret = denali_raw_oob_op(chip, chip->oob_poi,
+				denali_change_write_column_op, chip);
+	if (ret)
+		return ret;
 
 	return nand_prog_page_end_op(chip);
 }
@@ -798,85 +849,6 @@ static int denali_read_page(struct nand_chip *chip, uint8_t *buf,
 	return stat;
 }
 
-static int denali_write_page_raw(struct nand_chip *chip, const uint8_t *buf,
-				 int oob_required, int page)
-{
-	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct denali_nand_info *denali = mtd_to_denali(mtd);
-	int writesize = mtd->writesize;
-	int oobsize = mtd->oobsize;
-	int ecc_steps = chip->ecc.steps;
-	int ecc_size = chip->ecc.size;
-	int ecc_bytes = chip->ecc.bytes;
-	void *tmp_buf = denali->buf;
-	int oob_skip = denali->oob_skip_bytes;
-	size_t size = writesize + oobsize;
-	int i, pos, len;
-
-	/*
-	 * Fill the buffer with 0xff first except the full page transfer.
-	 * This simplifies the logic.
-	 */
-	if (!buf || !oob_required)
-		memset(tmp_buf, 0xff, size);
-
-	/* Arrange the buffer for syndrome payload/ecc layout */
-	if (buf) {
-		for (i = 0; i < ecc_steps; i++) {
-			pos = i * (ecc_size + ecc_bytes);
-			len = ecc_size;
-
-			if (pos >= writesize)
-				pos += oob_skip;
-			else if (pos + len > writesize)
-				len = writesize - pos;
-
-			memcpy(tmp_buf + pos, buf, len);
-			buf += len;
-			if (len < ecc_size) {
-				len = ecc_size - len;
-				memcpy(tmp_buf + writesize + oob_skip, buf,
-				       len);
-				buf += len;
-			}
-		}
-	}
-
-	if (oob_required) {
-		const uint8_t *oob = chip->oob_poi;
-
-		/* BBM at the beginning of the OOB area */
-		memcpy(tmp_buf + writesize, oob, oob_skip);
-		oob += oob_skip;
-
-		/* OOB ECC */
-		for (i = 0; i < ecc_steps; i++) {
-			pos = ecc_size + i * (ecc_size + ecc_bytes);
-			len = ecc_bytes;
-
-			if (pos >= writesize)
-				pos += oob_skip;
-			else if (pos + len > writesize)
-				len = writesize - pos;
-
-			memcpy(tmp_buf + pos, oob, len);
-			oob += len;
-			if (len < ecc_bytes) {
-				len = ecc_bytes - len;
-				memcpy(tmp_buf + writesize + oob_skip, oob,
-				       len);
-				oob += len;
-			}
-		}
-
-		/* OOB free */
-		len = oobsize - (oob - chip->oob_poi);
-		memcpy(tmp_buf + size - len, oob, len);
-	}
-
-	return denali_data_xfer(chip, tmp_buf, size, page, 1, 1);
-}
-
 static int denali_write_page(struct nand_chip *chip, const uint8_t *buf,
 			     int oob_required, int page)
 {
-- 
2.7.4

