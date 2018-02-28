Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752431AbeB1JlB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 04:41:01 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33277 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752410AbeB1Jk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 04:40:59 -0500
X-Google-Smtp-Source: AG47ELv7WSsQ6c+VQ9+fe7s6mg/CBjwsKIzQ75+iVyuaVKA+2nL0dZjxqoBB3sh+Mlw06Ucq7BFofQ==
From: Sebastian Panceac <sebastian@resin.io>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        x86@kernel.org
Cc: Sebastian Panceac <sebastian@resin.io>
Subject: [PATCH v3 1/1] x86: Fix Intel Edison module stuck reboot
Date: Wed, 28 Feb 2018 11:40:49 +0200
Message-Id: <1519810849-15131-1-git-send-email-sebastian@resin.io>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <CAHp75Vfdqky9HK9ddUk8+3OuU5pSDhg+9_ychW2ysb+bzAR4Yw@mail.gmail.com>
References: <CAHp75Vfdqky9HK9ddUk8+3OuU5pSDhg+9_ychW2ysb+bzAR4Yw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When powering Intel Edison module with 3.3V, the "reboot" command makes
the module stuck.
If the module is powered at a greater voltage, like 4.4V (as the Edison
Mini Breakout board does), reboot works OK.

This patch copies the behaviour from the official Intel Edison BSP,
where "IPCMSG_COLD_RESET" message was sent to SCU by default at
reboot time.

In the official BSP, sending the "IPCMSG_COLD_BOOT" message instead of
"IPCMSG_COLD_RESET" was possible, by using a kernel command
line parameter.

Signed-off-by: Sebastian Panceac <sebastian@resin.io>
---

Hi,

I submitted again the patch, after taking into consideration Andy's suggestions.

Regards!

 arch/x86/platform/intel-mid/intel-mid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
index 2c67bae..fb1df94 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -79,7 +79,7 @@ static void intel_mid_power_off(void)
 
 static void intel_mid_reboot(void)
 {
-	intel_scu_ipc_simple_command(IPCMSG_COLD_BOOT, 0);
+	intel_scu_ipc_simple_command(IPCMSG_COLD_RESET, 0);
 }
 
 static unsigned long __init intel_mid_calibrate_tsc(void)
-- 
2.7.4
