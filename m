Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C8BC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4355A20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfAHQ5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:57:21 -0500
Received: from gateway30.websitewelcome.com ([192.185.160.12]:49617 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729229AbfAHQ5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:57:18 -0500
X-Greylist: delayed 1501 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jan 2019 11:57:18 EST
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id EB12B18401
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jan 2019 10:08:09 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id gtvFgUtqK90ongtvFgz6zc; Tue, 08 Jan 2019 10:08:09 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=53072 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ggtvE-001emW-KW; Tue, 08 Jan 2019 10:08:09 -0600
Date:   Tue, 8 Jan 2019 10:08:05 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] IB/srp: Use struct_size() in kzalloc()
Message-ID: <20190108160805.GA22698@embeddedor>
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
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1ggtvE-001emW-KW
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:53072
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding the
size of a structure that has a zero-sized array at the end, along with memory
for some number of elements for that array. For example:

struct foo {
    int stuff;
    void *entry[];
};

instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can now
use the new struct_size() helper:

instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 31d91538bbf4..0f855294ff3f 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -443,8 +443,7 @@ static struct srp_fr_pool *srp_create_fr_pool(struct ib_device *device,
 	if (pool_size <= 0)
 		goto err;
 	ret = -ENOMEM;
-	pool = kzalloc(sizeof(struct srp_fr_pool) +
-		       pool_size * sizeof(struct srp_fr_desc), GFP_KERNEL);
+	pool = kzalloc(struct_size(pool, desc, pool_size), GFP_KERNEL);
 	if (!pool)
 		goto err;
 	pool->size = pool_size;
-- 
2.20.1

