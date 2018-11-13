Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39003C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E764822522
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtoeGpzV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E764822522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732274AbeKMPrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:47:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:33856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732221AbeKMPry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:47:54 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E70422529;
        Tue, 13 Nov 2018 05:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088286;
        bh=0+qUUorToCUDKC7tEPcD5MWoXpxUCyHI15pTI1x1Crk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YtoeGpzVBl0p0PyXu8nOg29o0DRLI39E5pGHsVGfVqqKmXPHiALE+8cTplXr8fGcA
         LU9KFPVwPoGi+0KWkGJhf2GR3NSiAvV+rC0/8VKeS0XGtxSwVhmFgVSyHPJenOrfL5
         YPyuUTI3koGSWCJhbtFuwHThxH0F8mmKmG/5d0XI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-afs@lists.infradead.org
Subject: [PATCH AUTOSEL 4.18 20/39] afs: Handle EIO from delivery function
Date:   Tue, 13 Nov 2018 00:50:34 -0500
Message-Id: <20181113055053.78352-20-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055053.78352-1-sashal@kernel.org>
References: <20181113055053.78352-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

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
index b6735ae3334e..167748df87eb 100644
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

