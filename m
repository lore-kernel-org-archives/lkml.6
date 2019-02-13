Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A630AC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7128820835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026644;
	bh=qXxg9THhxmvvWyZYCN+YubzoGd0xAxwKw4kK0abyqNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1syYVJ3c2snRWKPq3tQNCdR7DzTRui9NPBq6qyeIUY5lq9dLKhchedLqAvOYSrq4u
	 RrYbA6sDS0vcaPCrxNs4mKZcCU4bdC+kpdjKDfxD6ArqFM7UkQCvEFZPMZJAKg3ClU
	 ufXnomVJCg5ZoMV/tpKntuJgu9AajkBZ6OxEEdWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390142AbfBMC5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:57:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:40676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388234AbfBMChH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:37:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F9B5222C2;
        Wed, 13 Feb 2019 02:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025427;
        bh=qXxg9THhxmvvWyZYCN+YubzoGd0xAxwKw4kK0abyqNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EycEefSpWYCKgmzwP990kL7+OchthjhyWrjhSz5PLTuIPyFBWoJdWVodBg9WX/oKj
         9kFUU3zhJiU9gsmYcwtHRUdbIlFpl/Q2bRXHim4ovg+iOWhdiPvVG8GBWqN0wBBqtZ
         +1xUf2YEbXQ2hEjGPbxfQ7JeDp65wz31GnPkruL4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 04/83] pvcalls-front: don't try to free unallocated rings
Date:   Tue, 12 Feb 2019 21:35:42 -0500
Message-Id: <20190213023701.20286-4-sashal@kernel.org>
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

