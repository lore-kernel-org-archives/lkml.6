Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FD6C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2383920873
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEUGucry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2383920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbeJYWwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730593AbeJYWwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:31 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E4E82147A;
        Thu, 25 Oct 2018 14:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477174;
        bh=tfkPTFlnQElKZ8e73xkZntF0MimM3JHWkTahmmnhUuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gEUGucrysXwJA3RVexs/wO/FhxNy2deT0jjh26jtMcgyCE1KjYdK8jn5U53uGEROj
         P35xHrr04tVJ8EHaGDSt8NI72+DeRoOh9l1ZqnSyIP9tB+qz4uGZeUgeuwzWKt5XAY
         HA5MyYDF4LkbweoV+oHYl18khG9AIais/Zgxc7Nc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 26/98] NFS: Ignore transport protocol when detecting server trunking
Date:   Thu, 25 Oct 2018 10:17:41 -0400
Message-Id: <20181025141853.214051-26-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 7a01edf0058df98d6cc734c5a4ecc51f929a86ec ]

Detect server trunking across transport protocols. Otherwise, an
RDMA mount and a TCP mount of the same server will end up with
separate nfs_clients using the same clientid4.

Reported-by: Dai Ngo <dai.ngo@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4client.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index a8a9be4c6cf4..eb8777eb4d2b 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -495,9 +495,6 @@ int nfs40_walk_client_list(struct nfs_client *new,
 		if (pos->rpc_ops != new->rpc_ops)
 			continue;
 
-		if (pos->cl_proto != new->cl_proto)
-			continue;
-
 		if (pos->cl_minorversion != new->cl_minorversion)
 			continue;
 
@@ -633,9 +630,6 @@ int nfs41_walk_client_list(struct nfs_client *new,
 		if (pos->rpc_ops != new->rpc_ops)
 			continue;
 
-		if (pos->cl_proto != new->cl_proto)
-			continue;
-
 		if (pos->cl_minorversion != new->cl_minorversion)
 			continue;
 
-- 
2.17.1

