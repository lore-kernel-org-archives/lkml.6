Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520452667-2-17476442415579126436
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
    t=1520452666; b=nT5Dkm59jKVitSiCB31G9wi5zWSE36uF9zthqNfycwuWzQC
    ZIXDJUEMIOuoUjHASn04uLfIlqi6Dz6Am83JyOKjMiZfIHY5v7DYliR87uR5bIDp
    hm4drMWakJ+xI1zRBbf7FwvT2TU/WxY2zfxZ9P7ZROplsrN+TdmgIVfBEpVWvK5m
    b5U4RBTSwxC4s5k+T8nFlIAIPhVf665nvDZtZQyqN6H/gRXkLD2bViDr/ZB94ZG2
    R7cMoIsedJ2ORE6N4615EPpbCT2zXFWpp2cwCs8VV/LtwTLnRltHZlH7Ds18d4WN
    jbdF0SD70AAt8s4ivCoybBFFWZIi/bzQAg40C2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520452666; bh=hFpebPwa0+/uWr+SJDd13IYDRA
    RjjAePuXfDFzV0Z70=; b=K8PNn0aD9/aXP7oFJ10aCPZVkh7fX2apbrdqS8sc42
    DM5e4Q++ywacEjNiCT4GNNN37KE5YY5KUgZw+DrG7eMqfgs/KpKwGeUSgaqoJ9ZV
    +AIsopZZ8kLDkfJaDlLk1XNpXEittgvrvSH2nvM+/+tbuKfSGyj1NTgqJmzwkm1V
    jIfevgPVz5xUTFCQVtPQKgzwxqiJNoJWcU8NmYGlGGVAT3KrMbPs6VkM0r5lUr/V
    jXX8AZLWBs0cxiJWtsrNS4Ihv7CrN7vCLUnQnXjcJpYhBKXfj1aA9T98V0iSBncC
    0pRL2R2pbl5xKKvXpX5Vs7YklRdtyjPg4L/Pl2gIy2Bg==
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
        id S965703AbeCGTrR (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:47:17 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44936 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965684AbeCGTrP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:47:15 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 081/110] s390/qeth: fix IP address lookup for L3 devices
Date: Wed,  7 Mar 2018 11:39:04 -0800
Message-Id: <20180307191050.173434066@linuxfoundation.org>
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

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>


[ Upstream commit c5c48c58b259bb8f0482398370ee539d7a12df3e ]

Current code ("qeth_l3_ip_from_hash()") matches a queried address object
against objects in the IP table by IP address, Mask/Prefix Length and
MAC address ("qeth_l3_ipaddrs_is_equal()"). But what callers actually
require is either
a) "is this IP address registered" (ie. match by IP address only),
before adding a new address.
b) or "is this address object registered" (ie. match all relevant
   attributes), before deleting an address.

Right now
1. the ADD path is too strict in its lookup, and eg. doesn't detect
conflicts between an existing NORMAL address and a new VIPA address
(because the NORMAL address will have mask != 0, while VIPA has
a mask == 0),
2. the DELETE path is not strict enough, and eg. allows del_rxip() to
delete a VIPA address as long as the IP address matches.

Fix all this by adding helpers (_addr_match_ip() and _addr_match_all())
that do the appropriate checking.

Note that the ADD path for NORMAL addresses is special, as qeth keeps
track of how many times such an address is in use (and there is no
immediate way of returning errors to the caller). So when a requested
NORMAL address _fully_ matches an existing one, it's not considered a
conflict and we merely increment the refcount.

Fixes: 5f78e29ceebf ("qeth: optimize IP handling in rx_mode callback")
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_l3.h      |   34 ++++++++++++++
 drivers/s390/net/qeth_l3_main.c |   91 ++++++++++++++++++----------------------
 2 files changed, 74 insertions(+), 51 deletions(-)

--- a/drivers/s390/net/qeth_l3.h
+++ b/drivers/s390/net/qeth_l3.h
@@ -40,8 +40,40 @@ struct qeth_ipaddr {
 			unsigned int pfxlen;
 		} a6;
 	} u;
-
 };
