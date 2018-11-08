Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB23DECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716E121104
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMcazG2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716E121104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbeKIHdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:33:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:49138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbeKIHdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:33 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B95B20892;
        Thu,  8 Nov 2018 21:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714165;
        bh=X8bckyGEtv+tBCBa++9XwKmy1tPPuDic4Vk3uIrP/nU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nMcazG2ybsX09JCrfSAErmrAV+LkKjpfhfhlx0Sx59lBUJO65Kw4AvuD56O4qYXrT
         8jFFajhdByFOD+C+dqJ2VEHEdTAj9DIOwV0eX5OB7NBoTC+fwfCx62J2W3TmxNDUS8
         W7k+8JGBAkcNoy42Vx/szo713GDDLGOu17KLUDTs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 054/144] NFSv4: Cache the NFSv4/v4.1 client owner_id in the struct nfs_client
Date:   Thu,  8 Nov 2018 13:50:25 -0800
Message-Id: <20181108215058.746284285@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



