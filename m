Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B99C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494D02133F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3z6TBUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494D02133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbeK2REO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:04:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbeK2REN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:04:13 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6836921019;
        Thu, 29 Nov 2018 06:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471202;
        bh=DQ3ixg0MFFH2XgMjali88FIJqJohl84f9waLu0eLn4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J3z6TBUr775tXtpzErfXjUgsiuaWvReLin6UXDjgGTRVLv2yCdFRiDwUS9TtifuJX
         wklYnXexwlErQaSHP6eIUVbhVSaCFAm7o6upK/TeoGaa35blci6rbR2abGrcEFiCVr
         TMUfbEYUsWICkmH2t2HcNDjfkMrcjZr/JZxifkQA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 51/68] iomap: FUA is wrong for DIO O_DSYNC writes into unwritten extents
Date:   Thu, 29 Nov 2018 00:55:42 -0500
Message-Id: <20181129055559.159228-51-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

[ Upstream commit 0929d8580071c6a1cec1a7916a8f674c243ceee1 ]

When we write into an unwritten extent via direct IO, we dirty
metadata on IO completion to convert the unwritten extent to
written. However, when we do the FUA optimisation checks, the inode
may be clean and so we issue a FUA write into the unwritten extent.
This means we then bypass the generic_write_sync() call after
unwritten extent conversion has ben done and we don't force the
modified metadata to stable storage.

This violates O_DSYNC semantics. The window of exposure is a single
IO, as the next DIO write will see the inode has dirty metadata and
hence will not use the FUA optimisation. Calling
generic_write_sync() after completion of the second IO will also
sync the first write and it's metadata.

Fix this by avoiding the FUA optimisation when writing to unwritten
extents.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index ec15cf2ec696..fa46e3ed8f53 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1597,12 +1597,13 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 
 	if (iomap->flags & IOMAP_F_NEW) {
 		need_zeroout = true;
-	} else {
+	} else if (iomap->type == IOMAP_MAPPED) {
 		/*
-		 * Use a FUA write if we need datasync semantics, this
-		 * is a pure data IO that doesn't require any metadata
-		 * updates and the underlying device supports FUA. This
-		 * allows us to avoid cache flushes on IO completion.
+		 * Use a FUA write if we need datasync semantics, this is a pure
+		 * data IO that doesn't require any metadata updates (including
+		 * after IO completion such as unwritten extent conversion) and
+		 * the underlying device supports FUA. This allows us to avoid
+		 * cache flushes on IO completion.
 		 */
 		if (!(iomap->flags & (IOMAP_F_SHARED|IOMAP_F_DIRTY)) &&
 		    (dio->flags & IOMAP_DIO_WRITE_FUA) &&
-- 
2.17.1

