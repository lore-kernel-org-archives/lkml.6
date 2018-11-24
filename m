Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBADC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 09:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2644120874
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 09:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YH1V9J4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2644120874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbeKXUe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 15:34:26 -0500
Received: from m12-16.163.com ([220.181.12.16]:57191 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbeKXUe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 15:34:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=7cISUyBLpwoif6qmk8
        OegIZqzP9o3YE8YT9b7KIr0nQ=; b=YH1V9J4oJYWJtcEG9HvIAleze1ReIGVOlM
        IxkxsD4fk2pRo5X5kkQsPOGSH9vlAFF76r+Evmlw4LGfax5s3Y0is3VX2otppjkk
        nU537SzCCDJk2tEbCxQa6NWM8WR3cFaFXptOPAhw5C5HIZdaW1n3fUYsF4WqyYFK
        CoK1S8xco=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp12 (Coremail) with SMTP id EMCowAC3yFNzHflbe0hlBg--.22306S3;
        Sat, 24 Nov 2018 17:44:23 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Subject: [PATCH] xfs: libxfs: move xfs_perag_put late
Date:   Sat, 24 Nov 2018 17:44:20 +0800
Message-Id: <1543052660-58625-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EMCowAC3yFNzHflbe0hlBg--.22306S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFyrZF4UXFyrur43Kw45Jrb_yoWDCFX_Ka
        18KFs7A34ktrW7K3W5X395t3WUtF4fG393WayfJFW3K34UGFn3ZwsrXrn0qF13urWaqFZ8
        G3yDGFW3KryYvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU89Xo7UUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function xfs_alloc_get_freelist calls xfs_perag_put to drop the
reference. In this case, pag may be released. However,
pag->pagf_btreeblks is read and write after the put operation. This may
result in a use-after-free bug. This patch moves the put operation late.

Signed-off-by: Pan Bian <bianpan2016@163.com>
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


