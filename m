Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CBFECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C947D20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBpQesh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C947D20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732442AbeKAINU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:13:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731215AbeKAIMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:12:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5039F21019;
        Wed, 31 Oct 2018 23:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027542;
        bh=tiuaiob8ayIWktC1g3BJ/eOx6E806rt+854w9nHPKEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IBpQesh4WjM1SusVLrJfjRyStcDmJReQr0HG4acA04AqAhskSP0+mVdf+yQa7e4Wp
         AMyJ3c1bQ9HJ4MLphn0bILjnAZQjrN2HYdh/upZeTEUbUm1GqpV5O7JvDp2gQQAKE9
         7e3K5vPeUsh0vXHlo93O52oxob4/VmbwN3aT8i94=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, stable@kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 16/22] ext4: fix argument checking in EXT4_IOC_MOVE_EXT
Date:   Wed, 31 Oct 2018 19:12:00 -0400
Message-Id: <20181031231206.29509-16-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231206.29509-1-sashal@kernel.org>
References: <20181031231206.29509-1-sashal@kernel.org>
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
index 4d1049517e4a..ebe809bac808 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -533,9 +533,13 @@ mext_check_arguments(struct inode *orig_inode,
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

