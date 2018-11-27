Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14C5C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E2121104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Kwhz7LTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E2121104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeK0LbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:31:21 -0500
Received: from m12-15.163.com ([220.181.12.15]:56401 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727456AbeK0LbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 06:31:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=pILGacqwFxE2s3edWv
        IJ1QuH9Lszzm0YDswJvUE2GJU=; b=Kwhz7LTVZBqCUr45+aj3qq9mjc/tBjGMxG
        moZ2GCHsAhfFrsUNuB3BhPV4/M1tGJdqpK74q0yysfOKOUvTZoc19rJCvYRrorh2
        krpravBR604mLwQ9GKjgP8tTMdKqPH9Q8vR6XW0VJhagssYRdg5jxVg/74OmXdTj
        8LbWMfV+I=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp11 (Coremail) with SMTP id D8CowADX6DHikPxbqYR1AA--.4456S3;
        Tue, 27 Nov 2018 08:33:40 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-xfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Subject: [PATCH V2] xfs: libxfs: move xfs_perag_put late
Date:   Tue, 27 Nov 2018 08:33:38 +0800
Message-Id: <1543278818-117362-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: D8CowADX6DHikPxbqYR1AA--.4456S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFy7JF1rKw4kZF1UXF1UZFb_yoWDXrb_Ka
        1xtFs7A34ktrW7J3W5Xws5t3WUtF4fG393uayfJFW3K34UGFn3ZwsrXrn0qFy3urWaqFZ8
        W3yDGFW3Krya9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8RuWJUUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBZBwMclQHCrrVeAAAsI
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function xfs_alloc_get_freelist calls xfs_perag_put to drop the
reference. However, pag->pagf_btreeblks is read and write after the 
put operation. This patch moves the put operation late.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
V2: correct the commit log
---
 fs/xfs/libxfs/xfs_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index e1c0c0d..4be387d 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -2435,7 +2435,6 @@ xfs_alloc_get_freelist(
 	be32_add_cpu(&agf->agf_flcount, -1);
 	xfs_trans_agflist_delta(tp, -1);
 	pag->pagf_flcount--;
-	xfs_perag_put(pag);
 
 	logflags = XFS_AGF_FLFIRST | XFS_AGF_FLCOUNT;
 	if (btreeblk) {
@@ -2443,6 +2442,7 @@ xfs_alloc_get_freelist(
 		pag->pagf_btreeblks++;
 		logflags |= XFS_AGF_BTREEBLKS;
 	}
+	xfs_perag_put(pag);
 
 	xfs_alloc_log_agf(tp, agbp, logflags);
 	*bnop = bno;
-- 
2.7.4


