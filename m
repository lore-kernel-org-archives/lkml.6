Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E10C46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 14:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315C221A05
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 14:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1uFMPHt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315C221A05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbeHLQlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 12:41:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbeHLQk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 12:40:59 -0400
Received: from localhost.localdomain (unknown [58.212.144.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4346E21A07;
        Sun, 12 Aug 2018 14:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534082570;
        bh=q086Zq6+Ih1KUcOJTEGNzohFlf+NSyFNy9wKdsNwqz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1uFMPHt4I/++R6cOtSWqmHq1W2W2FWVeYT4C8ydujiKfa0GdfvXJk1B7aJRi4ll4l
         WK5Ljgm+qyd0n1/EwYwfZ1ceO4xdFR6qFk8by/TDiox4CoNyL94/Yzv7T9bpDhfGvs
         R595mcRnwkGCyOfmqNDoHkEytO00MTQBuXX3zZWY=
From:   Chao Yu <chao@kernel.org>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 8/8] staging: erofs: fix compression mapping beyond EOF
Date:   Sun, 12 Aug 2018 22:01:50 +0800
Message-Id: <20180812140150.13397-9-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180812140150.13397-1-chao@kernel.org>
References: <20180812140150.13397-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

Logical address of EOF LTP mapping should start at
`inode->i_size' rather than `inode->i_size - 1' to
`m_la(in)', fix it.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 drivers/staging/erofs/unzip_vle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 6c5b0a312592..2f47498eb1fe 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -1548,7 +1548,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	if (unlikely(map->m_la >= inode->i_size)) {
 		BUG_ON(!initial);
 		map->m_llen = map->m_la + 1 - inode->i_size;
-		map->m_la = inode->i_size - 1;
+		map->m_la = inode->i_size;
 		map->m_flags = 0;
 		goto out;
 	}
-- 
2.18.0

