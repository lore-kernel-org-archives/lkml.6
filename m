Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CB0C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145A3270B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145A3270B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934844AbeF1IUW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 04:20:22 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:48134 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932361AbeF1IUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 04:20:20 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id 48LJ1y00K3XaVaC068LJoL; Thu, 28 Jun 2018 10:20:19 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fYSA6-0003KV-97; Thu, 28 Jun 2018 10:20:18 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fYSA6-00056C-6v; Thu, 28 Jun 2018 10:20:18 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] mtd: Use kasprintf() instead of fixed buffer formatting
Date:   Thu, 28 Jun 2018 10:20:11 +0200
Message-Id: <20180628082011.19553-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using "%4.4X" in the calculation of the buffer size is misleading, as
the format string literal has no relation to the actual size needed.
Hence this is fragile w.r.t. future modification.

As this is not a hot path, fix this by replacing the formatting in a
fixed buffer by kasprintf().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.

Interestingly, this decreases code size (by 16 resp. 24 bytes on arm32
resp. arm64).
---
 drivers/mtd/chips/gen_probe.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/chips/gen_probe.c b/drivers/mtd/chips/gen_probe.c
index 879bebf9d8b12038..837b04ab96a9c526 100644
--- a/drivers/mtd/chips/gen_probe.c
+++ b/drivers/mtd/chips/gen_probe.c
@@ -202,16 +202,19 @@ static inline struct mtd_info *cfi_cmdset_unknown(struct map_info *map,
 	struct cfi_private *cfi = map->fldrv_priv;
 	__u16 type = primary?cfi->cfiq->P_ID:cfi->cfiq->A_ID;
 #ifdef CONFIG_MODULES
-	char probename[sizeof("cfi_cmdset_%4.4X")];
 	cfi_cmdset_fn_t *probe_function;
+	char *probename;
 
-	sprintf(probename, "cfi_cmdset_%4.4X", type);
+	probename = kasprintf(GFP_KERNEL, "cfi_cmdset_%4.4X", type);
+	if (!probename)
+		return NULL;
 
 	probe_function = __symbol_get(probename);
 	if (!probe_function) {
 		request_module("cfi_cmdset_%4.4X", type);
 		probe_function = __symbol_get(probename);
 	}
+	kfree(probename);
 
 	if (probe_function) {
 		struct mtd_info *mtd;
-- 
2.17.1

