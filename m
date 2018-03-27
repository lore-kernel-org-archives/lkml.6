Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754639AbeC0RNO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 13:13:14 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:59270 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755116AbeC0RNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 13:13:13 -0400
From: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
To: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
Subject: dma-mapping: clearing GFP_ZERO flag caused crashes of Ethernet on
 arc/hsdk board.
Thread-Topic: dma-mapping: clearing GFP_ZERO flag caused crashes of Ethernet
 on arc/hsdk board.
Thread-Index: AQHTxe7Y86AnIPeLoEWcNLwKgl2z7w==
Date: Tue, 27 Mar 2018 17:12:54 +0000
Message-ID: <1522170774.2593.9.camel@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E5AD8C975D8E34FB958C62C38827BD4@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2RHDJSF030661

Hello,

After commit  57bf5a8963f8 ("dma-mapping: clear harmful GFP_* flags in common code")  we noticed problems with Ethernet controller on one of our platforms (namely ARC HSDK).
I
n particular we see that removal of __GFP_ZERO flag in function dma_alloc_attrs() was the culprit because in our implementation of arc_dma_alloc() we only allocate zeroed pages if
that flag is explicitly set by the caller. Now with unconditional removal of that flag in dma_alloc_attrs() we allocate non-zeroed pages and that seem to cause problems.

From
mentioned commit message I may conclude that architectural code is supposed to always allocate zeroed pages but I cannot find any requirement of that in kernel's documentation.
Coul
d you please point me to that requirement if that exists at all, then we'll implement a fix in our arch code like that:
--------------------->8---------------------
diff --git
a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index 1dcc404b5aec..c92e518413aa 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -30,7 +30,7 @@ static void *arc_dma_alloc(struct
device *dev, size_t size,
      void *kvaddr;
      int need_coh = 1, need_kvaddr = 0;

-       page = alloc_pages(gfp, order);
+       page = alloc_pages(gfp | __GFP_ZERO, order);
     
if (!page)
              return NULL;
--------------------->8---------------------

Best regards,
Evgeniy Didin
