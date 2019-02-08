Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87485C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F572147C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfBHEXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 23:23:01 -0500
Received: from gateway20.websitewelcome.com ([192.185.47.18]:22131 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726793AbfBHEXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 23:23:00 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id D4F92400C7B3E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Feb 2019 22:22:59 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id rxgpg6vzT2qH7rxgpgfwlj; Thu, 07 Feb 2019 22:22:59 -0600
X-Authority-Reason: nr=8
Received: from [189.250.49.191] (port=49886 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1grxgp-002GDf-3P; Thu, 07 Feb 2019 22:22:59 -0600
Date:   Thu, 7 Feb 2019 22:22:58 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] ixgbe: Use struct_size() helper
Message-ID: <20190208042258.GA32468@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.49.191
X-Source-L: No
X-Exim-ID: 1grxgp-002GDf-3P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.49.191]:49886
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 22
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    struct boo entry[];
};

size = sizeof(struct foo) + count * sizeof(struct boo);
instance = kzalloc(size, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);

Notice that, in this case, variable size is not necessary, hence
it is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
index 62e6499e4146..cc3196ae5aea 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
@@ -836,12 +836,10 @@ static int ixgbe_alloc_q_vector(struct ixgbe_adapter *adapter,
 	struct ixgbe_ring *ring;
 	int node = NUMA_NO_NODE;
 	int cpu = -1;
-	int ring_count, size;
+	int ring_count;
 	u8 tcs = adapter->hw_tcs;
 
 	ring_count = txr_count + rxr_count + xdp_count;
-	size = sizeof(struct ixgbe_q_vector) +
-	       (sizeof(struct ixgbe_ring) * ring_count);
 
 	/* customize cpu for Flow Director mapping */
 	if ((tcs <= 1) && !(adapter->flags & IXGBE_FLAG_SRIOV_ENABLED)) {
@@ -855,9 +853,11 @@ static int ixgbe_alloc_q_vector(struct ixgbe_adapter *adapter,
 	}
 
 	/* allocate q_vector and rings */
-	q_vector = kzalloc_node(size, GFP_KERNEL, node);
+	q_vector = kzalloc_node(struct_size(q_vector, ring, ring_count),
+				GFP_KERNEL, node);
 	if (!q_vector)
-		q_vector = kzalloc(size, GFP_KERNEL);
+		q_vector = kzalloc(struct_size(q_vector, ring, ring_count),
+				   GFP_KERNEL);
 	if (!q_vector)
 		return -ENOMEM;
 
-- 
2.20.1

