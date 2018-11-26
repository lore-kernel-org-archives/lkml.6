Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE75FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EA22146F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkbBDITy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6EA22146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbeKZVzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:55:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:38670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729305AbeKZVzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:55:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F07320817;
        Mon, 26 Nov 2018 11:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230124;
        bh=KRcv30qXsL7Yd6ThmWA8m1AfwlQzpveyrMaNG9PMcOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jkbBDITyjRvZNDLyrd1uQAo7c0fWqs90/ikOwaynx+AF5jauDw/n2EIEAIuapMWTl
         tJ0gQ4VokkbN4qjIvr3JlZZS/7idmjftVKTcJEy5N+cbEO3spaibQCiscFNMz7oswb
         cbTCTzR2buVxyKfoKXRnzu2upRHycNYl8jSZIFno=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 018/118] afs: Handle EIO from delivery function
Date:   Mon, 26 Nov 2018 11:50:12 +0100
Message-Id: <20181126105100.562998074@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4ac15ea53622272c01954461b4814892b7481b40 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/rxrpc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 77a83790a31f..2543f24d23f8 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -500,7 +500,6 @@ static void afs_deliver_to_call(struct afs_call *call)
 		case -EINPROGRESS:
 		case -EAGAIN:
 			goto out;
-		case -EIO:
 		case -ECONNABORTED:
 			ASSERTCMP(state, ==, AFS_CALL_COMPLETE);
 			goto done;
@@ -509,6 +508,10 @@ static void afs_deliver_to_call(struct afs_call *call)
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
-- 
2.17.1



