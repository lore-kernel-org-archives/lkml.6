Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AF0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9802184D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130252;
	bh=Im+rznp5VYFhzQMOBJZEW2lR5UivlFCfbBvwtQ7uHUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0rwhiAbJqZdCQ2aHHzlPsddBS3iuGbKqaGllPWAy5UrbTbSd6rK4jtQsdB8ZeMSPB
	 dEUnT/sBqQNFYdkuW32xf1Eu4E1R9lgThaJlYJuIYumN7Z4rM5hWwWCLSSWvK2tw+t
	 pxNl2BCteSlsk/313nXmFjU1afAsxlwXCfFZmmXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732202AbfBYVau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:30:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:36392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732194AbfBYVar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:30:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EE0121841;
        Mon, 25 Feb 2019 21:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130246;
        bh=Im+rznp5VYFhzQMOBJZEW2lR5UivlFCfbBvwtQ7uHUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bwxwTiiSMAN/wR29R61nyByvW22yCmUVAbErQymlW4481kE/rizdKa5U92Gml3kVc
         giYXdSTpVk4mKQ1exuCNSqqQl6HaM/1qaQpf4+avK54hrbVEGtDMVwcqmtKBs3ao48
         kPIpRpbxTmuAtHGOQ2ZNuFJl8Vv99mUrlOidYzVY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefano Stabellini <stefanos@xilinx.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 022/183] pvcalls-front: dont try to free unallocated rings
Date:   Mon, 25 Feb 2019 22:09:55 +0100
Message-Id: <20190225195058.452068284@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index e5d95aab2cb80..4f3d664b3f39e 100644
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



