Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DC3C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 05:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A902089B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 05:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="cGwPAfL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A902089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbeGHFCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 01:02:25 -0400
Received: from imap.thunk.org ([74.207.234.97]:43564 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbeGHFCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 01:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=c2sj2c7UfahhkXhKDXw+js4AyzxKznpmrTMTwnzREQs=; b=cGwPAfL/KKgJRS9WChXH2MV/cT
        4CeoaaIa/aoR3VVLjL+7qb8/i2tRu7mevMYnW1GPuT2BZA116s6xMdWJLT5los3wULAplJNUso9wB
        3ojRwLhO4hGuIKJFuxp5fxR9n5o25lBNXyj/7S0aN2wgrb00q2NXl04oX6Ra++C4UO10=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fc1q2-0008Ix-VM; Sun, 08 Jul 2018 05:02:23 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B52307A552B; Sun,  8 Jul 2018 01:02:21 -0400 (EDT)
Date:   Sun, 8 Jul 2018 01:02:21 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     torvalds@linux-foundation.org
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ext4 fixes for 4.18
Message-ID: <20180708050221.GA5947@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        torvalds@linux-foundation.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 4f2f76f751433908364ccff82f437a57d0e6e9b7:

  ext4: fix fencepost error in check for inode count overflow during resize (2018-05-25 12:51:25 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

for you to fetch changes up to a17712c8e4be4fa5404d20e9cd3b2b21eae7bc56:

  ext4: check superblock mapped prior to committing (2018-07-02 18:45:18 -0400)

----------------------------------------------------------------
Bug fixes for ext4; most of which relate to vulnerabilities where a
maliciously crafted file system image can result in a kernel OOPS or
hang.  At least one fix addresses an inline data bug could be
triggered by userspace without the need of a crafted file system
(although it does require that the inline data feature be enabled).

----------------------------------------------------------------
Jon Derrick (1):
      ext4: check superblock mapped prior to committing

Theodore Ts'o (14):
      ext4: add warn_on_error mount option
      ext4: add corruption check in ext4_xattr_set_entry()
      ext4: always verify the magic number in xattr blocks
      ext4: always check block group bounds in ext4_init_block_bitmap()
      ext4: make sure bitmaps and the inode table don't overlap with bg descriptors
      ext4: only look at the bg_flags field if it is valid
      ext4: verify the depth of extent tree in ext4_find_extent()
      ext4: include the illegal physical block in the bad map ext4_error msg
      ext4: clear i_data in ext4_inode_info when removing inline data
      ext4: never move the system.data xattr out of the inode body
      jbd2: don't mark block as modified if the handle is out of credits
      ext4: avoid running out of journal credits when appending to an inline file
      ext4: add more inode number paranoia checks
      ext4: add more mount time checks of the superblock

 fs/ext4/balloc.c       | 21 +++++++++++++--------
 fs/ext4/ext4.h         |  9 +--------
 fs/ext4/ext4_extents.h |  1 +
 fs/ext4/extents.c      |  6 ++++++
 fs/ext4/ialloc.c       | 14 ++++++++++++--
 fs/ext4/inline.c       | 39 ++-------------------------------------
 fs/ext4/inode.c        |  7 ++++---
 fs/ext4/mballoc.c      |  6 ++++--
 fs/ext4/super.c        | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------
 fs/ext4/xattr.c        | 40 ++++++++++++++++++----------------------
 fs/jbd2/transaction.c  |  9 ++++++++-
 11 files changed, 155 insertions(+), 96 deletions(-)
