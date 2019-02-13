Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570F5C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BDE21934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026278;
	bh=Qh9bsEsEr35ZlKzDoT/RoXjoU3PPlW8lu0vCb05fTWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vii36Sn9BuDt6r9lOAXwjqIL4v0jAyt6jDAtkgDbPswxmwNdXIKygR/WZKtx9Vegb
	 Sgc2BDx6g/7ALuj7c+1CxK1exyjQWU6ALDqvAMsqXN1obBuZjIW7TeZgJA3855mOLq
	 hdKWhsS7nbRiyx79X7PSN4Pf+jIc8fCFdGvDNUaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388699AbfBMCj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:39:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:42916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730235AbfBMCjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:39:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1C88222C2;
        Wed, 13 Feb 2019 02:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025561;
        bh=Qh9bsEsEr35ZlKzDoT/RoXjoU3PPlW8lu0vCb05fTWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sc+qg2UdqG10XScguWE32+EFT/El0hy14B/tP6JsNgEjdB3DKZL6yMCjyTjm5mxG9
         FxTj5UCmrpOJFfnfFTbEWqY4XSj+Rj9sY68k8N4ibqjOLzaGeQKnuXeYEWPj8TA5EP
         xgtS9bGG5ygTM/+Q+Etxm9sSaFhInTngcQr+/VJo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-afs@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 68/83] afs: Don't set vnode->cb_s_break in afs_validate()
Date:   Tue, 12 Feb 2019 21:36:46 -0500
Message-Id: <20190213023701.20286-68-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Dionne <marc.dionne@auristor.com>

[ Upstream commit 4882a27cec24319d10f95e978ecc80050e3e3e15 ]

A cb_interest record is not necessarily attached to the vnode on entry to
afs_validate(), which can cause an oops when we try to bring the vnode's
cb_s_break up to date in the default case (ie. no current callback promise
and the vnode has not been deleted).

Fix this by simply removing the line, as vnode->cb_s_break will be set when
needed by afs_register_server_cb_interest() when we next get a callback
promise from RPC call.

The oops looks something like:

    BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
    ...
    RIP: 0010:afs_validate+0x66/0x250 [kafs]
    ...
    Call Trace:
     afs_d_revalidate+0x8d/0x340 [kafs]
     ? __d_lookup+0x61/0x150
     lookup_dcache+0x44/0x70
     ? lookup_dcache+0x44/0x70
     __lookup_hash+0x24/0xa0
     do_unlinkat+0x11d/0x2c0
     __x64_sys_unlink+0x23/0x30
     do_syscall_64+0x4d/0xf0
     entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: ae3b7361dc0e ("afs: Fix validation/callback interaction")
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 071075d775a9..26aa2d111a28 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -411,7 +411,6 @@ int afs_validate(struct afs_vnode *vnode, struct key *key)
 	} else if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
 		valid = true;
 	} else {
-		vnode->cb_s_break = vnode->cb_interest->server->cb_s_break;
 		vnode->cb_v_break = vnode->volume->cb_v_break;
 		valid = false;
 	}
-- 
2.19.1

