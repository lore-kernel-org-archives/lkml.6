Return-Path: <matthias.bgg@kernel.org>
X-Google-Smtp-Source: AB8JxZoDDRgRP1V18CXNv230foOjj8hU6VjtOU/sEeqxNjtxKY/NjkOaewcDc5t9hQIYL0p2rXt0
ARC-Seal: i=1; a=rsa-sha256; t=1524821061; cv=none;
        d=google.com; s=arc-20160816;
        b=sj/fIpgnPVQ7Nms3rLqI/z4brKENFKSwIiEe2tKCWrYVfhju/JdU7u/IN6lsFt+tkq
         RtARgZKdtY3mlW8F10+vfDchNTuRJyTIRugmjx3ECeEqTpRcUK2uh3S+fbjq9e5vrBTW
         nuqShOrMj42B4EyZniKwRmeWtdoHsGwaph69HWCsWq4zchEOXDN4IwpgXD920Q5hrFzJ
         IJ9kJgKSKIIcM1Ep7JKd611oB6NQxd6LxmHqX8FoZwyDOCwfTV9Awfy8fgBbb0WsvCKY
         JyFVdeO7JLLZ9ujmSdJkJkjjEPy9Xq+CURh90FNZbmvG9UnzmcZN5QYI2YTNlXuNmsFU
         bggA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dmarc-filter
         :arc-authentication-results;
        bh=5a5O0+Lkd56EHQ35aJhKdgawOA58XKyiJ2GGnthWoak=;
        b=ntvt68bZFyNvSt5P1u4vo1A3jeN63qgIVopYqQzrTi+15dAJtgfx1LdNOw7edNuSHB
         /ISK5YxJDCAwlqJ/hCafKxjGqde4o1S1Voh3cSlj9QvHoDrPmFFZ3ZRf9R0uu/npbVvo
         gHLeM0pSp0/0N6Znz7oo9VmiBTSHQGj8HklsJ8A5/E5TMboxqHHoqBpqKLm4KpgFElfA
         Udjjw0rjGSqCZtJ3HuMWP6Kk53YK1lu06giqa202Ls9OQRar4bsytdCgK0X0qGo48ufG
         1yvAHJcvTP2OZGmgjgroAaRHIFSJA4WwGGd2RqIo3NEiToSgxFid5zdpV44Utr/HHIPq
         V+pg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901DB2185C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=matthias.bgg@kernel.org
From: matthias.bgg@kernel.org
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
	sean.wang@mediatek.com,
	linux-clk@vger.kernel.org,
	linux@armlinux.org.uk,
	matthias.bgg@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <mbrugger@suse.com>
Subject: [v3 00/10] arm/arm64: mediatek: Fix mmsys device probing
Date: Fri, 27 Apr 2018 11:23:52 +0200
Message-Id: <cover.1524820923.git.mbrugger@suse.com>
X-Mailer: git-send-email 2.16.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598890769311881802?=
X-GMAIL-MSGID: =?utf-8?q?1598890769311881802?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthias Brugger <mbrugger@suse.com>

Changes since v2:
- fix kconfig typo (shame on me)
- delete __initconst from mm_clocks as converted to a platform driver

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
 drivers/clk/mediatek/clk-mt8173.c                  | 19 ++++-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |  4 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c             | 41 ++++------
 drivers/gpu/drm/mediatek/mtk_drm_ddp.h             |  4 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             | 33 ++++----
 drivers/gpu/drm/mediatek/mtk_drm_drv.h             |  2 +-
 drivers/mfd/Kconfig                                |  9 +++
 drivers/mfd/Makefile                               |  2 +
 drivers/mfd/mtk-mmsys.c                            | 93 ++++++++++++++++++++++
 14 files changed, 190 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt
 create mode 100644 drivers/mfd/mtk-mmsys.c

-- 
2.16.3
