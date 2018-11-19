Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B4BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9C9208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="grI65C+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB9C9208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390388AbeKTDP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:15:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:53692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389340AbeKTDP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:15:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6339A206BA;
        Mon, 19 Nov 2018 16:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646302;
        bh=E+Ppxt9YtQUslAYyMQvVIII0ogbBR5fotFZ7Eq8RxPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=grI65C+mpC76UL0h2we5nIpAQ6UoMJDd+dW2N5yTy6THcK6hZ5LVTuns25tRqsByd
         WHYDO4T+OKMDKpqMGmgZaAaTRhL0QzPfuoKEd/+5Waupx27LkD/9O3bOVlw1b2rtqT
         RJBYW9O1aLl+ffSp61jEfR3Sx60e4t3pExsmlAKE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 4.14 077/124] ext4: missing !bh check in ext4_xattr_inode_write()
Date:   Mon, 19 Nov 2018 17:28:51 +0100
Message-Id: <20181119162627.865562951@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@virtuozzo.com>

commit eb6984fa4ce2837dcb1f66720a600f31b0bb3739 upstream.

According to Ted Ts'o ext4_getblk() called in ext4_xattr_inode_write()
should not return bh = NULL

The only time that bh could be NULL, then, would be in the case of
something really going wrong; a programming error elsewhere (perhaps a
wild pointer dereference) or I/O error causing on-disk file system
corruption (although that would be highly unlikely given that we had
*just* allocated the blocks and so the metadata blocks in question
probably would still be in the cache).

Fixes: e50e5129f384 ("ext4: xattr-in-inode support")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org # 4.13
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/xattr.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1387,6 +1387,12 @@ retry:
 		bh = ext4_getblk(handle, ea_inode, block, 0);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
+		if (!bh) {
+			WARN_ON_ONCE(1);
+			EXT4_ERROR_INODE(ea_inode,
+					 "ext4_getblk() return bh = NULL");
+			return -EFSCORRUPTED;
+		}
 		ret = ext4_journal_get_write_access(handle, bh);
 		if (ret)
 			goto out;


