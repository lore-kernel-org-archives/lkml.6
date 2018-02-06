Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752755AbeBFQy5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:54:57 -0500
Received: from gateway24.websitewelcome.com ([192.185.50.66]:35147 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752961AbeBFQvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:51:20 -0500
Date: Tue, 6 Feb 2018 10:51:18 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Jacob chen <jacob2.chen@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH v3 6/8] rockchip/rga: use 64-bit arithmetic instead of 32-bit
Message-ID: <94fd0993cde02e18ee5d7f54707f8ce0d0341a0c.1517929336.git.gustavo@embeddedor.com>
References: <cover.1517929336.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1517929336.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.4.238
X-Source-L: No
X-Exim-ID: 1ej6Sl-000pK8-9Q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.4.238]:46798
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 36
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cast p to dma_addr_t in order to avoid a potential integer overflow.
This variable is being used in a context that expects an expression
of type dma_addr_t (u64).

The expression p << PAGE_SHIFT is currently being evaluated
using 32-bit arithmetic.

Addresses-Coverity-ID: 1458347 ("Unintentional integer overflow")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Update subject and changelog to better reflect the proposed code change.

Changes in v3:
 - Mention the specific Coverity report in the commit message.

 drivers/media/platform/rockchip/rga/rga-buf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/rockchip/rga/rga-buf.c b/drivers/media/platform/rockchip/rga/rga-buf.c
index 49cacc7..a43b57a 100644
--- a/drivers/media/platform/rockchip/rga/rga-buf.c
+++ b/drivers/media/platform/rockchip/rga/rga-buf.c
@@ -140,7 +140,8 @@ void rga_buf_map(struct vb2_buffer *vb)
 		address = sg_phys(sgl);
 
 		for (p = 0; p < len; p++) {
-			dma_addr_t phys = address + (p << PAGE_SHIFT);
+			dma_addr_t phys = address +
+					  ((dma_addr_t)p << PAGE_SHIFT);
 
 			pages[mapped_size + p] = phys;
 		}
-- 
2.7.4
