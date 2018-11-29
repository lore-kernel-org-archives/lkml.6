Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C44C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D90421104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Payb8tCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D90421104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbeK2RER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:04:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbeK2REQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:04:16 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A9C421104;
        Thu, 29 Nov 2018 06:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471205;
        bh=WdKGbFxZM9VvN1QzJOdBk7mXBsibUXd5Ruvhu4fCo+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Payb8tCMypKN8BcfrMPElDbcA0viFKGWJobXaEOYQdxTrWYaGIISKUG/XHGhY9YXP
         fntTRGcAnHurLwFA3GGWCxN0lgoxPpWlrp1qLePB2oY+7W3uExvNKgWAclYRl0jH7j
         mFeqiCjwkJMRI3/TmhJTsCApiMVZSxM3/bU1qtAY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 52/68] iomap: sub-block dio needs to zeroout beyond EOF
Date:   Thu, 29 Nov 2018 00:55:43 -0500
Message-Id: <20181129055559.159228-52-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

[ Upstream commit b450672fb66b4a991a5b55ee24209ac7ae7690ce ]

If we are doing sub-block dio that extends EOF, we need to zero
the unused tail of the block to initialise the data in it it. If we
do not zero the tail of the block, then an immediate mmap read of
the EOF block will expose stale data beyond EOF to userspace. Found
with fsx running sub-block DIO sizes vs MAPREAD/MAPWRITE operations.

Fix this by detecting if the end of the DIO write is beyond EOF
and zeroing the tail if necessary.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index fa46e3ed8f53..82e35265679d 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1678,7 +1678,14 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		dio->submit.cookie = submit_bio(bio);
 	} while (nr_pages);
 
-	if (need_zeroout) {
+	/*
+	 * We need to zeroout the tail of a sub-block write if the extent type
+	 * requires zeroing or the write extends beyond EOF. If we don't zero
+	 * the block tail in the latter case, we can expose stale data via mmap
+	 * reads of the EOF block.
+	 */
+	if (need_zeroout ||
+	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode))) {
 		/* zero out from the end of the write to the end of the block */
 		pad = pos & (fs_block_size - 1);
 		if (pad)
-- 
2.17.1

