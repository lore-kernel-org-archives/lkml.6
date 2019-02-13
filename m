Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B136BC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73EC3222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025294;
	bh=/gN0J49L3TM2EWp9cZTtqDgGoftpNUE0bk2qq0D1UWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mOFaVMz0TcjHNamaudNQdC2pDy3KC54mq6ibHcZmJIVwmQxfpILUfQ6y2jeL8Zcny
	 c9JIAOXY4GllbEQRzcnfQXT1xa/I599GBinP1ebqClMCAIxcQodIUXrLlKFBNHSGOC
	 j/FIxUKoNUosbYpSOCmykRmF58uunOq7tPIf1NME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387848AbfBMCew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:34:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:38432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387829AbfBMCeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:34:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8F21206B6;
        Wed, 13 Feb 2019 02:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025289;
        bh=/gN0J49L3TM2EWp9cZTtqDgGoftpNUE0bk2qq0D1UWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p54pXl7O7EMmqlBmRfoyVZr8aIfVzG0YEPkqkWS/lRZu4RTHUHcJQTPQXZWQx+Hz6
         gbkqSAMU8cHPbe3r+x7+JEfRrp3BqRwS/sfEjWC3tpwHeU45Qh9djeISpGsWp+Drej
         T6b/KYdO5pa795WJlax3xOWhemU1eXCgdDqmwjaQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-afs@lists.infradead.org
Subject: [PATCH AUTOSEL 4.20 048/105] afs: Set correct lock type for the yfs CreateFile
Date:   Tue, 12 Feb 2019 21:32:39 -0500
Message-Id: <20190213023336.19019-48-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Dionne <marc.dionne@auristor.com>

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
index 07bc10f076aa..d443e2bfa094 100644
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
index 12658c1363ae..5aa57929e8c2 100644
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

