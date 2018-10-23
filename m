Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279ACC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F992075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F992075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeJXMEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 08:04:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbeJXMEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 08:04:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1448530917A1;
        Tue, 23 Oct 2018 23:59:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 422F15DA63;
        Tue, 23 Oct 2018 23:59:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/25] afs: Handle EIO from delivery function [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 24 Oct 2018 00:59:00 +0100
Message-ID: <154033914054.12041.3892002868115623285.stgit@warthog.procyon.org.uk>
In-Reply-To: <154033906284.12041.12908874734066278152.stgit@warthog.procyon.org.uk>
References: <154033906284.12041.12908874734066278152.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 23 Oct 2018 23:59:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix afs_deliver_to_call() to handle -EIO being returned by the operation
delivery function, indicating that the call found itself in the wrong
state, by printing an error and aborting the call.

Currently, an assertion failure will occur.  This can happen, say, if the
delivery function falls off the end without calling afs_extract_data() with
the want_more parameter set to false to collect the end of the Rx phase of
a call.

The assertion failure looks like:

	AFS: Assertion failed
	4 == 7 is false
	0x4 == 0x7 is false
	------------[ cut here ]------------
	kernel BUG at fs/afs/rxrpc.c:462!

and is matched in the trace buffer by a line like:

kworker/7:3-3226 [007] ...1 85158.030203: afs_io_error: c=0003be0c r=-5 CM_REPLY

Fixes: 98bf40cd99fc ("afs: Protect call->state changes against signals")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/rxrpc.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index a3904a8315de..947ae3ab389b 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -499,7 +499,6 @@ static void afs_deliver_to_call(struct afs_call *call)
 		case -EINPROGRESS:
 		case -EAGAIN:
 			goto out;
-		case -EIO:
 		case -ECONNABORTED:
 			ASSERTCMP(state, ==, AFS_CALL_COMPLETE);
 			goto done;
@@ -508,6 +507,10 @@ static void afs_deliver_to_call(struct afs_call *call)
 			rxrpc_kernel_abort_call(call->net->socket, call->rxcall,
 						abort_code, ret, "KIV");
 			goto local_abort;
+		case -EIO:
+			pr_err("kAFS: Call %u in bad state %u\n",
+			       call->debug_id, state);
+			/* Fall through */
 		case -ENODATA:
 		case -EBADMSG:
 		case -EMSGSIZE:

