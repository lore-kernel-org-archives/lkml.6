Return-Path: <matthias.bgg@kernel.org>
X-Google-Smtp-Source: AIpwx4/8ySbiIS6v8aPGSgR+bB8TA9E9lb3pOQxD0zDyalIjVl6FjHwoHzUhKyAOe/TsIGr36zMh
ARC-Seal: i=1; a=rsa-sha256; t=1524563241; cv=none;
        d=google.com; s=arc-20160816;
        b=UWfGursxkCZIHzluDzyPUAlQSj6tGsbsFRfxrlgETJYnJdKjTxq3Abnb2EKSTtK5Bf
         DFaQAzYsIEDo648bXywnVGdaI7iDggEmzkmX6cuOo9onkK4LsXTP9wA7UeUEKjD8pMJO
         +3UwzvMb0mRWOl62pI5oJGTQr0kRdmSCGNYsm4Uc5FINpvncd9KbPJlvKSZ21l8IAfNB
         kXu7iTz2Oat523Hxi7Rk5fd0nEIZLgQrrFpzMUnvdT+Gvk77RUHALdQQUqCfu19B52c5
         yQIZ6quZeVCrFcveEUKa5775/fGKrKCx+UDZ6zbASNEaVVQyvABY8B89scool9sFMdG5
         E80g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dmarc-filter
         :arc-authentication-results;
        bh=dC0Z4R1xf46kH+zfW9FeL5mGZqA3LuQ6bTMkY5Ce2I8=;
        b=SPsF4VVxlCdy3xQGJLd5Rp8OTVNsMB9Y3NDlkcNL6pGOHstkv+VRuW1cOzs1vIEdwd
         dMKZDwYBVmojW5AhYk2+ht5xoRJ4B2+u23IZgX2iVbtINjKKzQBRUl+uuQ/4U/YPuBbI
         jIrKSFMFYlZ71vfsM73cjuSjQALnGlhxApZs6shCgR6o3RPcWF29nVk2UYU8vPG3K5RV
         lt5P+IDhTcjTt+B7n1woFZw82dNyJTcc2cnmhSKtv47BEX6+f/h4XAJ0I6+2WUqo9KH+
         Z7MN+jmg840O+unVhZAbU6zE96zfvmtUQCnJqSkjwQNuAUOpB2s+/t4GI9Ak3nCNS7sf
         238Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42E721717
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
Subject: [v2 resend 00/10] arm/arm64: mediatek: Fix mmsys device probing
Date: Tue, 24 Apr 2018 11:46:57 +0200
Message-Id: <cover.1524563001.git.mbrugger@suse.com>
X-Mailer: git-send-email 2.16.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598620425827873144?=
X-GMAIL-MSGID: =?utf-8?q?1598620425827873144?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthias Brugger <mbrugger@suse.com>

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
