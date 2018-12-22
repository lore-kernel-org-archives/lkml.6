Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFCAC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 03:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A213F21927
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 03:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733056AbeLVDHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 22:07:14 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:49644 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbeLVDHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 22:07:14 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 7CCC2275C8;
        Fri, 21 Dec 2018 22:07:11 -0500 (EST)
To:     Joshua Thompson <funaho@jurai.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <ed9f2567365292fd4f6ca081beb31a9aa8eae0df.1545445081.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] m68k/mac: Skip VIA port setup unless RTC is connected
Date:   Sat, 22 Dec 2018 13:18:01 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those Mac models which don't connect their RTC to VIA1 port B probably
have something else connected to those pins. Just leave them the way we
found them. Make the port B setup conditional on via_type, to match the
RTC accessors in arch/m68k/mac/misc.c.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/mac/via.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/m68k/mac/via.c b/arch/m68k/mac/via.c
index 31cccc79cb7a..4fa32752bd7d 100644
--- a/arch/m68k/mac/via.c
+++ b/arch/m68k/mac/via.c
@@ -188,13 +188,18 @@ void __init via_init(void)
 		via1[vBufB] |= 0x40;
 	}
 
-	/*
-	 * Set the RTC bits to a known state: all lines to outputs and
-	 * RTC disabled (yes that's 0 to enable and 1 to disable).
-	 */
-
-	via1[vDirB] |= (VIA1B_vRTCEnb | VIA1B_vRTCClk | VIA1B_vRTCData);
-	via1[vBufB] |= (VIA1B_vRTCEnb | VIA1B_vRTCClk);
+	switch (macintosh_config->adb_type) {
+	case MAC_ADB_IOP:
+	case MAC_ADB_II:
+	case MAC_ADB_PB1:
+		/*
+		 * Set the RTC bits to a known state: all lines to outputs and
+		 * RTC disabled (yes that's 0 to enable and 1 to disable).
+		 */
+		via1[vDirB] |= VIA1B_vRTCEnb | VIA1B_vRTCClk | VIA1B_vRTCData;
+		via1[vBufB] |= VIA1B_vRTCEnb | VIA1B_vRTCClk;
+		break;
+	}
 
 	/* Everything below this point is VIA2/RBV only... */
 
-- 
2.19.2
