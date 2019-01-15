Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBC1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57BD20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570744;
	bh=Xc3tO199DYCbfHyAiJS5aB7ao/363biI37/MwB6zQfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dKavw5SjKY/TVmjvJ2VNX1PVQPzPzpCXiHMxftEjM22WO+AjpE9MQ78hGtMflbRec
	 sFUzh5/lkCAVM22/UAcE9NFrea3zZhogRalTFvOTHozuiJLbaxZBEs5k8fzANsWnA2
	 16WE4HJdVSciaFvzkZD6T40plYCKjbiedQOcbpzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387842AbfAOQpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:45:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:35362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731001AbfAOQpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:45:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DB5C20645;
        Tue, 15 Jan 2019 16:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570738;
        bh=Xc3tO199DYCbfHyAiJS5aB7ao/363biI37/MwB6zQfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e2B9t6oh6R82jJu6wMvj/4CYEEd4SOIQSK1FBwo3zbfJAMoECjKbCThUnhpapN3si
         CopaDA2qCvz4ohvz6Ak1q3uxjqnwWDTBf5UfHGEkv5BLBL3hhlVjxUNHFc4cAtOrc3
         f+dyx97oOIWvfwyvkmF5I496NsLyipvVMDCuR+AI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Dan Carpenter <dan.carpenter@oracle.com>, stable@kernel.org
Subject: [PATCH 4.20 52/57] ext4: fix special inode number checks in __ext4_iget()
Date:   Tue, 15 Jan 2019 17:36:33 +0100
Message-Id: <20190115154913.934973436@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154910.734892368@linuxfoundation.org>
References: <20190115154910.734892368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 191ce17876c9367819c4b0a25b503c0f6d9054d8 upstream.

The check for special (reserved) inode number checks in __ext4_iget()
was broken by commit 8a363970d1dc: ("ext4: avoid declaring fs
inconsistent due to invalid file handles").  This was caused by a
botched reversal of the sense of the flag now known as
EXT4_IGET_SPECIAL (when it was previously named EXT4_IGET_NORMAL).
Fix the logic appropriately.

Fixes: 8a363970d1dc ("ext4: avoid declaring fs inconsistent...")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4834,7 +4834,7 @@ struct inode *__ext4_iget(struct super_b
 	gid_t i_gid;
 	projid_t i_projid;
 
-	if (((flags & EXT4_IGET_NORMAL) &&
+	if ((!(flags & EXT4_IGET_SPECIAL) &&
 	     (ino < EXT4_FIRST_INO(sb) && ino != EXT4_ROOT_INO)) ||
 	    (ino < EXT4_ROOT_INO) ||
 	    (ino > le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count))) {


