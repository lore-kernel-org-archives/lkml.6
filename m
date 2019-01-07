Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF58C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EF220859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864748;
	bh=F3SBEAkPlgMToHQt0dFg4pAwKDctQyQOkHOQ1Ng4sek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hkRn+kQ2ex86pOkt0KMKQlZipe67g62Dj8IoVsR/mYj0hvVD8Aa1k3RnrrsW5Txjm
	 +1rp2oLXnOwN5z+/LFSDxWqUF2Kf20OtVj0tzTzQNBxjUPK+gMmkYsSDUeE+sMluLT
	 weYPCsJvNONAUicgkOctozwvUbbg4btNjAHBUFZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfAGMjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:39:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:54226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbfAGMjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:39:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9498C20859;
        Mon,  7 Jan 2019 12:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864744;
        bh=F3SBEAkPlgMToHQt0dFg4pAwKDctQyQOkHOQ1Ng4sek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=exoLL/v+ZJw8CBvEkT1urr0Isl1eIpMJjSB+i1QYLBmN+ldsAC30atG/gDeCzk5GF
         2XcVoEek1RAs1+5mnw5ZjlSLI1Z8e14s3B9qoaTtWpXqdr2Oi6HubIQb1zErGKdbsK
         1O5XRb60+yKYnK5/sdsD2i74PVxnD50Uxo+IpWh0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Graham <stgraham2000@gmail.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 4.20 076/145] ext4: include terminating u32 in size of xattr entries when expanding inodes
Date:   Mon,  7 Jan 2019 13:31:53 +0100
Message-Id: <20190107104447.218124725@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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
@@ -2721,7 +2721,7 @@ retry:
 	base = IFIRST(header);
 	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
 	min_offs = end - base;
-	total_ino = sizeof(struct ext4_xattr_ibody_header);
+	total_ino = sizeof(struct ext4_xattr_ibody_header) + sizeof(u32);
 
 	error = xattr_check_inode(inode, header, end);
 	if (error)


