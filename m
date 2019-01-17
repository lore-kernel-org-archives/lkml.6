Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBFDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2976020855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfAQP1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:27:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45208 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbfAQP1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:27:45 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 91E057AEAC;
        Thu, 17 Jan 2019 15:27:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-128.rdu2.redhat.com [10.10.120.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DF2A5C729;
        Thu, 17 Jan 2019 15:27:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/6] afs: Set correct lock type for the yfs CreateFile
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Marc Dionne <marc.dionne@auristor.com>, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 17 Jan 2019 15:27:43 +0000
Message-ID: <154773886375.24105.1035981277638572361.stgit@warthog.procyon.org.uk>
In-Reply-To: <154773884927.24105.2730570814701376379.stgit@warthog.procyon.org.uk>
References: <154773884927.24105.2730570814701376379.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 17 Jan 2019 15:27:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Dionne <marc.dionne@auristor.com>

A lock type of 0 is "LockRead", which makes the fileserver record an
unintentional read lock on the new file.  This will cause problems
later on if the file is the subject of locking operations.

The correct default value should be -1 ("LockNone").

Fix the operation marshalling code to set the value and provide an enum to
symbolise the values whilst we're at it.

Fixes: 30062bd13e36 ("afs: Implement YFS support in the fs client")
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/protocol_yfs.h |   11 +++++++++++
 fs/afs/yfsclient.c    |    2 +-
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

