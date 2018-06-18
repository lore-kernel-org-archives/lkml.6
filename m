Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7B0C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FA3208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FA3208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966493AbeFRJXK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:23:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57546 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966389AbeFRI1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:27:09 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 71AF1C7A;
        Mon, 18 Jun 2018 08:27:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 253/279] afs: Fix the handling of CB.InitCallBackState3 to find the server by UUID
Date:   Mon, 18 Jun 2018 10:13:58 +0200
Message-Id: <20180618080619.211203367@linuxfoundation.org>
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

[ Upstream commit 001ab5a67ee5d191c64aebf4b4ef8c7a0dcfd2bc ]

Fix the handling of the CB.InitCallBackState3 service call to find the
record of a server that we're using by looking it up by the UUID passed as
the parameter rather than by its address (of which it might have many, and
which may change).

Fixes: c35eccb1f614 ("[AFS]: Implement the CB.InitCallBackState3 operation.")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/afs/cmservice.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -341,7 +341,6 @@ static int afs_deliver_cb_init_call_back
  */
 static int afs_deliver_cb_init_call_back_state3(struct afs_call *call)
 {
-	struct sockaddr_rxrpc srx;
 	struct afs_server *server;
 	struct afs_uuid *r;
 	unsigned loop;
@@ -398,8 +397,9 @@ static int afs_deliver_cb_init_call_back
 
 	/* we'll need the file server record as that tells us which set of
 	 * vnodes to operate upon */
-	rxrpc_kernel_get_peer(call->net->socket, call->rxcall, &srx);
-	server = afs_find_server(call->net, &srx);
+	rcu_read_lock();
+	server = afs_find_server_by_uuid(call->net, call->request);
+	rcu_read_unlock();
 	if (!server)
 		return -ENOTCONN;
 	call->cm_server = server;


