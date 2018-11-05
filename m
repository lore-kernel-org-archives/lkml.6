Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5830AC46465
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A342081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A342081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbeKFIXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:23:15 -0500
Received: from anholt.net ([50.246.234.109]:35728 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725726AbeKFIXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:23:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 003D110A1311;
        Mon,  5 Nov 2018 15:01:12 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id zf4MfrVUhDWI; Mon,  5 Nov 2018 15:01:10 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id C39AE10A028B;
        Mon,  5 Nov 2018 15:01:10 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 58AAA2FE1B8F; Mon,  5 Nov 2018 15:01:10 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Chunming Zhou <david1.zhou@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/syncobj: Fix oops on drm_syncobj_find_fence(file_priv, 0, ...).
Date:   Mon,  5 Nov 2018 15:01:10 -0800
Message-Id: <20181105230110.4812-1-eric@anholt.net>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This broke rendering on V3D, where we almost always have a 0
in-syncobj.

Signed-off-by: Eric Anholt <eric@anholt.net>
Fixes: 48197bc564c7 ("drm: add syncobj timeline support v9")
Cc: Chunming Zhou <david1.zhou@amd.com>
Cc: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/drm_syncobj.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 4dca5f7e8c4b..da8175d9c6ff 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -443,7 +443,8 @@ int drm_syncobj_find_fence(struct drm_file *file_private,
 	int ret;
 
 	ret = drm_syncobj_search_fence(syncobj, point, flags, fence);
-	drm_syncobj_put(syncobj);
+	if (syncobj)
+		drm_syncobj_put(syncobj);
 	return ret;
 }
 EXPORT_SYMBOL(drm_syncobj_find_fence);
-- 
2.19.1

