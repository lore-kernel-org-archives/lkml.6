Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2951739-1517591470-2-7606212366351792654
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591470; b=igCA8FjYp6HLRdZbcss4K/x9XE5BJtFlgw3PEeDq7Is1p8w
    elfqpb1KQYvvD5YsLFOtWeOlCU6pj2surO0hGwK1h70nLofm2PqYVMg/hP9qYAoE
    P/w5EI+ALba05RdrUh0aZDMqvEVLpQ1hdk+0reHXWB4boJXgnkRAIz0HtAhDDtMV
    m2jvCZe3KWdtLuFbRy1+2Z835QwaWpjGd2ZuSWmPbg6dRJc4wODp5qPNSg7sDQD5
    wNHNzJg5+pBg6QKL5IWB8P0XaDJQ3V/lEjqr00BFzWNaGTtxsUi80hcev0/Lw9QK
    3ULb5s8iJBliIg4DhkUJo6DUfP/eRZb1AHyW31g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591470; bh=OKdO/x2NYcJv+trYYXRVzIhp08
    XoSS1Mt9XbRqMn/WM=; b=Ng/bXfKlPXd/ukq9iGyRckkJYHznN2oztwLaG0zrjc
    V6x535tgnCSnfTgCQuT+4UaOarK6bTzoyay023/otjeT6Q6rLpJyHfIzDgCtbRb1
    QPmnB2rexcBEUFzMMV4IoZcL/6oc77Rhdqg9MPTgbD/vhXvREHzb/fEtCXe37r5t
    iZSnVR2YRVtfHmzE5MI7+pgGHQ6om+9vF55Y2hsqQ/+GUzZx5NWeFkiGCFGi+I2F
    MnhBGOQweeBxw4B7eseimjW7azkjDhAkn6vrk6BAie/EVTMlSMqaeI5/qFrfPLfR
    eR1VUqeCSx2wFLB9Y7mzLmcJ/01VqbfpdxceVVxPuZrA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753359AbeBBRLH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:11:07 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38518 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752626AbeBBRLE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:11:04 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Elble <aweits@rit.edu>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 088/156] nfsd: check for use of the closed special stateid
Date: Fri,  2 Feb 2018 17:57:49 +0100
Message-Id: <20180202140844.238432095@linuxfoundation.org>
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

From: Andrew Elble <aweits@rit.edu>


[ Upstream commit ae254dac721d44c0bfebe2795df87459e2e88219 ]

Prevent the use of the closed (invalid) special stateid by clients.

Signed-off-by: Andrew Elble <aweits@rit.edu>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4state.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -72,6 +72,7 @@ static u64 current_sessionid = 1;
 #define ZERO_STATEID(stateid) (!memcmp((stateid), &zero_stateid, sizeof(stateid_t)))
 #define ONE_STATEID(stateid)  (!memcmp((stateid), &one_stateid, sizeof(stateid_t)))
 #define CURRENT_STATEID(stateid) (!memcmp((stateid), &currentstateid, sizeof(stateid_t)))
+#define CLOSE_STATEID(stateid)  (!memcmp((stateid), &close_stateid, sizeof(stateid_t)))
 
 /* forward declarations */
 static bool check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner);
@@ -4869,7 +4870,8 @@ static __be32 nfsd4_validate_stateid(str
 	struct nfs4_stid *s;
 	__be32 status = nfserr_bad_stateid;
 
-	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid))
+	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
+		CLOSE_STATEID(stateid))
 		return status;
 	/* Client debugging aid. */
 	if (!same_clid(&stateid->si_opaque.so_clid, &cl->cl_clientid)) {
@@ -4927,7 +4929,8 @@ nfsd4_lookup_stateid(struct nfsd4_compou
 	else if (typemask & NFS4_DELEG_STID)
 		typemask |= NFS4_REVOKED_DELEG_STID;
 
-	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid))
+	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
+		CLOSE_STATEID(stateid))
 		return nfserr_bad_stateid;
 	status = lookup_clientid(&stateid->si_opaque.so_clid, cstate, nn);
 	if (status == nfserr_stale_clientid) {
