Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7894DC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3454F20881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3454F20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbeJOT16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:27:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbeJOT16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:27:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7168D308FB97;
        Mon, 15 Oct 2018 11:43:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 258575D76E;
        Mon, 15 Oct 2018 11:43:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix clearance of reply
From:   David Howells <dhowells@redhat.com>
To:     gregkh@linuxfoundation.org, torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date:   Mon, 15 Oct 2018 12:43:02 +0100
Message-ID: <153960378222.7221.8576360303007809015.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 15 Oct 2018 11:43:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent patch to fix the afs_server struct leak didn't actually fix the
bug, but rather fixed some of the symptoms.  The problem is that an
asynchronous call that holds a resource pointed to by call->reply[0] will
find the pointer cleared in the call destructor, thereby preventing the
resource from being cleaned up.

In the case of the server record leak, the afs_fs_get_capabilities()
function in devel code sets up a call with reply[0] pointing at the server
record that should be altered when the result is obtained, but this was
being cleared before the destructor was called, so the put in the
destructor does nothing and the record is leaked.

Commit f014ffb025c1 removed the additional ref obtained by
afs_install_server(), but the removal of this ref is actually used by the
garbage collector to mark a server record as being defunct after the record
has expired through lack of use.

The offending clearance of call->reply[0] upon completion in
afs_process_async_call() has been there from the origin of the code, but
none of the asynchronous calls actually use that pointer currently, so it
should be safe to remove (note that synchronous calls don't involve this
function).

Fix this by the following means:

 (1) Revert commit f014ffb025c1.

 (2) Remove the clearance of reply[0] from afs_process_async_call().

Without this, afs_manage_servers() will suffer an assertion failure if it
sees a server record that didn't get used because the usage count is not 1.

Fixes: f014ffb025c1 ("afs: Fix afs_server struct leak")
Fixes: 08e0e7c82eea ("[AF_RXRPC]: Make the in-kernel AFS filesystem use AF_RXRPC.")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/rxrpc.c  |    2 --
 fs/afs/server.c |    2 --
 2 files changed, 4 deletions(-)

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 748b37b130a2..9bbb8af000b4 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -620,8 +620,6 @@ static void afs_process_async_call(struct work_struct *work)
 	}
 
 	if (call->state == AFS_CALL_COMPLETE) {
-		call->reply[0] = NULL;
-
 		/* We have two refs to release - one from the alloc and one
 		 * queued with the work item - and we can't just deallocate the
 		 * call because the work item may be queued again.
diff --git a/fs/afs/server.c b/fs/afs/server.c
index d5ef05e24e18..1a087eb8f2d7 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -199,11 +199,9 @@ static struct afs_server *afs_install_server(struct afs_net *net,
 
 	write_sequnlock(&net->fs_addr_lock);
 	ret = 0;
-	goto out;
 
 exists:
 	afs_get_server(server);
-out:
 	write_sequnlock(&net->fs_lock);
 	return server;
 }

