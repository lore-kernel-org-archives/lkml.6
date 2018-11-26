Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36303C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8DE20663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="X/0UUI72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8DE20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbeKZThf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:37:35 -0500
Received: from m12-14.163.com ([220.181.12.14]:53139 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbeKZThf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=mRUPHWAZbqOzpceLys
        nWh/u7NmcOm2I8CdBzUvVl9WY=; b=X/0UUI72BuOq7LA1cQ3Y/o0hqo4y5gN/vB
        WC6LWpb7EMucZyuUrlo2mDQAiksXWQMl01KNltHxHNjz0UzHfwfEht9piMdsqa+c
        /pV/rYcXeYedf5zGEWIRG3wxH6vW7zZ3LrpJFiSLiuQEDaFDi1sepo7Z4AFeZp27
        53HAtLitA=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp10 (Coremail) with SMTP id DsCowADX6QwysvtbCavNBw--.55256S3;
        Mon, 26 Nov 2018 16:43:32 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Subject: [PATCH] gfs2: get rid of potential double free
Date:   Mon, 26 Nov 2018 16:43:29 +0800
Message-Id: <1543221809-86560-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DsCowADX6QwysvtbCavNBw--.55256S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF1xZw1xWr1rCF1kAw43Wrg_yoWkWFc_AF
        4DKwn5u34UW3WkXa9xuw45trs3ArWDW3W8CrW8tFy3ArW8K3srGr1DWwn5Cr15ZF47ZrZ5
        trykXFyjkr1SgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnFeHDUUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiVAkLclUMGKWupAAAsK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__gfs2_set_acl will not increase the reference count of acl if it fails.
In this case, posix_acl_release are called twice, one after
__gfs2_set_acl and one in the error handling block. This patch does not
release acl when __gfs2_set_acl fails.

Fixes: e01580bf9e4("gfs2: use generic posix ACL infrastructure")
Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 fs/gfs2/inode.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 648f0ca..3a9041c 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -744,12 +744,13 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 			       the gfs2 structures. */
 	if (default_acl) {
 		error = __gfs2_set_acl(inode, default_acl, ACL_TYPE_DEFAULT);
-		posix_acl_release(default_acl);
+		if (!error)
+			posix_acl_release(default_acl);
 	}
-	if (acl) {
+	if (acl && !error) {
+		error = __gfs2_set_acl(inode, acl, ACL_TYPE_ACCESS);
 		if (!error)
-			error = __gfs2_set_acl(inode, acl, ACL_TYPE_ACCESS);
-		posix_acl_release(acl);
+			posix_acl_release(acl);
 	}
 
 	if (error)
-- 
2.7.4


