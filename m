Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46889ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B4A20C0B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B4A20C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbeGQJed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:34:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40349 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbeGQJed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:34:33 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1ffLsm-0001Uh-Su; Tue, 17 Jul 2018 09:02:56 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] statfs: remove redundant pointer sb
Date:   Tue, 17 Jul 2018 10:02:56 +0100
Message-Id: <20180717090256.18162-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer sb is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'sb' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/statfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/statfs.c b/fs/statfs.c
index 3b8e27003754..82384616e524 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -402,7 +402,6 @@ COMPAT_SYSCALL_DEFINE2(ustat, unsigned, dev, struct compat_ustat __user *, u)
 static int fsinfo_generic_statfs(struct dentry *dentry,
 				 struct fsinfo_statfs *p)
 {
-	struct super_block *sb;
 	struct kstatfs buf;
 	int ret;
 
@@ -410,7 +409,6 @@ static int fsinfo_generic_statfs(struct dentry *dentry,
 	if (ret < 0)
 		return ret;
 
-	sb = dentry->d_sb;
 	p->f_blocks	= buf.f_blocks;
 	p->f_bfree	= buf.f_bfree;
 	p->f_bavail	= buf.f_bavail;
-- 
2.17.1

