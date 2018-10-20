Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFFDECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A458214C2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A458214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeJTJVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:21:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbeJTJVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:21:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 42B3030F8C04;
        Sat, 20 Oct 2018 01:12:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 623046DAF4;
        Sat, 20 Oct 2018 01:12:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 16/24] afs: Fix FS.FetchStatus delivery from updating wrong
 vnode
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 20 Oct 2018 02:12:34 +0100
Message-ID: <153999795464.866.14104249270040855238.stgit@warthog.procyon.org.uk>
In-Reply-To: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
References: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Sat, 20 Oct 2018 01:12:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FS.FetchStatus reply delivery function was updating inode of the
directory in which a lookup had been done with the status of the looked up
file.  This corrupts some of the directory state.

Fixes: 5cf9dd55a0ec ("afs: Prospectively look up extra files when doing a single lookup")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/fsclient.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 5e3027f21390..f758750e81d8 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -2026,7 +2026,7 @@ static int afs_deliver_fs_fetch_status(struct afs_call *call)
 	struct afs_file_status *status = call->reply[1];
 	struct afs_callback *callback = call->reply[2];
 	struct afs_volsync *volsync = call->reply[3];
-	struct afs_vnode *vnode = call->reply[0];
+	struct afs_fid *fid = call->reply[0];
 	const __be32 *bp;
 	int ret;
 
@@ -2034,21 +2034,15 @@ static int afs_deliver_fs_fetch_status(struct afs_call *call)
 	if (ret < 0)
 		return ret;
 
-	_enter("{%llx:%llu}", vnode->fid.vid, vnode->fid.vnode);
+	_enter("{%llx:%llu}", fid->vid, fid->vnode);
 
 	/* unmarshall the reply once we've received all of it */
 	bp = call->buffer;
-	ret = afs_decode_status(call, &bp, status, vnode,
+	ret = afs_decode_status(call, &bp, status, NULL,
 				&call->expected_version, NULL);
 	if (ret < 0)
 		return ret;
-	callback[call->count].version	= ntohl(bp[0]);
-	callback[call->count].expiry	= ntohl(bp[1]);
-	callback[call->count].type	= ntohl(bp[2]);
-	if (vnode)
-		xdr_decode_AFSCallBack(call, vnode, &bp);
-	else
-		bp += 3;
+	xdr_decode_AFSCallBack_raw(&bp, callback);
 	if (volsync)
 		xdr_decode_AFSVolSync(&bp, volsync);
 
@@ -2089,7 +2083,7 @@ int afs_fs_fetch_status(struct afs_fs_cursor *fc,
 	}
 
 	call->key = fc->key;
-	call->reply[0] = NULL; /* vnode for fid[0] */
+	call->reply[0] = fid;
 	call->reply[1] = status;
 	call->reply[2] = callback;
 	call->reply[3] = volsync;

