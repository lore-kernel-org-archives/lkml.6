Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520453027-2-2385282041556755662
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
    t=1520453026; b=CLS/GdUHyscqSU9kfClPezTqkO/3opXJ7Nr5lzF39ob8vv0
    ymeGIEaXgoG0CZs74cd1UXl1q1YFnp4Kbf1Q+cMeIT/KZeTIKUNANMEbD+ciVd1F
    tP34n4DLVpwA1OYoUcuUjlR2v2Nno4w95REt+M0YKQdH8caraKRuNFPMN4Xklza1
    9I0s9w5OMomSezw9FQNtNRd6T2IGwURqx+nM2kPDhzdSryzAiI+9/FiKlMPpSIEE
    EggrbrauPWOzO/KFlB7knS8QLyAQFua3m/eXdMwIs7VM2ehD7j9By7NmegTIaWyc
    iFnc1QcGrWFVb4Jws/tmqyslst5YAa8oiZn4miw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520453026; bh=W06UZSuN2NmYzsZO5bGv2YWB/x
    WNFt4MA+XCoDr28jI=; b=v+JI+nCjd0QYeAIUlJxHXk+e1t6do2WtGMIhgMXm6R
    MUJ6AaFP26WOuIdL2xN6dv2vwT42CcVGqhXycP3Se47LKb+JFupL6Glf3+JZ3cG/
    bcluP9Xl/9ppC136gu59pEui0S0ccY7877KIDESAQrhhPHbbQ0rS1FBMvdnirJ/e
    EhLRb4Ufp/H9NkpdhH3rnZnWa++BE1tqIMe2MMk3Ax6YBm3blbK98s3AwkevMXwA
    3N/5/qiS4HLZd1YIM+Rq4Hhre8pRTWda6dHSm+tv/Ylp2OWuDD+vz36rc2oYAktB
    0UO+2sMRd4EY7g1/w72B/RItgVZL1juFr3TLq2sQFVvA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
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
        id S964840AbeCGUDe (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 15:03:34 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44672 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965558AbeCGTqe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:46:34 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 065/110] bridge: Fix VLAN reference count problem
Date: Wed,  7 Mar 2018 11:38:48 -0800
Message-Id: <20180307191047.877377830@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@mellanox.com>


[ Upstream commit 0e5a82efda872c2469c210957d7d4161ef8f4391 ]

When a VLAN is added on a port, a reference is taken on the
corresponding master VLAN entry. If it does not already exist, then it
is created and a reference taken.

However, in the second case a reference is not really taken when
CONFIG_REFCOUNT_FULL is enabled as refcount_inc() is replaced by
refcount_inc_not_zero().

Fix this by using refcount_set() on a newly created master VLAN entry.

Fixes: 251277598596 ("net, bridge: convert net_bridge_vlan.refcnt from atomic_t to refcount_t")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bridge/br_vlan.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -157,6 +157,8 @@ static struct net_bridge_vlan *br_vlan_g
 		masterv = br_vlan_find(vg, vid);
 		if (WARN_ON(!masterv))
 			return NULL;
+		refcount_set(&masterv->refcnt, 1);
+		return masterv;
 	}
 	refcount_inc(&masterv->refcnt);
 
