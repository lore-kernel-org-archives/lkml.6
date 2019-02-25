Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3118C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676AB2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131865;
	bh=wzPqD/qouKgsvJ6QXXX+Lld1tHE1XrVoRIOVDQNDf6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wH0DHvsF9D7oOGHEmizAg2WCKQ7MEIE1Q4Q4Ikv+osPSZX9SDueoqCeM+dM3t+UoY
	 8AbcXAO8osk3uoqgaj2ZWjVkUGX3QIoYrD7rEKWqoKhMnzBdRKw+IUE1GWALNhaNfx
	 Ijv9zS2RGSoDZAnM3dny9gzS3335rPceF656I578=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbfBYV5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:57:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:54608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfBYVVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:21:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE7A0205C9;
        Mon, 25 Feb 2019 21:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129661;
        bh=wzPqD/qouKgsvJ6QXXX+Lld1tHE1XrVoRIOVDQNDf6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vZ1VkBaCEqyz8jXq3DpaVeYWoy/M4pkitv9h+Dm0pWWbbazhO9RjOy897lGSwEj8E
         OzaNjZzofeIF44V38kazbLagopufigdGRKZavTPCAYXOP97I7Y5RLY6ZNioV5JygP7
         tBlaJGRs7QQjgGuW/dP5ulm4dhu5NMbcqZSMcGdI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefano Stabellini <stefanos@xilinx.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 020/152] pvcalls-front: properly allocate sk
Date:   Mon, 25 Feb 2019 22:10:12 +0100
Message-Id: <20190225195045.051616928@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit beee1fbe8f7d57d6ebaa5188f9f4db89c2077196 ]

Don't use kzalloc: it ends up leaving sk->sk_prot not properly
initialized. Use sk_alloc instead and define our own trivial struct
proto.

Signed-off-by: Stefano Stabellini <stefanos@xilinx.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/pvcalls-front.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
index 4f3d664b3f39e..01588582ae663 100644
--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@ -31,6 +31,12 @@
 #define PVCALLS_NR_RSP_PER_RING __CONST_RING_SIZE(xen_pvcalls, XEN_PAGE_SIZE)
 #define PVCALLS_FRONT_MAX_SPIN 5000
 
+static struct proto pvcalls_proto = {
+	.name	= "PVCalls",
+	.owner	= THIS_MODULE,
+	.obj_size = sizeof(struct sock),
+};
+
 struct pvcalls_bedata {
 	struct xen_pvcalls_front_ring ring;
 	grant_ref_t ref;
@@ -837,7 +843,7 @@ int pvcalls_front_accept(struct socket *sock, struct socket *newsock, int flags)
 
 received:
 	map2->sock = newsock;
-	newsock->sk = kzalloc(sizeof(*newsock->sk), GFP_KERNEL);
+	newsock->sk = sk_alloc(sock_net(sock->sk), PF_INET, GFP_KERNEL, &pvcalls_proto, false);
 	if (!newsock->sk) {
 		bedata->rsp[req_id].req_id = PVCALLS_INVALID_ID;
 		map->passive.inflight_req_id = PVCALLS_INVALID_ID;
-- 
2.19.1



