Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B92ECDE46
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB632086D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAIM/GE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB632086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbeKDXHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:07:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:45372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730371AbeKDXHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:07:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD3CA20866;
        Sun,  4 Nov 2018 13:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339547;
        bh=ERrdJIY3Hv/YplvsUGg5dBzgxEgd/4BGGiF4IAuFQ5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CAIM/GE8h0GfLany7vK1ZoCA4mbtJ8eGpRQIyQv7WYXYsV4ShXFrZMO6BYvv+eCtM
         NB8Et9qOVSADT4v1jZ/Nop73bFk2qg/fTLK9Q+qQVq+UUi+qzmoHbTbNOFZSuPERZL
         4Qt94DI6LIvLCI2msrlX9OKaemybcCHlS/ytpNls=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 42/57] staging: erofs: fix a missing endian conversion
Date:   Sun,  4 Nov 2018 08:51:29 -0500
Message-Id: <20181104135144.88324-42-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135144.88324-1-sashal@kernel.org>
References: <20181104135144.88324-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

[ Upstream commit 37ec35a6cc2b99eb7fd6b85b7d7b75dff46bc353 ]

This patch fixes a missing endian conversion in
vle_get_logical_extent_head.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/erofs/unzip_vle.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 8721f0a41d15..14da8cc2246a 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -1490,6 +1490,7 @@ static erofs_off_t vle_get_logical_extent_head(
 	unsigned long long ofs;
 	const unsigned int clusterbits = EROFS_SB(inode->i_sb)->clusterbits;
 	const unsigned int clustersize = 1 << clusterbits;
+	unsigned int delta0;
 
 	if (page->index != blkaddr) {
 		kunmap_atomic(*kaddr_iter);
@@ -1504,12 +1505,13 @@ static erofs_off_t vle_get_logical_extent_head(
 	di = *kaddr_iter + vle_extent_blkoff(inode, lcn);
 	switch (vle_cluster_type(di)) {
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
-		BUG_ON(!di->di_u.delta[0]);
-		BUG_ON(lcn < di->di_u.delta[0]);
+		delta0 = le16_to_cpu(di->di_u.delta[0]);
+		DBG_BUGON(!delta0);
+		DBG_BUGON(lcn < delta0);
 
 		ofs = vle_get_logical_extent_head(inode,
 			page_iter, kaddr_iter,
-			lcn - di->di_u.delta[0], pcn, flags);
+			lcn - delta0, pcn, flags);
 		break;
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
 		*flags ^= EROFS_MAP_ZIPPED;
-- 
2.17.1

