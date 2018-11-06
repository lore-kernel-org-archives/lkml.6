Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C18CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB052083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB052083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbeKGHLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:11:45 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:53154 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbeKGHLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:11:45 -0500
Received: from ramsan.of.borg ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id wlkM1y00G3XaVaC01lkM05; Tue, 06 Nov 2018 22:44:27 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1gK993-0002DL-7f; Tue, 06 Nov 2018 22:44:21 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gK993-0002xn-4j; Tue, 06 Nov 2018 22:44:21 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH next] mtd: maps: physmap: Fix infinite loop crash in ROM type probing
Date:   Tue,  6 Nov 2018 22:44:16 +0100
Message-Id: <20181106214416.11342-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Toshiba RBTX4927, where map_probe is supposed to fail:

    Creating 2 MTD partitions on "physmap-flash.0":
    0x000000c00000-0x000001000000 : "boot"
    0x000000000000-0x000000c00000 : "user"
    physmap-flash physmap-flash.1: physmap platform flash device: [mem 0x1e000000-0x1effffff]
    CPU 0 Unable to handle kernel paging request at virtual address 00000000, epc == 80320f40, ra == 80321004
    ...
    Call Trace:
    [<80320f40>] get_mtd_chip_driver+0x30/0x8c
    [<80321004>] do_map_probe+0x20/0x90
    [<80328448>] physmap_flash_probe+0x484/0x4ec

The access to rom_probe_types[] was changed from a sentinel-based loop
to an infinite loop, causing a crash when reaching the sentinel.

Fix this by:
  - Removing the no longer needed sentinel,
  - Limiting the number of loop iterations to the actual number of ROM
    types.

Fixes: c7afe08496fa463e ("mtd: maps: physmap: Invert logic on if/else branch")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/mtd/maps/physmap-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/maps/physmap-core.c b/drivers/mtd/maps/physmap-core.c
index 33b77bd9022ce251..e8c3b250d8421edc 100644
--- a/drivers/mtd/maps/physmap-core.c
+++ b/drivers/mtd/maps/physmap-core.c
@@ -396,7 +396,7 @@ static int physmap_flash_of_init(struct platform_device *dev)
 #endif /* IS_ENABLED(CONFIG_MTD_PHYSMAP_OF) */
 
 static const char * const rom_probe_types[] = {
-	"cfi_probe", "jedec_probe", "qinfo_probe", "map_rom", NULL
+	"cfi_probe", "jedec_probe", "qinfo_probe", "map_rom",
 };
 
 static const char * const part_probe_types[] = {
@@ -524,7 +524,7 @@ static int physmap_flash_probe(struct platform_device *dev)
 		} else {
 			int j;
 
-			for (j = 0; ARRAY_SIZE(rom_probe_types); j++) {
+			for (j = 0; j < ARRAY_SIZE(rom_probe_types); j++) {
 				info->mtds[i] = do_map_probe(rom_probe_types[j],
 							     &info->maps[i]);
 				if (info->mtds[i])
-- 
2.17.1

