Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2943005-1517591083-2-10255825231235444560
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591082; b=Hzh00eD2NTvdiK0y6Hc/fUHKHmen1rBRc/8/+i8DKD9SwDl
    3ckJLfREycDa89JC4YgKnDqv4vTofSZgu3LDGGkAfg9sYcnLVyv5EBZZ+2+5FJro
    WU9asTZvKamwJCMEg33KzSCKjpuGse6ckntAI8mJMVD28NJn41JqsIotR0B8EbHi
    Lrawmq8qb6acuwYAOzIawgg+C9QHYcDNlx6gLDkyQ7JpQvZI/GCoFSlesAuA9CCK
    9LzAtRqzkSG6Tg6CZgJsj51JZVSmFwU9y6+YTROr4OP11gxnwTSlpSzzMACGCPS9
    0u5wZC8rViER27NkDJU+b6RxGyiR0/8RaIjtrlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591082; bh=bMWkEZJNqrt5/V/0entxzlqrmD
    i8iosN6k19ofRIQb0=; b=jeGEM4Ql2x8n/NfJUNhNjdLKJFCYEB3/LmvU61886R
    5/1R3dozTP/0myi9vCbzuADnWzx3xbiLHkFjxEHIQ1CJE3xW1MTidB4K7ySSngXX
    KQ3WyZlrVM31t/em9tSky92ygdypYcOFgS4xcK9WNIxQ89bgus84U0ns0MUbeKhE
    1ifJoQZz5F07lRQ1DG+LpN6PRhvfQkbor3T57s+k9WeCmrkeRJHvhNvAhd4p9Xrt
    eyxyNVTTTujnYDIpiDthHYihipgByJDqkSVxlbA43Q9fLz+5Xs67Wnir6yyMNJKs
    D77D5UA1qWy4zwifCG4SAYlDlOZYrCLOS8rpg/IdeMow==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbeBBREg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:04:36 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36252 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752641AbeBBREe (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:04:34 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 42/86] nfsd: Ensure we check stateid validity in the seqid operation checks
Date: Fri,  2 Feb 2018 17:58:02 +0100
Message-Id: <20180202140826.248482724@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@primarydata.com>


[ Upstream commit 9271d7e509c1bfc0b9a418caec29ec8d1ac38270 ]

After taking the stateid st_mutex, we want to know that the stateid
still represents valid state before performing any non-idempotent
actions.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4state.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5178,15 +5178,9 @@ static __be32 nfs4_seqid_op_checks(struc
 	status = nfsd4_check_seqid(cstate, sop, seqid);
 	if (status)
 		return status;
-	if (stp->st_stid.sc_type == NFS4_CLOSED_STID
-		|| stp->st_stid.sc_type == NFS4_REVOKED_DELEG_STID)
-		/*
-		 * "Closed" stateid's exist *only* to return
-		 * nfserr_replay_me from the previous step, and
-		 * revoked delegations are kept only for free_stateid.
-		 */
-		return nfserr_bad_stateid;
-	mutex_lock(&stp->st_mutex);
+	status = nfsd4_lock_ol_stateid(stp);
+	if (status != nfs_ok)
+		return status;
 	status = check_stateid_generation(stateid, &stp->st_stid.sc_stateid, nfsd4_has_session(cstate));
 	if (status == nfs_ok)
 		status = nfs4_check_fh(current_fh, &stp->st_stid);
