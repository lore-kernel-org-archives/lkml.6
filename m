Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6771AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332F820652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfAQP2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:28:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbfAQP2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:28:06 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D7ED12E505;
        Thu, 17 Jan 2019 15:28:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-128.rdu2.redhat.com [10.10.120.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67DF71C933;
        Thu, 17 Jan 2019 15:28:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 5/6] afs: Provide a function to get a ref on a call
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 17 Jan 2019 15:28:04 +0000
Message-ID: <154773888465.24105.5122235102200680723.stgit@warthog.procyon.org.uk>
In-Reply-To: <154773884927.24105.2730570814701376379.stgit@warthog.procyon.org.uk>
References: <154773884927.24105.2730570814701376379.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 17 Jan 2019 15:28:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a function to get a reference on an afs_call struct.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/rxrpc.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index a7b44863d502..4830e0a6bf1d 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -203,20 +203,26 @@ void afs_put_call(struct afs_call *call)
 	}
 }
 
+static struct afs_call *afs_get_call(struct afs_call *call,
+				     enum afs_call_trace why)
+{
+	int u = atomic_inc_return(&call->usage);
+
+	trace_afs_call(call, why, u,
+		       atomic_read(&call->net->nr_outstanding_calls),
+		       __builtin_return_address(0));
+	return call;
+}
+
 /*
  * Queue the call for actual work.
  */
 static void afs_queue_call_work(struct afs_call *call)
 {
 	if (call->type->work) {
-		int u = atomic_inc_return(&call->usage);
-
-		trace_afs_call(call, afs_call_trace_work, u,
-			       atomic_read(&call->net->nr_outstanding_calls),
-			       __builtin_return_address(0));
-
 		INIT_WORK(&call->work, call->type->work);
 
+		afs_get_call(call, afs_call_trace_work);
 		if (!queue_work(afs_wq, &call->work))
 			afs_put_call(call);
 	}

