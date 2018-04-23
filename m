Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755600AbeDWUfF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 16:35:05 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46347 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755165AbeDWUfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 16:35:03 -0400
X-Google-Smtp-Source: AIpwx4/or4R1669l/jHlV7ZAkmGi5tbnNoXMggm9c3Cbus76+t0Bw7uQkfkPF+HTgSDmIneRwb0blA==
Date: Mon, 23 Apr 2018 13:35:00 -0700
From: Kees Cook <keescook@chromium.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org
Subject: [PATCH] mtd: nftl: Remove VLA usage
Message-ID: <20180423203500.GA36488@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the quest to remove all VLAs from the kernel[1] this changes the
check_free_sectors() routine to use the same stack buffer for both
data byte checks (SECTORSIZE) and oob byte checks (oobsize). Since
these regions aren't needed at the same time, they don't need to be
consecutively allocated. Additionally, while it's possible for oobsize
to be large, it is unlikely to be larger than the actual SECTORSIZE. As
such, remove the VLA, adjust offsets and add a sanity check to make sure
we never get a pathological oobsize.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/mtd/inftlmount.c | 11 ++++++++---
 drivers/mtd/nftlmount.c  | 11 ++++++++---
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/inftlmount.c b/drivers/mtd/inftlmount.c
index aab4f68bd36f..9cdae7f0fc2e 100644
--- a/drivers/mtd/inftlmount.c
+++ b/drivers/mtd/inftlmount.c
@@ -334,7 +334,7 @@ static int memcmpb(void *a, int c, int n)
 static int check_free_sectors(struct INFTLrecord *inftl, unsigned int address,
 	int len, int check_oob)
 {
-	u8 buf[SECTORSIZE + inftl->mbd.mtd->oobsize];
+	u8 buf[SECTORSIZE];
 	struct mtd_info *mtd = inftl->mbd.mtd;
 	size_t retlen;
 	int i;
@@ -346,10 +346,15 @@ static int check_free_sectors(struct INFTLrecord *inftl, unsigned int address,
 			return -1;
 
 		if (check_oob) {
+			if (mtd->oobsize > sizeof(buf)) {
+				pr_warn("MTD oobsize > SECTORSIZE: %d\n",
+					mtd->oobsize);
+				return -1;
+			}
 			if(inftl_read_oob(mtd, address, mtd->oobsize,
-					  &retlen, &buf[SECTORSIZE]) < 0)
+					  &retlen, buf) < 0)
 				return -1;
-			if (memcmpb(buf + SECTORSIZE, 0xff, mtd->oobsize) != 0)
+			if (memcmpb(buf, 0xff, mtd->oobsize) != 0)
 				return -1;
 		}
 		address += SECTORSIZE;
diff --git a/drivers/mtd/nftlmount.c b/drivers/mtd/nftlmount.c
index a6fbfa4e5799..e6eba7f3fdf5 100644
--- a/drivers/mtd/nftlmount.c
+++ b/drivers/mtd/nftlmount.c
@@ -272,7 +272,7 @@ static int memcmpb(void *a, int c, int n)
 static int check_free_sectors(struct NFTLrecord *nftl, unsigned int address, int len,
 			      int check_oob)
 {
-	u8 buf[SECTORSIZE + nftl->mbd.mtd->oobsize];
+	u8 buf[SECTORSIZE];
 	struct mtd_info *mtd = nftl->mbd.mtd;
 	size_t retlen;
 	int i;
@@ -284,10 +284,15 @@ static int check_free_sectors(struct NFTLrecord *nftl, unsigned int address, int
 			return -1;
 
 		if (check_oob) {
+			if (mtd->oobsize > sizeof(buf)) {
+				pr_warn("MTD oobsize > SECTORSIZE: %d\n",
+					mtd->oobsize);
+				return -1;
+			}
 			if(nftl_read_oob(mtd, address, mtd->oobsize,
-					 &retlen, &buf[SECTORSIZE]) < 0)
+					 &retlen, buf) < 0)
 				return -1;
-			if (memcmpb(buf + SECTORSIZE, 0xff, mtd->oobsize) != 0)
+			if (memcmpb(buf, 0xff, mtd->oobsize) != 0)
 				return -1;
 		}
 		address += SECTORSIZE;
-- 
2.7.4


-- 
Kees Cook
Pixel Security
