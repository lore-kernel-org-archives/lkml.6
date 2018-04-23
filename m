Return-Path: <mbrugger@localhost>
X-Google-Smtp-Source: AIpwx4+iFpB9MxulSvb3XQM6bSGIFCOGKimHl944v1vNcbSoPs1J9UeqRpTeBkzZTYPTiAy3+0fy
ARC-Seal: i=1; a=rsa-sha256; t=1524497541; cv=none;
        d=google.com; s=arc-20160816;
        b=yFepGsX06PojALg7n5oZ6cXBEYsd0NGIwCh2DkeTs/i8tAju/1rCchESoupPOVPaft
         MMT2EKu2kkkcTihbYSXNLT0Ln62vJRvAw2R75ZKLRnCMw7fesAFX7jlKEFQCaUWjHzEY
         KtzOwD35f+11WraneB4p3eu14f66KIqoIyDcsDcEhSCeWGTdCbtL5CqrniBdZBSQlunk
         G0QMkyYUqqh0wQHrTkNGAlNmBpwxVIEul2kc+XP5HdfuqNOmWVXv1cInYSOFIqLQcAI1
         Jc4geZM191aFkhdMms2MgcB6e6ha1FyP1CmZBG0x9oD7uVGqKJVxr7XQ7QKPMso/+vDd
         s3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=DOfptkYs8TmOk2kuTcyl6TwbfdnTOWg4OCWQHNfuMek=;
        b=J4c5d3R5pYCws0YNmmdS0TokwMmjeYwdOuVhKJJbWJQD1gp4A95nlMas+p8fEztJDa
         UpUHiJDqCkVVycezc6IqsVIH/qPwxRXR0bb0WGVuT5eelBOSp/7KRKA4swWgpy1/kAwF
         IrBa9tA3iyq4vhk2ka0TR9Wc6t1yBPEPT4tkS/k/XGVICWSmNVf2eDXV+gq1fb5H1K9p
         h9/+1VQmWivj7jk9ByBx1pM7T9B6LUc0bvfZaBPDXS1QX1a6l3LjDMz1eka4TNqy66Qy
         dIq51Sxp0f+k+5bhLcn/SUaF78OndLvght2mFbdDBEm+yzxm5oo7VFlXs+QkssdBwEkO
         9W3g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 37.223.140.222 is neither permitted nor denied by best guess record for domain of mbrugger@localhost) smtp.mailfrom=mbrugger@localhost
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 37.223.140.222 is neither permitted nor denied by best guess record for domain of mbrugger@localhost) smtp.mailfrom=mbrugger@localhost
From: Matthias Brugger <mbrugger@suse.com>
To: ulrich.hecht+renesas@gmail.com,
	laurent.pinchart@ideasonboard.com,
	ck.hu@mediatek.com,
	p.zabel@pengutronix.de,
	airlied@linux.ie,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	mturquette@baylibre.com,
	sboyd@codeaurora.org,
	lee.jones@linaro.org
Cc: davem@davemloft.net,
	gregkh@linuxfoundation.org,
	mchehab@kernel.org,
	rdunlap@infradead.org,
	pi-cheng.chen@linaro.org,
	sean.wang@mediatek.com,
	linux-clk@vger.kernel.org,
	linux@armlinux.org.uk,
	matthias.bgg@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <mbrugger@suse.com>
Subject: [v2 00/10] arm/arm64: mediatek: Fix mmsys device probing
Date: Mon, 23 Apr 2018 17:31:59 +0200
Message-Id: <cover.1524497268.git.mbrugger@suse.com>
X-Mailer: git-send-email 2.16.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598551533402013398?=
X-GMAIL-MSGID: =?utf-8?q?1598551533402013398?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Changes since v1:
- add binding documentation
- ddp: use regmap_update_bits
- ddp: ignore EPROBE_DEFER on clock probing
- mfd: delete mmsys_private
- add Reviewed-by and Acked-by tags

---

MMSYS in Mediatek SoCs has some registers to control clock gates (which is 
used in the clk driver) and some registers to set the routing and enable
the differnet blocks of the display subsystem.

Up to now both drivers, clock and drm are probed with the same device tree
compatible. But only the first driver get probed, which in effect breaks
graphics on mt8173 and mt2701.

This patch set introduces a new mfd device, which binds against the mmsys
compatible and takes care of probing the needed devices. It was tested on the
bananapi-r2 and the Acer R13 Chromebook.


Matthias Brugger (10):
  dt-bindings: mediatek: mmsys: Add support for mfd
  drm/mediatek: Use regmap for register access
  mfd: mtk-mmsys: Add mmsys driver
  drm/mediatek: mt2701: switch to mfd probing.
  clk: mediatek: mt2701-mm: switch to mfd device
  mfd: mtk-mmsys: Add mt8173 nodes
  drm/mediatek: Add mfd support for mt8173
  clk: mediatek: mt8173-mm: switch to mfd device
  drm: mediatek: Omit warning on probe defers
  MAINTAINERS: update Mediatek Soc entry

 .../bindings/arm/mediatek/mediatek,mmsys.txt       |  2 -
 .../bindings/display/mediatek/mediatek,disp.txt    |  2 +-
 .../devicetree/bindings/mfd/mediatek,mmsys.txt     | 27 +++++++
 MAINTAINERS                                        |  2 +
 drivers/clk/mediatek/clk-mt2701-mm.c               | 10 +--
 drivers/clk/mediatek/clk-mt8173.c                  | 17 +++-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |  4 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c             | 41 ++++------
 drivers/gpu/drm/mediatek/mtk_drm_ddp.h             |  4 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             | 33 ++++----
 drivers/gpu/drm/mediatek/mtk_drm_drv.h             |  2 +-
 drivers/mfd/Kconfig                                |  9 +++
 drivers/mfd/Makefile                               |  2 +
 drivers/mfd/mtk-mmsys.c                            | 93 ++++++++++++++++++++++
 14 files changed, 189 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt
 create mode 100644 drivers/mfd/mtk-mmsys.c

-- 
2.16.3
