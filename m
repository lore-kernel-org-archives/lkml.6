Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F3DC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB5621726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360134;
	bh=aMb6kBX7NGR3zvOoH3QSyrWHV1kuvUMxREKAVrQ3J3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GRAANj8W5K6Bhq8WR28EJvZz2nhtmRVJV8bQMhuVGMtGBKbJRFPwGUAV/JfjGQ10k
	 CXISg0azHq+zNOI4hM+zCSLQlfx9niMYIslAaRW8lp+brz62cRG9WXQW7Kcv6a8MFg
	 qz1Bwxuwu7XdIkAioSh6kBup2NyKrMg7+3Ojq7WE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731994AbfAXTdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:33:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:33074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731979AbfAXTdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:33:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B6E8218D4;
        Thu, 24 Jan 2019 19:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358396;
        bh=aMb6kBX7NGR3zvOoH3QSyrWHV1kuvUMxREKAVrQ3J3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T8jLg08U7Zh/ioyAXhNkSuscRS0YnIZ/ae8O1VqooGD5iTupgYuAPp+tRXRLbf/dW
         RahhYKDmtO8ZRO1+A6bQXXqNB05GLz9pkRb3Zxq6dkBoSQd7LvG1sprggkyvOikZiV
         xnWXTIlUq6D4CCT9H9zOHdoG9Sg5DQPg7T1doxQg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Mayhew <smayhew@redhat.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Qian Lu <luqia@amazon.com>
Subject: [PATCH 4.14 58/63] nfs: fix a deadlock in nfs client initialization
Date:   Thu, 24 Jan 2019 20:20:47 +0100
Message-Id: <20190124190202.138301116@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190155.176570028@linuxfoundation.org>
References: <20190124190155.176570028@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Scott Mayhew <smayhew@redhat.com>

commit c156618e15101a9cc8c815108fec0300a0ec6637 upstream.

The following deadlock can occur between a process waiting for a client
to initialize in while walking the client list during nfsv4 server trunking
detection and another process waiting for the nfs_clid_init_mutex so it
can initialize that client:

Process 1                               Process 2
---------                               ---------
spin_lock(&nn->nfs_client_lock);
list_add_tail(&CLIENTA->cl_share_link,
        &nn->nfs_client_list);
spin_unlock(&nn->nfs_client_lock);
                                        spin_lock(&nn->nfs_client_lock);
                                        list_add_tail(&CLIENTB->cl_share_link,
                                                &nn->nfs_client_list);
                                        spin_unlock(&nn->nfs_client_lock);
                                        mutex_lock(&nfs_clid_init_mutex);
                                        nfs41_walk_client_list(clp, result, cred);
                                        nfs_wait_client_init_complete(CLIENTA);
(waiting for nfs_clid_init_mutex)

Make sure nfs_match_client() only evaluates clients that have completed
initialization in order to prevent that deadlock.

This patch also fixes v4.0 trunking behavior by not marking the client
NFS_CS_READY until the clientid has been confirmed.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Qian Lu <luqia@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/client.c     |   11 +++++++++++
 fs/nfs/nfs4client.c |   17 +++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -291,12 +291,23 @@ static struct nfs_client *nfs_match_clie
 	const struct sockaddr *sap = data->addr;
 	struct nfs_net *nn = net_generic(data->net, nfs_net_id);
 
+again:
 	list_for_each_entry(clp, &nn->nfs_client_list, cl_share_link) {
 	        const struct sockaddr *clap = (struct sockaddr *)&clp->cl_addr;
 		/* Don't match clients that failed to initialise properly */
 		if (clp->cl_cons_state < 0)
 			continue;
 
+		/* If a client is still initializing then we need to wait */
+		if (clp->cl_cons_state > NFS_CS_READY) {
+			atomic_inc(&clp->cl_count);
+			spin_unlock(&nn->nfs_client_lock);
+			nfs_wait_client_init_complete(clp);
+			nfs_put_client(clp);
+			spin_lock(&nn->nfs_client_lock);
+			goto again;
+		}
+
 		/* Different NFS versions cannot share the same nfs_client */
 		if (clp->rpc_ops != data->nfs_mod->rpc_ops)
 			continue;
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -404,15 +404,19 @@ struct nfs_client *nfs4_init_client(stru
 	if (error < 0)
 		goto error;
 
-	if (!nfs4_has_session(clp))
-		nfs_mark_client_ready(clp, NFS_CS_READY);
-
 	error = nfs4_discover_server_trunking(clp, &old);
 	if (error < 0)
 		goto error;
 
-	if (clp != old)
+	if (clp != old) {
 		clp->cl_preserve_clid = true;
+		/*
+		 * Mark the client as having failed initialization so other
+		 * processes walking the nfs_client_list in nfs_match_client()
+		 * won't try to use it.
+		 */
+		nfs_mark_client_ready(clp, -EPERM);
+	}
 	nfs_put_client(clp);
 	clear_bit(NFS_CS_TSM_POSSIBLE, &clp->cl_flags);
 	return old;
@@ -539,6 +543,9 @@ int nfs40_walk_client_list(struct nfs_cl
 	spin_lock(&nn->nfs_client_lock);
 	list_for_each_entry(pos, &nn->nfs_client_list, cl_share_link) {
 
+		if (pos == new)
+			goto found;
+
 		status = nfs4_match_client(pos, new, &prev, nn);
 		if (status < 0)
 			goto out_unlock;
@@ -559,6 +566,7 @@ int nfs40_walk_client_list(struct nfs_cl
 		 * way that a SETCLIENTID_CONFIRM to pos can succeed is
 		 * if new and pos point to the same server:
 		 */
+found:
 		atomic_inc(&pos->cl_count);
 		spin_unlock(&nn->nfs_client_lock);
 
@@ -572,6 +580,7 @@ int nfs40_walk_client_list(struct nfs_cl
 		case 0:
 			nfs4_swap_callback_idents(pos, new);
 			pos->cl_confirm = new->cl_confirm;
+			nfs_mark_client_ready(pos, NFS_CS_READY);
 
 			prev = NULL;
 			*result = pos;


