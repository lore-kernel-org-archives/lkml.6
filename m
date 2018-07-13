Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DAEECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD1B208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD1B208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731992AbeGMQrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:47:07 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:51658 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729788AbeGMQrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:47:07 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id AGXh1y00V3XaVaC01GXh3r; Fri, 13 Jul 2018 18:31:43 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fe0yr-0003zi-IG; Fri, 13 Jul 2018 18:31:41 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fe0Hx-0004mK-Ie; Fri, 13 Jul 2018 17:47:21 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 3/3] regulator: bd9571mwv: Document "backup_mode" sysfs file
Date:   Fri, 13 Jul 2018 17:47:20 +0200
Message-Id: <20180713154720.18316-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180713154720.18316-1-geert+renesas@glider.be>
References: <20180713154720.18316-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - New.
---
 .../testing/sysfs-driver-bd9571mwv-regulator  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator

diff --git a/Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator b/Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator
new file mode 100644
index 0000000000000000..f2baec6d70312591
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator
@@ -0,0 +1,27 @@
+What:		/sys/bus/i2c/devices/.../bd9571mwv-regulator.*.auto/backup_mode
+Date:		Jul 2018
+KernelVersion:	4.19
+Contact:	Geert Uytterhoeven <geert+renesas@glider.be>
+Description:	Read/write the current state of DDR Backup Mode, which controls
+		if DDR power rails will be kept powered during system suspend.
+		("on"/"1" = enabled, "off"/"0" = disabled).
+		Two types of switches (or signals) can be used:
+		  A. With a momentary power switch (or pulse signal), DDR
+		     Backup Mode is enabled by default when available, as the
+		     PMIC will be configured only during system suspend.
+		  B. With a toggle power switch (or level signal), the
+		     following steps must be followed exactly:
+		       1. Configure PMIC for backup mode, to change the role of
+			  the accessory power switch from a power switch to a
+			  wake-up switch,
+		       2. Switch accessory power switch off, to prepare for
+			  system suspend, which is a manual step not controlled
+			  by software,
+		       3. Suspend system,
+		       4. Switch accessory power switch on, to resume the
+			  system.
+		     DDR Backup Mode must be explicitly enabled by the user,
+		     to invoke step 1.
+		See also Documentation/devicetree/bindings/mfd/bd9571mwv.txt.
+Users:		User space applications for embedded boards equipped with a
+		BD9571MWV PMIC.
-- 
2.17.1

