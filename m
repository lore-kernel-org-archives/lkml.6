Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931F6C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5974920835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026618;
	bh=OCLElpAJRbiN/Ciz6RLEptCZiZ74HCFYGyR9z62sgRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m0rsxbbYEzCbY2DNulUuuBhbeioqYUwAnODVGxb5OfK9+tCvbVxLSR+jNYpbgB8hH
	 LPsfzwJnatpnGL+fbrhoe9PXV6c3ioaokyWWwi6xiZZIrknbsOun4CTvoQ6GBp7iGn
	 6jaQvjiXaBgSsBKVIrxIZt3LZEA77u8RUtRIDmfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388247AbfBMChM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:37:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732343AbfBMChJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:37:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD5EF222C9;
        Wed, 13 Feb 2019 02:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025428;
        bh=OCLElpAJRbiN/Ciz6RLEptCZiZ74HCFYGyR9z62sgRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BKn4sEG8+O1QsMkxiellxsmSymvD+95CfARf9xO08o0gF4jZceI9NIapPajjqZzgT
         yPeajomCpZc1uA1x9fc5luST0ccc7vpwRtf1T+iy0f1cNA3ygsOKiA4eG2XVGR/TgD
         LXAxfz4LVPVSuorD8DC3Tdg4ymaOIKUwP+fscM7o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 05/83] pvcalls-front: properly allocate sk
Date:   Tue, 12 Feb 2019 21:35:43 -0500
Message-Id: <20190213023701.20286-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Stabellini <sstabellini@kernel.org>

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
index 4f3d664b3f39..01588582ae66 100644
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

