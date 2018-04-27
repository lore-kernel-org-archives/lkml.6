Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq6IreFYHMAlfcaL6HCShAJhCy1rjJNfQXs01YCxktC5SQC9pfn9qFatlq9zGQWtMTDCfxl
ARC-Seal: i=1; a=rsa-sha256; t=1524837897; cv=none;
        d=google.com; s=arc-20160816;
        b=Ft0pP6kjOCXdlMPiGk1x+dK/wSztx95UR+pb0hrAuhhzrQ9ynI2i4IsWpzbyNg3kUr
         jUsj1WwI7usa5SFVc7+bA2kcPHpoGSvwq5Px32ceCxUvRGCoBwRamhfb/mnibXRIED1r
         iYCcagqzwFrcwCjTRdCgVq7WLRvutiSKu/QrpwuPAhZXytAusF/EySaqbC62B6k4zeOe
         qNgYoLvaCACvYGjnjzerLjfxCfN+f2aCJ1EhfZbNMkizelnf3LITXJCycT4UNVJiCcjd
         AdGfjJTe6etzq5I3xb07KuEdU0OCLFw13GTn/i5l/WKhchd3cmffAZU/ToVgTQBJ7SA+
         uNLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=4ZDW+/VPBm6RrF/Ch0d6CpXS+n0eggWN8LKeTTeTZwI=;
        b=vu6d0Mk8p+D9fCsC3DiB9n1oBXFf8rotwpGo9Z0wt6O5N5CbyxoTmq609/MTweMvUI
         IJ1v15VnNF4vExQLfQT58f/GFxcTtaXDZNJCU+2OT5P9GNjm6LltYNCyWizvjpdHjmG5
         Bx07lcMcmh6YMshudkfkyMEw9qD9ou4pk6qEbI3nEcBafnMN7+1J3qPtoxfWhvayzF3d
         YyRXVyr/gzmc3kJ1TOpJUfkv74PV6BejvUJ1zvWRrRzN3gSUjPX9hBsebxYFGfmTT9CB
         S9Cv8zXOV8UHFfBBNA6onNFdhwCO/u4hdyii71buEaJh0tSS05yHbaYKmOAWKRc1ka9p
         W+iA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9BD21864
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
Subject: [PATCH 4.9 59/74] sctp: do not check port in sctp_inet6_cmp_addr
Date: Fri, 27 Apr 2018 15:58:49 +0200
Message-Id: <20180427135712.376671269@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908235270410091?=
X-GMAIL-MSGID: =?utf-8?q?1598908423140309557?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -521,46 +521,49 @@ static void sctp_v6_to_addr(union sctp_a
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
@@ -844,8 +847,8 @@ static int sctp_inet6_cmp_addr(const uni
 			       const union sctp_addr *addr2,
 			       struct sctp_sock *opt)
 {
-	struct sctp_af *af1, *af2;
 	struct sock *sk = sctp_opt2sk(opt);
+	struct sctp_af *af1, *af2;
 
 	af1 = sctp_get_af_specific(addr1->sa.sa_family);
 	af2 = sctp_get_af_specific(addr2->sa.sa_family);
@@ -861,10 +864,7 @@ static int sctp_inet6_cmp_addr(const uni
 	if (sctp_is_any(sk, addr1) || sctp_is_any(sk, addr2))
 		return 1;
 
-	if (addr1->sa.sa_family != addr2->sa.sa_family)
-		return 0;
-
-	return af1->cmp_addr(addr1, addr2);
+	return __sctp_v6_cmp_addr(addr1, addr2);
 }
 
 /* Verify that the provided sockaddr looks bindable.   Common verification,
