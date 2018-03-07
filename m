Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751151AbeCGIQn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 03:16:43 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:7767 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750989AbeCGIQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 03:16:41 -0500
X-UUID: 9b820d63e60943899d242afc3c323a7d-20180307
From: <sean.wang@mediatek.com>
To: <vinod.koul@intel.com>, <dan.j.williams@intel.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v6 0/3] add support for Mediatek High-Speed DMA controller on MT7622 and MT7623 SoC
Date: Wed, 7 Mar 2018 16:16:25 +0800
Message-ID: <cover.1520407882.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23704.005
X-TM-AS-Result: No-6.408300-8.000000-10
X-TMASE-MatchedRID: xfuVRybaRmIbZUQXhYPYzIoLoibgjVEXMVx/3ZYby78L/50zj0KL7EUe
        RhGY4VMdk7kyF4Md6sy7mdCoyGbuUqqAKDdqPyaKvbFZsqMF9Y8Ea8g1x8eqF+BvxYFhNwdMIw6
        4a0XgvUT7mria/yRwJi4tbilhwCGWyi3rT9eHsAEZXJLztZviXBlgDfyCPcHEVCdU5v5PcvFSUt
        G/M//UwWpZTVC80hAGEUOlogk6C+8p4sbMqb/D0s6vz9r9NIijdyejMZ27QTjo1+KnG60kJ/UsB
        kkR9dFxgTYJSGkzbIePRJT8sai6Bgi0xaFtKyGqLTHwnYOikQ3Ld8x3ukKaXrTTh+pZ2v9RdBeS
        8kW64WSVMlcqqHWd7Uzyp2gK85W+az+0XDplNBaeAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8h+ICq
        uNi0WJFSjI4Dhz2u7OAj7Rfr6JuaiTFdx0TUjK4mUSPSMxiIyftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.408300-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23704.005
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Changes since v5:
- use C99 style comments at the first two lines
- remove unused header includes
- use directly KBUILD_MODNAME as a driver name
- use DMA_SLAVE_BUSWIDTH_4_BYTES to reflect the real bus width
- refine comments
- refine code style aligning with 80 chars and wrap
- use GFP_NOWAIT as the flag for memory allocations for DMA
- changing flow for it should be returning 0 instead of -ENOSPC for all
  successful descriptor issuing either in part or in full
- refine ISR with a fail-safe loop, and having a status check at the start
- remove a few unused code
- refine callback device_terminate_all, which does it should be freeing
  all descriptors
- refine callback device_free_chan_resources, which does it should be
  freeing all descriptors before freeing physical channel
- remove unnecessary callback device_synchronize

Changes since v4:
- rebase to 4.16-rc1
- fold back patch 4 and 5 in v4 into the original commit
- add the missing header included
- fix typo and add more explanation in existing comments
- fix the comments with kernel-doc style which uses /** as the begin
- begin the multi-line comments with /*

Changes since v3:
- enhance dt-binding documents based on Rob's comments
- make consistent among all comments
- perfer ordering declarations longest to shortest
- fix warning reported from kbuild test robot
- add patch 4 and 5 to keep Fengguang and Julia's effort

Changes since v2:
- remove extra tasklets and refactor driver for letting descriptors being processed ASAP.
- add more comments stating the relevant logic
- remove unused macro and variables
- change to use the disclaimer with SPDX identifier
- add mt7622 support
- refine hardware initialization sequence
- add tx_status support for DMA_RESIDUE_GRANULARITY_SEGMENT
- refine remove handler with killing vc's tasklet

Changes since v1:
- fix typo in the commit message.
- delete status shown in the dt-binding example.

This patchset introduces support for MediaTek High-Speed DMA controller
(MTK-HSDMA) Currently, the driver is already tested successfully with
dmatest module on MT7622 and MT7623 SoC. 

MTK-HSDMA on MT7622/23 SoC has a single ring which is dedicated for
doing memory-to-memory transfer through ring-based descriptor management.
Even though there is only a single ring available inside HSDMA, the
driver is being extended to the support for multiple virtual channels
processing simultaneously by means of DMA_VIRTUAL_CHANNELS.

Sean Wang (3):
  dt-bindings: dmaengine: Add MediaTek High-Speed DMA controller
    bindings
  dmaengine: mediatek: Add MediaTek High-Speed DMA controller for MT7622
    and MT7623 SoC
  dmaengine: mediatek: update MAINTAINERS entry with MediaTek DMA driver

 .../devicetree/bindings/dma/mtk-hsdma.txt          |   33 +
 MAINTAINERS                                        |    9 +
 drivers/dma/Kconfig                                |    2 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/mediatek/Kconfig                       |   13 +
 drivers/dma/mediatek/Makefile                      |    1 +
 drivers/dma/mediatek/mtk-hsdma.c                   | 1056 ++++++++++++++++++++
 7 files changed, 1115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/mtk-hsdma.txt
 create mode 100644 drivers/dma/mediatek/Kconfig
 create mode 100644 drivers/dma/mediatek/Makefile
 create mode 100644 drivers/dma/mediatek/mtk-hsdma.c

-- 
2.7.4
