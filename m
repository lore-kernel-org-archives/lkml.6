Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6134BC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7CA2086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762800;
	bh=twUBzgsuVUqfsbqvgxU90t7Y/jPuf/e5InN9BaL9Fg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LIZrPitf7shyco3Sh2WLT84B2/xr3kyNIImRuTpvXq9kJM6GMBtHc+a0/3zUUSEzy
	 wCL5YbaPKbfHITR7yjlpGfoCM4tFAJE6cEYc35ChWgHobB4yA0hjEgMoaoegJIv7O+
	 Fj5ERAM88LP9GOsUcWhKyr3gEdF9uSEKBnGftjFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbfA2Lw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:52:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732083AbfA2LwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:52:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDC7F20882;
        Tue, 29 Jan 2019 11:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762744;
        bh=twUBzgsuVUqfsbqvgxU90t7Y/jPuf/e5InN9BaL9Fg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j8Mn1ShtkXq3B6/zENJgqqaMsnPiXjH1jtiCjjKCp5AgDS+u1/huatt6jg/uzWsiz
         502ZEe2WY3KnkKhWULC+iDIYZzdirdC7Aky2MIS1Xlq/i9VvdYeaFDs97CY2Q9IhYy
         zPp+Z2Wn4VVJ9hi0c38WWSGh/GIaD0RpXT2Yt/yw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Mahoney <jeffm@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.9 43/44] btrfs: fix error handling in btrfs_dev_replace_start
Date:   Tue, 29 Jan 2019 12:36:38 +0100
Message-Id: <20190129113143.456682357@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113139.826927690@linuxfoundation.org>
References: <20190129113139.826927690@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Mahoney <jeffm@suse.com>

commit 5c06147128fbbdf7a84232c5f0d808f53153defe upstream.

When we fail to start a transaction in btrfs_dev_replace_start, we leave
dev_replace->replace_start set to STARTED but clear ->srcdev and
->tgtdev.  Later, that can result in an Oops in
btrfs_dev_replace_progress when having state set to STARTED or SUSPENDED
implies that ->srcdev is valid.

Also fix error handling when the state is already STARTED or SUSPENDED
while starting.  That, too, will clear ->srcdev and ->tgtdev even though
it doesn't own them.  This should be an impossible case to hit since we
should be protected by the BTRFS_FS_EXCL_OP bit being set.  Let's add an
ASSERT there while we're at it.

Fixes: e93c89c1aaaaa (Btrfs: add new sources for device replace code)
CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/dev-replace.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -350,6 +350,7 @@ int btrfs_dev_replace_start(struct btrfs
 		break;
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_STARTED:
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED:
+		ASSERT(0);
 		ret = BTRFS_IOCTL_DEV_REPLACE_RESULT_ALREADY_STARTED;
 		goto leave;
 	}
@@ -394,6 +395,10 @@ int btrfs_dev_replace_start(struct btrfs
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		btrfs_dev_replace_lock(dev_replace, 1);
+		dev_replace->replace_state =
+			BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED;
+		dev_replace->srcdev = NULL;
+		dev_replace->tgtdev = NULL;
 		goto leave;
 	}
 
@@ -415,8 +420,6 @@ int btrfs_dev_replace_start(struct btrfs
 	return ret;
 
 leave:
-	dev_replace->srcdev = NULL;
-	dev_replace->tgtdev = NULL;
 	btrfs_dev_replace_unlock(dev_replace, 1);
 	btrfs_destroy_dev_replace_tgtdev(fs_info, tgt_device);
 	return ret;


