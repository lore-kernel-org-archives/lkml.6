Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2948269-1517591465-2-9683388766279913213
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
    t=1517591464; b=XgjXgK7F4S/WFnc7uK29grZUSiIQcd5cspf5jVyFG6Ktvjz
    RaWuUEciL08VThjxrkWym3yFuYS1itydisG4TsdAcKUPco6HVlWgLHTjbH1TrkGc
    M0ItyjgyQziWylM2UW+gjDJDGdu+O1txxngD97mIQiyQ6HrL8Uc9K10QiuAECTDj
    SBl2pO4K6dfDKycqVahEy+uc51zjaV22izUOI0kYlWlLGzTXKGS3gmu2goUtwkEs
    +6AeHmqoP7xX5tlSiIbP+lLzJEyH0ah1UftsH5S6FhuNjfohzenU5C/2REu7og0I
    w3Uma67SsHtslMi61C4vd/wpVWFEFjYFWXNNQbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591464; bh=tw/QczJbYVIcxm2UJvTe6ddA0e
    pXNQDlRzGrg9XE1jw=; b=PKr1RqzItkBjbZcorBx25ywRe+UBm+BWog6IHPj7rq
    QFjf4JnY/dBKEHgVisaddvokP+y99cAlYlfgR4K1UDtFzkjVj16ahL0woRL2kUGn
    eJ0AeA9ysv89ZeX6gfGAAZxYsX5VounktLW8u3KCsngM8TXKncAM2dX3Xs+rN7IG
    FvKcjfPTszsSIqYGjSvzE20QqpOOTMp2J+Z6ix6j/3/bucRbTO38bbwUSE5dovCB
    n30mTZ6INVD1ufUH7lc2jdJiJEQhMHyTzlcmIyKLyhb2FSUTTa51xGIufqNh0Bhl
    rNoXX8ZloLAjcoDRfzTEPqlbtjPSIPLAaVAWKG107BTA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753354AbeBBRK6 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:10:58 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38470 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753123AbeBBRKx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:10:53 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 086/156] nfsd: Ensure we check stateid validity in the seqid operation checks
Date: Fri,  2 Feb 2018 17:57:47 +0100
Message-Id: <20180202140844.144140129@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@primarydata.com>


[ Upstream commit 9271d7e509c1bfc0b9a418caec29ec8d1ac38270 ]

After taking the stateid st_mutex, we want to know that the stateid
still represents valid state before performing any non-idempotent
actions.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4state.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5180,15 +5180,9 @@ static __be32 nfs4_seqid_op_checks(struc
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
