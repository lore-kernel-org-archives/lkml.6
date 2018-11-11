Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54D7C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9277720866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="meFH7HOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9277720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbeKKVjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 16:39:40 -0500
Received: from imap.thunk.org ([74.207.234.97]:38418 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbeKKVjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 16:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=yZ4QAUzvGTimvVyljzyKsHkwYjT1tSTJwLGp4/0lGUY=; b=meFH7HOEZjgTsE4/dYiHXJtiOa
        Wefi7+FeKuqogd7Phc6gOBGRsWNG69GF+wbns3o8HRESbC0VL/nbE5jqeFwfZNWKllhDw8aGk81Nx
        0BLlwnSE/k1KblLSKM8bMWV9gkDQhdBP0J1i0NRZlH/LSDf/boHTg5ODXhb5xFVZRrXo=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gLoGr-0007oW-B3; Sun, 11 Nov 2018 11:51:17 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id F1CAD7A03EF; Sun, 11 Nov 2018 06:51:15 -0500 (EST)
Date:   Sun, 11 Nov 2018 06:51:15 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 bug fixes for 4.20-rc2
Message-ID: <20181111115115.GA3085@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 33458eaba4dfe778a426df6a19b7aad2ff9f7eec:

  ext4: fix use-after-free race in ext4_remount()'s error path (2018-10-12 09:28:09 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

for you to fetch changes up to eb6984fa4ce2837dcb1f66720a600f31b0bb3739:

  ext4: missing !bh check in ext4_xattr_inode_write() (2018-11-09 11:34:40 -0500)

----------------------------------------------------------------
A large number of ext4 bug fixes, mostly buffer and memory leaks on
error return cleanup paths.

----------------------------------------------------------------
Theodore Ts'o (2):
      ext4: avoid possible double brelse() in add_new_gdb() on error path
      ext4: fix possible leak of sbi->s_group_desc_leak in error path

Vasily Averin (16):
      ext4: avoid potential extra brelse in setup_new_flex_group_blocks()
      ext4: add missing brelse() in set_flexbg_block_bitmap()'s error path
      ext4: add missing brelse() add_new_gdb_meta_bg()'s error path
      ext4: add missing brelse() update_backups()'s error path
      ext4: fix missing cleanup if ext4_alloc_flex_bg_array() fails while resizing
      ext4: fix possible inode leak in the retry loop of ext4_resize_fs()
      ext4: avoid buffer leak on shutdown in ext4_mark_iloc_dirty()
      ext4: avoid buffer leak in ext4_orphan_add() after prior errors
      ext4: remove unneeded brelse call in ext4_xattr_inode_update_ref()
      ext4: fix possible leak of s_journal_flag_rwsem in error path
      ext4: fix buffer leak in ext4_xattr_get_block() on error path
      ext4: release bs.bh before re-using in ext4_xattr_block_find()
      ext4: fix buffer leak in ext4_xattr_move_to_block() on error path
      ext4: fix buffer leak in ext4_expand_extra_isize_ea() on error path
      ext4: fix buffer leak in __ext4_read_dirblock() on error path
      ext4: missing !bh check in ext4_xattr_inode_write()

 fs/ext4/inode.c  |  5 +++--
 fs/ext4/namei.c  |  5 ++++-
 fs/ext4/resize.c | 28 ++++++++++++++++------------
 fs/ext4/super.c  | 17 +++++++++--------
 fs/ext4/xattr.c  | 27 +++++++++++++++++++--------
 5 files changed, 51 insertions(+), 31 deletions(-)
