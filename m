Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C980C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D154D24208
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D154D24208
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932974AbeGCWIp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:08:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52846 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753295AbeGCWAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:00:42 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 78406207DA; Wed,  4 Jul 2018 00:00:40 +0200 (CEST)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0CCF820719;
        Wed,  4 Jul 2018 00:00:39 +0200 (CEST)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Wenyou Yang <wenyou.yang@microchip.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Han Xu <han.xu@nxp.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Xiaolei Li <xiaolei.li@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>, Stefan Agner <stefan@agner.ch>
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 01/32] mtd: rawnand: add hooks that may be called during nand_scan()
Date:   Tue,  3 Jul 2018 23:59:58 +0200
Message-Id: <20180703220029.19565-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180703220029.19565-1-miquel.raynal@bootlin.com>
References: <20180703220029.19565-1-miquel.raynal@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to remove the limitation that forbids dynamic allocation in
nand_scan_ident(), we must create a path that will be the same for all
controller drivers. The idea is to use nand_scan() instead of the widely
implemented nand_scan_ident()/nand_scan_tail() couple. In order to
achieve this, controller drivers will need to adjust some parameters
between these two functions depending on the NAND chip wired on them.

For that, a hook called ->attach_chip() is created in the
nand_hw_control structure. This structure may be referenced by two ways:
1/ if the driver does not implement its own controller, the
   chip->controller hook is not populated before nand_scan() so it
   cannot be dereferenced: use chip->hwcontrol instead (which is
   statically allocated and will be referenced later by chip->controller
   anyway).
2/ through chip->controller if the driver implements its own controller.

Another hook, ->detach_chip() is also introduced in order to clean the
controller driver's potential allocations in case of failure of
nand_scan_tail(). There is no need for the controller driver to call the
->detach_chip() hook directly upon error after a successful nand_scan().
In this situation, calling nand_release() as before is enough.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c | 21 +++++++++++++++++++--
 include/linux/mtd/rawnand.h      |  6 ++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index faac82b1e058..97a74d48b0cf 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -6712,11 +6712,23 @@ EXPORT_SYMBOL(nand_scan_tail);
 int nand_scan_with_ids(struct mtd_info *mtd, int maxchips,
 		       struct nand_flash_dev *ids)
 {
+	struct nand_chip *chip = mtd_to_nand(mtd);
 	int ret;
 
 	ret = nand_scan_ident(mtd, maxchips, ids);
-	if (!ret)
-		ret = nand_scan_tail(mtd);
+	if (ret)
+		return ret;
+
+	if (chip->controller->attach_chip) {
+		ret = chip->controller->attach_chip(chip);
+		if (ret)
+			return ret;
+	}
+
+	ret = nand_scan_tail(mtd);
+	if (ret && chip->controller->detach_chip)
+		chip->controller->detach_chip(chip);
+
 	return ret;
 }
 EXPORT_SYMBOL(nand_scan_with_ids);
@@ -6744,7 +6756,12 @@ void nand_cleanup(struct nand_chip *chip)
 
 	/* Free manufacturer priv data. */
 	nand_manufacturer_cleanup(chip);
+
+	/* Free controller specific allocations after chip identification */
+	if (chip->controller->detach_chip)
+		chip->controller->detach_chip(chip);
 }
+
 EXPORT_SYMBOL_GPL(nand_cleanup);
 
 /**
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 0c6fb316b409..81654211e520 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -517,11 +517,17 @@ struct nand_id {
  * @wq:			wait queue to sleep on if a NAND operation is in
  *			progress used instead of the per chip wait queue
  *			when a hw controller is available.
+ * @attach_chip:	Callback that may be called between nand_detect() and
+ *			nand_scan_tail() during nand_scan() (optional).
+ * @detach_chip:	Callback that may be called if nand_scan_tail() fails
+ *			(optional).
  */
 struct nand_hw_control {
 	spinlock_t lock;
 	struct nand_chip *active;
 	wait_queue_head_t wq;
+	int (*attach_chip)(struct nand_chip *chip);
+	void (*detach_chip)(struct nand_chip *chip);
 };
 
 static inline void nand_hw_control_init(struct nand_hw_control *nfc)
-- 
2.14.1

