Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AECC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939B5213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I35qwmMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939B5213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389605AbeK3BiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:38:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:41908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389583AbeK3BiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:38:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 624B92145D;
        Thu, 29 Nov 2018 14:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501969;
        bh=GfLQ1z4738EbdXHKsR7q/bIEHz6PBOJ1dNh9nmk4btI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I35qwmMw8tRHg7vZFoP1z9k1AzetYgU1bx+qNOTbvxc7O2qmSUUtkFl41TFug8tmj
         uJaONJ4mURuIi8OE8ZZL/iDKk2AX7w2cjBhGKDCljKYo310rMoGIc+3OHAlSkESf2z
         Igz8yVUEK/iC7Wht2OsATjM7c4OXBCtYViwyINkQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yufen Yu <yuyufen@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 097/110] tmpfs: make lseek(SEEK_DATA/SEK_HOLE) return ENXIO with a negative offset
Date:   Thu, 29 Nov 2018 15:13:08 +0100
Message-Id: <20181129135925.167058504@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 446942677cd4..38d228a30fdc 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2610,9 +2610,7 @@ static loff_t shmem_file_llseek(struct file *file, loff_t offset, int whence)
 	inode_lock(inode);
 	/* We're holding i_mutex so we can access i_size directly */
 
-	if (offset < 0)
-		offset = -EINVAL;
-	else if (offset >= inode->i_size)
+	if (offset < 0 || offset >= inode->i_size)
 		offset = -ENXIO;
 	else {
 		start = offset >> PAGE_SHIFT;
-- 
2.17.1



