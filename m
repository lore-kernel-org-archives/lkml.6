Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id mZEIORNRGltcAgAAmS7hNA
	; Fri, 08 Jun 2018 09:50:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7126B607A4; Fri,  8 Jun 2018 09:50:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E6E0660275;
	Fri,  8 Jun 2018 09:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E6E0660275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeFHJuH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 05:50:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:5513 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751176AbeFHJuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 05:50:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 02:50:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,490,1520924400";
   d="scan'208";a="206372410"
Received: from shbuild888.sh.intel.com ([10.239.146.239])
  by orsmga004.jf.intel.com with ESMTP; 08 Jun 2018 02:50:04 -0700
From: Feng Tang <feng.tang@intel.com>
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: Feng Tang <feng.tang@intel.com>
Subject: [PATCH] mmc: Move the mmc driver init earlier
Date: Fri,  8 Jun 2018 17:51:54 +0800
Message-Id: <20180608095154.22413-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing some boot time optimization for an eMMC rootfs NUCs,
we found the rootfs may spend around 100 microseconds waiting
for eMMC card to be initialized, then the rootfs could be
mounted.
	[    1.216561] Waiting for root device /dev/mmcblk1p1...
	[    1.289262] mmc1: new HS400 MMC card at address 0001
	[    1.289667] mmcblk1: mmc1:0001 R1J56L 14.7 GiB
	[    1.289772] mmcblk1boot0: mmc1:0001 R1J56L partition 1 8.00 MiB
	[    1.289869] mmcblk1boot1: mmc1:0001 R1J56L partition 2 8.00 MiB
	[    1.289967] mmcblk1rpmb: mmc1:0001 R1J56L partition 3 4.00 MiB
	[    1.292798]  mmcblk1: p1 p2 p3
	[    1.300576] EXT4-fs (mmcblk1p1): couldn't mount as ext3 due to feature incompatibilities
	[    1.300912] EXT4-fs (mmcblk1p1): couldn't mount as ext2 due to feature incompatibilities

And this is a common problem for smartphones, tablets, embedded
devices and automotive products. This patch will make the eMMC/SD
card  start initializing earlier, by changing its order in drivers/Makefile.

On our platform, the waiting for eMMC card is almost eliminated with the patch,
which is critical to boot time.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 drivers/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 24cd47014657..c473afd3c688 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -50,6 +50,9 @@ obj-$(CONFIG_REGULATOR)		+= regulator/
 # reset controllers early, since gpu drivers might rely on them to initialize
 obj-$(CONFIG_RESET_CONTROLLER)	+= reset/
 
+# put mmc early as many morden devices use emm/sd card as rootfs storage
+obj-y				+= mmc/
+
 # tty/ comes before char/ so that the VT console is the boot-time
 # default.
 obj-y				+= tty/
@@ -128,7 +131,6 @@ obj-$(CONFIG_EISA)		+= eisa/
 obj-$(CONFIG_PM_OPP)		+= opp/
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle/
-obj-y				+= mmc/
 obj-$(CONFIG_MEMSTICK)		+= memstick/
 obj-$(CONFIG_NEW_LEDS)		+= leds/
 obj-$(CONFIG_INFINIBAND)	+= infiniband/
-- 
2.14.1
