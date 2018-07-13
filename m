Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DA6ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A27208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A27208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbeGMQrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:47:05 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:58774 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729783AbeGMQrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:47:04 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id AGXh1y00S3XaVaC06GXhDw; Fri, 13 Jul 2018 18:31:42 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fe0yr-0003zi-Kw; Fri, 13 Jul 2018 18:31:41 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fe0Hx-0004mH-He; Fri, 13 Jul 2018 17:47:21 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 2/3] regulator: bd9571mwv: Add support for toggle power switches
Date:   Fri, 13 Jul 2018 17:47:19 +0200
Message-Id: <20180713154720.18316-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180713154720.18316-1-geert+renesas@glider.be>
References: <20180713154720.18316-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the existing support for backup mode to toggle power switches.
With a toggle power switch (or level signal), the following steps must
be followed exactly:
   1. Configure PMIC for backup mode,
   2. Switch accessory power switch off, to prepare for system suspend,
      which is a manual step not controlled by software,
   3. Suspend system,
   4. Switch accessory power switch on to wake up system.

Hence the PMIC is configured for backup mode when "on" or "1" is written
to the PMIC's "backup_mode" virtual file in sysfs.  Conversely, writing
"off" or "0" reverts the role of the accessory switch to a power
switch.

Unlike with momentary switches, backup mode is not enabled by default,
as enabling it prevents the board from being powered off using the power
switch, which may confuse the user.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Replace use of "wake_up" sysfs file and extra callback for wake-up
    change notification by custom "backup_mode" sysfs file,

v2:
  - Improve patch description,
  - Drop "return;" at end of function.
---
 drivers/regulator/bd9571mwv-regulator.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/regulator/bd9571mwv-regulator.c b/drivers/regulator/bd9571mwv-regulator.c
index 7432b605db4dc879..9b5df51751624d8b 100644
--- a/drivers/regulator/bd9571mwv-regulator.c
+++ b/drivers/regulator/bd9571mwv-regulator.c
@@ -185,6 +185,7 @@ static ssize_t backup_mode_store(struct device *dev,
 				 const char *buf, size_t count)
 {
 	struct bd9571mwv_reg *bdreg = dev_get_drvdata(dev);
+	unsigned int mode;
 	int ret;
 
 	if (!count)
@@ -194,6 +195,22 @@ static ssize_t backup_mode_store(struct device *dev,
 	if (ret)
 		return ret;
 
+	if (!bdreg->rstbmode_level)
+		return count;
+
+	/* Configure DDR Backup Mode */
+	ret = bd9571mwv_bkup_mode_read(bdreg->bd, &mode);
+	if (ret)
+		return ret;
+
+	mode &= ~BD9571MWV_BKUP_MODE_CNT_KEEPON_MASK;
+	if (bdreg->bkup_mode_enabled)
+		mode |= bdreg->bkup_mode_cnt_keepon;
+
+	ret = bd9571mwv_bkup_mode_write(bdreg->bd, mode);
+	if (ret)
+		return ret;
+
 	return count;
 }
 
-- 
2.17.1

