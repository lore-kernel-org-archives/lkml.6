Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A009ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E58214C2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E58214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeJTJWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:22:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbeJTJV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:21:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA7413082AF5;
        Sat, 20 Oct 2018 01:13:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACBD46DB8E;
        Sat, 20 Oct 2018 01:13:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 23/24] afs: Fix callback handling
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 20 Oct 2018 02:13:24 +0100
Message-ID: <153999800493.866.1168613158575237512.stgit@warthog.procyon.org.uk>
In-Reply-To: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
References: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Sat, 20 Oct 2018 01:13:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some circumstances, the callback interest pointer is NULL, so in such a
case we can't dereference it when checking to see if the callback is
broken.  This causes an oops in some circumstances.

Fix this by replacing the function that worked out the aggregate break
counter with one that actually does the comparison, and then make that
return true (ie. broken) if there is no callback interest as yet (ie. the
pointer is NULL).

Fixes: 68251f0a6818 ("afs: Fix whole-volume callback handling")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/fsclient.c  |    2 +-
 fs/afs/internal.h  |    9 ++++++---
 fs/afs/security.c  |    7 ++++---
 fs/afs/yfsclient.c |    2 +-
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 3975969719de..7c75a1813321 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -269,7 +269,7 @@ static void xdr_decode_AFSCallBack(struct afs_call *call,
 
 	write_seqlock(&vnode->cb_lock);
 
-	if (call->cb_break == afs_cb_break_sum(vnode, cbi)) {
+	if (!afs_cb_is_broken(call->cb_break, vnode, cbi)) {
 		vnode->cb_version	= ntohl(*bp++);
 		cb_expiry		= ntohl(*bp++);
 		vnode->cb_type		= ntohl(*bp++);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index e5b596bd8acf..b60d15212975 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -776,10 +776,13 @@ static inline unsigned int afs_calc_vnode_cb_break(struct afs_vnode *vnode)
 	return vnode->cb_break + vnode->cb_s_break + vnode->cb_v_break;
 }
 
-static inline unsigned int afs_cb_break_sum(struct afs_vnode *vnode,
-					    struct afs_cb_interest *cbi)
+static inline bool afs_cb_is_broken(unsigned int cb_break,
+				    const struct afs_vnode *vnode,
+				    const struct afs_cb_interest *cbi)
 {
-	return vnode->cb_break + cbi->server->cb_s_break + vnode->volume->cb_v_break;
+	return !cbi || cb_break != (vnode->cb_break +
+				    cbi->server->cb_s_break +
+				    vnode->volume->cb_v_break);
 }
 
 /*
diff --git a/fs/afs/security.c b/fs/afs/security.c
index d1ae53fd3739..5f58a9a17e69 100644
--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -147,7 +147,8 @@ void afs_cache_permit(struct afs_vnode *vnode, struct key *key,
 					break;
 				}
 
-				if (cb_break != afs_cb_break_sum(vnode, vnode->cb_interest)) {
+				if (afs_cb_is_broken(cb_break, vnode,
+						     vnode->cb_interest)) {
 					changed = true;
 					break;
 				}
@@ -177,7 +178,7 @@ void afs_cache_permit(struct afs_vnode *vnode, struct key *key,
 		}
 	}
 
-	if (cb_break != afs_cb_break_sum(vnode, vnode->cb_interest))
+	if (afs_cb_is_broken(cb_break, vnode, vnode->cb_interest))
 		goto someone_else_changed_it;
 
 	/* We need a ref on any permits list we want to copy as we'll have to
@@ -256,7 +257,7 @@ void afs_cache_permit(struct afs_vnode *vnode, struct key *key,
 
 	spin_lock(&vnode->lock);
 	zap = rcu_access_pointer(vnode->permit_cache);
-	if (cb_break == afs_cb_break_sum(vnode, vnode->cb_interest) &&
+	if (!afs_cb_is_broken(cb_break, vnode, vnode->cb_interest) &&
 	    zap == permits)
 		rcu_assign_pointer(vnode->permit_cache, replacement);
 	else
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index d5e3f0095040..12658c1363ae 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -324,7 +324,7 @@ static void xdr_decode_YFSCallBack(struct afs_call *call,
 
 	write_seqlock(&vnode->cb_lock);
 
-	if (call->cb_break == afs_cb_break_sum(vnode, cbi)) {
+	if (!afs_cb_is_broken(call->cb_break, vnode, cbi)) {
 		cb_expiry = xdr_to_u64(xdr->expiration_time);
 		do_div(cb_expiry, 10 * 1000 * 1000);
 		vnode->cb_version	= ntohl(xdr->version);

