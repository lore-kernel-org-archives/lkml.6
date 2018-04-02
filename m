Return-Path: <robert.jarzmik@free.fr>
X-Google-Smtp-Source: AIpwx49qQSiMaciTtaouG2xvQ1MCvUCWsjlIHM+dpTYQjTWgF2F3A8aSwiJmSTzyIrp7odPtI6mG
ARC-Seal: i=1; a=rsa-sha256; t=1522679238; cv=none;
        d=google.com; s=arc-20160816;
        b=fZaZbWm97kr69ZUjAN4T48V8cXEhmNMmHQDGN51xETW63JojIAhlYImEpQOe+/vdH2
         0r0uhi02NMqvuMAc1IvdKfyEc2hYy6b5SLDb7aDySEgcs7exLXKYJ7uDVdof/R2xjQbA
         JE43WC7nss/SA7yglZp4xwIK6G4bGJz3DvpFPIX3cdgrZCkaopPg8NtYkHESzk3y50DD
         nYWnpm1oZhrxPmCGx2rpTrYE2qcQJq61kKTn/YAX6ejPjF8mhiqbebennzDs/HbiAB8O
         kj5aoKPrfQ/6E8Uqhsmlr0YrqPL4VTG02G1veTc9lAbVsDdQv3nkpjBGiZU01m/RePWU
         ohTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=wyuYSrByu0qbk3fDipmrhnQ2q1DARd5aaa3cc39IeHo=;
        b=kQkBnKvqsMxhuBFH1iZkm7fh/eJEwZNBk7S6r6h5RNzqNxTQtr2Za4QnDahSrpgamz
         Kl/M55fUvW1LpxDrtUIjOzhnpBQk2ABzl+9Vf6AE//sIE/3kS7ljnYD8FTdl1M3H1a/q
         92d4MXgHwaogIyPlO6gr9rLGgAORzPCr/Yj0le9qTW2YBwou83gzf+TrIlDTfI/wnsO0
         7aJOOz4eNsXqRxx912cufGzHIjhGm1I92vZesDWgqzx38msB2LZ8+OrpzYSB2GtrsV/u
         VDEBmS4DgTGQzHoVW621tEDDpu595tY4SyR/RGv6lS0UeWwHuAZ33/8AuAw1IogJ5OiE
         fitA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 80.12.242.128 is neither permitted nor denied by best guess record for domain of robert.jarzmik@free.fr) smtp.mailfrom=robert.jarzmik@free.fr
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 80.12.242.128 is neither permitted nor denied by best guess record for domain of robert.jarzmik@free.fr) smtp.mailfrom=robert.jarzmik@free.fr
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 02 Apr 2018 16:27:17 +0200
X-ME-IP: 86.201.130.131
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Tejun Heo <tj@kernel.org>,
	Vinod Koul <vinod.koul@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Marek Vasut <marek.vasut@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
	Nicolas Pitre <nico@fluxnic.net>,
	Samuel Ortiz <samuel@sortiz.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	netdev@vger.kernel.org,
	devel@driverdev.osuosl.org,
	alsa-devel@alsa-project.org
Subject: [PATCH 00/15] ARM: pxa: switch to DMA slave maps
Date: Mon,  2 Apr 2018 16:26:41 +0200
Message-Id: <20180402142656.26815-1-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596644905129799893?=
X-GMAIL-MSGID: =?utf-8?q?1596644905129799893?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

This serie is aimed at removing the dmaengine slave compat use, and transfer
knowledge of the DMA requestors into architecture code.

This was discussed/advised by Arnd a couple of years back, it's almost time.

The serie is divided in 3 phasees :
 - phase 1 : patch 1/15 and patch 2/15
   => this is the preparation work
 - phase 2 : patches 3/15 .. 10/15
   => this is the switch of all the drivers
   => this one will require either an Ack of the maintainers or be taken by them
      once phase 1 is merged
 - phase 3 : patches 11/15
   => this is the last part, cleanup and removal of export of the DMA filter
      function

As this looks like a patch bomb, each maintainer expressing for his tree either
an Ack or "I want to take through my tree" will be spared in the next iterations
of this serie.

Several of these changes have been tested on actual hardware, including :
 - pxamci
 - pxa_camera
 - smc*
 - ASoC and SSP

Happy review.

Robert Jarzmik (15):
  dmaengine: pxa: use a dma slave map
  ARM: pxa: add dma slave map
  mmc: pxamci: remove the dmaengine compat need
  media: pxa_camera: remove the dmaengine compat need
  mtd: nand: pxa3xx: remove the dmaengine compat need
  net: smc911x: remove the dmaengine compat need
  net: smc91x: remove the dmaengine compat need
  ASoC: pxa: remove the dmaengine compat need
  net: irda: pxaficp_ir: remove the dmaengine compat need
  ata: pata_pxa: remove the dmaengine compat need
  dmaengine: pxa: document pxad_param
  dmaengine: pxa: make the filter function internal
  ARM: pxa: remove the DMA IO resources
  ARM: pxa: change SSP devices allocation
  ARM: pxa: change SSP DMA channels allocation

 arch/arm/mach-pxa/devices.c               | 269 ++++++++++++++----------------
 arch/arm/mach-pxa/devices.h               |  14 +-
 arch/arm/mach-pxa/include/mach/audio.h    |  12 ++
 arch/arm/mach-pxa/pxa25x.c                |   4 +-
 arch/arm/mach-pxa/pxa27x.c                |   4 +-
 arch/arm/mach-pxa/pxa3xx.c                |   5 +-
 arch/arm/plat-pxa/ssp.c                   |  50 +-----
 drivers/ata/pata_pxa.c                    |  10 +-
 drivers/dma/pxa_dma.c                     |  13 +-
 drivers/media/platform/pxa_camera.c       |  22 +--
 drivers/mmc/host/pxamci.c                 |  29 +---
 drivers/mtd/nand/pxa3xx_nand.c            |  10 +-
 drivers/net/ethernet/smsc/smc911x.c       |  16 +-
 drivers/net/ethernet/smsc/smc91x.c        |  12 +-
 drivers/net/ethernet/smsc/smc91x.h        |   1 -
 drivers/staging/irda/drivers/pxaficp_ir.c |  14 +-
 include/linux/dma/pxa-dma.h               |  20 +--
 include/linux/platform_data/mmp_dma.h     |   4 +
 include/linux/pxa2xx_ssp.h                |   4 +-
 sound/arm/pxa2xx-ac97.c                   |  14 +-
 sound/arm/pxa2xx-pcm-lib.c                |   6 +-
 sound/soc/pxa/pxa-ssp.c                   |   5 +-
 sound/soc/pxa/pxa2xx-ac97.c               |  32 +---
 23 files changed, 196 insertions(+), 374 deletions(-)

-- 
2.11.0
