Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2FCC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E3E21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E3E21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387970AbeIXSdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:33:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57914 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730258AbeIXSdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:33:00 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E6FD51099;
        Mon, 24 Sep 2018 12:31:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Piotr Sawicki <p.sawicki2@partner.samsung.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 071/235] Smack: Fix handling of IPv4 traffic received by PF_INET6 sockets
Date:   Mon, 24 Sep 2018 13:50:57 +0200
Message-Id: <20180924113112.319567222@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Piotr Sawicki <p.sawicki2@partner.samsung.com>

[ Upstream commit 129a99890936766f4b69b9da7ed88366313a9210 ]

A socket which has sk_family set to PF_INET6 is able to receive not
only IPv6 but also IPv4 traffic (IPv4-mapped IPv6 addresses).

Prior to this patch, the smk_skb_to_addr_ipv6() could have been
called for socket buffers containing IPv4 packets, in result such
traffic was allowed.

Signed-off-by: Piotr Sawicki <p.sawicki2@partner.samsung.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/smack/smack_lsm.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3924,15 +3924,19 @@ static int smack_socket_sock_rcv_skb(str
 	struct smack_known *skp = NULL;
 	int rc = 0;
 	struct smk_audit_info ad;
+	u16 family = sk->sk_family;
 #ifdef CONFIG_AUDIT
 	struct lsm_network_audit net;
 #endif
 #if IS_ENABLED(CONFIG_IPV6)
 	struct sockaddr_in6 sadd;
 	int proto;
+
+	if (family == PF_INET6 && skb->protocol == htons(ETH_P_IP))
+		family = PF_INET;
 #endif /* CONFIG_IPV6 */
 
-	switch (sk->sk_family) {
+	switch (family) {
 	case PF_INET:
 #ifdef CONFIG_SECURITY_SMACK_NETFILTER
 		/*
@@ -3950,7 +3954,7 @@ static int smack_socket_sock_rcv_skb(str
 		 */
 		netlbl_secattr_init(&secattr);
 
-		rc = netlbl_skbuff_getattr(skb, sk->sk_family, &secattr);
+		rc = netlbl_skbuff_getattr(skb, family, &secattr);
 		if (rc == 0)
 			skp = smack_from_secattr(&secattr, ssp);
 		else
@@ -3963,7 +3967,7 @@ access_check:
 #endif
 #ifdef CONFIG_AUDIT
 		smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
-		ad.a.u.net->family = sk->sk_family;
+		ad.a.u.net->family = family;
 		ad.a.u.net->netif = skb->skb_iif;
 		ipv4_skb_to_auditdata(skb, &ad.a, NULL);
 #endif
@@ -3977,7 +3981,7 @@ access_check:
 		rc = smk_bu_note("IPv4 delivery", skp, ssp->smk_in,
 					MAY_WRITE, rc);
 		if (rc != 0)
-			netlbl_skbuff_err(skb, sk->sk_family, rc, 0);
+			netlbl_skbuff_err(skb, family, rc, 0);
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case PF_INET6:
@@ -3993,7 +3997,7 @@ access_check:
 			skp = smack_net_ambient;
 #ifdef CONFIG_AUDIT
 		smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
-		ad.a.u.net->family = sk->sk_family;
+		ad.a.u.net->family = family;
 		ad.a.u.net->netif = skb->skb_iif;
 		ipv6_skb_to_auditdata(skb, &ad.a, NULL);
 #endif /* CONFIG_AUDIT */


