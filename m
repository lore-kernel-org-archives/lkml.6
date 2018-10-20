Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C81ECDE43
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1210E214C4
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1210E214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbeJTJUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:20:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbeJTJUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:20:53 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 602E04620D;
        Sat, 20 Oct 2018 01:12:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80C0E1057047;
        Sat, 20 Oct 2018 01:12:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 14/24] afs: Remove callback details from afs_callback_break
 struct
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 20 Oct 2018 02:12:19 +0100
Message-ID: <153999793977.866.12544346332502038724.stgit@warthog.procyon.org.uk>
In-Reply-To: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
References: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sat, 20 Oct 2018 01:12:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary details of a broken callback, such as version, expiry
and type, from the afs_callback_break struct as they're not actually used
and make the list take more memory.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/afs.h       |    2 +-
 fs/afs/callback.c  |    8 ++------
 fs/afs/cmservice.c |   17 +++++------------
 3 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/fs/afs/afs.h b/fs/afs/afs.h
index c23b31b742fa..fb9bcb8758ea 100644
--- a/fs/afs/afs.h
+++ b/fs/afs/afs.h
@@ -75,7 +75,7 @@ struct afs_callback {
 
 struct afs_callback_break {
 	struct afs_fid		fid;		/* File identifier */
-	struct afs_callback	cb;		/* Callback details */
+	//struct afs_callback	cb;		/* Callback details */
 };
 
 #define AFSCBMAX 50	/* maximum callbacks transferred per bulk op */
diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 8698198ad427..df9bfee698ad 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -310,14 +310,10 @@ void afs_break_callbacks(struct afs_server *server, size_t count,
 	/* TODO: Sort the callback break list by volume ID */
 
 	for (; count > 0; callbacks++, count--) {
-		_debug("- Fid { vl=%08llx n=%llu u=%u }  CB { v=%u x=%u t=%u }",
+		_debug("- Fid { vl=%08llx n=%llu u=%u }",
 		       callbacks->fid.vid,
 		       callbacks->fid.vnode,
-		       callbacks->fid.unique,
-		       callbacks->cb.version,
-		       callbacks->cb.expiry,
-		       callbacks->cb.type
-		       );
+		       callbacks->fid.unique);
 		afs_break_one_callback(server, &callbacks->fid);
 	}
 
diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index 186f621f8722..fc0010d800a0 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -218,7 +218,6 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 			cb->fid.vid	= ntohl(*bp++);
 			cb->fid.vnode	= ntohl(*bp++);
 			cb->fid.unique	= ntohl(*bp++);
-			cb->cb.type	= AFSCM_CB_UNTYPED;
 		}
 
 		afs_extract_to_tmp(call);
@@ -236,24 +235,18 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 		if (call->count2 != call->count && call->count2 != 0)
 			return afs_protocol_error(call, -EBADMSG,
 						  afs_eproto_cb_count);
-		afs_extract_to_buf(call, call->count2 * 3 * 4);
+		call->_iter = &call->iter;
+		iov_iter_discard(&call->iter, READ, call->count2 * 3 * 4);
 		call->unmarshall++;
 
 	case 4:
-		_debug("extract CB array");
+		_debug("extract discard %zu/%u",
+		       iov_iter_count(&call->iter), call->count2 * 3 * 4);
+
 		ret = afs_extract_data(call, false);
 		if (ret < 0)
 			return ret;
 
-		_debug("unmarshall CB array");
-		cb = call->request;
-		bp = call->buffer;
-		for (loop = call->count2; loop > 0; loop--, cb++) {
-			cb->cb.version	= ntohl(*bp++);
-			cb->cb.expiry	= ntohl(*bp++);
-			cb->cb.type	= ntohl(*bp++);
-		}
-
 		call->unmarshall++;
 	case 5:
 		break;

