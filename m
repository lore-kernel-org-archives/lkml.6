Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04649C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45B521916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfBHETs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 23:19:48 -0500
Received: from gateway23.websitewelcome.com ([192.185.50.108]:21296 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726892AbfBHETr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 23:19:47 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id C9B274436
        for <linux-kernel@vger.kernel.org>; Thu,  7 Feb 2019 22:19:46 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id rxdigG3VXiQerrxdigWQ6G; Thu, 07 Feb 2019 22:19:46 -0600
X-Authority-Reason: nr=8
Received: from [189.250.49.191] (port=49852 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1grxdi-002DJ4-2m; Thu, 07 Feb 2019 22:19:46 -0600
Date:   Thu, 7 Feb 2019 22:19:45 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] igc: Use struct_size() helper
Message-ID: <20190208041945.GA4687@embeddedor>
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
X-Exim-ID: 1grxdi-002DJ4-2m
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.49.191]:49852
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 17
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
instance = kzalloc(size, GFP_KERNEL)

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL)

Notice that, in this case, variable size is not necessary, hence
it is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 11c75433fe22..87a11879bf2d 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2958,22 +2958,21 @@ static int igc_alloc_q_vector(struct igc_adapter *adapter,
 {
 	struct igc_q_vector *q_vector;
 	struct igc_ring *ring;
-	int ring_count, size;
+	int ring_count;
 
 	/* igc only supports 1 Tx and/or 1 Rx queue per vector */
 	if (txr_count > 1 || rxr_count > 1)
 		return -ENOMEM;
 
 	ring_count = txr_count + rxr_count;
-	size = sizeof(struct igc_q_vector) +
-		(sizeof(struct igc_ring) * ring_count);
 
 	/* allocate q_vector and rings */
 	q_vector = adapter->q_vector[v_idx];
 	if (!q_vector)
-		q_vector = kzalloc(size, GFP_KERNEL);
+		q_vector = kzalloc(struct_size(q_vector, ring, ring_count),
+				   GFP_KERNEL);
 	else
-		memset(q_vector, 0, size);
+		memset(q_vector, 0, struct_size(q_vector, ring, ring_count));
 	if (!q_vector)
 		return -ENOMEM;
 
-- 
2.20.1

