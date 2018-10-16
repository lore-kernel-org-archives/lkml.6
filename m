Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4801EC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 118D521477
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5u3LSr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118D521477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbeJQBG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:06:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728422AbeJQBG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:06:58 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 333592089E;
        Tue, 16 Oct 2018 17:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710133;
        bh=TbY17Jf0SnyPu7F6grMWhfbxNs3GPunck/oCLjLMdfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e5u3LSr6TktQAJSFM1ZOA1Azxmn5ONZEFt8o5QtggmkpmYX2Nz9hR8D5EeXLcoMz5
         TCaV3NLkGhF35CLWs0mUw4dAiTRLhEG8KbXHabxYRpXIdyXG1/aZtscTi7A0vR/1w8
         jQC7vQUMoXJ+txoyI2+ICc/oO0UnwDuWWFNlczMU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH 4.18 112/135] afs: Fix clearance of reply
Date:   Tue, 16 Oct 2018 19:05:42 +0200
Message-Id: <20181016170523.063427203@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit f0a7d1883d9f78ae7bf15fc258bf9a2b20f35b76 upstream.

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
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/afs/rxrpc.c  |    2 --
 fs/afs/server.c |    2 --
 2 files changed, 4 deletions(-)

--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -690,8 +690,6 @@ static void afs_process_async_call(struc
 	}
 
 	if (call->state == AFS_CALL_COMPLETE) {
-		call->reply[0] = NULL;
-
 		/* We have two refs to release - one from the alloc and one
 		 * queued with the work item - and we can't just deallocate the
 		 * call because the work item may be queued again.
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -199,11 +199,9 @@ static struct afs_server *afs_install_se
 
 	write_sequnlock(&net->fs_addr_lock);
 	ret = 0;
-	goto out;
 
 exists:
 	afs_get_server(server);
-out:
 	write_sequnlock(&net->fs_lock);
 	return server;
 }


