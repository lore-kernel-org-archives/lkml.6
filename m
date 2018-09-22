Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7DCECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F91C2157C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F91C2157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391818AbeIVGMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:12:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44291 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391930AbeIVGKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:49 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdy-0008BQ-7C; Sat, 22 Sep 2018 01:19:30 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdo-0000su-Fx; Sat, 22 Sep 2018 01:19:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Noam Rathaus" <noamr@beyondsecurity.com>,
        "Cong Wang" <xiyou.wangcong@gmail.com>,
        "Jason Gunthorpe" <jgg@mellanox.com>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.99470495@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 40/63] infiniband: fix a possible use-after-free bug
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

commit cb2595c1393b4a5211534e6f0a0fbad369e21ad8 upstream.

ucma_process_join() will free the new allocated "mc" struct,
if there is any error after that, especially the copy_to_user().

But in parallel, ucma_leave_multicast() could find this "mc"
through idr_find() before ucma_process_join() frees it, since it
is already published.

So "mc" could be used in ucma_leave_multicast() after it is been
allocated and freed in ucma_process_join(), since we don't refcnt
it.

Fix this by separating "publish" from ID allocation, so that we
can get an ID first and publish it later after copy_to_user().

Fixes: c8f6a362bf3e ("RDMA/cma: Add multicast communication support")
Reported-by: Noam Rathaus <noamr@beyondsecurity.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/core/ucma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -180,7 +180,7 @@ static struct ucma_multicast* ucma_alloc
 		return NULL;
 
 	mutex_lock(&mut);
-	mc->id = idr_alloc(&multicast_idr, mc, 0, 0, GFP_KERNEL);
+	mc->id = idr_alloc(&multicast_idr, NULL, 0, 0, GFP_KERNEL);
 	mutex_unlock(&mut);
 	if (mc->id < 0)
 		goto error;
@@ -1285,6 +1285,10 @@ static ssize_t ucma_process_join(struct
 		goto err3;
 	}
 
+	mutex_lock(&mut);
+	idr_replace(&multicast_idr, mc, mc->id);
+	mutex_unlock(&mut);
+
 	mutex_unlock(&file->mut);
 	ucma_put_ctx(ctx);
 	return 0;

