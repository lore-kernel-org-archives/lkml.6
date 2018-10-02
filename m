Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA02FC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D22B20684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="os9tLMu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D22B20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbeJBMRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 08:17:23 -0400
Received: from imap.thunk.org ([74.207.234.97]:49268 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbeJBMRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 08:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5iGivTEtVlzulUMBj0Ifr8+XtTCqOMcfHC5LV7UnXSc=; b=os9tLMu+N/tGL6DwRcqxrdaj5d
        uQQmCDdek6ksItW5Z9l4376ULfPTa9z4uDQ1RPkdLLdPxUVpc1kAm6r4p1oVhTclJZT7qLqMqmrBN
        5MhI9NC5WFomx9d52T8EREjaiViejSRTfkjDQSul0Yrw7/5KYl5aGNJXDeo84KmFqYMY=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g7DLi-0005rO-2S; Tue, 02 Oct 2018 05:35:58 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C44487A55B3; Tue,  2 Oct 2018 01:35:56 -0400 (EDT)
Date:   Tue, 2 Oct 2018 01:35:56 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+c61979f6f2cba5cb3c06@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: INFO: task hung in ext4_fallocate
Message-ID: <20181002053556.GB17537@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        syzbot <syzbot+c61979f6f2cba5cb3c06@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000003908ec05772ec554@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003908ec05772ec554@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is fixed with the following patch.

						- Ted

From c4a928ee604e31354c969b461aa9a6171825096a Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Tue, 2 Oct 2018 01:34:44 -0400
Subject: [PATCH] ext4: fix argument checking in EXT4_IOC_MOVE_EXT

If the starting block number of either the source or destination file
exceeds the EOF, EXT4_IOC_MOVE_EXT should return EINVAL.

Also fixed the helper function mext_check_coverage() so that if the
logical block is beyond EOF, make it return immediately, instead of
looping until the block number wraps all the away around.  This takes
long enough that if there are multiple threads trying to do pound on
an the same inode doing non-sensical things, it can end up triggering
the kernel's soft lockup detector.

Reported-by: syzbot+c61979f6f2cba5cb3c06@syzkaller.appspotmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/move_extent.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index a409ff70d67b..4901e389f847 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -92,16 +92,18 @@ mext_check_coverage(struct inode *inode, ext4_lblk_t from, ext4_lblk_t count,
 {
 	struct ext4_ext_path *path = NULL;
 	struct ext4_extent *ext;
-	int ret = 0;
+	int len, ret = 0;
 	ext4_lblk_t last = from + count;
 	while (from < last) {
 		*err = get_ext_path(inode, from, &path);
 		if (*err)
 			goto out;
 		ext = path[ext_depth(inode)].p_ext;
-		if (unwritten != ext4_ext_is_unwritten(ext))
+		len = ext4_ext_get_actual_len(ext);
+		if ((ext->ee_block < from) ||
+		    (unwritten != ext4_ext_is_unwritten(ext)))
 			goto out;
-		from += ext4_ext_get_actual_len(ext);
+		from = ext->ee_block + len;
 		ext4_ext_drop_refs(path);
 	}
 	ret = 1;
@@ -516,9 +518,13 @@ mext_check_arguments(struct inode *orig_inode,
 			orig_inode->i_ino, donor_inode->i_ino);
 		return -EINVAL;
 	}
-	if (orig_eof < orig_start + *len - 1)
+	if (orig_eof <= orig_start)
+		*len = 0;
+	else if (orig_eof < orig_start + *len - 1)
 		*len = orig_eof - orig_start;
-	if (donor_eof < donor_start + *len - 1)
+	if (donor_eof <= donor_start)
+		*len = 0;
+	else if (donor_eof < donor_start + *len - 1)
 		*len = donor_eof - donor_start;
 	if (!*len) {
 		ext4_debug("ext4 move extent: len should not be 0 "
-- 
2.18.0.rc0

