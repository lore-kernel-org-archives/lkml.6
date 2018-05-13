Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeEMSJz (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 14:09:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54683 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751893AbeEMSJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 14:09:52 -0400
Date: Sun, 13 May 2018 11:09:46 -0700
From: tip-bot for Joe Perches <tipbot@zytor.com>
Message-ID: <tip-a7a3153a98d581196ce092e0b83cac2c4ee1fd1f@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        joe@perches.com, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        joe@perches.com, mingo@kernel.org
In-Reply-To: <8fb4b2a77d50e21ae1f7e4e267e68691efe2c270.1525878372.git.joe@perches.com>
References: <8fb4b2a77d50e21ae1f7e4e267e68691efe2c270.1525878372.git.joe@perches.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/early-quirks: Rename duplicate define of
 dev_err
Git-Commit-ID: a7a3153a98d581196ce092e0b83cac2c4ee1fd1f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a7a3153a98d581196ce092e0b83cac2c4ee1fd1f
Gitweb:     https://git.kernel.org/tip/a7a3153a98d581196ce092e0b83cac2c4ee1fd1f
Author:     Joe Perches <joe@perches.com>
AuthorDate: Wed, 9 May 2018 08:15:45 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 13 May 2018 20:04:35 +0200

x86/early-quirks: Rename duplicate define of dev_err

dev_err is becoming a macro calling _dev_err to allow prefixing of
dev_fmt to any dev_<level> use that has a #define dev_fmt(fmt) similar
to the existing #define pr_fmt(fmt) uses.

Remove this dev_err macro and convert the existing two uses to pr_err.
This allows clean compilation in the patch that introduces dev_fmt which
can prefix dev_<level> logging macros with arbitrary content similar to
the #define pr_fmt macro.

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/8fb4b2a77d50e21ae1f7e4e267e68691efe2c270.1525878372.git.joe@perches.com

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
 
