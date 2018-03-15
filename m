Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbeCOHkq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 03:40:46 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:30646 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751362AbeCOHko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 03:40:44 -0400
X-UUID: f8dd18254e6c432cb9065080dfdfeaf9-20180315
From: <sean.wang@mediatek.com>
To: <vinod.koul@intel.com>, <dan.j.williams@intel.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v7 0/3] add support for Mediatek High-Speed DMA controller on MT7622 and MT7623 SoC
Date: Thu, 15 Mar 2018 15:40:34 +0800
Message-ID: <cover.1521098171.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23720.005
X-TM-AS-Result: No-5.953800-8.000000-10
X-TMASE-MatchedRID: rUVaOj5Q3/wxFdXyW/P+XWNW0DAjL5p+UAjrAJWsTe/pKlp3rWb963nv
        qbLkjGO67nZqDCMcUaSM/8iqZNn392J1mLiX15SGFPCqKjnJ9scDA8I31/g84NA0hGs3DiOkK33
        GICKuN/+37cssi5Wn7ZxQrQ7wRdoU9eJj30BX/YiXXOyNnX/prChRWQHuJ8meiJ71fA8tGWh4Lw
        vym5RtmZzxnyeItlimidbsGVQHN2Mn7/+1a+vDY8AmcZEx8XHJbUpf52Lnbx1jD1mE/UkWnFlyo
        bZskGdj+zeX6pGYRAwIlsaZLrUbOBC3b15W9wmcSEQN/D/3cG5ReWnUUdhI9TrW2rRfTfGr0aRn
        VaZ3nel3I1qXcZvalIgmzRSnu+RYqjvsBy5CHDt0BEBFOTiHn30tCKdnhB589yM15V5aWpj6C0e
        Ps7A07QsfaqMZktsdABDL5/XtvjrbJrpmzP/IlLdC3bCClQ7fWdj8J5A9HMk=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.953800-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23720.005
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Changes since v6:
- add Reviewed-by tag from Rob to patch 1

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
