Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9BAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1689620835
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1689620835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbeKNJUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 04:20:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbeKNJUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 04:20:53 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4624C0669C0;
        Tue, 13 Nov 2018 23:20:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1168101960A;
        Tue, 13 Nov 2018 23:20:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/3] afs: Fix validation/callback interaction
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 13 Nov 2018 23:20:21 +0000
Message-ID: <154215122104.3727.7941494935890131525.stgit@warthog.procyon.org.uk>
In-Reply-To: <154215121391.3727.8471308154885635876.stgit@warthog.procyon.org.uk>
References: <154215121391.3727.8471308154885635876.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 13 Nov 2018 23:20:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When afs_validate() is called to validate a vnode (inode), there are two
unhandled cases in the fastpath at the top of the function:

 (1) If the vnode is promised (AFS_VNODE_CB_PROMISED is set), the break
     counters match and the data has expired, then there's an implicit case
     in which the vnode needs revalidating.

     This has no consequences since the default "valid = false" set at the
     top of the function happens to do the right thing.

 (2) If the vnode is not promised and it hasn't been deleted
     (AFS_VNODE_DELETED is not set) then there's a default case we're not
     handling in which the vnode is invalid.  If the vnode is invalid, we
     need to bring cb_s_break and cb_v_break up to date before we refetch
     the status.

     As a consequence, once the server loses track of the client
     (ie. sufficient time has passed since we last sent it an operation),
     it will send us a CB.InitCallBackState* operation when we next try to
     talk to it.  This calls afs_init_callback_state() which increments
     afs_server::cb_s_break, but this then doesn't propagate to the
     afs_vnode record.

     The result being that every afs_validate() call thereafter sends a
     status fetch operation to the server.

Clarify and fix this by:

 (A) Setting valid in all the branches rather than initialising it at the
     top so that the compiler catches where we've missed.

 (B) Restructuring the logic in the 'promised' branch so that we set valid
     to false if the callback is due to expire (or has expired) and so that
     the final case is that the vnode is still valid.

 (C) Adding an else-statement that ups cb_s_break and cb_v_break if the
     promised and deleted cases don't match.

Fixes: c435ee34551e ("afs: Overhaul the callback handling")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/inode.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 4c6d8e1112c2..6b17d3620414 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -382,7 +382,7 @@ void afs_zap_data(struct afs_vnode *vnode)
 int afs_validate(struct afs_vnode *vnode, struct key *key)
 {
 	time64_t now = ktime_get_real_seconds();
-	bool valid = false;
+	bool valid;
 	int ret;
 
 	_enter("{v={%llx:%llu} fl=%lx},%x",
@@ -402,15 +402,21 @@ int afs_validate(struct afs_vnode *vnode, struct key *key)
 			vnode->cb_v_break = vnode->volume->cb_v_break;
 			valid = false;
 		} else if (vnode->status.type == AFS_FTYPE_DIR &&
-			   test_bit(AFS_VNODE_DIR_VALID, &vnode->flags) &&
-			   vnode->cb_expires_at - 10 > now) {
-			valid = true;
-		} else if (!test_bit(AFS_VNODE_ZAP_DATA, &vnode->flags) &&
-			   vnode->cb_expires_at - 10 > now) {
+			   (!test_bit(AFS_VNODE_DIR_VALID, &vnode->flags) ||
+			    vnode->cb_expires_at - 10 <= now)) {
+			valid = false;
+		} else if (test_bit(AFS_VNODE_ZAP_DATA, &vnode->flags) ||
+			   vnode->cb_expires_at - 10 <= now) {
+			valid = false;
+		} else {
 			valid = true;
 		}
 	} else if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
 		valid = true;
+	} else {
+		vnode->cb_s_break = vnode->cb_interest->server->cb_s_break;
+		vnode->cb_v_break = vnode->volume->cb_v_break;
+		valid = false;
 	}
 
 	read_sequnlock_excl(&vnode->cb_lock);

