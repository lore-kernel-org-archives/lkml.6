Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753937AbeDRNSM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 09:18:12 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:33588 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753442AbeDRNSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 09:18:09 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 0/4] regulator: bd9571mwv: Add support for DDR backup mode
Date: Wed, 18 Apr 2018 15:18:00 +0200
Message-Id: <1524057484-25350-1-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

The ROHM BD9571MWV PMIC on the Renesas Salvator-X(S) and ULCB
development boards supports DDR Backup Power, which means that the DDR
power rails can be kept powered while the main SoC is powered down.

Currently performing a system suspend/resume cycle involves several
manual steps:
  1. Configure the PMIC for Backup Mode, using
     "i2cset -f -y 7 0x30 0x20 0x0f", which changes the role of the
     power switch to a wake-up switch,
  2. Switch off SW23 (the ACC toggle switch) to prepare for suspend
     (only on Salvator-X(S)),
  3. Suspend to RAM, using "echo mem > /sys/power/state",
  4. Switch on SW23 (on Salvator-X(S)) or push momentary switch SW8 (on
     ULCB) to resume.
Note the need for step 2 on systems equipped with a toggle instead of
momentary power switch.

Especially the first and second steps are cumbersome, as they rely on
  1. Intimate knowledge about the PMIC and actual board design,
  2. Direct i2c access,
  3. Having the i2cset utility available,
  4. A manual toggle switch operation (on Salvator-X(S)).
In addition, all of this has to be redone after system resume.

This patch series integrates Backup Mode configuration into the PMIC
driver, using the "wakeup" sysfs virtual file.  I.e. it can be enabled
or disabled by writing "enabled" or "disabled" to e.g.

    /sys/devices/platform/soc/e60b0000.i2c/i2c-7/7-0030/bd9571mwv-regulator.2.auto/power/wakeup

Which DDR rails are to be kept powered is board-specific, and controlled
using the optional "rohm,ddr-backup-power" property in the board DTS
file.

As the power switch type is board-specific, and cannot be determined
automatically, it is obtained from the presence of one of the
"rohm,rstbmode-{pulse,level}" properties in DT.

For now only momentary power switches are supported, and wake-up is
enabled by default, as it doesn't have any run-time side-effects.
Support for toggle switches is added in a follow-up series ("[PATCH/RFC
0/2] regulator: bd9571mwv: Add support for toggle power switches",
https://lkml.org/lkml/2018/3/14/324).

Changes compared to v2:
  - Add Reviewed-by, Acked-for-MFD-by (for Lee's own reference),
  - Use a hex value for the bit mask.

Changes compared to v1:
  - Improve DT property description,
  - Add DT properties for power switch type,
  - Add Acked-by,
  - Use normal "wakeup" sysfs virtual file instead of adding our own
    "backup_mode" file,
  - Differentiate between momentary and toggle power switches:
      - Support for momentary switches is enabled automatically,
      - Toggle switches are not yet supported (but still work when
	backup mode is enabled using i2set from userspace).
  - Split off DTS part into its own series.

This has been tested on M3ULCB (thanks Jacopo!), and on Salvator-X(S)
(still using i2set from userspace).

For testing, driver and DTS patches are available in the
topic/bd9571-ddr-backup-mode-driver-v3 and
topic/bd9571-ddr-backup-mode-dt-v3 branches of my renesas-drivers git
repository at
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.

Thanks for applying!

Geert Uytterhoeven (4):
  dt-bindings: mfd: bd9571mwv: Document DDR Backup Mode properties
  mfd: bd9571mwv: Add DDR Backup Power register bit definitions
  mfd: bd9571mwv: Allow DDR Backup Power register access
  regulator: bd9571mwv: Add support for backup mode

 .../devicetree/bindings/mfd/bd9571mwv.txt          |  21 ++++
 drivers/mfd/bd9571mwv.c                            |   2 +
 drivers/regulator/bd9571mwv-regulator.c            | 127 ++++++++++++++++++++-
 include/linux/mfd/bd9571mwv.h                      |   5 +
 4 files changed, 154 insertions(+), 1 deletion(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
