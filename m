Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693BAECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB5320854
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB5320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387731AbeGMQrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:47:08 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:53522 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731878AbeGMQrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:47:08 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id AGXh1y00T3XaVaC01GXh2Q; Fri, 13 Jul 2018 18:31:44 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fe0yr-0003zi-M3; Fri, 13 Jul 2018 18:31:41 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fe0Hx-0004mC-Dm; Fri, 13 Jul 2018 17:47:21 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 0/3] regulator: bd9571mwv: Add support for toggle power switches
Date:   Fri, 13 Jul 2018 17:47:17 +0200
Message-Id: <20180713154720.18316-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

The ROHM BD9571MWV PMIC on the Renesas Salvator-X(S) and ULCB
development boards supports DDR Backup Power, which means that the DDR
power rails can be kept powered while the main SoC is powered down.

This patch series extends the support for DDR backup mode (see commit
6eb0bfae6973eb6a ("regulator: bd9571mwv: Add support for backup mode"))
to systems with toggle instead of momentary power switches.

With a toggle power switch (or level signal), the following steps must
be followed exactly:
   1. Configure PMIC for backup mode, which changes the role of the
      power switch to a wake-up switch, 
   2. Switch accessory power switch off, to prepare for system suspend,
      which is a manual step not controlled by software,
   3. Suspend system,
   4. Switch accessory power switch on, to resume.

Unlike on systems with a momentary toggle switch, an additional step 2
must be performed in between step 1 and step 3.  Hence step 1 can no
longer be handled in the PMIC's suspend callback.

This patch series allows performing step 1 when the user writes
"on" to the PMIC's "backup_mode" virtual file in sysfs, e.g.

    echo on > /sys/bus/i2c/drivers/bd9571mwv/*/bd9571mwv-regulator*/backup_mode

Conversely, writing "off" reverts the role of the accessory switch to a
power switch.
Note that unlike with momentary switches, backup mode is not enabled by
default, as enabling it prevents the board from being powered off using
the power switch, which may confuse the user.

Changes compared to v2:
  - Drop 'PM / wakeup: Add callback for wake-up change notification',
  - New patch 'regulator: bd9571mwv: Use "backup_mode" sysfs file
    instead of "wake_up"',
  - Replace use of "wake_up" sysfs file and extra callback for wake-up
    change notification by custom "backup_mode" sysfs file,
  - New patch ;regulator: bd9571mwv: Document "backup_mode" sysfs file'.

Changes compared to v1:
  - Improve patch descriptions,
  - Drop "return;" at end of function.

This has been tested on Salvator-XS.

For testing, this series is also available in the
topic/bd9571-toggle-power-switch-v3 branch of my renesas-drivers git
repository at
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.

Thanks!

Geert Uytterhoeven (3):
  regulator: bd9571mwv: Use "backup_mode" sysfs file instead of
    "wake_up"
  regulator: bd9571mwv: Add support for toggle power switches
  regulator: bd9571mwv: Document "backup_mode" sysfs file

 .../testing/sysfs-driver-bd9571mwv-regulator  | 27 ++++++++
 drivers/regulator/bd9571mwv-regulator.c       | 69 +++++++++++++++++--
 2 files changed, 90 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator

-- 
2.17.1

