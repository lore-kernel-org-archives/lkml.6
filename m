Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbeBAGeF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 01:34:05 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:38565 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751635AbeBAGeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 01:34:03 -0500
X-Google-Smtp-Source: AH8x225elyyCrhHMCJ948qsMYvNNtn1ikmzo6qR9AuO98PnSWkPhcEfbTgK5H60lkFqT+LWoaVHUDw==
Message-ID: <1517466839.3715.115.camel@gmail.com>
Subject: [PATCH v2] iommu/vt-d: add NUMA awareness to intel_alloc_coherent()
From: Eric Dumazet <eric.dumazet@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Benjamin Serebrin <serebrin@google.com>,
        David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, netdev <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Date: Wed, 31 Jan 2018 22:33:59 -0800
In-Reply-To: <1517438756.3715.108.camel@gmail.com>
References: <1517438756.3715.108.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

Some devices (like mlx4) try hard to allocate memory on selected
NUMA node, but it turns out intel_alloc_coherent() is not NUMA
aware yet.

Note that dma_generic_alloc_coherent() in arch/x86/kernel/pci-dma.c
gets this right.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Benjamin Serebrin <serebrin@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
---
v2: no fallback to alloc_pages(), this is not needed and might even
hurt in OOM cases.

 drivers/iommu/intel-iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a1373cf343269455808f66ad18dc0a2fb7aa73f2..3c538466a98bdb8fffdca688462b1350d536791b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3735,7 +3735,7 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 	}
 
 	if (!page)
-		page = alloc_pages(flags, order);
+		page = alloc_pages_node(dev_to_node(dev), flags, order);
 	if (!page)
 		return NULL;
 	memset(page_address(page), 0, size);
