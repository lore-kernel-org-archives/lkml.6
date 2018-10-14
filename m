Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835B1C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F1720645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F1720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbeJNXXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:23:32 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36939 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726996AbeJNXXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:23:31 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM3-0004cA-B5; Sun, 14 Oct 2018 16:30:55 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLS-0000Ks-Fh; Sun, 14 Oct 2018 16:30:18 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jianwen Ji" <jiji@redhat.com>,
        "Xin Long" <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Neil Horman" <nhorman@tuxdriver.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.376568313@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 143/366] sctp: do not check port in sctp_inet6_cmp_addr
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

commit 1071ec9d453a38023579714b64a951a2fb982071 upstream.

pf->cmp_addr() is called before binding a v6 address to the sock. It
should not check ports, like in sctp_inet_cmp_addr.

But sctp_inet6_cmp_addr checks the addr by invoking af(6)->cmp_addr,
sctp_v6_cmp_addr where it also compares the ports.

This would cause that setsockopt(SCTP_SOCKOPT_BINDX_ADD) could bind
multiple duplicated IPv6 addresses after Commit 40b4f0fd74e4 ("sctp:
lack the check for ports in sctp_v6_cmp_addr").

This patch is to remove af->cmp_addr called in sctp_inet6_cmp_addr,
but do the proper check for both v6 addrs and v4mapped addrs.

v1->v2:
  - define __sctp_v6_cmp_addr to do the common address comparison
    used for both pf and af v6 cmp_addr.

Fixes: 40b4f0fd74e4 ("sctp: lack the check for ports in sctp_v6_cmp_addr")
Reported-by: Jianwen Ji <jiji@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/sctp/ipv6.c | 60 ++++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -496,46 +496,49 @@ static void sctp_v6_to_addr(union sctp_a
 	addr->v6.sin6_scope_id = 0;
 }
 
-/* Compare addresses exactly.
- * v4-mapped-v6 is also in consideration.
- */
-static int sctp_v6_cmp_addr(const union sctp_addr *addr1,
-			    const union sctp_addr *addr2)
+static int __sctp_v6_cmp_addr(const union sctp_addr *addr1,
+			      const union sctp_addr *addr2)
 {
 	if (addr1->sa.sa_family != addr2->sa.sa_family) {
 		if (addr1->sa.sa_family == AF_INET &&
 		    addr2->sa.sa_family == AF_INET6 &&
-		    ipv6_addr_v4mapped(&addr2->v6.sin6_addr)) {
-			if (addr2->v6.sin6_port == addr1->v4.sin_port &&
-			    addr2->v6.sin6_addr.s6_addr32[3] ==
-			    addr1->v4.sin_addr.s_addr)
-				return 1;
-		}
+		    ipv6_addr_v4mapped(&addr2->v6.sin6_addr) &&
+		    addr2->v6.sin6_addr.s6_addr32[3] ==
+		    addr1->v4.sin_addr.s_addr)
+			return 1;
+
 		if (addr2->sa.sa_family == AF_INET &&
 		    addr1->sa.sa_family == AF_INET6 &&
-		    ipv6_addr_v4mapped(&addr1->v6.sin6_addr)) {
-			if (addr1->v6.sin6_port == addr2->v4.sin_port &&
-			    addr1->v6.sin6_addr.s6_addr32[3] ==
-			    addr2->v4.sin_addr.s_addr)
-				return 1;
-		}
+		    ipv6_addr_v4mapped(&addr1->v6.sin6_addr) &&
+		    addr1->v6.sin6_addr.s6_addr32[3] ==
+		    addr2->v4.sin_addr.s_addr)
+			return 1;
+
 		return 0;
 	}
-	if (addr1->v6.sin6_port != addr2->v6.sin6_port)
-		return 0;
+
 	if (!ipv6_addr_equal(&addr1->v6.sin6_addr, &addr2->v6.sin6_addr))
 		return 0;
+
 	/* If this is a linklocal address, compare the scope_id. */
-	if (ipv6_addr_type(&addr1->v6.sin6_addr) & IPV6_ADDR_LINKLOCAL) {
-		if (addr1->v6.sin6_scope_id && addr2->v6.sin6_scope_id &&
-		    (addr1->v6.sin6_scope_id != addr2->v6.sin6_scope_id)) {
-			return 0;
-		}
-	}
+	if ((ipv6_addr_type(&addr1->v6.sin6_addr) & IPV6_ADDR_LINKLOCAL) &&
+	    addr1->v6.sin6_scope_id && addr2->v6.sin6_scope_id &&
+	    addr1->v6.sin6_scope_id != addr2->v6.sin6_scope_id)
+		return 0;
 
 	return 1;
 }
 
+/* Compare addresses exactly.
+ * v4-mapped-v6 is also in consideration.
+ */
+static int sctp_v6_cmp_addr(const union sctp_addr *addr1,
+			    const union sctp_addr *addr2)
+{
+	return __sctp_v6_cmp_addr(addr1, addr2) &&
+	       addr1->v6.sin6_port == addr2->v6.sin6_port;
+}
+
 /* Initialize addr struct to INADDR_ANY. */
 static void sctp_v6_inaddr_any(union sctp_addr *addr, __be16 port)
 {
@@ -820,8 +823,8 @@ static int sctp_inet6_cmp_addr(const uni
 			       const union sctp_addr *addr2,
 			       struct sctp_sock *opt)
 {
-	struct sctp_af *af1, *af2;
 	struct sock *sk = sctp_opt2sk(opt);
+	struct sctp_af *af1, *af2;
 
 	af1 = sctp_get_af_specific(addr1->sa.sa_family);
 	af2 = sctp_get_af_specific(addr2->sa.sa_family);
@@ -837,10 +840,7 @@ static int sctp_inet6_cmp_addr(const uni
 	if (sctp_is_any(sk, addr1) || sctp_is_any(sk, addr2))
 		return 1;
 
-	if (addr1->sa.sa_family != addr2->sa.sa_family)
-		return 0;
-
-	return af1->cmp_addr(addr1, addr2);
+	return __sctp_v6_cmp_addr(addr1, addr2);
 }
 
 /* Verify that the provided sockaddr looks bindable.   Common verification,