+
+static inline bool qeth_l3_addr_match_ip(struct qeth_ipaddr *a1,
+					 struct qeth_ipaddr *a2)
+{
+	if (a1->proto != a2->proto)
+		return false;
+	if (a1->proto == QETH_PROT_IPV6)
+		return ipv6_addr_equal(&a1->u.a6.addr, &a2->u.a6.addr);
+	return a1->u.a4.addr == a2->u.a4.addr;
+}
+
+static inline bool qeth_l3_addr_match_all(struct qeth_ipaddr *a1,
+					  struct qeth_ipaddr *a2)
+{
+	/* Assumes that the pair was obtained via qeth_l3_addr_find_by_ip(),
+	 * so 'proto' and 'addr' match for sure.
+	 *
+	 * For ucast:
+	 * -	'mac' is always 0.
+	 * -	'mask'/'pfxlen' for RXIP/VIPA is always 0. For NORMAL, matching
+	 *	values are required to avoid mixups in takeover eligibility.
+	 *
+	 * For mcast,
+	 * -	'mac' is mapped from the IP, and thus always matches.
+	 * -	'mask'/'pfxlen' is always 0.
+	 */
+	if (a1->type != a2->type)
+		return false;
+	if (a1->proto == QETH_PROT_IPV6)
+		return a1->u.a6.pfxlen == a2->u.a6.pfxlen;
+	return a1->u.a4.mask == a2->u.a4.mask;
+}
+
 static inline  u64 qeth_l3_ipaddr_hash(struct qeth_ipaddr *addr)
 {
 	u64  ret = 0;
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -149,6 +149,24 @@ int qeth_l3_string_to_ipaddr(const char
 		return -EINVAL;
 }
 
+static struct qeth_ipaddr *qeth_l3_find_addr_by_ip(struct qeth_card *card,
+						   struct qeth_ipaddr *query)
+{
+	u64 key = qeth_l3_ipaddr_hash(query);
+	struct qeth_ipaddr *addr;
+
+	if (query->is_multicast) {
+		hash_for_each_possible(card->ip_mc_htable, addr, hnode, key)
+			if (qeth_l3_addr_match_ip(addr, query))
+				return addr;
+	} else {
+		hash_for_each_possible(card->ip_htable,  addr, hnode, key)
+			if (qeth_l3_addr_match_ip(addr, query))
+				return addr;
+	}
+	return NULL;
+}
+
 static void qeth_l3_convert_addr_to_bits(u8 *addr, u8 *bits, int len)
 {
 	int i, j;
@@ -202,34 +220,6 @@ static bool qeth_l3_is_addr_covered_by_i
 	return rc;
 }
 
-inline int
-qeth_l3_ipaddrs_is_equal(struct qeth_ipaddr *addr1, struct qeth_ipaddr *addr2)
-{
-	return addr1->proto == addr2->proto &&
-		!memcmp(&addr1->u, &addr2->u, sizeof(addr1->u))  &&
-		!memcmp(&addr1->mac, &addr2->mac, sizeof(addr1->mac));
-}
-
-static struct qeth_ipaddr *
-qeth_l3_ip_from_hash(struct qeth_card *card, struct qeth_ipaddr *tmp_addr)
-{
-	struct qeth_ipaddr *addr;
-
-	if (tmp_addr->is_multicast) {
-		hash_for_each_possible(card->ip_mc_htable,  addr,
-				hnode, qeth_l3_ipaddr_hash(tmp_addr))
-			if (qeth_l3_ipaddrs_is_equal(tmp_addr, addr))
-				return addr;
-	} else {
-		hash_for_each_possible(card->ip_htable,  addr,
-				hnode, qeth_l3_ipaddr_hash(tmp_addr))
-			if (qeth_l3_ipaddrs_is_equal(tmp_addr, addr))
-				return addr;
-	}
-
-	return NULL;
-}
-
 int qeth_l3_delete_ip(struct qeth_card *card, struct qeth_ipaddr *tmp_addr)
 {
 	int rc = 0;
@@ -244,8 +234,8 @@ int qeth_l3_delete_ip(struct qeth_card *
 		QETH_CARD_HEX(card, 4, ((char *)&tmp_addr->u.a6.addr) + 8, 8);
 	}
 
-	addr = qeth_l3_ip_from_hash(card, tmp_addr);
-	if (!addr)
+	addr = qeth_l3_find_addr_by_ip(card, tmp_addr);
+	if (!addr || !qeth_l3_addr_match_all(addr, tmp_addr))
 		return -ENOENT;
 
 	addr->ref_counter--;
@@ -267,6 +257,7 @@ int qeth_l3_add_ip(struct qeth_card *car
 {
 	int rc = 0;
 	struct qeth_ipaddr *addr;
+	char buf[40];
 
 	QETH_CARD_TEXT(card, 4, "addip");
 
@@ -277,8 +268,20 @@ int qeth_l3_add_ip(struct qeth_card *car
 		QETH_CARD_HEX(card, 4, ((char *)&tmp_addr->u.a6.addr) + 8, 8);
 	}
 
-	addr = qeth_l3_ip_from_hash(card, tmp_addr);
-	if (!addr) {
+	addr = qeth_l3_find_addr_by_ip(card, tmp_addr);
+	if (addr) {
+		if (tmp_addr->type != QETH_IP_TYPE_NORMAL)
+			return -EADDRINUSE;
+		if (qeth_l3_addr_match_all(addr, tmp_addr)) {
+			addr->ref_counter++;
+			return 0;
+		}
+		qeth_l3_ipaddr_to_string(tmp_addr->proto, (u8 *)&tmp_addr->u,
+					 buf);
+		dev_warn(&card->gdev->dev,
+			 "Registering IP address %s failed\n", buf);
+		return -EADDRINUSE;
+	} else {
 		addr = qeth_l3_get_addr_buffer(tmp_addr->proto);
 		if (!addr)
 			return -ENOMEM;
@@ -326,11 +329,7 @@ int qeth_l3_add_ip(struct qeth_card *car
 			hash_del(&addr->hnode);
 			kfree(addr);
 		}
-	} else {
-			if (addr->type == QETH_IP_TYPE_NORMAL)
-				addr->ref_counter++;
 	}
-
 	return rc;
 }
 
@@ -714,12 +713,7 @@ int qeth_l3_add_vipa(struct qeth_card *c
 		return -ENOMEM;
 
 	spin_lock_bh(&card->ip_lock);
-
-	if (qeth_l3_ip_from_hash(card, ipaddr))
-		rc = -EEXIST;
-	else
-		qeth_l3_add_ip(card, ipaddr);
-
+	rc = qeth_l3_add_ip(card, ipaddr);
 	spin_unlock_bh(&card->ip_lock);
 
 	kfree(ipaddr);
@@ -782,12 +776,7 @@ int qeth_l3_add_rxip(struct qeth_card *c
 		return -ENOMEM;
 
 	spin_lock_bh(&card->ip_lock);
-
-	if (qeth_l3_ip_from_hash(card, ipaddr))
-		rc = -EEXIST;
-	else
-		qeth_l3_add_ip(card, ipaddr);
-
+	rc = qeth_l3_add_ip(card, ipaddr);
 	spin_unlock_bh(&card->ip_lock);
 
 	kfree(ipaddr);
@@ -1395,8 +1384,9 @@ qeth_l3_add_mc_to_hash(struct qeth_card
 		memcpy(tmp->mac, buf, sizeof(tmp->mac));
 		tmp->is_multicast = 1;
 
-		ipm = qeth_l3_ip_from_hash(card, tmp);
+		ipm = qeth_l3_find_addr_by_ip(card, tmp);
 		if (ipm) {
+			/* for mcast, by-IP match means full match */
 			ipm->disp_flag = QETH_DISP_ADDR_DO_NOTHING;
 		} else {
 			ipm = qeth_l3_get_addr_buffer(QETH_PROT_IPV4);
@@ -1479,8 +1469,9 @@ qeth_l3_add_mc6_to_hash(struct qeth_card
 		       sizeof(struct in6_addr));
 		tmp->is_multicast = 1;
 
-		ipm = qeth_l3_ip_from_hash(card, tmp);
+		ipm = qeth_l3_find_addr_by_ip(card, tmp);
 		if (ipm) {
+			/* for mcast, by-IP match means full match */
 			ipm->disp_flag = QETH_DISP_ADDR_DO_NOTHING;
 			continue;
 		}
