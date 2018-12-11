Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C31C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BE62084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544126;
	bh=GOkEG5vwq4/oubRfc6Y3ezEkX/tAb1L5TDhDzXe0/gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hJnyvMDPAXo2wxmOk46MtvHbz1il4AyO3BY9lXZYX1Zt1yBrhUlGNfhTXKBXH2fv+
	 KGQ63iGsmFWOToRzZlmDRnOIrthU27bJwlOB5eCV+ifSjnxNNTE+qrVgafD/xpG8rn
	 k6DIz8wgu21WhbjCwDN3Qh5yZzTYHOn/ATvkBupE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BE62084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbeLKQCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:02:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730727AbeLKP5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:57:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD5082086D;
        Tue, 11 Dec 2018 15:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543824;
        bh=GOkEG5vwq4/oubRfc6Y3ezEkX/tAb1L5TDhDzXe0/gc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dbtGxq6bZIXU0dj989aXgAp/ghmDxE/elwMbFD0B+kEfCNAm5tG8jSmemE722O2xI
         Bj/yav1m5s777J2SE9Ebc6s6iM4ljjpdLg0AgHK7zhIYG8HDevVXKgt+U7y0MjNA7n
         6hoFmFpTELyKpVTVf/mYVxTuUQvFDx+7Hw0rkcyg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 043/118] NFSv4: Fix a NFSv4 state manager deadlock
Date:   Tue, 11 Dec 2018 16:41:02 +0100
Message-Id: <20181211151645.981856431@linuxfoundation.org>
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

[ Upstream commit aeabb3c96186a0f944fc2b1f25c84d5eb3a93fa9 ]

Fix a deadlock whereby the NFSv4 state manager can get stuck in the
delegation return code, waiting for a layout return to complete in
another thread. If the server reboots before that other thread
completes, then we need to be able to start a second state
manager thread in order to perform recovery.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4_fs.h   |  2 ++
 fs/nfs/nfs4state.c | 16 +++++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 3a6904173214..63287d911c08 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -41,6 +41,8 @@ enum nfs4_client_state {
 	NFS4CLNT_MOVED,
 	NFS4CLNT_LEASE_MOVED,
 	NFS4CLNT_DELEGATION_EXPIRED,
+	NFS4CLNT_RUN_MANAGER,
+	NFS4CLNT_DELEGRETURN_RUNNING,
 };
 
 #define NFS4_RENEW_TIMEOUT		0x01
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 18920152da14..d2f645d34eb1 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1210,6 +1210,7 @@ void nfs4_schedule_state_manager(struct nfs_client *clp)
 	struct task_struct *task;
 	char buf[INET6_ADDRSTRLEN + sizeof("-manager") + 1];
 
+	set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
 	if (test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state) != 0)
 		return;
 	__module_get(THIS_MODULE);
@@ -2485,6 +2486,7 @@ static void nfs4_state_manager(struct nfs_client *clp)
 
 	/* Ensure exclusive access to NFSv4 state */
 	do {
+		clear_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
 		if (test_bit(NFS4CLNT_PURGE_STATE, &clp->cl_state)) {
 			section = "purge state";
 			status = nfs4_purge_lease(clp);
@@ -2575,14 +2577,18 @@ static void nfs4_state_manager(struct nfs_client *clp)
 		}
 
 		nfs4_end_drain_session(clp);
-		if (test_and_clear_bit(NFS4CLNT_DELEGRETURN, &clp->cl_state)) {
-			nfs_client_return_marked_delegations(clp);
-			continue;
+		nfs4_clear_state_manager_bit(clp);
+
+		if (!test_and_set_bit(NFS4CLNT_DELEGRETURN_RUNNING, &clp->cl_state)) {
+			if (test_and_clear_bit(NFS4CLNT_DELEGRETURN, &clp->cl_state)) {
+				nfs_client_return_marked_delegations(clp);
+				set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
+			}
+			clear_bit(NFS4CLNT_DELEGRETURN_RUNNING, &clp->cl_state);
 		}
 
-		nfs4_clear_state_manager_bit(clp);
 		/* Did we race with an attempt to give us more work? */
-		if (clp->cl_state == 0)
+		if (!test_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state))
 			return;
 		if (test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state) != 0)
 			return;
-- 
2.19.1



