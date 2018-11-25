Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCFCC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 01:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805A42087E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 01:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ivV162Ba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 805A42087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbeKYMRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 07:17:49 -0500
Received: from m12-16.163.com ([220.181.12.16]:60602 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbeKYMRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 07:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=3zDafuTT6xnzkxZqfQ
        ZEO5Z4PSwIWXdNevZ7cyb3zdo=; b=ivV162Ba+P+k2VpNihTA7fLnLHym/soRaz
        bNFPqlNWxnIOlUcaOjO4UcL++CUESp1JOPVNKlHBaNG3ufsjgi1ZLv8+glIJ1HRX
        xTDuVrTMR6jAP+typCIqTtWY9Sp1/hby94NCJIuEGxubL1r7WGuC2FzcBIPd85jW
        tP2x0a5c0=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp12 (Coremail) with SMTP id EMCowABXakd0+vlb_XDLBg--.4563S3;
        Sun, 25 Nov 2018 09:27:18 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Tao Ma <boyu.mt@taobao.com>, Pan Bian <bianpan2016@163.com>
Subject: [PATCH] ocfs2: fix potential use after free
Date:   Sun, 25 Nov 2018 09:27:17 +0800
Message-Id: <1543109237-110227-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EMCowABXakd0+vlb_XDLBg--.4563S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrWkCr48Cr1Dtw17Wr1rWFg_yoWDGrbEkr
        4Utan2kw45Zrn7WFs8W3ySqFsa93WvgFn7GF1xKrn8K34jvFykXrn5XwnYvr97Wr13uF98
        Zw4kXFyDtw1a9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnbVy7UUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiQAwKclSIYSbodgAAsx
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function ocfs2_get_dentry calls iput(inode) to drop the reference
count of inode, and if the reference count hits 0, inode is freed.
However, in this function, it then reads inode->i_generation, which may
result in a use after free bug. This patch moves the put operation
later.

Fixes: 781f200cb7a("ocfs2: Remove masklog ML_EXPORT.")
Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 fs/ocfs2/export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/export.c b/fs/ocfs2/export.c
index 9f88188..4bf8d58 100644
--- a/fs/ocfs2/export.c
+++ b/fs/ocfs2/export.c
@@ -125,10 +125,10 @@ static struct dentry *ocfs2_get_dentry(struct super_block *sb,
 
 check_gen:
 	if (handle->ih_generation != inode->i_generation) {
-		iput(inode);
 		trace_ocfs2_get_dentry_generation((unsigned long long)blkno,
 						  handle->ih_generation,
 						  inode->i_generation);
+		iput(inode);
 		result = ERR_PTR(-ESTALE);
 		goto bail;
 	}
-- 
2.7.4


