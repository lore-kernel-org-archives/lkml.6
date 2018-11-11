Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48A4C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F5F214F1
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBtmAdAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F5F214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391368AbeKLI31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:29:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:32982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404978AbeKLIZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:25:14 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38624224E0;
        Sun, 11 Nov 2018 22:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975715;
        bh=YzyOdCyy8uQQA/5ap6VIjVN1jo2ZVVslEjGudE3MEOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tBtmAdAiiNgqs43VH31ZKLrwQgwzJuL3D7TWhf/W8/XHfEzQyPgMrzu7TM0xeViFQ
         pxT+/qeHgMUxQe9NfIXuxU9ZkWRDwTPc/sbBdYzifV9AQumVMCcM4NwdUZyFoxtYGL
         MOg23HK5LigSZM6Vh1geEId+Zwa5uFeW+gpAG1qI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4.9 111/141] NFSv4.1: Fix the r/wsize checking
Date:   Sun, 11 Nov 2018 14:26:10 -0800
Message-Id: <20181111221643.282839886@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit 943cff67b842839f4f35364ba2db5c2d3f025d94 upstream.

The intention of nfs4_session_set_rwsize() was to cap the r/wsize to the
buffer sizes negotiated by the CREATE_SESSION. The initial code had a
bug whereby we would not check the values negotiated by nfs_probe_fsinfo()
(the assumption being that CREATE_SESSION will always negotiate buffer values
that are sane w.r.t. the server's preferred r/wsizes) but would only check
values set by the user in the 'mount' command.

The code was changed in 4.11 to _always_ set the r/wsize, meaning that we
now never use the server preferred r/wsizes. This is the regression that
this patch fixes.
Also rename the function to nfs4_session_limit_rwsize() in order to avoid
future confusion.

Fixes: 033853325fe3 (NFSv4.1 respect server's max size in CREATE_SESSION")
Cc: stable@vger.kernel.org # v4.11+
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/nfs4client.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -988,10 +988,10 @@ EXPORT_SYMBOL_GPL(nfs4_set_ds_client);
 
 /*
  * Session has been established, and the client marked ready.
- * Set the mount rsize and wsize with negotiated fore channel
- * attributes which will be bound checked in nfs_server_set_fsinfo.
+ * Limit the mount rsize, wsize and dtsize using negotiated fore
+ * channel attributes.
  */
-static void nfs4_session_set_rwsize(struct nfs_server *server)
+static void nfs4_session_limit_rwsize(struct nfs_server *server)
 {
 #ifdef CONFIG_NFS_V4_1
 	struct nfs4_session *sess;
@@ -1004,9 +1004,11 @@ static void nfs4_session_set_rwsize(stru
 	server_resp_sz = sess->fc_attrs.max_resp_sz - nfs41_maxread_overhead;
 	server_rqst_sz = sess->fc_attrs.max_rqst_sz - nfs41_maxwrite_overhead;
 
-	if (!server->rsize || server->rsize > server_resp_sz)
+	if (server->dtsize > server_resp_sz)
+		server->dtsize = server_resp_sz;
+	if (server->rsize > server_resp_sz)
 		server->rsize = server_resp_sz;
-	if (!server->wsize || server->wsize > server_rqst_sz)
+	if (server->wsize > server_rqst_sz)
 		server->wsize = server_rqst_sz;
 #endif /* CONFIG_NFS_V4_1 */
 }
@@ -1053,12 +1055,12 @@ static int nfs4_server_common_setup(stru
 			(unsigned long long) server->fsid.minor);
 	nfs_display_fhandle(mntfh, "Pseudo-fs root FH");
 
-	nfs4_session_set_rwsize(server);
-
 	error = nfs_probe_fsinfo(server, mntfh, fattr);
 	if (error < 0)
 		goto out;
 
+	nfs4_session_limit_rwsize(server);
+
 	if (server->namelen == 0 || server->namelen > NFS4_MAXNAMLEN)
 		server->namelen = NFS4_MAXNAMLEN;
 


