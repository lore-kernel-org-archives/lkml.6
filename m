Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF25C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFD920652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfAQP1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:27:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbfAQP1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:27:52 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9682D935C9;
        Thu, 17 Jan 2019 15:27:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-128.rdu2.redhat.com [10.10.120.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8886D10A48D4;
        Thu, 17 Jan 2019 15:27:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/6] afs: Don't set vnode->cb_s_break in afs_validate()
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Marc Dionne <marc.dionne@auristor.com>, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 17 Jan 2019 15:27:50 +0000
Message-ID: <154773887076.24105.174798845449873807.stgit@warthog.procyon.org.uk>
In-Reply-To: <154773884927.24105.2730570814701376379.stgit@warthog.procyon.org.uk>
References: <154773884927.24105.2730570814701376379.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 17 Jan 2019 15:27:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Dionne <marc.dionne@auristor.com>

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
---

 fs/afs/inode.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 6b17d3620414..211343831c30 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -414,7 +414,6 @@ int afs_validate(struct afs_vnode *vnode, struct key *key)
 	} else if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
 		valid = true;
 	} else {
-		vnode->cb_s_break = vnode->cb_interest->server->cb_s_break;
 		vnode->cb_v_break = vnode->volume->cb_v_break;
 		valid = false;
 	}

