Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5EDC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77410222CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025224;
	bh=qXxg9THhxmvvWyZYCN+YubzoGd0xAxwKw4kK0abyqNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EAb03FLn2CyDGo/FgdatA1sqBMES7yYF6Hu0URRQDWAy6fzB2mvQfYQAi45gwxhJv
	 fvJWzWXjN7B3+Acj19fxAdEE3QiCy8grIZgpCbzim6GUNVsfWm3PPKsuKnFByf+BI8
	 jkQO6RtG4Xy0dRtRXa4zc1jg/iTUPHa8T+39k6xU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387444AbfBMCdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:33:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:37206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731487AbfBMCdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:33:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98E26222CC;
        Wed, 13 Feb 2019 02:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025221;
        bh=qXxg9THhxmvvWyZYCN+YubzoGd0xAxwKw4kK0abyqNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KuuPAnvQ7XeTW99yR0fYIws2VTKFELF/bTufnqCKzalvMxS5OyfRH1vb3rZzNGwHr
         bP0ByQRzkV4w4dS6aanXM9S+FSNASVuOav4CDdMSB/nC1W5wxw3ZErYDqm9MJXsUYd
         0deyjOQA+i4rGjZxbyChCbx4GtdiocEtEjLVW+oM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 004/105] pvcalls-front: don't try to free unallocated rings
Date:   Tue, 12 Feb 2019 21:31:55 -0500
Message-Id: <20190213023336.19019-4-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Stabellini <sstabellini@kernel.org>

[ Upstream commit 96283f9a084e23d7cda2d3c5d1ffa6df6cf1ecec ]

inflight_req_id is 0 when initialized. If inflight_req_id is 0, there is
no accept_map to free. Fix the check in pvcalls_front_release.

Signed-off-by: Stefano Stabellini <stefanos@xilinx.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/pvcalls-front.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
index e5d95aab2cb8..4f3d664b3f39 100644
--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@ -1030,8 +1030,8 @@ int pvcalls_front_release(struct socket *sock)
 		spin_lock(&bedata->socket_lock);
 		list_del(&map->list);
 		spin_unlock(&bedata->socket_lock);
-		if (READ_ONCE(map->passive.inflight_req_id) !=
-		    PVCALLS_INVALID_ID) {
+		if (READ_ONCE(map->passive.inflight_req_id) != PVCALLS_INVALID_ID &&
+			READ_ONCE(map->passive.inflight_req_id) != 0) {
 			pvcalls_front_free_map(bedata,
 					       map->passive.accept_map);
 		}
-- 
2.19.1

