Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91F1C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7092120652
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7092120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965404AbeFRJ7I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:59:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54868 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935442AbeFRITZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:19:25 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7E0AAC7A;
        Mon, 18 Jun 2018 08:19:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 062/279] afs: Fix server record deletion
Date:   Mon, 18 Jun 2018 10:10:47 +0200
Message-Id: <20180618080611.400153532@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 660625922b3d9fcb376e5870299bc5c1086e1d32 ]

AFS server records get removed from the net->fs_servers tree when
they're deleted, but not from the net->fs_addresses{4,6} lists, which
can lead to an oops in afs_find_server() when a server record has been
removed, for instance during rmmod.

Fix this by deleting the record from the by-address lists before posting
it for RCU destruction.

The reason this hasn't been noticed before is that the fileserver keeps
probing the local cache manager, thereby keeping the service record
alive, so the oops would only happen when a fileserver eventually gets
bored and stops pinging or if the module gets rmmod'd and a call comes
in from the fileserver during the window between the server records
being destroyed and the socket being closed.

The oops looks something like:

  BUG: unable to handle kernel NULL pointer dereference at 000000000000001c
  ...
  Workqueue: kafsd afs_process_async_call [kafs]
  RIP: 0010:afs_find_server+0x271/0x36f [kafs]
  ...
  Call Trace:
   afs_deliver_cb_init_call_back_state3+0x1f2/0x21f [kafs]
   afs_deliver_to_call+0x1ee/0x5e8 [kafs]
   afs_process_async_call+0x5b/0xd0 [kafs]
   process_one_work+0x2c2/0x504
   worker_thread+0x1d4/0x2ac
   kthread+0x11f/0x127
   ret_from_fork+0x24/0x30

Fixes: d2ddc776a458 ("afs: Overhaul volume and server record caching and fileserver rotation")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/afs/server.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -426,8 +426,15 @@ static void afs_gc_servers(struct afs_ne
 		}
 		write_sequnlock(&net->fs_lock);
 
-		if (deleted)
+		if (deleted) {
+			write_seqlock(&net->fs_addr_lock);
+			if (!hlist_unhashed(&server->addr4_link))
+				hlist_del_rcu(&server->addr4_link);
+			if (!hlist_unhashed(&server->addr6_link))
+				hlist_del_rcu(&server->addr6_link);
+			write_sequnlock(&net->fs_addr_lock);
 			afs_destroy_server(net, server);
+		}
 	}
 }
 


