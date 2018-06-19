Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C100DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8268C2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8268C2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966523AbeFSNz1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:55:27 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:46846 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966330AbeFSNzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:55:22 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id 0dvL1y00M3XaVaC01dvLLg; Tue, 19 Jun 2018 15:55:21 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fVH6O-0000Yq-BX; Tue, 19 Jun 2018 15:55:20 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fVH6O-0002Ll-9t; Tue, 19 Jun 2018 15:55:20 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/2] regulator: bd9571mwv: Add support for toggle power switches
Date:   Tue, 19 Jun 2018 15:55:16 +0200
Message-Id: <20180619135518.8990-1-geert+renesas@glider.be>
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

This patch series proposes a new callback for wake-up change
notification, which allows performing step 1 when the user writes
"enabled" to the PMIC's "wakeup" virtual file in sysfs, e.g.

    echo enabled > /sys/devices/platform/soc/e60b0000.i2c/i2c-7/7-0030/bd9571mwv-regulator.2.auto/power/wakeup

Conversely, writing "disabled" reverts the role of the accessory switch
to a power switch.
Note that unlike with momentary switches, backup mode is not enabled by
default, as enabling it prevents the board from being powered off using
the power switch, which may confuse the user.

Changes compared to v1:
  - Improve patch descriptions,
  - Drop "return;" at end of function.

This has been tested on M3ULCB (thanks Jacopo!), and on Salvator-X(S).

For testing, this series is also available in the
topic/bd9571-toggle-power-switch-v2 branch of my renesas-drivers git
repository at
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.

Thanks!

Geert Uytterhoeven (2):
  PM / wakeup: Add callback for wake-up change notification
  regulator: bd9571mwv: Add support for toggle power switches

 drivers/base/power/wakeup.c             |  4 ++++
 drivers/regulator/bd9571mwv-regulator.c | 23 +++++++++++++++++++++++
 include/linux/pm.h                      |  1 +
 3 files changed, 28 insertions(+)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
