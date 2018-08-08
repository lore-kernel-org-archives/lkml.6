Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BDDC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FEE21762
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="bVz4yfGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FEE21762
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeHHQHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:07:43 -0400
Received: from imap.thunk.org ([74.207.234.97]:50120 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbeHHQHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=QvW6dDRaukrffhD+rK8IMESyNYavkUyy2FmC27mA71E=; b=bVz4yfGbouzqADRtmIvDX1B1hi
        AU0EjlhdRl1pTUrgIYsOx2mgwwB/CbDane1t05Vp4q8kqoFmIaDJkiSyQq4mYTRljry8TryzuZbkt
        8xtx46aD1v734nxIlwRjb3KsHANDZ3aXlnzWtfspWkQhP/fm/eHC1z3owN8p3aqP+mnU=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fnOoe-0002yE-K0; Wed, 08 Aug 2018 13:47:56 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A5DFB7A6513; Wed,  8 Aug 2018 09:47:54 -0400 (EDT)
Date:   Wed, 8 Aug 2018 09:47:54 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matthias Schiffer <mschiffer@universe-factory.net>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Eric Whitney <enwlinux@gmail.com>
Subject: Re: [PATCH 4.14 222/246] ext4: fix check to prevent initializing
 reserved inodes
Message-ID: <20180808134754.GA3662@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Schiffer <mschiffer@universe-factory.net>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Eric Whitney <enwlinux@gmail.com>
References: <20180801165011.700991984@linuxfoundation.org>
 <20180801165022.329322870@linuxfoundation.org>
 <0360c726-c139-345b-a478-82b33a7aa804@universe-factory.net>
 <20180808052845.GB20034@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808052845.GB20034@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 07:28:45AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 08, 2018 at 12:17:30AM +0200, Matthias Schiffer wrote:
> > On 08/01/2018 06:52 PM, Greg Kroah-Hartman wrote:
> > > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > 
> > It seems this patch is still missing from the 4.4.y and 4.9.y branches.
> 
> Maybe because no one has provided a working backport?  :)

Here you go....

					- Ted

From c489f091a4b8ef4835146a6bb9a77cfc31055cd4 Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Sat, 28 Jul 2018 08:12:04 -0400
Subject: [PATCH] ext4: fix check to prevent initializing reserved inodes

Commit 5012284700775a4e6e3fbe7eac4c543c4874b559 upstream.

Commit 8844618d8aa7: "ext4: only look at the bg_flags field if it is
valid" will complain if block group zero does not have the
EXT4_BG_INODE_ZEROED flag set.  Unfortunately, this is not correct,
since a freshly created file system has this flag cleared.  It gets
almost immediately after the file system is mounted read-write --- but
the following somewhat unlikely sequence will end up triggering a
false positive report of a corrupted file system:

   mkfs.ext4 /dev/vdc
   mount -o ro /dev/vdc /vdc
   mount -o remount,rw /dev/vdc

Instead, when initializing the inode table for block group zero, test
to make sure that itable_unused count is not too large, since that is
the case that will result in some or all of the reserved inodes
getting cleared.

This fixes the failures reported by Eric Whiteney when running
generic/230 and generic/231 in the the nojournal test case.

Fixes: 8844618d8aa7 ("ext4: only look at the bg_flags field if it is valid")
Reported-by: Eric Whitney <enwlinux@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/ialloc.c | 5 ++++-
 fs/ext4/super.c  | 8 +-------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index ffaf66a51de3..4f78e099de1d 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1316,7 +1316,10 @@ int ext4_init_inode_table(struct super_block *sb, ext4_group_t group,
 			    ext4_itable_unused_count(sb, gdp)),
 			    sbi->s_inodes_per_block);
 
-	if ((used_blks < 0) || (used_blks > sbi->s_itb_per_group)) {
+	if ((used_blks < 0) || (used_blks > sbi->s_itb_per_group) ||
+	    ((group == 0) && ((EXT4_INODES_PER_GROUP(sb) -
+			       ext4_itable_unused_count(sb, gdp)) <
+			      EXT4_FIRST_INO(sb)))) {
 		ext4_error(sb, "Something is wrong with group %u: "
 			   "used itable blocks: %d; "
 			   "itable unused count: %u",
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 41ef83471ea5..04f49572a9a0 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3031,14 +3031,8 @@ static ext4_group_t ext4_has_uninit_itable(struct super_block *sb)
 		if (!gdp)
 			continue;
 
-		if (gdp->bg_flags & cpu_to_le16(EXT4_BG_INODE_ZEROED))
-			continue;
-		if (group != 0)
+		if (!(gdp->bg_flags & cpu_to_le16(EXT4_BG_INODE_ZEROED)))
 			break;
-		ext4_error(sb, "Inode table for bg 0 marked as "
-			   "needing zeroing");
-		if (sb->s_flags & MS_RDONLY)
-			return ngroups;
 	}
 
 	return group;
-- 
2.18.0.rc0


