Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520451748-2-99993827783207710
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
    t=1520451748; b=Sa7n2/6PjphtDnnGGiIqnf432a87JDF6zSi/YdIbg1BOlfN
    76QTbehq0WwpW0pbzCwbKzpFgK4vWS6h6NeOKq/zXoVX00p76EWGexyhNMHIUGGg
    3PlP+Ejroc00ZQqjfJMrvRl7vrcBRFLFGRLYnITfDyU3NxwUiaVkQlDEBpWgNX3O
    r6qzoGh2ALzrMENmoFvEyxg+jdS4RIV13iVOtQzlpXk+L0RObE05d019oGiEmc6m
    EtUELZ1Qy2ctyiVETqRyZwIcv7rSLpDXUxqlenv6gMCyPkWbfrgi/NPnNnMEoBlM
    j9mVdxAn8d+o1IYD2VbvKs4b/daGRQah1jRKiig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520451748; bh=z18lZHGGrRqHa6nCz+yARfGXrQ
    YCbY3N0JTxt/MD4Og=; b=QL3zCrVE0UmShCscLqTQJsRmgZ0cp+8QnGsNFzMmqE
    usJCxjrxyaGHqngp0OPxULbmame2gDYVbgRwvdHnGBmvJFfyoEdx3P0E3zcZsVWC
    v9JYtpdJOZWpCBJtiY/PvDtCGBYoO8U/sau7bsInvdc322kuHP6x2rBDzP3IscHT
    5rjo7sSIVhoKcX2zn3Gxk6Pm8x53hnxlKvhu0zpMR5X3pm89WQ9u50wNieZ4/a0i
    3CURkpvk6hU4JS/baarucbwKyA+pp+LKrHChLKZ7r0o94bP4Q8F4VQ/tEw4JsENo
    dK8+kYgfV1iSXQyZW+TybY1h/idrooiDG2bi+/2FUSuA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
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
        id S934506AbeCGTmY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:42:24 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42252 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934250AbeCGTmW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:42:22 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 040/122] fib_semantics: Dont match route with mismatching tclassid
Date: Wed,  7 Mar 2018 11:37:32 -0800
Message-Id: <20180307191734.848176670@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefano Brivio <sbrivio@redhat.com>


[ Upstream commit a8c6db1dfd1b1d18359241372bb204054f2c3174 ]

In fib_nh_match(), if output interface or gateway are passed in
the FIB configuration, we don't have to check next hops of
multipath routes to conclude whether we have a match or not.

However, we might still have routes with different realms
matching the same output interface and gateway configuration,
and this needs to cause the match to fail. Otherwise the first
route inserted in the FIB will match, regardless of the realms:

 # ip route add 1.1.1.1 dev eth0 table 1234 realms 1/2
 # ip route append 1.1.1.1 dev eth0 table 1234 realms 3/4
 # ip route list table 1234
 1.1.1.1 dev eth0 scope link realms 1/2
 1.1.1.1 dev eth0 scope link realms 3/4
 # ip route del 1.1.1.1 dev ens3 table 1234 realms 3/4
 # ip route list table 1234
 1.1.1.1 dev ens3 scope link realms 3/4

whereas route with realms 3/4 should have been deleted instead.

Explicitly check for fc_flow passed in the FIB configuration
(this comes from RTA_FLOW extracted by rtm_to_fib_config()) and
fail matching if it differs from nh_tclassid.

The handling of RTA_FLOW for multipath routes later in
fib_nh_match() is still needed, as we can have multiple RTA_FLOW
attributes that need to be matched against the tclassid of each
next hop.

v2: Check that fc_flow is set before discarding the match, so
    that the user can still select the first matching rule by
    not specifying any realm, as suggested by David Ahern.

Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
Acked-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/fib_semantics.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -646,6 +646,11 @@ int fib_nh_match(struct fib_config *cfg,
 					    fi->fib_nh, cfg, extack))
 				return 1;
 		}
+#ifdef CONFIG_IP_ROUTE_CLASSID
+		if (cfg->fc_flow &&
+		    cfg->fc_flow != fi->fib_nh->nh_tclassid)
+			return 1;
+#endif
 		if ((!cfg->fc_oif || cfg->fc_oif == fi->fib_nh->nh_oif) &&
 		    (!cfg->fc_gw  || cfg->fc_gw == fi->fib_nh->nh_gw))
 			return 0;
