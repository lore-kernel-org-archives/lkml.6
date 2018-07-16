Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF2CECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2302620647
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2302620647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbeGPP6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:58:51 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:34086 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbeGPP6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:58:51 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id BTWu1y00D3XaVaC01TWuJq; Mon, 16 Jul 2018 17:30:54 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1ff5Sg-0007Mp-2K; Mon, 16 Jul 2018 17:30:54 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ff5Sg-0000UI-0P; Mon, 16 Jul 2018 17:30:54 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 0/3] regulator: bd9571mwv: Add support for toggle power switches
Date:   Mon, 16 Jul 2018 17:30:49 +0200
Message-Id: <20180716153052.1830-1-geert+renesas@glider.be>
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

Changes compared to v3:
  - Fix build error and warning if !CONFIG_PM_SLEEP,
  - Improve patch description and comment,
  - Add Acked-by.

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
topic/bd9571-toggle-power-switch-v4 branch of my renesas-drivers git
repository at
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.

Thanks for applying!

Geert Uytterhoeven (3):
  regulator: bd9571mwv: Use "backup_mode" sysfs file instead of
    "wake_up"
  regulator: bd9571mwv: Add support for toggle power switches
  regulator: bd9571mwv: Document "backup_mode" sysfs file

 .../testing/sysfs-driver-bd9571mwv-regulator  | 27 +++++++
 drivers/regulator/bd9571mwv-regulator.c       | 72 +++++++++++++++++--
 2 files changed, 94 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator

-- 
2.17.1

