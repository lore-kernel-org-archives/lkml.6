Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707CCC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1DD20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1DD20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732561AbeHATrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:47:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49804 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405895AbeHATIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:38 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 90CA21372;
        Wed,  1 Aug 2018 17:13:49 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Noam Rathaus <noamr@beyondsecurity.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 045/246] infiniband: fix a possible use-after-free bug
Date:   Wed,  1 Aug 2018 18:49:15 +0200
Message-Id: <20180801165013.869196673@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit cb2595c1393b4a5211534e6f0a0fbad369e21ad8 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/ucma.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -218,7 +218,7 @@ static struct ucma_multicast* ucma_alloc
 		return NULL;
 
 	mutex_lock(&mut);
-	mc->id = idr_alloc(&multicast_idr, mc, 0, 0, GFP_KERNEL);
+	mc->id = idr_alloc(&multicast_idr, NULL, 0, 0, GFP_KERNEL);
 	mutex_unlock(&mut);
 	if (mc->id < 0)
 		goto error;
@@ -1404,6 +1404,10 @@ static ssize_t ucma_process_join(struct
 		goto err3;
 	}
 
+	mutex_lock(&mut);
+	idr_replace(&multicast_idr, mc, mc->id);
+	mutex_unlock(&mut);
+
 	mutex_unlock(&file->mut);
 	ucma_put_ctx(ctx);
 	return 0;


