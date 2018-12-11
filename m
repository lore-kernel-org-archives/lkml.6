Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A347AC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616C5205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543760;
	bh=n3ssv5CCc1/08MFwH5QSaKBXoRPAXml7ZUIBBoiJWAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mmfu9k03dcrpYSde9pR6mNiEXSvpJWhC/o7oKYP3cdA0J/cFYfcYvl/cTR8SJ0TtH
	 d2JpbHaNSw3mqGeWp9x/ycR7T8tlxcQjawP5E4SyzBd2FQkX1Lpr8vbOKQJieIQvtc
	 i3E+aiJ7xcOZs86pQsNUu7A8ozWw7w9SsCmh8gQM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616C5205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbeLKPz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:55:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:44620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729246AbeLKPzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:55:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6789A21104;
        Tue, 11 Dec 2018 15:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543749;
        bh=n3ssv5CCc1/08MFwH5QSaKBXoRPAXml7ZUIBBoiJWAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pzb8hfyxwB8QJs404WgtHbCzKhujxwaECatzyRC7YhsSvc6UJhnG0vrHt59JJSfP3
         VOYGjbWmw6wTBQRiv+0UvSxeXgUwdTN6q4HI3dQL41i22uVXs9XUI/Kl+hX9vPdmZo
         DBZNTxhVMP6yfAtSvOIUZK0hrN/9PXjkbNUqo93w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 050/118] NFSv4.2 copy do not allocate memory under the lock
Date:   Tue, 11 Dec 2018 16:41:09 +0100
Message-Id: <20181211151646.268676335@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 99f2c55591fb5c1b536263970d98c2ebc2089906 ]

Bruce pointed out that we shouldn't allocate memory while holding
a lock in the nfs4_callback_offload() and handle_async_copy()
that deal with a racing CB_OFFLOAD and reply to COPY case.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/callback_proc.c | 22 +++++++++++-----------
 fs/nfs/nfs42proc.c     | 19 ++++++++++---------
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 7b861bbc0b43..315967354954 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -686,20 +686,24 @@ __be32 nfs4_callback_offload(void *data, void *dummy,
 {
 	struct cb_offloadargs *args = data;
 	struct nfs_server *server;
-	struct nfs4_copy_state *copy;
+	struct nfs4_copy_state *copy, *tmp_copy;
 	bool found = false;
 
+	copy = kzalloc(sizeof(struct nfs4_copy_state), GFP_NOFS);
+	if (!copy)
+		return htonl(NFS4ERR_SERVERFAULT);
+
 	spin_lock(&cps->clp->cl_lock);
 	rcu_read_lock();
 	list_for_each_entry_rcu(server, &cps->clp->cl_superblocks,
 				client_link) {
-		list_for_each_entry(copy, &server->ss_copies, copies) {
+		list_for_each_entry(tmp_copy, &server->ss_copies, copies) {
 			if (memcmp(args->coa_stateid.other,
-					copy->stateid.other,
+					tmp_copy->stateid.other,
 					sizeof(args->coa_stateid.other)))
 				continue;
-			nfs4_copy_cb_args(copy, args);
-			complete(&copy->completion);
+			nfs4_copy_cb_args(tmp_copy, args);
+			complete(&tmp_copy->completion);
 			found = true;
 			goto out;
 		}
@@ -707,15 +711,11 @@ __be32 nfs4_callback_offload(void *data, void *dummy,
 out:
 	rcu_read_unlock();
 	if (!found) {
-		copy = kzalloc(sizeof(struct nfs4_copy_state), GFP_NOFS);
-		if (!copy) {
-			spin_unlock(&cps->clp->cl_lock);
-			return htonl(NFS4ERR_SERVERFAULT);
-		}
 		memcpy(&copy->stateid, &args->coa_stateid, NFS4_STATEID_SIZE);
 		nfs4_copy_cb_args(copy, args);
 		list_add_tail(&copy->copies, &cps->clp->pending_cb_stateids);
-	}
+	} else
+		kfree(copy);
 	spin_unlock(&cps->clp->cl_lock);
 
 	return 0;
diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index ac5b784a1de0..fed06fd9998d 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -137,31 +137,32 @@ static int handle_async_copy(struct nfs42_copy_res *res,
 			     struct file *dst,
 			     nfs4_stateid *src_stateid)
 {
-	struct nfs4_copy_state *copy;
+	struct nfs4_copy_state *copy, *tmp_copy;
 	int status = NFS4_OK;
 	bool found_pending = false;
 	struct nfs_open_context *ctx = nfs_file_open_context(dst);
 
+	copy = kzalloc(sizeof(struct nfs4_copy_state), GFP_NOFS);
+	if (!copy)
+		return -ENOMEM;
+
 	spin_lock(&server->nfs_client->cl_lock);
-	list_for_each_entry(copy, &server->nfs_client->pending_cb_stateids,
+	list_for_each_entry(tmp_copy, &server->nfs_client->pending_cb_stateids,
 				copies) {
-		if (memcmp(&res->write_res.stateid, &copy->stateid,
+		if (memcmp(&res->write_res.stateid, &tmp_copy->stateid,
 				NFS4_STATEID_SIZE))
 			continue;
 		found_pending = true;
-		list_del(&copy->copies);
+		list_del(&tmp_copy->copies);
 		break;
 	}
 	if (found_pending) {
 		spin_unlock(&server->nfs_client->cl_lock);
+		kfree(copy);
+		copy = tmp_copy;
 		goto out;
 	}
 
-	copy = kzalloc(sizeof(struct nfs4_copy_state), GFP_NOFS);
-	if (!copy) {
-		spin_unlock(&server->nfs_client->cl_lock);
-		return -ENOMEM;
-	}
 	memcpy(&copy->stateid, &res->write_res.stateid, NFS4_STATEID_SIZE);
 	init_completion(&copy->completion);
 	copy->parent_state = ctx->state;
-- 
2.19.1



