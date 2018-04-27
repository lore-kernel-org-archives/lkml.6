Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZol4bCXRXHchJZGE9ytg3Eoe6mcn/tzjmYaNNX3Oj6ZzBa6aAXNQ2c+wJbyxqR7aVsQVMQu
ARC-Seal: i=1; a=rsa-sha256; t=1524837719; cv=none;
        d=google.com; s=arc-20160816;
        b=jNYy0tfz7c/NyrHERLDPlB2Y8q2As17xQfOxh/w/Mskr9WnYK8O7JeaVY+dQCuy5Z/
         LVVjqp4lc5Ri9frSShXqodto9EHClQWusP+BWimrLQpgxTuevyM2cu7nRnd05p6oVJ0I
         1K0e2vhxE4NQFXerPEIAhFbTDlGb7qwRqliA7iDsSsF/LuvL7mryp8W+di8BKvH26gyW
         OLQwh/1U1AZWrejnfb7tcldD8JxUEafMTQTPT2aVUvPQmbIYfo4CNjWtKOzkwj0F9+9v
         XbCFlCYtXUCCnwgkxp7pq8/8sOJnt8OgKvoQ8c2I9VdlmQJ2K5wiPhvqalFoQf2SsD3h
         dyVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=l+ylv9A4E8j13/Bn2IFwVyQRZNYx2VngEzV5JcGFKaw=;
        b=Z6S5x7cCd+zC6QTWCsL5ayk/z/hStQVKuEwJ6VCEOfbfT8ea+ZQoF+aITH6AdimGpe
         NxNO9tsioc9IXqT/CcdLxnwP/EQkdKXPPoWy5m3mE2z2iGz4SVSmSc4BxVdHT22KZndf
         AIzujFHu0PujuDwXFxEJZNGNHGRmE9xaVpypq71gTdkmdMjN3SQYdWYq/TFj6qTrYH0F
         8ciJJE0ZV5jLkOhw14ZcGw9ytrVIB9/ECC0Djd3vnEwdUXwg0zHSXH506V5taPnDiO97
         NT2bf+hoyYfOVrVhZqA8aEftFT09T7bnhJcBE0IJgekQ9oOLFmnwsigI/FI+sdQGIhfc
         80bA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C80D21890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jianwen Ji <jiji@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 39/50] sctp: do not check port in sctp_inet6_cmp_addr
Date: Fri, 27 Apr 2018 15:58:41 +0200
Message-Id: <20180427135658.001565876@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908235270410091?=
X-GMAIL-MSGID: =?utf-8?q?1598908235270410091?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit 1071ec9d453a38023579714b64a951a2fb982071 ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/ipv6.c |   60 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -519,46 +519,49 @@ static void sctp_v6_to_addr(union sctp_a
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
@@ -843,8 +846,8 @@ static int sctp_inet6_cmp_addr(const uni
 			       const union sctp_addr *addr2,
 			       struct sctp_sock *opt)
 {
-	struct sctp_af *af1, *af2;
 	struct sock *sk = sctp_opt2sk(opt);
+	struct sctp_af *af1, *af2;
 
 	af1 = sctp_get_af_specific(addr1->sa.sa_family);
 	af2 = sctp_get_af_specific(addr2->sa.sa_family);
@@ -860,10 +863,7 @@ static int sctp_inet6_cmp_addr(const uni
 	if (sctp_is_any(sk, addr1) || sctp_is_any(sk, addr2))
 		return 1;
 
-	if (addr1->sa.sa_family != addr2->sa.sa_family)
-		return 0;
-
-	return af1->cmp_addr(addr1, addr2);
+	return __sctp_v6_cmp_addr(addr1, addr2);
 }
 
 /* Verify that the provided sockaddr looks bindable.   Common verification,
