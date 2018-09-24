Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E3FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADFE21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADFE21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732767AbeIXS0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:26:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56764 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731873AbeIXS0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:26:08 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8440F1094;
        Mon, 24 Sep 2018 12:24:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.14 106/173] NFSv4.1 fix infinite loop on I/O.
Date:   Mon, 24 Sep 2018 13:52:20 +0200
Message-Id: <20180924113123.866955895@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trondmy@gmail.com>

commit 994b15b983a72e1148a173b61e5b279219bb45ae upstream.

The previous fix broke recovery of delegated stateids because it assumes
that if we did not mark the delegation as suspect, then the delegation has
effectively been revoked, and so it removes that delegation irrespectively
of whether or not it is valid and still in use. While this is "mostly
harmless" for ordinary I/O, we've seen pNFS fail with LAYOUTGET spinning
in an infinite loop while complaining that we're using an invalid stateid
(in this case the all-zero stateid).

What we rather want to do here is ensure that the delegation is always
correctly marked as needing testing when that is the case. So we want
to close the loophole offered by nfs4_schedule_stateid_recovery(),
which marks the state as needing to be reclaimed, but not the
delegation that may be backing it.

Fixes: 0e3d3e5df07dc ("NFSv4.1 fix infinite loop on IO BAD_STATEID error")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: stable@vger.kernel.org # v4.11+
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/nfs4proc.c  |   10 +++++++---
 fs/nfs/nfs4state.c |    2 ++
 2 files changed, 9 insertions(+), 3 deletions(-)

--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2533,14 +2533,18 @@ static void nfs41_check_delegation_state
 	}
 
 	nfs4_stateid_copy(&stateid, &delegation->stateid);
-	if (test_bit(NFS_DELEGATION_REVOKED, &delegation->flags) ||
-		!test_and_clear_bit(NFS_DELEGATION_TEST_EXPIRED,
-			&delegation->flags)) {
+	if (test_bit(NFS_DELEGATION_REVOKED, &delegation->flags)) {
 		rcu_read_unlock();
 		nfs_finish_clear_delegation_stateid(state, &stateid);
 		return;
 	}
 
+	if (!test_and_clear_bit(NFS_DELEGATION_TEST_EXPIRED,
+				&delegation->flags)) {
+		rcu_read_unlock();
+		return;
+	}
+
 	cred = get_rpccred(delegation->cred);
 	rcu_read_unlock();
 	status = nfs41_test_and_free_expired_stateid(server, &stateid, cred);
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1354,6 +1354,8 @@ int nfs4_schedule_stateid_recovery(const
 
 	if (!nfs4_state_mark_reclaim_nograce(clp, state))
 		return -EBADF;
+	nfs_inode_find_delegation_state_and_recover(state->inode,
+			&state->stateid);
 	dprintk("%s: scheduling stateid recovery for server %s\n", __func__,
 			clp->cl_hostname);
 	nfs4_schedule_state_manager(clp);


