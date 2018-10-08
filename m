Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F96C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A97521479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMDyvYN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A97521479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbeJICCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:02:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730559AbeJICCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:02:50 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18737204FD;
        Mon,  8 Oct 2018 18:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024583;
        bh=sY02rBfSrvgFjMzn6Hl14GGJOO6NuVrYp1y1/fw1kS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CMDyvYN18W+hjk404HZkaWkp7ZMnBbTGcm02mJnDnI9HJxtlq1hz5FrX52HEaboPa
         698hDj/BRRW1U0KqvKKj1lmefQAkCtFx+Dl3H78GWpe+9EizOhopibUusMHaZfWuTX
         xcPqfzUhNTxf8q/Zb2Y4nyTOu22A76JmGYmHubZ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Jan Kara <jack@suse.cz>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 064/168] fsnotify: fix ignore mask logic in fsnotify()
Date:   Mon,  8 Oct 2018 20:30:44 +0200
Message-Id: <20181008175622.483891230@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 9bdda4e9cf2dcecb60a0683b10ffb8cd7e5f2f45 ]

Commit 92183a42898d ("fsnotify: fix ignore mask logic in
send_to_group()") acknoledges the use case of ignoring an event on
an inode mark, because of an ignore mask on a mount mark of the same
group (i.e. I want to get all events on this file, except for the events
that came from that mount).

This change depends on correctly merging the inode marks and mount marks
group lists, so that the mount mark ignore mask would be tested in
send_to_group(). Alas, the merging of the lists did not take into
account the case where event in question is not in the mask of any of
the mount marks.

To fix this, completely remove the tests for inode and mount event masks
from the lists merging code.

Fixes: 92183a42898d ("fsnotify: fix ignore mask logic in send_to_group")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/notify/fsnotify.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -351,16 +351,9 @@ int fsnotify(struct inode *to_tell, __u3
 
 	iter_info.srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
 
-	if ((mask & FS_MODIFY) ||
-	    (test_mask & to_tell->i_fsnotify_mask)) {
-		iter_info.marks[FSNOTIFY_OBJ_TYPE_INODE] =
-			fsnotify_first_mark(&to_tell->i_fsnotify_marks);
-	}
-
-	if (mnt && ((mask & FS_MODIFY) ||
-		    (test_mask & mnt->mnt_fsnotify_mask))) {
-		iter_info.marks[FSNOTIFY_OBJ_TYPE_INODE] =
-			fsnotify_first_mark(&to_tell->i_fsnotify_marks);
+	iter_info.marks[FSNOTIFY_OBJ_TYPE_INODE] =
+		fsnotify_first_mark(&to_tell->i_fsnotify_marks);
+	if (mnt) {
 		iter_info.marks[FSNOTIFY_OBJ_TYPE_VFSMOUNT] =
 			fsnotify_first_mark(&mnt->mnt_fsnotify_marks);
 	}


