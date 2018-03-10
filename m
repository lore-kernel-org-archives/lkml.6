Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELusCixNUf7ujeR5ig1zB1F/VD6cgGCFjyJc28wmnDUleYANnQLnp1npSZp1wp8OfyxRcEoV
ARC-Seal: i=1; a=rsa-sha256; t=1520641357; cv=none;
        d=google.com; s=arc-20160816;
        b=BabnTXjCMTh0hBb1lquKR4fLMYR1EhjW47F0H2PjM7uWnhFA5am7oSpLlEFBwmtm0J
         lwYT/row2QL5eEH1CM6Ud3UWMeWZg/NoWn785MEpXItDMzKW2I5q8LnOfb9tnZWl2EWy
         PEa6aJAwwG625/pnHpEbQduGsuGWyxkTVewwpQP3LqOeL4tRfwJNArdCVaYUsba3DLc0
         VMIy98RUPXcf9xyqjV36AjqK8/+NLLe4j87BvtfvmQYxIjeXuMbqgRFTQVV/o79MUSA6
         lEP51eyfCZOng0dSASIb19HUCrpekGTS/e+7aZXyTeol94G3pIV0hEibMvYPhLVh3x2k
         ikyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Q7qsySqI0W+bJGwGl6p3AZ3FtJ1IzaNVeoMXBvhHe6Y=;
        b=NZhmchRu4W5WFPJhxyC88EUY5taA7U1qNXmH1JXF0XePLdtCHTpfP/HqzTE1g2PeKh
         0FYOlWJNl3+Tft2fZCsu/kXCG4WBBaqsnv+dVLt3yERTTsMB7OC7HAdXB4cvD0yqkzQG
         KPIDqCI0ztKO0DAjMbQyStxVCPr23W6JqhgPDlwMrRcqSTDL2Q1Xbe11Ss2uktck7W8q
         365C8+VFgiLhnQMy4cWekQx6WmzfyLx7D5RwQTauJhR9RThTSqKYVxkUtNqcht5oBGhK
         lQtfdSfFdYEaMGqiS2GvVmpHI5I6IiCTRLv18PRhWKoJ+BZX6Mz6Z0rHdzW0oMFpu7Pf
         80JA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julian Wiedmann <jwi@linux.vnet.ibm.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 54/65] s390/qeth: fix IP address lookup for L3 devices
Date: Fri,  9 Mar 2018 16:18:54 -0800
Message-Id: <20180310001829.341775302@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594508032260658564?=
X-GMAIL-MSGID: =?utf-8?q?1594508032260658564?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -39,8 +39,40 @@ struct qeth_ipaddr {
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
@@ -154,6 +154,24 @@ int qeth_l3_string_to_ipaddr(const char
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
@@ -207,34 +225,6 @@ static bool qeth_l3_is_addr_covered_by_i
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
@@ -249,8 +239,8 @@ int qeth_l3_delete_ip(struct qeth_card *
 		QETH_CARD_HEX(card, 4, ((char *)&tmp_addr->u.a6.addr) + 8, 8);
 	}
 
-	addr = qeth_l3_ip_from_hash(card, tmp_addr);
-	if (!addr)
+	addr = qeth_l3_find_addr_by_ip(card, tmp_addr);
+	if (!addr || !qeth_l3_addr_match_all(addr, tmp_addr))
 		return -ENOENT;
 
 	addr->ref_counter--;
@@ -272,6 +262,7 @@ int qeth_l3_add_ip(struct qeth_card *car
 {
 	int rc = 0;
 	struct qeth_ipaddr *addr;
+	char buf[40];
 
 	QETH_CARD_TEXT(card, 4, "addip");
 
@@ -282,8 +273,20 @@ int qeth_l3_add_ip(struct qeth_card *car
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
@@ -331,11 +334,7 @@ int qeth_l3_add_ip(struct qeth_card *car
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
 
@@ -719,12 +718,7 @@ int qeth_l3_add_vipa(struct qeth_card *c
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
@@ -787,12 +781,7 @@ int qeth_l3_add_rxip(struct qeth_card *c
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
@@ -1437,8 +1426,9 @@ qeth_l3_add_mc_to_hash(struct qeth_card
 		memcpy(tmp->mac, buf, sizeof(tmp->mac));
 		tmp->is_multicast = 1;
 
-		ipm = qeth_l3_ip_from_hash(card, tmp);
+		ipm = qeth_l3_find_addr_by_ip(card, tmp);
 		if (ipm) {
+			/* for mcast, by-IP match means full match */
 			ipm->disp_flag = QETH_DISP_ADDR_DO_NOTHING;
 		} else {
 			ipm = qeth_l3_get_addr_buffer(QETH_PROT_IPV4);
@@ -1521,8 +1511,9 @@ qeth_l3_add_mc6_to_hash(struct qeth_card
 		       sizeof(struct in6_addr));
 		tmp->is_multicast = 1;
 
-		ipm = qeth_l3_ip_from_hash(card, tmp);
+		ipm = qeth_l3_find_addr_by_ip(card, tmp);
 		if (ipm) {
+			/* for mcast, by-IP match means full match */
 			ipm->disp_flag = QETH_DISP_ADDR_DO_NOTHING;
 			continue;
 		}
