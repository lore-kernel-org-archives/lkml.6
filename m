Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452D6C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1132148E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789165;
	bh=e35lxz3Ffdp3H4PhkvHbp10FhrQtZfYTEfR7nwka9fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f6+CkDJBAcybiUs11ODXSA/FOmszT1kceTtNSMixfRcnRwjTduk0kzUcYVOLWCCof
	 ewlECEVgaeft8zL1P+XHCOMVHvYKLwGBXTCvUZlDBftEivf7TQBXdZ6OROoNqOzFUX
	 beKT0hDMW0z8fKQeaDRism8Vr6zjlBZy7xjUiHUw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1132148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbeLNMGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:06:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:50960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730381AbeLNMGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:06:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A76D921479;
        Fri, 14 Dec 2018 12:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789159;
        bh=e35lxz3Ffdp3H4PhkvHbp10FhrQtZfYTEfR7nwka9fc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O9HqeCAfiUUXRHURK2xMgkk9cF3ZDmUsTLpYEEaLB7OQbftt1TEuZMBeLg3cFUwRC
         JapRVohkoz3zyx5cnc7gWY5oY1TuL99aUsXlw5IozSXnlikIVp/KvtT19kXbWSfOk1
         W+jjhS2ZZXoLFRUv3XOFyoNkl9rVn8vJfi16orkA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 116/142] afs: Fix validation/callback interaction
Date:   Fri, 14 Dec 2018 13:00:01 +0100
Message-Id: <20181214115751.678281412@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1



