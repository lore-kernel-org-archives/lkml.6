Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2588EECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2DE2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCZg19uZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2DE2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbeKIHck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:32:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:47976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727055AbeKIHck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:32:40 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBF5D2086C;
        Thu,  8 Nov 2018 21:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714113;
        bh=6CqUx3LUdLBqCz8zfw01CqvQkJXu6nZa3fgYW/BMau0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aCZg19uZYUcteVLDZS8tw0O0AOhIzYoNATdnEFFwNzJMgwM0ltVOA2EcWPiHM5HaY
         TpqO7qXhZ9YlSlBTd2aqLYWEtgmfVopvaO2+NXSA+c+6K+oaQ8Wxy88cC+npXOUDOr
         TmxU+r2KEMz63YoqQW5RB0nazRogiZIIBJw1Td5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 055/144] NFSv4/v4.1: Verify the client owner id during trunking detection
Date:   Thu,  8 Nov 2018 13:50:26 -0800
Message-Id: <20181108215058.824631804@linuxfoundation.org>
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



