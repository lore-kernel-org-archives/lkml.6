Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2D8C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2199D23FBA
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2199D23FBA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933241AbeGFNKs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:10:48 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.182]:27701 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932830AbeGFNKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:10:47 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 689815CD497
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jul 2018 08:10:46 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id bQVafRWMFaSeybQVaf5XvN; Fri, 06 Jul 2018 08:10:46 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=40042 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fbQVZ-004J9U-Th; Fri, 06 Jul 2018 08:10:46 -0500
Date:   Fri, 6 Jul 2018 08:10:44 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] xarray: Fix lock/unlock imbalance in xa_alloc
Message-ID: <20180706131044.GA25469@embeddedor.com>
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
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1fbQVZ-004J9U-Th
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:40042
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Release *xa_lock* before return.

Addresses-Coverity-ID: 1471631 ("Missing unlock")
Fixes: 29a6bfc32eb2 ("xarray: Track free entries in an XArray")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 lib/xarray.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index be10039..a27fdb38 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1474,8 +1474,10 @@ int xa_alloc(struct xarray *xa, u32 *id, void *entry, gfp_t gfp)
 		xas.xa_index = 0;
 		xas_lock(&xas);
 		xas_find_tagged(&xas, UINT_MAX, XA_FREE_TAG);
-		if (xas.xa_node == XAS_BOUNDS && xas.xa_index == UINT_MAX + 1)
+		if (xas.xa_node == XAS_BOUNDS && xas.xa_index == UINT_MAX + 1) {
+			xas_unlock(&xas);
 			return -ENOSPC;
+		}
 		*id = xas.xa_index;
 		xas_store(&xas, entry);
 		xas_clear_tag(&xas, XA_FREE_TAG);
-- 
2.7.4

