Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7C1C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51918222CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025382;
	bh=XTI987AEHSt822ZvPEbGQtEQzqNj4edSVwAnWZ7Wy4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qBewRQcMtSChtNR5Z29xZLlu/0HjhlyHfr+8+O8tyqxQtaLfxZ9lFzI1AaLgGr4Vw
	 KPUToKhe76dmpgNM83ggESZR1nflwf5qKHFkPbtnUzkHGliDLhO/BnOyjmeI/XfqbT
	 XXSpjGOGDtOMdCyjNXoqffZNpXC6ljJ9EAPefEbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbfBMCgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:36:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:39898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730336AbfBMCgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:36:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A189A222C7;
        Wed, 13 Feb 2019 02:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025377;
        bh=XTI987AEHSt822ZvPEbGQtEQzqNj4edSVwAnWZ7Wy4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nun+92HPeb2+Yw2oTiTYrpRjS928EtCelfwFnw0XK3VQ2uvclPCDUGDHMirVzuazN
         c7Fd5Dioi7vnpcA9R1A2iDAdXQkiWugaTTFlNYu52VS7B9nhy9gsfHpg6FisA1eARu
         lngu9DDCT2XWoLfpiCtTOBtpQhPV+rz3o36MQVU8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-afs@lists.infradead.org
Subject: [PATCH AUTOSEL 4.20 087/105] afs: Provide a function to get a ref on a call
Date:   Tue, 12 Feb 2019 21:33:18 -0500
Message-Id: <20190213023336.19019-87-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit 7a75b0079a1d54e342c502c3c8107ba97e05d3d3 ]

Provide a function to get a reference on an afs_call struct.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/rxrpc.c | 18 ++++++++++++------
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
-- 
2.19.1

