Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303463-1521213989-2-15163539503567240491
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521213988; b=HCBPUXcJ9B9AsCxtISKHrdnTAUM28YdRulwrkBu5ls1IkZy
    3kv7ajO0e1QKEicIE5tuDmkZDhKpklfK6DOpr3DPipov+Z48Y07KCwPY0xfS1m++
    a4+m1K8gR7qHPxXWm6a0Rx9pHPtxqFCcnOPzYJ3/hW8tW+pORhDEwjMGt6uqzV7q
    5aLG7JtbWXH3S1NbH38uum2COB1wONwrEYIsHSSWc1mnjiSdmUwp5CTDxsRJbfJL
    HbKxoH+Woj4y2f3tB+eMgkNcmCZS8+ryl5fl6DYq2o8qS5MGodH4I2ZSj6LVCs0I
    vMH0XRxm8ADZVk1xvwBFYVxZapOwIDjrqXnAVuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521213988; bh=L2xJZVXEOcdLfpjrnkXut++XFO
    2duORqTcczXoy7xmw=; b=wWZm/k70kIs1Qpoub0n7w9V8u7x8QZ+n+/AhvNHQup
    gqhhWFUSzJNTtwgvRb/r1M+vzx9p1j4QnRSKvVcw4qs9+sDFsdOrc+1vM3YXEZsB
    q7ehVI031FADAdFAYxGaUPJwoEBbNCa1FaAnj7CbKoScZUxSwNprWhksCJkaqJXt
    R0gr0bIj/nMQmkNkEjMDyTm+8hoPgsaKbdve6A7vP67QUDKZ9j0y+qoBqEN3CWae
    lTzMdmUZsznNjp+ZC6lyyE1fbBOz6smdba8RQvijT1pzCAbPgDRPin8gRU0em2+4
    pEwWI5eRSY2xPEygXAbEk8CYTV5InPg2ANspqzsGGiZA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754088AbeCPP0X (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:26:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33826 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753882AbeCPP0W (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:26:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+845a53d13171abf8bf29@syzkaller.appspotmail.com,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 3.18 10/25] netfilter: ebtables: CONFIG_COMPAT: dont trust userland offsets
Date: Fri, 16 Mar 2018 16:22:57 +0100
Message-Id: <20180316152233.175386099@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152232.750180431@linuxfoundation.org>
References: <20180316152232.750180431@linuxfoundation.org>
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

From: Florian Westphal <fw@strlen.de>

commit b71812168571fa55e44cdd0254471331b9c4c4c6 upstream.

We need to make sure the offsets are not out of range of the
total size.
Also check that they are in ascending order.

The WARN_ON triggered by syzkaller (it sets panic_on_warn) is
changed to also bail out, no point in continuing parsing.

Briefly tested with simple ruleset of
-A INPUT --limit 1/s' --log
plus jump to custom chains using 32bit ebtables binary.

Reported-by: <syzbot+845a53d13171abf8bf29@syzkaller.appspotmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bridge/netfilter/ebtables.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2019,7 +2019,9 @@ static int ebt_size_mwt(struct compat_eb
 		if (match_kern)
 			match_kern->match_size = ret;
 
-		WARN_ON(type == EBT_COMPAT_TARGET && size_left);
+		if (WARN_ON(type == EBT_COMPAT_TARGET && size_left))
+			return -EINVAL;
+
 		match32 = (struct compat_ebt_entry_mwt *) buf;
 	}
 
@@ -2076,6 +2078,15 @@ static int size_entry_mwt(struct ebt_ent
 	 *
 	 * offsets are relative to beginning of struct ebt_entry (i.e., 0).
 	 */
+	for (i = 0; i < 4 ; ++i) {
+		if (offsets[i] >= *total)
+			return -EINVAL;
+		if (i == 0)
+			continue;
+		if (offsets[i-1] > offsets[i])
+			return -EINVAL;
+	}
+
 	for (i = 0, j = 1 ; j < 4 ; j++, i++) {
 		struct compat_ebt_entry_mwt *match32;
 		unsigned int size;
