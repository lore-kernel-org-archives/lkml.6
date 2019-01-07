Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AA6C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB1F217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866498;
	bh=yQsP6D9eSNhsSXu8JtO7Z9/J9ZFq+f8FMR8HkpVADPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xqJ3OinEQr+/JjGKWsDesgPIfOQgswC4IEF8vbPOTY9OcE+2Xyz+rdHAkn6Ic72cj
	 xaBZM7XtH+s0Gl+ojm+0ogGTvZO6Iwafi9qB4qKvZdZMEBSL73/v2bOuUpeNi5yJML
	 abTnR1E3UX+fIMYM6dsAP4SfyuknZpVDG3ZF0IYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbfAGNIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:08:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730855AbfAGNIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:08:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E1002147C;
        Mon,  7 Jan 2019 13:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866492;
        bh=yQsP6D9eSNhsSXu8JtO7Z9/J9ZFq+f8FMR8HkpVADPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iMm62ejGmaFZrqVhEOa6QwUZqdPmhgrUq7yi5GCIZK2j5wOKipacU7atC5vsUJhm8
         A8R9f9LyDACcdOHqCWP+chZ76Yj31gjCWiWB+vOo/wmpooF0ZFBRLNEObdxvj4pvYd
         5sZDemgIMQEmHvUZ359EbU7KCjkdkqSANmwvLkG4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Graham <stgraham2000@gmail.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 4.9 49/71] ext4: include terminating u32 in size of xattr entries when expanding inodes
Date:   Mon,  7 Jan 2019 13:33:18 +0100
Message-Id: <20190107105335.546078808@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
References: <20190107105330.280153213@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit a805622a757b6d7f65def4141d29317d8e37b8a1 upstream.

In ext4_expand_extra_isize_ea(), we calculate the total size of the
xattr header, plus the xattr entries so we know how much of the
beginning part of the xattrs to move when expanding the inode extra
size.  We need to include the terminating u32 at the end of the xattr
entries, or else if there is uninitialized, non-zero bytes after the
xattr entries and before the xattr values, the list of xattr entries
won't be properly terminated.

Reported-by: Steve Graham <stgraham2000@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/xattr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1499,7 +1499,7 @@ retry:
 	base = IFIRST(header);
 	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
 	min_offs = end - base;
-	total_ino = sizeof(struct ext4_xattr_ibody_header);
+	total_ino = sizeof(struct ext4_xattr_ibody_header) + sizeof(u32);
 
 	error = xattr_check_inode(inode, header, end);
 	if (error)


