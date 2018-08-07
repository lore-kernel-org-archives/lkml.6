Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EB7C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454D52170A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454D52170A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403889AbeHGVIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:08:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33092 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeHGVIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:08:35 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4E80CD01;
        Tue,  7 Aug 2018 18:52:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Massey <bart.massey@gmail.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.17 06/18] jfs: Fix usercopy whitelist for inline inode data
Date:   Tue,  7 Aug 2018 20:51:09 +0200
Message-Id: <20180807172313.194184605@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172312.964272530@linuxfoundation.org>
References: <20180807172312.964272530@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 961b33c244e5ba1543ae26270a1ba29f29c2db83 upstream.

Bart Massey reported what turned out to be a usercopy whitelist false
positive in JFS when symlink contents exceeded 128 bytes. The inline
inode data (i_inline) is actually designed to overflow into the "extended
area" following it (i_inline_ea) when needed. So the whitelist needed to
be expanded to include both i_inline and i_inline_ea (the whole size
of which is calculated internally using IDATASIZE, 256, instead of
sizeof(i_inline), 128).

$ cd /mnt/jfs
$ touch $(perl -e 'print "B" x 250')
$ ln -s B* b
$ ls -l >/dev/null

[  249.436410] Bad or missing usercopy whitelist? Kernel memory exposure attempt detected from SLUB object 'jfs_ip' (offset 616, size 250)!

Reported-by: Bart Massey <bart.massey@gmail.com>
Fixes: 8d2704d382a9 ("jfs: Define usercopy region in jfs_ip slab cache")
Cc: Dave Kleikamp <shaggy@kernel.org>
Cc: jfs-discussion@lists.sourceforge.net
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/jfs/jfs_dinode.h |    7 +++++++
 fs/jfs/jfs_incore.h |    1 +
 fs/jfs/super.c      |    3 +--
 3 files changed, 9 insertions(+), 2 deletions(-)

--- a/fs/jfs/jfs_dinode.h
+++ b/fs/jfs/jfs_dinode.h
@@ -115,6 +115,13 @@ struct dinode {
 					dxd_t _dxd;	/* 16: */
 					union {
 						__le32 _rdev;	/* 4: */
+						/*
+						 * The fast symlink area
+						 * is expected to overflow
+						 * into _inlineea when
+						 * needed (which will clear
+						 * INLINEEA).
+						 */
 						u8 _fastsymlink[128];
 					} _u;
 					u8 _inlineea[128];
--- a/fs/jfs/jfs_incore.h
+++ b/fs/jfs/jfs_incore.h
@@ -87,6 +87,7 @@ struct jfs_inode_info {
 		struct {
 			unchar _unused[16];	/* 16: */
 			dxd_t _dxd;		/* 16: */
+			/* _inline may overflow into _inline_ea when needed */
 			unchar _inline[128];	/* 128: inline symlink */
 			/* _inline_ea may overlay the last part of
 			 * file._xtroot if maxentry = XTROOTINITSLOT
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -967,8 +967,7 @@ static int __init init_jfs_fs(void)
 	jfs_inode_cachep =
 	    kmem_cache_create_usercopy("jfs_ip", sizeof(struct jfs_inode_info),
 			0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD|SLAB_ACCOUNT,
-			offsetof(struct jfs_inode_info, i_inline),
-			sizeof_field(struct jfs_inode_info, i_inline),
+			offsetof(struct jfs_inode_info, i_inline), IDATASIZE,
 			init_once);
 	if (jfs_inode_cachep == NULL)
 		return -ENOMEM;


