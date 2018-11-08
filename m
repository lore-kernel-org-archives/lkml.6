Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAB6C0044B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA57220840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGGW0oyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA57220840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbeKIIVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:21:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:48464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728660AbeKIHdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:06 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CE6D2089A;
        Thu,  8 Nov 2018 21:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714139;
        bh=DDzLlFpvM/CqpKIjMH0Uy2prPhQf4Qrf4cZmKe5TK2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NGGW0oyRK1HDecB4FzezFh0RSE1DB+UkNLoGD1ZrYlddNr54qGxed3t4ammdaLwIO
         ic0NlfT5ZRfm/bX0CCe6gApggzAu92E19kNqvswQmvK3Pg1X3dPXb+B4A6qEzoDS+k
         xr/irIrbDUji0R+1VJLDnZwWJkcwb06jfsDN7fW4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dai Ngo <dai.ngo@oracle.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 056/144] NFS: Ignore transport protocol when detecting server trunking
Date:   Thu,  8 Nov 2018 13:50:27 -0800
Message-Id: <20181108215058.897159886@linuxfoundation.org>
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



