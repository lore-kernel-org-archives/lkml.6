Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7501FECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A7220840
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGliCDoA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A7220840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbeKAIMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:12:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732094AbeKAIMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:12:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 237A12085A;
        Wed, 31 Oct 2018 23:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027519;
        bh=tHrttO4wnHzs3MgD5CI088CEOQIQdsSASAp6WRXK1dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cGliCDoA8cRgpUzFU96AOCTawE0LH3fh2YxTzPwxg1JORXxLYf8QUP9bzkYYdq8ig
         DeHrIbJPVHhhzoKNrIYrw8LpJc5zVEam2obeA0emDnpL0Ut9PFeQTtdoNQKTl5KLwH
         OJ9wQCWCaK4ZYbWrblEgLme/D82xVVPiCj/R1HOs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, stable@kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 24/32] ext4: fix argument checking in EXT4_IOC_MOVE_EXT
Date:   Wed, 31 Oct 2018 19:11:29 -0400
Message-Id: <20181031231137.29429-24-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231137.29429-1-sashal@kernel.org>
References: <20181031231137.29429-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

[ Upstream commit f18b2b83a727a3db208308057d2c7945f368e625 ]

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
Cc: stable@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/move_extent.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 05048fcfd602..6b5e2eddd8d7 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -526,9 +526,13 @@ mext_check_arguments(struct inode *orig_inode,
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
2.17.1

