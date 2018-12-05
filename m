Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F8CC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798EC206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qj68u1eW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798EC206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbeLEJlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:41:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:46228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727564AbeLEJln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:41:43 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A92820850;
        Wed,  5 Dec 2018 09:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002901;
        bh=Sim1mrP5hkkRaJ4B3924zh8vsZq6+DKU1GAaQ98dXng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qj68u1eW+LAnhgPfjaHudYl0nEscHreX/LuVzOjCJTSyEfw7wCrA8vJrLMr3HtkbP
         T2tsrHwpeCBaBBBzhgEyPGQW2rDEpjtN0Odl4soFVqPV5IPR310Gpsewmi/nMYYcJ8
         SQqIt1EwhqdaLok9DLRLmUk8DyqIBCZMHE7RF+5w=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>, linux-afs@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 105/123] afs: Fix validation/callback interaction
Date:   Wed,  5 Dec 2018 04:35:37 -0500
Message-Id: <20181205093555.5386-105-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit ae3b7361dc0ee9a425bf7d77ce211f533500b39b ]

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
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/inode.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 479b7fdda124..071075d775a9 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -379,7 +379,7 @@ void afs_zap_data(struct afs_vnode *vnode)
 int afs_validate(struct afs_vnode *vnode, struct key *key)
 {
 	time64_t now = ktime_get_real_seconds();
-	bool valid = false;
+	bool valid;
 	int ret;
 
 	_enter("{v={%x:%u} fl=%lx},%x",
@@ -399,15 +399,21 @@ int afs_validate(struct afs_vnode *vnode, struct key *key)
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
-- 
2.17.1

