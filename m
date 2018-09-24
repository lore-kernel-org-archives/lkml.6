Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620D3ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6A821486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6A821486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbeIXRmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:42:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50816 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbeIXRmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:42:16 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C9C611071;
        Mon, 24 Sep 2018 11:40:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 065/105] gfs2: Special-case rindex for gfs2_grow
Date:   Mon, 24 Sep 2018 13:33:51 +0200
Message-Id: <20180924113119.944294653@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113113.268650190@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit 776125785a87ff05d49938bd5b9f336f2a05bff6 ]

To speed up the common case of appending to a file,
gfs2_write_alloc_required presumes that writing beyond the end of a file
will always require additional blocks to be allocated.  This assumption
is incorrect for preallocates files, but there are no negative
consequences as long as *some* space is still left on the filesystem.

One special file that always has some space preallocated beyond the end
of the file is the rindex: when growing a filesystem, gfs2_grow adds one
or more new resource groups and appends records describing those
resource groups to the rindex; the preallocated space ensures that this
is always possible.

However, when a filesystem is completely full, gfs2_write_alloc_required
will indicate that an additional allocation is required, and appending
the next record to the rindex will fail even though space for that
record has already been preallocated.  To fix that, skip the incorrect
optimization in gfs2_write_alloc_required, but for the rindex only.
Other writes to preallocated space beyond the end of the file are still
allowed to fail on completely full filesystems.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Reviewed-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/gfs2/bmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1476,7 +1476,7 @@ int gfs2_write_alloc_required(struct gfs
 	end_of_file = (i_size_read(&ip->i_inode) + sdp->sd_sb.sb_bsize - 1) >> shift;
 	lblock = offset >> shift;
 	lblock_stop = (offset + len + sdp->sd_sb.sb_bsize - 1) >> shift;
-	if (lblock_stop > end_of_file)
+	if (lblock_stop > end_of_file && ip != GFS2_I(sdp->sd_rindex))
 		return 1;
 
 	size = (lblock_stop - lblock) << shift;


