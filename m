Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57D2C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 01:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945EE21568
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 01:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945EE21568
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbeHXEpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 00:45:38 -0400
Received: from gateway23.websitewelcome.com ([192.185.48.84]:12746 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725945AbeHXEpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 00:45:38 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id BE24D137AA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 20:13:22 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id t0eef34P6PvAdt0ezf1SRf; Thu, 23 Aug 2018 20:13:21 -0500
X-Authority-Reason: nr=8
Received: from [189.250.73.28] (port=44150 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ft0ed-003Uo1-QY; Thu, 23 Aug 2018 20:12:47 -0500
Date:   Thu, 23 Aug 2018 20:12:47 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ath10k: use struct_size() in kzalloc()
Message-ID: <20180824011247.GA25648@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.73.28
X-Source-L: No
X-Exim-ID: 1ft0ed-003Uo1-QY
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.73.28]:44150
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 31
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
        void *entry[];
};

instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/wireless/ath/ath10k/ce.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
index 18c709c..d0381aa 100644
--- a/drivers/net/wireless/ath/ath10k/ce.c
+++ b/drivers/net/wireless/ath/ath10k/ce.c
@@ -1416,10 +1416,8 @@ ath10k_ce_alloc_src_ring(struct ath10k *ar, unsigned int ce_id,
 
 	nentries = roundup_pow_of_two(nentries);
 
-	src_ring = kzalloc(sizeof(*src_ring) +
-			   (nentries *
-			    sizeof(*src_ring->per_transfer_context)),
-			   GFP_KERNEL);
+	src_ring = kzalloc(struct_size(src_ring, per_transfer_context,
+				       nentries), GFP_KERNEL);
 	if (src_ring == NULL)
 		return ERR_PTR(-ENOMEM);
 
@@ -1476,10 +1474,8 @@ ath10k_ce_alloc_src_ring_64(struct ath10k *ar, unsigned int ce_id,
 
 	nentries = roundup_pow_of_two(nentries);
 
-	src_ring = kzalloc(sizeof(*src_ring) +
-			   (nentries *
-			    sizeof(*src_ring->per_transfer_context)),
-			   GFP_KERNEL);
+	src_ring = kzalloc(struct_size(src_ring, per_transfer_context,
+				       nentries), GFP_KERNEL);
 	if (!src_ring)
 		return ERR_PTR(-ENOMEM);
 
@@ -1534,10 +1530,8 @@ ath10k_ce_alloc_dest_ring(struct ath10k *ar, unsigned int ce_id,
 
 	nentries = roundup_pow_of_two(attr->dest_nentries);
 
-	dest_ring = kzalloc(sizeof(*dest_ring) +
-			    (nentries *
-			     sizeof(*dest_ring->per_transfer_context)),
-			    GFP_KERNEL);
+	dest_ring = kzalloc(struct_size(dest_ring, per_transfer_context,
+					nentries), GFP_KERNEL);
 	if (dest_ring == NULL)
 		return ERR_PTR(-ENOMEM);
 
@@ -1580,10 +1574,8 @@ ath10k_ce_alloc_dest_ring_64(struct ath10k *ar, unsigned int ce_id,
 
 	nentries = roundup_pow_of_two(attr->dest_nentries);
 
-	dest_ring = kzalloc(sizeof(*dest_ring) +
-			    (nentries *
-			     sizeof(*dest_ring->per_transfer_context)),
-			    GFP_KERNEL);
+	dest_ring = kzalloc(struct_size(dest_ring, per_transfer_context,
+					nentries), GFP_KERNEL);
 	if (!dest_ring)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.7.4

