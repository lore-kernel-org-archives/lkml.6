Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6B0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77E62145D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcknjYug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77E62145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405564AbeKTDoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:44:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404671AbeKTDXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:23:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 939282148E;
        Mon, 19 Nov 2018 16:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646780;
        bh=HPjxfxZmbYcEOSrwE4NZAAmBSvsrbfEzCujaXKCSzAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NcknjYugegLCDjroTNEAT6SNf+6oZZpLN7dRv8GF8W84TiaFd7NP+29BtSUqTEOiP
         lQToH/OfmFYSt1S7t0z4mbXsecR+hFBJPRCUnphXgqfNp3h/vkdjNLGGq3sYGfX++r
         xwUFGzat1hN0mO4d7KQfjJ5q9ZRe2jPBTRR6Fy90=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Mahoney <jeffm@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.4 087/160] btrfs: dont attempt to trim devices that dont support it
Date:   Mon, 19 Nov 2018 17:28:46 +0100
Message-Id: <20181119162639.652870725@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Mahoney <jeffm@suse.com>

commit 0be88e367fd8fbdb45257615d691f4675dda062f upstream.

We check whether any device the file system is using supports discard in
the ioctl call, but then we attempt to trim free extents on every device
regardless of whether discard is supported.  Due to the way we mask off
EOPNOTSUPP, we can end up issuing the trim operations on each free range
on devices that don't support it, just wasting time.

Fixes: 499f377f49f08 ("btrfs: iterate over unused chunk space in FITRIM")
CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/extent-tree.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -10629,6 +10629,10 @@ static int btrfs_trim_free_extents(struc
 
 	*trimmed = 0;
 
+	/* Discard not supported = nothing to do. */
+	if (!blk_queue_discard(bdev_get_queue(device->bdev)))
+		return 0;
+
 	/* Not writeable = nothing to do. */
 	if (!device->writeable)
 		return 0;


