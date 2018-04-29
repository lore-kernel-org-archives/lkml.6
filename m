Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753614AbeD2PA5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 11:00:57 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37797 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753389AbeD2PA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 11:00:56 -0400
X-Google-Smtp-Source: AB8JxZoBB5nMn2aD0sfAwpdEeoRo+AomGfJwNsQusW2wVBBKfwe6P0EAOcRMUnl1fJQ6eluUXujkUg==
Date: Sun, 29 Apr 2018 08:00:53 -0700
From: Kees Cook <keescook@chromium.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mtd: nftl: Remove VLA usage
Message-ID: <20180429150053.GA27374@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the quest to remove all stack VLAs from the kernel[1] this changes
the check_free_sectors() routine to use a kmalloc()ed buffer instead
of a large VLA stack buffer.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: kmalloc() instead of stack buffer (Boris)
---
 drivers/mtd/inftlmount.c | 23 ++++++++++++++++-------
 drivers/mtd/nftlmount.c  | 23 ++++++++++++++++-------
 2 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/inftlmount.c b/drivers/mtd/inftlmount.c
index aab4f68bd36f..2d598412972d 100644
--- a/drivers/mtd/inftlmount.c
+++ b/drivers/mtd/inftlmount.c
@@ -334,28 +334,37 @@ static int memcmpb(void *a, int c, int n)
 static int check_free_sectors(struct INFTLrecord *inftl, unsigned int address,
 	int len, int check_oob)
 {
-	u8 buf[SECTORSIZE + inftl->mbd.mtd->oobsize];
 	struct mtd_info *mtd = inftl->mbd.mtd;
 	size_t retlen;
-	int i;
+	int i, ret;
+	u8 *buf;
+
+	buf = kmalloc(SECTORSIZE + mtd->oobsize, GFP_KERNEL);
+	if (!buf)
+		return -1;
 
+	ret = -1;
 	for (i = 0; i < len; i += SECTORSIZE) {
 		if (mtd_read(mtd, address, SECTORSIZE, &retlen, buf))
-			return -1;
+			goto out;
 		if (memcmpb(buf, 0xff, SECTORSIZE) != 0)
-			return -1;
+			goto out;
 
 		if (check_oob) {
 			if(inftl_read_oob(mtd, address, mtd->oobsize,
 					  &retlen, &buf[SECTORSIZE]) < 0)
-				return -1;
+				goto out;
 			if (memcmpb(buf + SECTORSIZE, 0xff, mtd->oobsize) != 0)
-				return -1;
+				goto out;
 		}
 		address += SECTORSIZE;
 	}
 
-	return 0;
+	ret = 0;
+
+out:
+	kfree(buf);
+	return ret;
 }
 
 /*
diff --git a/drivers/mtd/nftlmount.c b/drivers/mtd/nftlmount.c
index a6fbfa4e5799..6281da3dadac 100644
--- a/drivers/mtd/nftlmount.c
+++ b/drivers/mtd/nftlmount.c
@@ -272,28 +272,37 @@ static int memcmpb(void *a, int c, int n)
 static int check_free_sectors(struct NFTLrecord *nftl, unsigned int address, int len,
 			      int check_oob)
 {
-	u8 buf[SECTORSIZE + nftl->mbd.mtd->oobsize];
 	struct mtd_info *mtd = nftl->mbd.mtd;
 	size_t retlen;
-	int i;
+	int i, ret;
+	u8 *buf;
+
+	buf = kmalloc(SECTORSIZE + mtd->oobsize, GFP_KERNEL);
+	if (!buf)
+		return -1;
 
+	ret = -1;
 	for (i = 0; i < len; i += SECTORSIZE) {
 		if (mtd_read(mtd, address, SECTORSIZE, &retlen, buf))
-			return -1;
+			goto out;
 		if (memcmpb(buf, 0xff, SECTORSIZE) != 0)
-			return -1;
+			goto out;
 
 		if (check_oob) {
 			if(nftl_read_oob(mtd, address, mtd->oobsize,
 					 &retlen, &buf[SECTORSIZE]) < 0)
-				return -1;
+				goto out;
 			if (memcmpb(buf + SECTORSIZE, 0xff, mtd->oobsize) != 0)
-				return -1;
+				goto out;
 		}
 		address += SECTORSIZE;
 	}
 
-	return 0;
+	ret = 0;
+
+out:
+	kfree(buf);
+	return ret;
 }
 
 /* NFTL_format: format a Erase Unit by erasing ALL Erase Zones in the Erase Unit and
-- 
2.7.4


-- 
Kees Cook
Pixel Security
