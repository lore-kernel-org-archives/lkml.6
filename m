Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AIpwx4/7JPNqrKYP4crgZXQ8vQ3U/lm3uGUTfng3koytuaqxbgYK4ecBQGYKUAi6zRhuIzcS0XLX
ARC-Seal: i=1; a=rsa-sha256; t=1524505566; cv=none;
        d=google.com; s=arc-20160816;
        b=Cb0kcLrAx/u6utUoAweuB4gYWh0f1l+SbPk5LlzB7AgCLKyx/HIDwpdgJBWGK4ggx8
         TmVl0IMV7Crbqavac79tpSjCWgresjf9zIDecc11jtb2v6gjGSTKz9io11NXw31r/e7m
         uNFyStQVf07IZ9KXGhtlAVT1tXaFqKFTecyGjwocxteH++FLzIQdn8bnwK9BwjDKSAso
         GkuYFVtacIW5GzUDkaT+KNvaztWbJnF89WicnxVu7rst+vfQhxAoeFISW6QYuc0+9TTp
         uTjDuN7HOEez35EhOijF3iIpS1jULGhA50LLKSH/6D7GajFAVmy++6l3FT0rQM9ZA37q
         QdgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=aPyWubnw6SizqrOb3BOdGNtXrzvPSJnkbSnmor65ZN8=;
        b=HicN8E1RIr0DFF12luDMyWer47G8kACkWDkKKGLwr8JBxsS0i9hROYwNmgpOm9lFsr
         7C/J/sIEXMUxflL6rEH5kFoV3PoAVw9/J5xDSWH52a1Pk3wTVih1t6QLNUQ1Q33iYyzp
         YXoGMYHwlaQGc4PSlZb1F1VE9pz/h0KhXIL1czHwAqqivwPaYZLnE1LeN3ltdLE6Veqb
         Yi6SGL1cyafyv/zDoohd9LvP1R4iKmqEgAdZ98MIkJdZkd0IhPK0VtqhWrIpzItofgrQ
         omxLepfyImRJ+48/h9Oj+kMPq4hQ4yE1L//DGfKB+kA5a4GXMKTcAa1VCRzhvMA3WSfk
         HMew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nishanth Menon <nm@ti.com>,
	Suman Anna <s-anna@ti.com>,
	Tero Kristo <t-kristo@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 00/16] ti-sysc driver changes to support more devices
Date: Mon, 23 Apr 2018 10:45:33 -0700
Message-Id: <20180423174549.57412-1-tony@atomide.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598559948457783708?=
X-GMAIL-MSGID: =?utf-8?q?1598559948457783708?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi all,

This series contains improvments for ti-sysc driver to allow booting
with more devices configured in device tree instead of the legacy
platform data. Looks like some device drivers also need updating for
suspend and resume, I'll be posting patches separately for those.

Regards,

Tony


Tony Lindgren (16):
  ARM: OMAP2+: Drop unused pm-noop
  ARM: OMAP2+: Allow using ti-sysc for system timers
  ARM: OMAP2+: Use signed value for sysc register offsets
  ARM: OMAP2+: Only probe SDMA via ti-sysc if configured in dts
  ARM: OMAP2+: Initialize SoC PM later
  ARM: OMAP2+: Make display related init into device_initcall
  bus: ti-sysc: Handle simple-bus for nested children
  bus: ti-sysc: Make child clock alias handling more generic
  bus: ti-sysc: Add handling for clkctrl opt clocks
  bus: ti-sysc: Tag some modules resource providers for noirq suspend
  bus: ti-sysc: Improve suspend and resume handling
  bus: ti-sysc: Add initial support for external resets
  bus: ti-sysc: Detect omap4 type timers for quirk
  bus: ti-sysc: Detect UARTs for SYSC_QUIRK_LEGACY_IDLE quirk on omap4
  bus: ti-sysc: Tag sdio and wdt with legacy mode for suspend
  bus: ti-sysc: Show module information for suspend if DEBUG is enabled

 .../devicetree/bindings/bus/ti-sysc.txt       |   6 +-
 arch/arm/mach-omap2/Makefile                  |   1 -
 arch/arm/mach-omap2/board-generic.c           |   2 -
 arch/arm/mach-omap2/common.h                  |  18 +-
 arch/arm/mach-omap2/display.c                 |  10 +-
 arch/arm/mach-omap2/hsmmc.c                   |   1 -
 arch/arm/mach-omap2/i2c.c                     |   1 -
 arch/arm/mach-omap2/io.c                      |  70 +---
 arch/arm/mach-omap2/omap-pm-noop.c            | 176 --------
 arch/arm/mach-omap2/omap-pm.h                 | 161 --------
 arch/arm/mach-omap2/omap_device.c             |  22 +-
 arch/arm/mach-omap2/omap_hwmod.c              |  21 +-
 arch/arm/mach-omap2/omap_hwmod.h              |   6 +-
 .../omap_hwmod_33xx_43xx_ipblock_data.c       |   1 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |   4 +
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c    |   1 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c    |   4 +
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c    |   3 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c     |   6 +
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c    |   1 +
 arch/arm/mach-omap2/pdata-quirks.c            |  15 -
 arch/arm/mach-omap2/pm-debug.c                |   5 -
 arch/arm/mach-omap2/pm.c                      |  21 +-
 arch/arm/mach-omap2/pm33xx-core.c             |   4 +-
 arch/arm/mach-omap2/timer.c                   |  68 ++-
 arch/arm/plat-omap/Kconfig                    |  10 -
 drivers/bus/ti-sysc.c                         | 388 ++++++++++++++++--
 drivers/media/rc/ir-rx51.c                    |  17 +-
 include/linux/platform_data/media/ir-rx51.h   |   9 -
 include/linux/platform_data/ti-sysc.h         |   1 +
 30 files changed, 494 insertions(+), 559 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/omap-pm-noop.c
 delete mode 100644 arch/arm/mach-omap2/omap-pm.h
 delete mode 100644 include/linux/platform_data/media/ir-rx51.h

-- 
2.17.0
