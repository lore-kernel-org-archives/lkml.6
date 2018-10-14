Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F31AC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87CA20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87CA20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbeJNXZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:25:11 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37035 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728020AbeJNXZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:25:10 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM9-0004cD-BK; Sun, 14 Oct 2018 16:31:01 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLQ-0000HK-Pw; Sun, 14 Oct 2018 16:30:16 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Richard Weinberger" <richard@nod.at>,
        "Artem Bityutskiy" <dedekind1@gmail.com>,
        "Boris Brezillon" <boris.brezillon@bootlin.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.502345812@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 102/366] ubi: Reject MLC NAND
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Weinberger <richard@nod.at>

commit b5094b7f135be34630e3ea8a98fa215715d0f29d upstream.

While UBI and UBIFS seem to work at first sight with MLC NAND, you will
most likely lose all your data upon a power-cut or due to read/write
disturb.
In order to protect users from bad surprises, refuse to attach to MLC
NAND.

Signed-off-by: Richard Weinberger <richard@nod.at>
Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
Acked-by: Artem Bityutskiy <dedekind1@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mtd/ubi/build.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -905,6 +905,17 @@ int ubi_attach_mtd_dev(struct mtd_info *
 		return -EINVAL;
 	}
 
+	/*
+	 * Both UBI and UBIFS have been designed for SLC NAND and NOR flashes.
+	 * MLC NAND is different and needs special care, otherwise UBI or UBIFS
+	 * will die soon and you will lose all your data.
+	 */
+	if (mtd->type == MTD_MLCNANDFLASH) {
+		pr_err("ubi: refuse attaching mtd%d - MLC NAND is not supported\n",
+			mtd->index);
+		return -EINVAL;
+	}
+
 	if (ubi_num == UBI_DEV_NUM_AUTO) {
 		/* Search for an empty slot in the @ubi_devices array */
 		for (ubi_num = 0; ubi_num < UBI_MAX_DEVICES; ubi_num++)

