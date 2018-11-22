Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4A6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DDF20892
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0WxCSeg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DDF20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407478AbeKWGjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:39:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392612AbeKWGjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:39:11 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64434208A3;
        Thu, 22 Nov 2018 19:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542916698;
        bh=LBzIsxv/TdLbjLR1viyix92nnccRuCBOZ/Kh1O2mteU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F0WxCSeg8wIXNOaS/XXixB9T20/5e+eBdJ7dC4y95Q0EIPf1ZJxAQ9jdTM0wG2vO6
         wV7DW90hVdmLUza9CTtAdS5ldTm5KcCqnga1rjKDsqjo83mIkgIThxSN5+ihFA0P3l
         HGhSPbuo8jKghVo0l2ZynSWJZ4Dupyo5EixWBWas=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yufen Yu <yuyufen@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 3.18 7/7] tmpfs: make lseek(SEEK_DATA/SEK_HOLE) return ENXIO with a negative offset
Date:   Thu, 22 Nov 2018 14:57:49 -0500
Message-Id: <20181122195749.14086-7-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122195749.14086-1-sashal@kernel.org>
References: <20181122195749.14086-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yufen Yu <yuyufen@huawei.com>

[ Upstream commit 1a413646931cb14442065cfc17561e50f5b5bb44 ]

Other filesystems such as ext4, f2fs and ubifs all return ENXIO when
lseek (SEEK_DATA or SEEK_HOLE) requests a negative offset.

man 2 lseek says

:      EINVAL whence  is  not  valid.   Or: the resulting file offset would be
:             negative, or beyond the end of a seekable device.
:
:      ENXIO  whence is SEEK_DATA or SEEK_HOLE, and the file offset is  beyond
:             the end of the file.

Make tmpfs return ENXIO under these circumstances as well.  After this,
tmpfs also passes xfstests's generic/448.

[akpm@linux-foundation.org: rewrite changelog]
Link: http://lkml.kernel.org/r/1540434176-14349-1-git-send-email-yuyufen@huawei.com
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Hugh Dickins <hughd@google.com>
Cc: William Kucharski <william.kucharski@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/shmem.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 371d5eca80ed..64c33e3dbe69 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1805,9 +1805,7 @@ static loff_t shmem_file_llseek(struct file *file, loff_t offset, int whence)
 	mutex_lock(&inode->i_mutex);
 	/* We're holding i_mutex so we can access i_size directly */
 
-	if (offset < 0)
-		offset = -EINVAL;
-	else if (offset >= inode->i_size)
+	if (offset < 0 || offset >= inode->i_size)
 		offset = -ENXIO;
 	else {
 		start = offset >> PAGE_CACHE_SHIFT;
-- 
2.17.1

