Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4428EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF73D20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF73D20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbeIFTKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:10:55 -0400
Received: from gateway20.websitewelcome.com ([192.185.49.40]:43670 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729124AbeIFTKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:10:55 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id EC9CE400E15B0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Sep 2018 09:35:05 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id xvMVfEh5WBcCXxvMvfgoUF; Thu, 06 Sep 2018 09:35:05 -0500
X-Authority-Reason: nr=8
Received: from [189.250.106.191] (port=34464 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fxvMV-000ToD-3T; Thu, 06 Sep 2018 09:34:23 -0500
Date:   Thu, 6 Sep 2018 09:34:21 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] interconnect: core: Fix uninitialized variable
Message-ID: <20180906143421.GA3779@embeddedor.com>
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
X-Source-IP: 189.250.106.191
X-Source-L: No
X-Exim-ID: 1fxvMV-000ToD-3T
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.106.191]:34464
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a potential execution path in which variable *ret* is returned
without being properly initialized previously.

Fix this by initializing variable *ret* to -EINVAL.

Addresses-Coverity-ID: 1473202 ("Uninitialized scalar variable")
Fixes: 81b4cdb447fe ("interconnect: Add generic on-chip interconnect API")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/interconnect/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 2740f1a..ea5245f 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -227,7 +227,7 @@ static int aggregate_requests(struct icc_node *node)
 static int apply_constraints(struct icc_path *path)
 {
 	struct icc_node *next, *prev = NULL;
-	int ret;
+	int ret = -EINVAL;
 	int i;
 
 	for (i = 0; i < path->num_nodes; i++, prev = next) {
-- 
2.7.4

