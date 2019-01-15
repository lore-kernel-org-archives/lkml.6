Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478A6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F0720645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570613;
	bh=nCgdScAdDbWYzXlDo8sIpkBpb6q1MwMAzrPom4O2RWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dC/ZSx30xmwhNrvG//aJrAFJLJeCDAS1Js70kB8dkPc4w8dRxSJAG1N2zGow7/YEI
	 ev1CIuS6h3xZOwEm296waw3f8ALjFT4iaZc7B8/T3yYRB9z9CoBnvMe4ns16hQtrCV
	 ZgytkT8K1FwrymmVnJd8GwNbAb4LOkV9dFZVFqnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733262AbfAOQnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:43:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:32964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733247AbfAOQn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:43:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5C9E2054F;
        Tue, 15 Jan 2019 16:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570607;
        bh=nCgdScAdDbWYzXlDo8sIpkBpb6q1MwMAzrPom4O2RWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EEehAGjo7ablwLm8CUAFZnyjAo9bnlB2mx5xSUyi9Io50W5djEo/jiq0R8YAnGY0H
         JPBrPF9vcTGPKt3E8aFO2sxKg8IC6UqLSr5QsqWxBhkw3/PSv4emn5kPUY2FjpvIUC
         qMTSH4SBe+dp3uagylbwQ6Jmz/ixgfIVJJdEins0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Dan Carpenter <dan.carpenter@oracle.com>, stable@kernel.org
Subject: [PATCH 4.19 43/50] ext4: fix special inode number checks in __ext4_iget()
Date:   Tue, 15 Jan 2019 17:36:19 +0100
Message-Id: <20190115154912.377329877@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154909.933241945@linuxfoundation.org>
References: <20190115154909.933241945@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4803,7 +4803,7 @@ struct inode *__ext4_iget(struct super_b
 	gid_t i_gid;
 	projid_t i_projid;
 
-	if (((flags & EXT4_IGET_NORMAL) &&
+	if ((!(flags & EXT4_IGET_SPECIAL) &&
 	     (ino < EXT4_FIRST_INO(sb) && ino != EXT4_ROOT_INO)) ||
 	    (ino < EXT4_ROOT_INO) ||
 	    (ino > le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count))) {


