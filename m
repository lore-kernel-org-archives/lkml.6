Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B3CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4994021841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130511;
	bh=rq4/tjc0CrrEE1fLQQ6DHFJpDA43W3EfeWVsHTtW6Js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E6xaDD9ggJyOLUsi/qohQOxbDleXQG4l1R8C2RDIzegUo1pyeA8QRMx1CNdAtQ/Wy
	 YgBuI/cvgUonka9hIlvEijaVq5eQthbpK/5HspX0/lI5W1fZ2607cLv8MjGFU9P7R0
	 Kyyp53OoGLON+Jaukux1vPwVFOxrlszGte3fJNqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732931AbfBYVfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:35:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:41234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732305AbfBYVfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:35:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD5D7217F5;
        Mon, 25 Feb 2019 21:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130506;
        bh=rq4/tjc0CrrEE1fLQQ6DHFJpDA43W3EfeWVsHTtW6Js=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1zzxrdtjc5NhEW2U7mSSIE4p/rd/bth034bFMS6lN+NEjA9WnCl1yhctcCQTqyDpJ
         WEd/hIX+imjCxjosRvz5cHEQ6sNlwIxzNyaxn7TfyM3cckgwH+rsKXM5G7jqes9CyV
         T9ZqC2yCfuFUxYtF81UoEs8N0l8Y5ZoVhUA3cYIo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 104/183] afs: Provide a function to get a ref on a call
Date:   Mon, 25 Feb 2019 22:11:17 +0100
Message-Id: <20190225195112.248368438@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7a75b0079a1d54e342c502c3c8107ba97e05d3d3 ]

Provide a function to get a reference on an afs_call struct.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/rxrpc.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index a7b44863d502e..4830e0a6bf1d1 100644
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
-- 
2.19.1



