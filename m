Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBA7ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BE020873
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzeLz/hU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BE020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbeJYWwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729403AbeJYWwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:30 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 507CE20873;
        Thu, 25 Oct 2018 14:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477173;
        bh=o3RfPsHLywGEn+DFJooVUJqYBbyLN005zqhD++nQpSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XzeLz/hUB3JcmZZWJo3HR+FIiUp2T7cprpIKDPcP8E5SeAohxFGxZ2hgBt5gZLiGK
         +N1mM6jFagxLevrKZK4CZgdvAwMbq5M1m731c+th8WUIlXE9GkCFhIrH/lEr2uZ0Yi
         UWwiLpJLJlafQEoK/HhgmOr0HPY2jrwEbYmwWFpU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Trond Myklebust <trond.myklebust@primarydata.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 25/98] NFSv4/v4.1: Verify the client owner id during trunking detection
Date:   Thu, 25 Oct 2018 10:17:40 -0400
Message-Id: <20181025141853.214051-25-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@primarydata.com>

[ Upstream commit 55b9df93ddd684cbc4c2dee9b8a99f6e48348212 ]

While we normally expect the NFSv4 client to always send the same client
owner to all servers, there are a couple of situations where that is not
the case:
 1) In NFSv4.0, switching between use of '-omigration' and not will cause
    the kernel to switch between using the non-uniform and uniform client
    strings.
 2) In NFSv4.1, or NFSv4.0 when using uniform client strings, if the
    uniquifier string is suddenly changed.

This patch will catch those situations by checking the client owner id
in the trunking detection code, and will do the right thing if it notices
that the strings differ.

Cc: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4client.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index d748d403bab1..a8a9be4c6cf4 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -456,6 +456,14 @@ static void nfs4_swap_callback_idents(struct nfs_client *keep,
 	spin_unlock(&nn->nfs_client_lock);
 }
 
+static bool nfs4_match_client_owner_id(const struct nfs_client *clp1,
+		const struct nfs_client *clp2)
+{
+	if (clp1->cl_owner_id == NULL || clp2->cl_owner_id == NULL)
+		return true;
+	return strcmp(clp1->cl_owner_id, clp2->cl_owner_id) == 0;
+}
+
 /**
  * nfs40_walk_client_list - Find server that recognizes a client ID
  *
@@ -515,6 +523,9 @@ int nfs40_walk_client_list(struct nfs_client *new,
 		if (pos->cl_clientid != new->cl_clientid)
 			continue;
 
+		if (!nfs4_match_client_owner_id(pos, new))
+			continue;
+
 		atomic_inc(&pos->cl_count);
 		spin_unlock(&nn->nfs_client_lock);
 
@@ -664,6 +675,13 @@ int nfs41_walk_client_list(struct nfs_client *new,
 		if (!nfs4_check_clientid_trunking(pos, new))
 			continue;
 
+		/* Unlike NFSv4.0, we know that NFSv4.1 always uses the
+		 * uniform string, however someone might switch the
+		 * uniquifier string on us.
+		 */
+		if (!nfs4_match_client_owner_id(pos, new))
+			continue;
+
 		atomic_inc(&pos->cl_count);
 		*result = pos;
 		status = 0;
-- 
2.17.1

