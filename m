Return-Path: <geert@linux-m68k.org>
X-Google-Smtp-Source: AG47ELtGcWoEZRLRtDYZmJaAut4gSbYmMB1ZC4hx59F1EnmOIjXAlW6+G7Rwcch6fh5U7rKLm6zG
ARC-Seal: i=1; a=rsa-sha256; t=1521208193; cv=none;
        d=google.com; s=arc-20160816;
        b=w3i0B7WwhVEUjYJiSVxOogVHQ2M3TFrpDMMFeBcvdmC9cEBouogCNWtE9OPpZB1DRq
         ksrSBEPHCrtYUq9297ye5m7dmX85/oEjctQrADQqf84D6Up4slaGagenThBTriHopEuE
         br1cLnC+cmggqSgzcGMLwNZM4LNHU3NOJpZW8d+UUNv3Kd4eR8NzX2QhDyhYeLOQMxsj
         Pi35jBGg+l4GqBnCUIXNL2Yz+2qf0CVK3Dt6zbOogFk2amsXcMrevwyjwEHma+yXLcuB
         2MJi/h03Zr/30kA+O3y5LC7Xa3WrpekrWtaNaGwUGVwg+3EiXdOPGuLQrX//Q0Xp365x
         nH0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=0O0IMBKxd/F/GgAjFCLFzZJyoYk2aunHzbXSh1hUdFw=;
        b=ngfXHpISDUvCna1gNrQFR54HGB0sa7L/yKKGvGr7qzXqa1UIbXaD+QUOPDgomUgxnT
         9rjzibQHcPWRRbkKbQSE+xGTWSmUWymFwKgE9s75nw0uyrFO5G58Z2iy9zAyOApKq2BC
         /lRFijYb2DT9dRiREnanKBk3JqY+EAkHQJx95oq/nHLPOHM95QYuqBxB3D0tKqZvoOBi
         tuSy6hUWReKTWuQ4nYJhaKwGC0I+eaeHG1rsHbEq5OKxMw6hi/uqj2eK92TqLhJWrifE
         jh0g+mOfvUaBDCDP0Z4fx3so19Wm2m27IqiZ6qn4e7pRqj5BDyA3MmK080AZ6ok5hvJA
         fCyw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a02:1800:120:4::f00:14 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a02:1800:120:4::f00:14 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Felipe Balbi <balbi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: iommu@lists.linux-foundation.org,
	linux-usb@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 0/5] Allow compile-testing NO_DMA (core)
Date: Fri, 16 Mar 2018 14:25:39 +0100
Message-Id: <1521206744-1504-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595102402335154451?=
X-GMAIL-MSGID: =?utf-8?q?1595102402335154451?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

	Hi all,

If NO_DMA=y, get_dma_ops() returns a reference to the non-existing
symbol bad_dma_ops, thus causing a link failure if it is ever used.

The intention of this is twofold:
  1. To catch users of the DMA API on systems that do no support the DMA
     mapping API,
  2. To avoid building drivers that cannot work on such systems anyway.

However, the disadvantage is that we have to keep on adding dependencies
on HAS_DMA all over the place.

Thanks to the COMPILE_TEST symbol, lots of drivers now depend on one or
more platform dependencies (that imply HAS_DMA) || COMPILE_TEST, thus
already covering intention #2.  Having to add an explicit dependency on
HAS_DMA here is cumbersome, and hinders compile-testing.

Hence I think the time is ripe to reconsider the link failure.
This patch series:
  - Changes get_dma_ops() to return NULL instead,
  - Adds a few more dummies to enable compile-testing.

A follow-up patch series will:
  - Remove dependencies on HAS_DMA for symbols that already have
    platform dependencies implying HAS_DMA.

Changes compared to v1:
  - Add Reviewed-by, Acked-by,
  - Group NO_DMA-stubs for the DMA pool API under a single #ifdef,
  - Split the big Kconfig patch in per-subsystem patches, split-off in a
    follow-up series.

This series is against v4.16-rc5. It can also be found at
https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git/log/?h=no-dma-compile-testing-v2

It has been compile-tested with allmodconfig and allyesconfig for
m68k/sun3, and has received attention from the kbuild test robot.

Thanks!

Geert Uytterhoeven (5):
  dma-mapping: Convert NO_DMA get_dma_ops() into a real dummy
  dma-coherent: Add NO_DMA dummies for managed DMA API
  usb: gadget: Add NO_DMA dummies for DMA mapping API
  mm: Add NO_DMA dummies for DMA pool API
  scsi: Add NO_DMA dummies for SCSI DMA mapping API

 include/linux/dma-mapping.h | 19 ++++++++++++++-----
 include/linux/dmapool.h     | 30 +++++++++++++++++++++++-------
 include/linux/usb/gadget.h  | 12 ++++++++++++
 include/scsi/scsi_cmnd.h    |  5 +++++
 4 files changed, 54 insertions(+), 12 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
