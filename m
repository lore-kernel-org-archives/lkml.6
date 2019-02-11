Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B2BC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F0721B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549898541;
	bh=XAn6QfY4GHGELhvwTQwdPdwcPpHQpBBiNdIcLyoq6ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iIBISDrSucFY5UzHvtFSPdGXuX25NG5xTqIzk7W7bmz71mF78jKQt+6hHSnh6dLrR
	 S4+illV+VcQ3NHelWlewBR3zELmcOFDwCwhdpM1gvzPZlD44E4dQeveCyHJu96j5vd
	 jCC4utWN9a34cO4UApiapVL2OqGec4+h03BeO2xc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403867AbfBKPWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:22:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:52776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390688AbfBKPD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:03:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A98C222AD;
        Mon, 11 Feb 2019 15:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897438;
        bh=XAn6QfY4GHGELhvwTQwdPdwcPpHQpBBiNdIcLyoq6ns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IeyIj18gFGeJjZzg95GielJ0S+atWA91XwP4hsBQ9Na4Z9uM26S5O+O9r7s4g+/pe
         Pib/IZaZOG3dXdGNf8TlIYIssyzXU7x0PoECHUc5g9nb0X0KYKCxFbibkHqav2jxcS
         Xs3Su+ZqXJOf2x2ORVeRC9Qh+HDQ9rfQchWd1U7k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olga Kornievskaia <aglo@umich.edu>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Donald Buczek <buczek@molgen.mpg.de>
Subject: [PATCH 4.14 203/205] nfsd4: catch some false session retries
Date:   Mon, 11 Feb 2019 15:20:01 +0100
Message-Id: <20190211141841.702237509@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: J. Bruce Fields <bfields@redhat.com>

commit 53da6a53e1d414e05759fa59b7032ee08f4e22d7 upstream.

The spec allows us to return NFS4ERR_SEQ_FALSE_RETRY if we notice that
the client is making a call that matches a previous (slot, seqid) pair
but that *isn't* actually a replay, because some detail of the call
doesn't actually match the previous one.

Catching every such case is difficult, but we may as well catch a few
easy ones.  This also handles the case described in the previous patch,
in a different way.

The spec does however require us to catch the case where the difference
is in the rpc credentials.  This prevents somebody from snooping another
user's replies by fabricating retries.

(But the practical value of the attack is limited by the fact that the
replies with the most sensitive data are READ replies, which are not
normally cached.)

Tested-by: Olga Kornievskaia <aglo@umich.edu>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Donald Buczek <buczek@molgen.mpg.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfsd/nfs4state.c |   37 ++++++++++++++++++++++++++++++++++++-
 fs/nfsd/state.h     |    1 +
 2 files changed, 37 insertions(+), 1 deletion(-)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1472,8 +1472,10 @@ free_session_slots(struct nfsd4_session
 {
 	int i;
 
-	for (i = 0; i < ses->se_fchannel.maxreqs; i++)
+	for (i = 0; i < ses->se_fchannel.maxreqs; i++) {
+		free_svc_cred(&ses->se_slots[i]->sl_cred);
 		kfree(ses->se_slots[i]);
+	}
 }
 
 /*
@@ -2334,6 +2336,8 @@ nfsd4_store_cache_entry(struct nfsd4_com
 	slot->sl_flags |= NFSD4_SLOT_INITIALIZED;
 	slot->sl_opcnt = resp->opcnt;
 	slot->sl_status = resp->cstate.status;
+	free_svc_cred(&slot->sl_cred);
+	copy_cred(&slot->sl_cred, &resp->rqstp->rq_cred);
 
 	if (!nfsd4_cache_this(resp)) {
 		slot->sl_flags &= ~NFSD4_SLOT_CACHED;
@@ -3040,6 +3044,34 @@ static bool nfsd4_request_too_big(struct
 	return xb->len > session->se_fchannel.maxreq_sz;
 }
 
+static bool replay_matches_cache(struct svc_rqst *rqstp,
+		 struct nfsd4_sequence *seq, struct nfsd4_slot *slot)
+{
+	struct nfsd4_compoundargs *argp = rqstp->rq_argp;
+
+	if ((bool)(slot->sl_flags & NFSD4_SLOT_CACHETHIS) !=
+	    (bool)seq->cachethis)
+		return false;
+	/*
+	 * If there's an error than the reply can have fewer ops than
+	 * the call.  But if we cached a reply with *more* ops than the
+	 * call you're sending us now, then this new call is clearly not
+	 * really a replay of the old one:
+	 */
+	if (slot->sl_opcnt < argp->opcnt)
+		return false;
+	/* This is the only check explicitly called by spec: */
+	if (!same_creds(&rqstp->rq_cred, &slot->sl_cred))
+		return false;
+	/*
+	 * There may be more comparisons we could actually do, but the
+	 * spec doesn't require us to catch every case where the calls
+	 * don't match (that would require caching the call as well as
+	 * the reply), so we don't bother.
+	 */
+	return true;
+}
+
 __be32
 nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
@@ -3099,6 +3131,9 @@ nfsd4_sequence(struct svc_rqst *rqstp, s
 		status = nfserr_seq_misordered;
 		if (!(slot->sl_flags & NFSD4_SLOT_INITIALIZED))
 			goto out_put_session;
+		status = nfserr_seq_false_retry;
+		if (!replay_matches_cache(rqstp, seq, slot))
+			goto out_put_session;
 		cstate->slot = slot;
 		cstate->session = session;
 		cstate->clp = clp;
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -169,6 +169,7 @@ static inline struct nfs4_delegation *de
 struct nfsd4_slot {
 	u32	sl_seqid;
 	__be32	sl_status;
+	struct svc_cred sl_cred;
 	u32	sl_datalen;
 	u16	sl_opcnt;
 #define NFSD4_SLOT_INUSE	(1 << 0)


