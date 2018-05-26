Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031080AbeEZDKy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 23:10:54 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38928 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030929AbeEZDKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 23:10:53 -0400
X-Google-Smtp-Source: AB8JxZrEIX1lMB8bSg1ALijagaS4ZavQSfyFPBmi9j87lIL+YdJGd0c+DSqxP2avlYpfnehUbx02Tg==
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: John Stultz <john.stultz@linaro.org>, Ryan Grachek <ryan@edited.us>,
        Wei Xu <xuwei5@hisilicon.com>, Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>, Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] arm64: dts: hikey: Fix eMMC corruption regression
Date: Fri, 25 May 2018 20:10:47 -0700
Message-Id: <1527304247-12868-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a partial revert of commit
abd7d0972a19 ("arm64: dts: hikey: Enable HS200 mode on eMMC")

which has been causing eMMC corruption on my HiKey board.

Symptoms usually looked like:

mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot req 400000Hz, actual 400000HZ div = 31)
...
mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot req 150000000Hz, actual 148800000HZ div = 0)
mmc0: new HS200 MMC card at address 0001
...
dwmmc_k3 f723d000.dwmmc0: Unexpected command timeout, state 3
mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot req 400000Hz, actual 400000HZ div = 31)
mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot req 150000000Hz, actual 148800000HZ div = 0)
mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot req 400000Hz, actual 400000HZ div = 31)
mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot req 150000000Hz, actual 148800000HZ div = 0)
mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot req 400000Hz, actual 400000HZ div = 31)
mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot req 150000000Hz, actual 148800000HZ div = 0)
print_req_error: I/O error, dev mmcblk0, sector 8810504
Aborting journal on device mmcblk0p10-8.
mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot req 400000Hz, actual 400000HZ div = 31)
mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot req 150000000Hz, actual 148800000HZ div = 0)
mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot req 400000Hz, actual 400000HZ div = 31)
mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot req 150000000Hz, actual 148800000HZ div = 0)
mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot req 400000Hz, actual 400000HZ div = 31)
mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot req 150000000Hz, actual 148800000HZ div = 0)
mmc_host mmc0: Bus speed (slot 0) = 24800000Hz (slot req 400000Hz, actual 400000HZ div = 31)
mmc_host mmc0: Bus speed (slot 0) = 148800000Hz (slot req 150000000Hz, actual 148800000HZ div = 0)
EXT4-fs error (device mmcblk0p10): ext4_journal_check_start:61: Detected aborted journal
EXT4-fs (mmcblk0p10): Remounting filesystem read-only

And quite often this would result in a disk that wouldn't properly
boot even with older kernels.

It seems the max-frequency property added by the above patch is
causing the problem, so remove it.

Cc: Ryan Grachek <ryan@edited.us>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: YongQin Liu <yongqin.liu@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index 724a0d3..edb4ee0 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -299,7 +299,6 @@
 		/* GPIO blocks 16 thru 19 do not appear to be routed to pins */
 
 		dwmmc_0: dwmmc0@f723d000 {
-			max-frequency = <150000000>;
 			cap-mmc-highspeed;
 			mmc-hs200-1_8v;
 			non-removable;
-- 
2.7.4
