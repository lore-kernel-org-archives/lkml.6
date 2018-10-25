Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B323C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6ADC20870
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s01DbUZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6ADC20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730585AbeJYWwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729490AbeJYWwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:30 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 209B92086D;
        Thu, 25 Oct 2018 14:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477171;
        bh=q6VmlWSjVJmU9lQfV9JAj2GBLXxysmGqVludBepks0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s01DbUZBd028fkjCLw+U0/SDKtF+wMvw8TPTnjPQXTImQ16fs0zqnwej0foVugfrb
         00Pr/RMuZuXXv31rZM01B7lVghtH/p/JnXTKbRVb/8iKwJ2KQfbrMvXTC1VjMrD3L2
         /S+NovyNu14a5PZAwDYgm/yAqXWQFtUlOdccONsE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 24/98] NFSv4: Cache the NFSv4/v4.1 client owner_id in the struct nfs_client
Date:   Thu, 25 Oct 2018 10:17:39 -0400
Message-Id: <20181025141853.214051-24-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@primarydata.com>

[ Upstream commit ceb3a16c070c403f5f9ca46b46cf2bb79ea11750 ]

Ensure that we cache the NFSv4/v4.1 client owner_id so that we can
verify it when we're doing trunking detection.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4client.c       |  1 +
 fs/nfs/nfs4proc.c         | 19 +++++++++++++++----
 include/linux/nfs_fs_sb.h |  3 +++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 723c656ebd28..d748d403bab1 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -228,6 +228,7 @@ static void nfs4_shutdown_client(struct nfs_client *clp)
 	kfree(clp->cl_serverowner);
 	kfree(clp->cl_serverscope);
 	kfree(clp->cl_implid);
+	kfree(clp->cl_owner_id);
 }
 
 void nfs4_free_client(struct nfs_client *clp)
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 321044c183f5..db8456b4ecb8 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4913,11 +4913,14 @@ static void nfs4_init_boot_verifier(const struct nfs_client *clp,
 }
 
 static unsigned int
-nfs4_init_nonuniform_client_string(const struct nfs_client *clp,
+nfs4_init_nonuniform_client_string(struct nfs_client *clp,
 				   char *buf, size_t len)
 {
 	unsigned int result;
 
+	if (clp->cl_owner_id != NULL)
+		return strlcpy(buf, clp->cl_owner_id, len);
+
 	rcu_read_lock();
 	result = scnprintf(buf, len, "Linux NFSv4.0 %s/%s %s",
 				clp->cl_ipaddr,
@@ -4926,24 +4929,32 @@ nfs4_init_nonuniform_client_string(const struct nfs_client *clp,
 				rpc_peeraddr2str(clp->cl_rpcclient,
 							RPC_DISPLAY_PROTO));
 	rcu_read_unlock();
+	clp->cl_owner_id = kstrdup(buf, GFP_KERNEL);
 	return result;
 }
 
 static unsigned int
-nfs4_init_uniform_client_string(const struct nfs_client *clp,
+nfs4_init_uniform_client_string(struct nfs_client *clp,
 				char *buf, size_t len)
 {
 	const char *nodename = clp->cl_rpcclient->cl_nodename;
+	unsigned int result;
+
+	if (clp->cl_owner_id != NULL)
+		return strlcpy(buf, clp->cl_owner_id, len);
 
 	if (nfs4_client_id_uniquifier[0] != '\0')
-		return scnprintf(buf, len, "Linux NFSv%u.%u %s/%s",
+		result = scnprintf(buf, len, "Linux NFSv%u.%u %s/%s",
 				clp->rpc_ops->version,
 				clp->cl_minorversion,
 				nfs4_client_id_uniquifier,
 				nodename);
-	return scnprintf(buf, len, "Linux NFSv%u.%u %s",
+	else
+		result = scnprintf(buf, len, "Linux NFSv%u.%u %s",
 				clp->rpc_ops->version, clp->cl_minorversion,
 				nodename);
+	clp->cl_owner_id = kstrdup(buf, GFP_KERNEL);
+	return result;
 }
 
 /*
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index fd249ab2718f..4ac99c07406a 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -74,6 +74,9 @@ struct nfs_client {
 	/* idmapper */
 	struct idmap *		cl_idmap;
 
+	/* Client owner identifier */
+	const char *		cl_owner_id;
+
 	/* Our own IP address, as a null-terminated string.
 	 * This is used to generate the mv0 callback address.
 	 */
-- 
2.17.1

