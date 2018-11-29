Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D55C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933382146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBZmk6C2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 933382146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389525AbeK3BiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:38:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729157AbeK3BiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:38:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0DE1213A2;
        Thu, 29 Nov 2018 14:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501955;
        bh=HAzIvAm1Iy/O6N57Sj87DvaUEc7m5o7sL70gI59bZhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cBZmk6C2mT4wQOQ7oCbdK2k3/IsmtdTmjsKgWZG1NCl+9XSVLB7MnWsko1iP7kA7l
         B5T5Y7YMkvAdfg8csW95a1RqFIbCX3bnch/cAxPYkYv1OHGHkjuFBbQ3OlkrW/f6jg
         sb5OykurZz5ljSwvuDvsvCbJpF7imPRKp3x9I8vM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 092/110] NFSv4: Fix an Oops during delegation callbacks
Date:   Thu, 29 Nov 2018 15:13:03 +0100
Message-Id: <20181129135924.971468147@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e39d8a186ed002854196668cb7562ffdfbc6d379 ]

If the server sends a CB_GETATTR or a CB_RECALL while the filesystem is
being unmounted, then we can Oops when releasing the inode in
nfs4_callback_getattr() and nfs4_callback_recall().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/callback_proc.c |  4 ++--
 fs/nfs/delegation.c    | 11 +++++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index fa515d5ea5ba..7b861bbc0b43 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -66,7 +66,7 @@ __be32 nfs4_callback_getattr(void *argp, void *resp,
 out_iput:
 	rcu_read_unlock();
 	trace_nfs4_cb_getattr(cps->clp, &args->fh, inode, -ntohl(res->status));
-	iput(inode);
+	nfs_iput_and_deactive(inode);
 out:
 	dprintk("%s: exit with status = %d\n", __func__, ntohl(res->status));
 	return res->status;
@@ -108,7 +108,7 @@ __be32 nfs4_callback_recall(void *argp, void *resp,
 	}
 	trace_nfs4_cb_recall(cps->clp, &args->fh, inode,
 			&args->stateid, -ntohl(res));
-	iput(inode);
+	nfs_iput_and_deactive(inode);
 out:
 	dprintk("%s: exit with status = %d\n", __func__, ntohl(res));
 	return res;
diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index f033f3a69a3b..75fe92eaa681 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -849,16 +849,23 @@ nfs_delegation_find_inode_server(struct nfs_server *server,
 				 const struct nfs_fh *fhandle)
 {
 	struct nfs_delegation *delegation;
-	struct inode *res = NULL;
+	struct inode *freeme, *res = NULL;
 
 	list_for_each_entry_rcu(delegation, &server->delegations, super_list) {
 		spin_lock(&delegation->lock);
 		if (delegation->inode != NULL &&
 		    nfs_compare_fh(fhandle, &NFS_I(delegation->inode)->fh) == 0) {
-			res = igrab(delegation->inode);
+			freeme = igrab(delegation->inode);
+			if (freeme && nfs_sb_active(freeme->i_sb))
+				res = freeme;
 			spin_unlock(&delegation->lock);
 			if (res != NULL)
 				return res;
+			if (freeme) {
+				rcu_read_unlock();
+				iput(freeme);
+				rcu_read_lock();
+			}
 			return ERR_PTR(-EAGAIN);
 		}
 		spin_unlock(&delegation->lock);
-- 
2.17.1



