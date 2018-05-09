Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965004AbeEIPQB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:16:01 -0400
Received: from smtprelay0232.hostedemail.com ([216.40.44.232]:34130 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S964939AbeEIPP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:15:58 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:800:960:968:973:988:989:1260:1345:1359:1431:1437:1534:1541:1711:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3352:3740:3865:3866:3867:3868:3870:3871:3874:4321:4384:4419:4605:5007:6261:8957:9592:10004:10848:11026:11473:11658:11914:12043:12296:12438:12555:12895:12986:13069:13161:13229:13311:13357:14181:14384:14394:14721:21080:21433:21451:21627:30009:30054:30065,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: sugar88_8b2ba3d73690f
X-Filterd-Recvd-Size: 2501
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/6] x86/early-quirks: Rename duplicate define of dev_err
Date: Wed,  9 May 2018 08:15:45 -0700
Message-Id: <8fb4b2a77d50e21ae1f7e4e267e68691efe2c270.1525878372.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1525878372.git.joe@perches.com>
References: <cover.1525878372.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_err is becoming a macro calling _dev_err to allow prefixing of
dev_fmt to any dev_<level> use that has a #define dev_fmt(fmt) similar
to the existing #define pr_fmt(fmt) uses.

Remove this dev_err macro and convert the existing two uses to pr_err.
This allows clean compilation in the patch that introduces dev_fmt which
can prefix dev_<level> logging macros with arbitrary content similar to
the #define pr_fmt macro.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/x86/kernel/early-quirks.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index bae0d32e327b..da5d8ac60062 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -28,8 +28,6 @@
 #include <asm/irq_remapping.h>
 #include <asm/early_ioremap.h>
 
-#define dev_err(msg)  pr_err("pci 0000:%02x:%02x.%d: %s", bus, slot, func, msg)
-
 static void __init fix_hypertransport_config(int num, int slot, int func)
 {
 	u32 htcfg;
@@ -617,7 +615,8 @@ static void __init apple_airport_reset(int bus, int slot, int func)
 
 		pmcsr = read_pci_config_16(bus, slot, func, BCM4331_PM_CAP + PCI_PM_CTRL);
 		if ((pmcsr & PCI_PM_CTRL_STATE_MASK) != PCI_D0) {
-			dev_err("Cannot power up Apple AirPort card\n");
+			pr_err("pci 0000:%02x:%02x.%d: Cannot power up Apple AirPort card\n",
+			       bus, slot, func);
 			return;
 		}
 	}
@@ -628,7 +627,8 @@ static void __init apple_airport_reset(int bus, int slot, int func)
 
 	mmio = early_ioremap(addr, BCM4331_MMIO_SIZE);
 	if (!mmio) {
-		dev_err("Cannot iomap Apple AirPort card\n");
+		pr_err("pci 0000:%02x:%02x.%d: Cannot iomap Apple AirPort card\n",
+		       bus, slot, func);
 		return;
 	}
 
-- 
2.15.0
