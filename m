Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3586829-1519410652-2-11209064356848849436
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519410651; b=HaSeAar2VoGfk3AumtZ9Ux5nl3SMnzBGPC+mZj3sGz3LH0q
    ckN+NoD7H9TugbAWBQDa12yJbvtpjItFxbukMHg008xFk4hteTPNn4KjU1ec+nW0
    7jWSAjNak4i8oq73JZAqrT43Yse3STI4Sc3S/B+7z3wPC2pkL5+o3QI4Z0E6TyMW
    FRHeidh19EYkIoDEQyf8Uw+NWI5QgYpI0iqXjo0wzDLfzJkVYJL6C2Xr2nnfMuel
    xcBo3ZFEzPj8+IRkPR9LIm7ckV/tzqnUDxZebauHPDKmpQNc5+3Ly6LobmyEBpr4
    R7+S3dzhvK2849dQRRAYKvDYZCvMTkMQUDAaCRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519410651; bh=E2w9tesD5denANOtkwu9da4Is/
    yqN/gZpS6IVDDRmLI=; b=vlB39dcYckehwec84ah9oDWBNX63SymUzzpWWLO0Ak
    6W2scSOmcd6aRm0kNPxQF+IvWLrvpAobky0sxjMEXUHpGp0MeqQO6Ul8xzYmFxbo
    Z8h4eTOy+7ozqMD/sCRykDG1tdTbEyUFY80PBTen72dgEU7E01PIezvyoSRCPTh8
    DUPhSrJ/Fkgou7nbiLBssXNBwprA1B69BIMKxgRDBiOYJPaXtR1iQ2kSyhBBiGQS
    a32iBZjZFVMrh+BD0uluebAueZUVnVyQsAWrxT0bS/Muw3SlKSYcajPI6SG9enEW
    x/TfqlNkaB/szN7te+64NWIS8uYGHU+xq/9ADpnu0HbQ==
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
        id S1752373AbeBWSar (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:30:47 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34660 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751463AbeBWSap (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:30:45 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 3.18 24/58] netfilter: x_tables: avoid out-of-bounds reads in xt_request_find_{match|target}
Date: Fri, 23 Feb 2018 19:26:23 +0100
Message-Id: <20180223170210.706218104@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit da17c73b6eb74aad3c3c0654394635675b623b3e upstream.

It looks like syzbot found its way into netfilter territory.

Issue here is that @name comes from user space and might
not be null terminated.

Out-of-bound reads happen, KASAN is not happy.

v2 added similar fix for xt_request_find_target(),
as Florian advised.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/x_tables.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -209,6 +209,9 @@ xt_request_find_match(uint8_t nfproto, c
 {
 	struct xt_match *match;
 
+	if (strnlen(name, XT_EXTENSION_MAXNAMELEN) == XT_EXTENSION_MAXNAMELEN)
+		return ERR_PTR(-EINVAL);
+
 	match = xt_find_match(nfproto, name, revision);
 	if (IS_ERR(match)) {
 		request_module("%st_%s", xt_prefix[nfproto], name);
@@ -251,6 +254,9 @@ struct xt_target *xt_request_find_target
 {
 	struct xt_target *target;
 
+	if (strnlen(name, XT_EXTENSION_MAXNAMELEN) == XT_EXTENSION_MAXNAMELEN)
+		return ERR_PTR(-EINVAL);
+
 	target = xt_find_target(af, name, revision);
 	if (IS_ERR(target)) {
 		request_module("%st_%s", xt_prefix[af], name);
