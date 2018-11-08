Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3935EECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0140F208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcUeLCh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0140F208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbeKIHlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:41:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:33216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727584AbeKIHle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:41:34 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75B8920844;
        Thu,  8 Nov 2018 22:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714644;
        bh=ZvQBjl0T3+f+5GtWE7yOt2+GkJxOTHuS93vaqnX1/i4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dcUeLCh+F/tEzBDhaJsGFyjDNB+cLFM9NzKBKB03yK6MAa8BunnvEfmvCQsXlHbH1
         GvCBAMcL3GlhHiQ22A3uCxBG2LQm2V7N6mDOG9BN5hk/t8mvDX7Yig5b3FczLgxYjB
         /uf1DmrqxQV01bU9V8MQi5XwBf2OwVfyN19Lomys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sheng Yong <shengyong1@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 037/171] f2fs: fix multiple f2fs_add_link() having same name for inline dentry
Date:   Thu,  8 Nov 2018 13:50:07 -0800
Message-Id: <20181108215130.082195933@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d3bb910c15d75ee3340311c64a1c05985bb663a3 ]

Commit 88c5c13a5027 (f2fs: fix multiple f2fs_add_link() calls having
same name) does not cover the scenario where inline dentry is enabled.
In that case, F2FS_I(dir)->task will be NULL, and __f2fs_add_link will
lookup dentries one more time.

This patch fixes it by moving the assigment of current task to a upper
level to cover both normal and inline dentry.

Cc: <stable@vger.kernel.org>
Fixes: 88c5c13a5027 (f2fs: fix multiple f2fs_add_link() calls having same name)
Signed-off-by: Sheng Yong <shengyong1@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/dir.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 8add4e8bab99..af719d93507e 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -212,13 +212,9 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 		f2fs_put_page(dentry_page, 0);
 	}
 
-	/* This is to increase the speed of f2fs_create */
-	if (!de && room) {
-		F2FS_I(dir)->task = current;
-		if (F2FS_I(dir)->chash != namehash) {
-			F2FS_I(dir)->chash = namehash;
-			F2FS_I(dir)->clevel = level;
-		}
+	if (!de && room && F2FS_I(dir)->chash != namehash) {
+		F2FS_I(dir)->chash = namehash;
+		F2FS_I(dir)->clevel = level;
 	}
 
 	return de;
@@ -259,6 +255,9 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 			break;
 	}
 out:
+	/* This is to increase the speed of f2fs_create */
+	if (!de)
+		F2FS_I(dir)->task = current;
 	return de;
 }
 
-- 
2.17.1



