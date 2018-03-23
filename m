Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521803976-2-14554336176453673608
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
    t=1521803975; b=Ym/43KM1efivYfVoBnscm+YK6oeX/KK4/wl8fL1GsCEH1z1
    njOkXBODPa1HW4za6BQzeFv/LQ2susSAgvds6EjSsMGhaSszMaaOSFuvnVIrHPET
    KloRBMxuqT/a7FxMsKZ4lThZ+Su6CYsYApBIA0Eiqa41V8K2BRm/oElz3cTDLiUM
    K+dSiM7MX1Sm/YCTs2Axcx1N2NH2v0bQNVUoHK5IPceZwfb9qCDZmDjfllFPzGJC
    tciad+hXp/SgMjdgVzM30tBBzzSU7jNk18xoeu+34eybZlf6w9L6DWfBmzdaoMnS
    up9yHTWbQ88UmDrcF6hH+Wt1WSsUZkVITHqCAew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803975; bh=1+l3JcTgKCNiV1gPaQCzKwyWyH
    wI/LYNhd8lRL/PQBY=; b=tyfHTFF7HAimHf5ozZDstvENXxBm/D2IHIsGFQJGly
    JXee7RjLu7/8J7w/eoY2RjAfRh29cZAYap51q5OC5pDXe47aowkTTI8NV2NrSkGW
    x18aLHq538CWLooco37FeCjCI2ykrvfLJL7J+St7IugRfTw7o/+KvPtEBygzPsMj
    +xCXeSKC2XPCmja+IIL8pvE0NkGxG2tNmOtTIUYpKpM3Kj7nZKJjtdJ+T1zycT+d
    6gtA540xS+y8hb/V8y2AMm4HptIsL1zDWLRoos7LflqEEOpQkKHat9rceK6lHgmi
    GUoQZ0SzhHmjW6Y+EZtrmr2HGeF1699Y5I0jPJdmPgsg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753689AbeCWKIx (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:08:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41842 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755655AbeCWKIv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:08:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Julian Anastasov <ja@ssi.bg>,
        Simon Horman <horms@verge.net.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 090/177] ipvs: explicitly forbid ipv6 service/dest creation if ipv6 mod is disabled
Date: Fri, 23 Mar 2018 10:53:38 +0100
Message-Id: <20180323094209.263628915@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>


[ Upstream commit 1442f6f7c1b77de1c508318164a527e240c24a4d ]

When creating a new ipvs service, ipv6 addresses are always accepted
if CONFIG_IP_VS_IPV6 is enabled. On dest creation the address family
is not explicitly checked.

This allows the user-space to configure ipvs services even if the
system is booted with ipv6.disable=1. On specific configuration, ipvs
can try to call ipv6 routing code at setup time, causing the kernel to
oops due to fib6_rules_ops being NULL.

This change addresses the issue adding a check for the ipv6
module being enabled while validating ipv6 service operations and
adding the same validation for dest operations.

According to git history, this issue is apparently present since
the introduction of ipv6 support, and the oops can be triggered
since commit 09571c7ae30865ad ("IPVS: Add function to determine
if IPv6 address is local")

Fixes: 09571c7ae30865ad ("IPVS: Add function to determine if IPv6 address is local")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/ipvs/ip_vs_ctl.c |   22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -3092,6 +3092,17 @@ nla_put_failure:
 	return skb->len;
 }
 
+static bool ip_vs_is_af_valid(int af)
+{
+	if (af == AF_INET)
+		return true;
+#ifdef CONFIG_IP_VS_IPV6
+	if (af == AF_INET6 && ipv6_mod_enabled())
+		return true;
+#endif
+	return false;
+}
+
 static int ip_vs_genl_parse_service(struct netns_ipvs *ipvs,
 				    struct ip_vs_service_user_kern *usvc,
 				    struct nlattr *nla, int full_entry,
@@ -3118,11 +3129,7 @@ static int ip_vs_genl_parse_service(stru
 	memset(usvc, 0, sizeof(*usvc));
 
 	usvc->af = nla_get_u16(nla_af);
-#ifdef CONFIG_IP_VS_IPV6
-	if (usvc->af != AF_INET && usvc->af != AF_INET6)
-#else
-	if (usvc->af != AF_INET)
-#endif
+	if (!ip_vs_is_af_valid(usvc->af))
 		return -EAFNOSUPPORT;
 
 	if (nla_fwmark) {
@@ -3624,6 +3631,11 @@ static int ip_vs_genl_set_cmd(struct sk_
 		if (udest.af == 0)
 			udest.af = svc->af;
 
+		if (!ip_vs_is_af_valid(udest.af)) {
+			ret = -EAFNOSUPPORT;
+			goto out;
+		}
+
 		if (udest.af != svc->af && cmd != IPVS_CMD_DEL_DEST) {
 			/* The synchronization protocol is incompatible
 			 * with mixed family services
