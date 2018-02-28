Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753397AbeB1RWX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:22:23 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34361 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753101AbeB1RWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:22:07 -0500
Date: Wed, 28 Feb 2018 09:21:59 -0800
From: tip-bot for Sebastian Panceac <tipbot@zytor.com>
Message-ID: <tip-028091f82eefd5e84f81cef81a7673016ecbe78b@git.kernel.org>
Cc: tglx@linutronix.de, hpa@zytor.com, sebastian@resin.io,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        andy.shevchenko@gmail.com
Reply-To: hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
        andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org,
        sebastian@resin.io
In-Reply-To: <1519810849-15131-1-git-send-email-sebastian@resin.io>
References: <1519810849-15131-1-git-send-email-sebastian@resin.io>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/platform/intel-mid: Handle Intel Edison reboot
 correctly
Git-Commit-ID: 028091f82eefd5e84f81cef81a7673016ecbe78b
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

Commit-ID:  028091f82eefd5e84f81cef81a7673016ecbe78b
Gitweb:     https://git.kernel.org/tip/028091f82eefd5e84f81cef81a7673016ecbe78b
Author:     Sebastian Panceac <sebastian@resin.io>
AuthorDate: Wed, 28 Feb 2018 11:40:49 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Feb 2018 18:17:18 +0100

x86/platform/intel-mid: Handle Intel Edison reboot correctly

When the Intel Edison module is powered with 3.3V, the reboot command makes
the module stuck.  If the module is powered at a greater voltage, like 4.4V
(as the Edison Mini Breakout board does), reboot works OK.

The official Intel Edison BSP sends the IPCMSG_COLD_RESET message to the
SCU by default. The IPCMSG_COLD_BOOT which is used by the upstream kernel
is only sent when explicitely selected on the kernel command line.

Use IPCMSG_COLD_RESET unconditionally which makes reboot work independent
of the power supply voltage.

[ tglx: Massaged changelog ]

Fixes: bda7b072de99 ("x86/platform/intel-mid: Implement power off sequence")
Signed-off-by: Sebastian Panceac <sebastian@resin.io>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1519810849-15131-1-git-send-email-sebastian@resin.io

---
 arch/x86/platform/intel-mid/intel-mid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
index 2c67bae6bb53..fb1df9488e98 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -79,7 +79,7 @@ static void intel_mid_power_off(void)
 
 static void intel_mid_reboot(void)
 {
-	intel_scu_ipc_simple_command(IPCMSG_COLD_BOOT, 0);
+	intel_scu_ipc_simple_command(IPCMSG_COLD_RESET, 0);
 }
 
 static unsigned long __init intel_mid_calibrate_tsc(void)
