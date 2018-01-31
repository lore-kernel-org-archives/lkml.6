Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751918AbeAaWqB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 17:46:01 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33244 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751650AbeAaWp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 17:45:59 -0500
X-Google-Smtp-Source: AH8x227YDEBu5q2sLu24uefZzK0S0z9ze5CExG9rLqPolYPq577w4MTxgSFOsG/XW3NG2VvFj7so0Q==
Message-ID: <1517438756.3715.108.camel@gmail.com>
Subject: [PATCH] iommu/vt-d: add NUMA awareness to intel_alloc_coherent()
From: Eric Dumazet <eric.dumazet@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Benjamin Serebrin <serebrin@google.com>,
        David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, netdev <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Date: Wed, 31 Jan 2018 14:45:56 -0800
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
 drivers/iommu/intel-iommu.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a1373cf343269455808f66ad18dc0a2fb7aa73f2..0efef077abc099eb29ebc5cefdd1b996f025dffd 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3734,8 +3734,11 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 		}
 	}
 
-	if (!page)
-		page = alloc_pages(flags, order);
+	if (!page) {
+		page = alloc_pages_node(dev_to_node(dev), flags, order);
+		if (!page)
+			page = alloc_pages(flags, order);
+	}
 	if (!page)
 		return NULL;
 	memset(page_address(page), 0, size);
