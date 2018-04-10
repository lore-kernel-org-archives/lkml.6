Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+bHf3fP+4aF618L0KzhFrV1lmX8bGhRK9gaSefhxhLJrfXBTVUdPazE/AS/tUZSOTnuLyb
ARC-Seal: i=1; a=rsa-sha256; t=1523399558; cv=none;
        d=google.com; s=arc-20160816;
        b=tkuiAQZ2ftBb1ytQqm6C7GupjCIVme/UV6Aj2xpj6Mn89urg9GXvfVd0q71g4QaGmS
         IMq40r5TfRQAuAZWksTjjFzxdcG/8Xbl4iQap5ztsYctDUQ/SxtZetA6XuXHg5s2uSxy
         ALM2W+2xRriYDq0PPx5mXBGAgco5M5QkfJWj3mzx0jFU3rK233WxGS2lpd3zAFQ4t7kp
         ReZvgsesv0SY93D4GJnxPYalKDW5NMs6n+4VXy72PWG2LSxHwXXCrwLcA9oZlZsax1CI
         kuct+C9q8VdyzW1WO/S9RgMVmoJPwVoPX0m2FmMJ3zqmEioH5ogYBNlZT8GULScQ4SO8
         8Mdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ktaf2YgXwRoAwY1vshigg0Q12vlzVE7Yfyav4f//5XQ=;
        b=QC6sBoHECigvnkmEaiFOivtKUuR5VkZTdgQEWWJEhITkpWx/0oUXBLVSv4yhLir9xj
         EkdkM6MihuM65/qElaVwoC9tOtTxtf6ef71hWMMtZVjSeIV+IXsKcW8DuPvnG3qYATHa
         4otlVeiQL8QcoHgs2BFHvLDDRARSSBam12gPqO1AdxZ/7yBPis41MxwBtWnl7TXVhqDP
         hwTEbv8ughhT+Nif6JLJcnUYtoqxeZ5FTVbpz5nhe+ITUU552WczAP50wBUg2uejSnlh
         SZOxRdFZmstmIc8cgjV76Q41HrJzwgLCPFnehG1xS7sVZbF5qd+4uV8qk/uufxN5AuLZ
         EvSw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Aviv Heller <avivh@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.15 152/168] net/mlx5e: Avoid using the ipv6 stub in the TC offload neigh update path
Date: Wed, 11 Apr 2018 00:24:54 +0200
Message-Id: <20180410212807.543019007@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400215891535900?=
X-GMAIL-MSGID: =?utf-8?q?1597400215891535900?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Or Gerlitz <ogerlitz@mellanox.com>


[ Upstream commit 423c9db29943cfc43e3a408192e9efa4178af6a1 ]

Currently we use the global ipv6_stub var to access the ipv6 global
nd table. This practice gets us to troubles when the stub is only partially
set e.g when ipv6 is loaded under the disabled policy. In this case, as of commit
343d60aada5a ("ipv6: change ipv6_stub_impl.ipv6_dst_lookup to take net argument")
the stub is not null, but stub->nd_tbl is and we crash.

As we can access the ipv6 nd_tbl directly, the fix is just to avoid the
reference through the stub. There is one place in the code where we
issue ipv6 route lookup and keep doing it through the stub, but that
mentioned commit makes sure we get -EAFNOSUPPORT from the stack.

Fixes: 232c001398ae ("net/mlx5e: Add support to neighbour update flow")
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Reviewed-by: Aviv Heller <avivh@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c |    6 +++---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c  |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -231,7 +231,7 @@ void mlx5e_remove_sqs_fwd_rules(struct m
 static void mlx5e_rep_neigh_update_init_interval(struct mlx5e_rep_priv *rpriv)
 {
 #if IS_ENABLED(CONFIG_IPV6)
-	unsigned long ipv6_interval = NEIGH_VAR(&ipv6_stub->nd_tbl->parms,
+	unsigned long ipv6_interval = NEIGH_VAR(&nd_tbl.parms,
 						DELAY_PROBE_TIME);
 #else
 	unsigned long ipv6_interval = ~0UL;
@@ -367,7 +367,7 @@ static int mlx5e_rep_netevent_event(stru
 	case NETEVENT_NEIGH_UPDATE:
 		n = ptr;
 #if IS_ENABLED(CONFIG_IPV6)
-		if (n->tbl != ipv6_stub->nd_tbl && n->tbl != &arp_tbl)
+		if (n->tbl != &nd_tbl && n->tbl != &arp_tbl)
 #else
 		if (n->tbl != &arp_tbl)
 #endif
@@ -415,7 +415,7 @@ static int mlx5e_rep_netevent_event(stru
 		 * done per device delay prob time parameter.
 		 */
 #if IS_ENABLED(CONFIG_IPV6)
-		if (!p->dev || (p->tbl != ipv6_stub->nd_tbl && p->tbl != &arp_tbl))
+		if (!p->dev || (p->tbl != &nd_tbl && p->tbl != &arp_tbl))
 #else
 		if (!p->dev || p->tbl != &arp_tbl)
 #endif
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -495,7 +495,7 @@ void mlx5e_tc_update_neigh_used_value(st
 		tbl = &arp_tbl;
 #if IS_ENABLED(CONFIG_IPV6)
 	else if (m_neigh->family == AF_INET6)
-		tbl = ipv6_stub->nd_tbl;
+		tbl = &nd_tbl;
 #endif
 	else
 		return;
