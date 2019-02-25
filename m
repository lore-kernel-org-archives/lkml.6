Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C37C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F77217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130387;
	bh=HqPDRsyLlZp1MHs5KcwxNlHGSddpFt32/LIU+/yyyfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CE+jZMTn/vrEBdQj4Xvj6UI9lKATYBtiuRR/yiCX7tYILnN6BrvuUhOubccIxtJKB
	 mfIDj9zQF45cOkcZFnlV5t1Wgp7CcrX2+WxweeKBRO1i1iSf2FLxWiK/pZ+DKW04xx
	 GZVfZsqfGOHcuU/JiuTcfB7C+snNBzXZ4i+vl32o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbfBYVdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:33:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:39076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732157AbfBYVdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:33:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A27921850;
        Mon, 25 Feb 2019 21:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130382;
        bh=HqPDRsyLlZp1MHs5KcwxNlHGSddpFt32/LIU+/yyyfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GAK4DOPRvC5ss0KGwSLu7bnlmPoG/e2LIOt+Af0l2979HWPS7CvdUq2DpSHNho2x7
         5QGYrGgDk9FXuawWm/+6jdrl06NMxBSR7jLsQsdX3nLuAG1m+GxeJ/TP/9OeqZl2fB
         /eUUzgqw6KO7vQnHp5sbNZImDGQrOMD9kndgrxfk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 066/183] afs: Set correct lock type for the yfs CreateFile
Date:   Mon, 25 Feb 2019 22:10:39 +0100
Message-Id: <20190225195105.665000367@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 5edc22cc1d33d6a88d175d25adc38d2a5cee134d ]

A lock type of 0 is "LockRead", which makes the fileserver record an
unintentional read lock on the new file.  This will cause problems
later on if the file is the subject of locking operations.

The correct default value should be -1 ("LockNone").

Fix the operation marshalling code to set the value and provide an enum to
symbolise the values whilst we're at it.

Fixes: 30062bd13e36 ("afs: Implement YFS support in the fs client")
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/protocol_yfs.h | 11 +++++++++++
 fs/afs/yfsclient.c    |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/afs/protocol_yfs.h b/fs/afs/protocol_yfs.h
index 07bc10f076aac..d443e2bfa0946 100644
--- a/fs/afs/protocol_yfs.h
+++ b/fs/afs/protocol_yfs.h
@@ -161,3 +161,14 @@ struct yfs_xdr_YFSStoreVolumeStatus {
 	struct yfs_xdr_u64	max_quota;
 	struct yfs_xdr_u64	file_quota;
 } __packed;
+
+enum yfs_lock_type {
+	yfs_LockNone		= -1,
+	yfs_LockRead		= 0,
+	yfs_LockWrite		= 1,
+	yfs_LockExtend		= 2,
+	yfs_LockRelease		= 3,
+	yfs_LockMandatoryRead	= 0x100,
+	yfs_LockMandatoryWrite	= 0x101,
+	yfs_LockMandatoryExtend	= 0x102,
+};
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 12658c1363ae4..5aa57929e8c23 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -803,7 +803,7 @@ int yfs_fs_create_file(struct afs_fs_cursor *fc,
 	bp = xdr_encode_YFSFid(bp, &vnode->fid);
 	bp = xdr_encode_string(bp, name, namesz);
 	bp = xdr_encode_YFSStoreStatus_mode(bp, mode);
-	bp = xdr_encode_u32(bp, 0); /* ViceLockType */
+	bp = xdr_encode_u32(bp, yfs_LockNone); /* ViceLockType */
 	yfs_check_req(call, bp);
 
 	afs_use_fs_server(call, fc->cbi);
-- 
2.19.1



