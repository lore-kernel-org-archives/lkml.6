Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx482e9KCj/vg6oN3Y7U7lLcg1R/oCX4VFmxn4oYN3zEjXCuuKsN/+ZwUhWmDKYJkjFROXY2J
ARC-Seal: i=1; a=rsa-sha256; t=1522346681; cv=none;
        d=google.com; s=arc-20160816;
        b=bkq88If8DCtDqwFOiwXQTKa6Av4+APIx9Rd9iEQ2klQoWXnJjdyTX+ZmmXO2P51ZlD
         ysPFhhDcxJspJAwK0yQ/X3tUILNqCZRDbkkkkABckF0T/0khKtfR7VG+deS9BBCCIViU
         MixFkjwa9ZG2NabWiqcq0QapkK6GfD/TWv46K60NK8yxiModCzQTiN+63/b5tYFVVN8G
         6M6qbfXh8lv0ZzG4PuUybIsY41y2EHcDc+8nD1ai3oSPZRWnrLvxke4UDdH0dLt61W6h
         UJfjVlKwn1RtCqotaJQnKJx/4bB5jpVlWetYWKE/xlHsqM1Oz/0S7//z3X57Mm9oG7eE
         E32A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RMRrGtnisgxIYDDwYznpNlMIgXQoqnd8aYJdoKJqeqw=;
        b=kM5lrGy8UlVZC9nL39iZGH0lww+g/22LO/X17Pa2Colna1sUb3jGlagl7QPpv6rRkG
         Coq3C4VgTSGKnUBFXTEu0yEmAeTF3FdLuOoqARzOJZTJH/NpyUtXvTeixgb0cGRaFQqU
         zL2e8JCmqvzHxYhPmppJI01LBD2VNQOIZqr5Jb2xdM8ZTCJKM/Ib6e7G16MMLJfHRC2P
         8lal/htIBoHYpOPCwXQWp0oX/KGJN74+P6AEL5jAurjMWKD61EA4xM4axkXsJj9p02lg
         F589VAPVrYefCPFasYFeeZ0Vxa7eniddQf1b1J8nwnLTEbZxOZ2tG+5oHdHgqSHsiClv
         ymsw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michal Kalderon <Michal.Kalderon@cavium.com>,
	Ariel Elior <Ariel.Elior@cavium.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 03/43] qed: Fix non TCP packets should be dropped on iWARP ll2 connection
Date: Thu, 29 Mar 2018 19:59:58 +0200
Message-Id: <20180329175730.461211781@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296021593210759?=
X-GMAIL-MSGID: =?utf-8?q?1596296193592686483?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Kalderon <Michal.Kalderon@cavium.com>


[ Upstream commit 16da09047d3fb991dc48af41f6d255fd578e8ca2 ]

FW workaround. The iWARP LL2 connection did not expect TCP packets
to arrive on it's connection. The fix drops any non-tcp packets

Fixes b5c29ca ("qed: iWARP CM - setup a ll2 connection for handling
SYN packets")

Signed-off-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Signed-off-by: Ariel Elior <Ariel.Elior@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
@@ -1663,6 +1663,13 @@ qed_iwarp_parse_rx_pkt(struct qed_hwfn *
 	iph = (struct iphdr *)((u8 *)(ethh) + eth_hlen);
 
 	if (eth_type == ETH_P_IP) {
+		if (iph->protocol != IPPROTO_TCP) {
+			DP_NOTICE(p_hwfn,
+				  "Unexpected ip protocol on ll2 %x\n",
+				  iph->protocol);
+			return -EINVAL;
+		}
+
 		cm_info->local_ip[0] = ntohl(iph->daddr);
 		cm_info->remote_ip[0] = ntohl(iph->saddr);
 		cm_info->ip_version = TCP_IPV4;
@@ -1671,6 +1678,14 @@ qed_iwarp_parse_rx_pkt(struct qed_hwfn *
 		*payload_len = ntohs(iph->tot_len) - ip_hlen;
 	} else if (eth_type == ETH_P_IPV6) {
 		ip6h = (struct ipv6hdr *)iph;
+
+		if (ip6h->nexthdr != IPPROTO_TCP) {
+			DP_NOTICE(p_hwfn,
+				  "Unexpected ip protocol on ll2 %x\n",
+				  iph->protocol);
+			return -EINVAL;
+		}
+
 		for (i = 0; i < 4; i++) {
 			cm_info->local_ip[i] =
 			    ntohl(ip6h->daddr.in6_u.u6_addr32[i]);
