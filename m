Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F64C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 03:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFE621927
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 03:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387770AbeLVDHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 22:07:32 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:49664 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733177AbeLVDHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 22:07:31 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id DCC68275C8;
        Fri, 21 Dec 2018 22:07:28 -0500 (EST)
To:     Joshua Thompson <funaho@jurai.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <dc3abf702c1f54d536c94305c44de7182f5212b6.1545445081.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] m68k/mac: Use '030 reset method on SE/30
Date:   Sat, 22 Dec 2018 13:18:01 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment says that calling the ROM routine doesn't work. But testing
shows that the 68030 fall-back reset method does work, so just use that.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/mac/misc.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index ebb3b6d169ea..2d8da060f875 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -410,9 +410,8 @@ void mac_poweroff(void)
 
 void mac_reset(void)
 {
-	if (macintosh_config->adb_type == MAC_ADB_II) {
-		unsigned long flags;
-
+	if (macintosh_config->adb_type == MAC_ADB_II &&
+	    macintosh_config->ident != MAC_MODEL_SE30) {
 		/* need ROMBASE in booter */
 		/* indeed, plus need to MAP THE ROM !! */
 
@@ -422,17 +421,8 @@ void mac_reset(void)
 		/* works on some */
 		rom_reset = (void *) (mac_bi_data.rombase + 0xa);
 
-		if (macintosh_config->ident == MAC_MODEL_SE30) {
-			/*
-			 * MSch: Machines known to crash on ROM reset ...
-			 */
-		} else {
-			local_irq_save(flags);
-
-			rom_reset();
-
-			local_irq_restore(flags);
-		}
+		local_irq_disable();
+		rom_reset();
 #ifdef CONFIG_ADB_CUDA
 	} else if (macintosh_config->adb_type == MAC_ADB_EGRET ||
 	           macintosh_config->adb_type == MAC_ADB_CUDA) {
-- 
2.19.2
