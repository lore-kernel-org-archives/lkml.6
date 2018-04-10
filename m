Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+GU1hio5wrCO+ks1KE94uSOeUWKxphIard1lZcVUgBdXhpK698LYerUtj5ob/XHvJ5hyMA
ARC-Seal: i=1; a=rsa-sha256; t=1523399954; cv=none;
        d=google.com; s=arc-20160816;
        b=EB9Ck0RFz4qoqpQMG51IpiDRzwnfwa0M2pOGGmdXVZjW/NsxI/GMA3XYvqx9OHXrc0
         1swfe3rUe7eq8HcDm/gMHOoXSGThK8Irlywx0nzNUcqgKdEdwQEAZD8DvMmjOQZ4m9XC
         /Ex6D4q/nRGpSg5DUhMjtONQJlETZCEgQHGyusC/WBv1j3xFU7usyk98mMizFKZYJAom
         Y9uG8V5VlTu+bmh+dd+QOWUMYziH7C5SxvAKpVK8EdCsSwdnnzi6jdXTlkdasmzwgXJY
         fWrl8RrF3GXfLrqPPzhqt27X5JwBtJiV0SAdReE43saGOf9NZrpBPrlCriGpagGCd35j
         hM+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Bph7aQWiIblfg6yjyGHvzwupxNGD+j58Acq61h0ET4g=;
        b=vLucOkkRUQgamg962smvKClqHdul5rXiVOJaN/XI88PLYniO8vfL1KWv0mdhBj6AoP
         fyY8Ixcd5EHzrNWZlFaNbIrPo/yudcVcAfIvLXxuWoM5vcBojL6TOLkMZWJlWQ2jyaHZ
         aZ05R5IMNnZQwhU3aZgCflAnj2+bLpvJp/lSN+66KcrGuD+MleNqaA+uSxQEcJh3s8Hn
         /54uiyTRxablpG9zHeMD2Do+e8bWI1q+MeYXPy+7lvd16AaQNqPVzGCCl3MPRrt4sZRs
         xeKoQZy4YJML9wgAWP/DYbO1UNshVsmvBwqacOk7krtI88W28P/jWtGhvXt3JJT+95k3
         zyRQ==
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
Subject: [PATCH 4.14 123/138] net/mlx5e: Avoid using the ipv6 stub in the TC offload neigh update path
Date: Wed, 11 Apr 2018 00:25:13 +0200
Message-Id: <20180410212916.470603428@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400215891535900?=
X-GMAIL-MSGID: =?utf-8?q?1597400630535313170?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -230,7 +230,7 @@ void mlx5e_remove_sqs_fwd_rules(struct m
 static void mlx5e_rep_neigh_update_init_interval(struct mlx5e_rep_priv *rpriv)
 {
 #if IS_ENABLED(CONFIG_IPV6)
-	unsigned long ipv6_interval = NEIGH_VAR(&ipv6_stub->nd_tbl->parms,
+	unsigned long ipv6_interval = NEIGH_VAR(&nd_tbl.parms,
 						DELAY_PROBE_TIME);
 #else
 	unsigned long ipv6_interval = ~0UL;
@@ -366,7 +366,7 @@ static int mlx5e_rep_netevent_event(stru
 	case NETEVENT_NEIGH_UPDATE:
 		n = ptr;
 #if IS_ENABLED(CONFIG_IPV6)
-		if (n->tbl != ipv6_stub->nd_tbl && n->tbl != &arp_tbl)
+		if (n->tbl != &nd_tbl && n->tbl != &arp_tbl)
 #else
 		if (n->tbl != &arp_tbl)
 #endif
@@ -414,7 +414,7 @@ static int mlx5e_rep_netevent_event(stru
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
@@ -484,7 +484,7 @@ void mlx5e_tc_update_neigh_used_value(st
 		tbl = &arp_tbl;
 #if IS_ENABLED(CONFIG_IPV6)
 	else if (m_neigh->family == AF_INET6)
-		tbl = ipv6_stub->nd_tbl;
+		tbl = &nd_tbl;
 #endif
 	else
 		return;
