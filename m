Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49ElGSyvV6jHbu+NmMx0y38cpDCbgZTTHFB4uDWPyxgvwX37zZ6V6Z5xfGztmA35xnNsfHL
ARC-Seal: i=1; a=rsa-sha256; t=1523473398; cv=none;
        d=google.com; s=arc-20160816;
        b=VPR95u2nEcuC3HkWF2Mle6lU5NmgLTds0wrLmIVFGgHor0ldM5lAZqH5uvhCbtgpwT
         qeJQM/+c1vXQWiRB2h+mV+WAecPqJ2M4zEDt7JwPj59SkrDoW+VBZpSvOmDoKAk6MqWJ
         PetX4KnnafJPZbpb9XetyioKzXaki+i23LaewMB3aBygMtpPuhQfg90CL1J6FaW5ljZX
         oSKif6QeAnR+cL9z03bU0H5AVYJeZyIJr7gYsPHI8rIBNwOVgx72nQu9SQqoF+FQhBym
         rhjvsOHehE+FwI5WoXF3gtcAHHws0Wy/5OIUe1atuaxIeZTfr+FExh8f8z3SP9OSz0DR
         iMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6IU66UGL2R28dEzBYBnFK6n7OmX6dH8FFVrgbhElqqY=;
        b=fHjq9Cv/MbehreVpLoMHT4Pz8U1OTPCDXf/Zz746rVD3S4gWPyo50pgi1rLexGVg/e
         bHoLg3G+L66rnqN0bTP7dBSOJnF0r9xa8Fri0aQU/Mx7XWmclhTsduls7X8R1717qNAD
         6Sd/dT23RtWRrJOnFvqDcUJE9CNmiSTaML0QNUvkWTlX6WHavnwR/aT55TlJg1T7qZkI
         TQZaC/kJ33RoIxZ1JijtF73jfpnh3PuprKe1B+ax2A9d0RXs81jGd4mM9im2x3gTAmfY
         vp0b9JKJKHt5j39ctABsv64ldkvxJbgEhgYBI5xIVWvUzy2VEtuuYhqnZDb+P9Zp+vwG
         DKVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Girish Moodalbail <girish.moodalbail@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 233/310] geneve: add missing rx stats accounting
Date: Wed, 11 Apr 2018 20:36:12 +0200
Message-Id: <20180411183632.530827538@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477642416843729?=
X-GMAIL-MSGID: =?utf-8?q?1597477642416843729?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Girish Moodalbail <girish.moodalbail@oracle.com>


[ Upstream commit fe741e2362f33bbea813bcc3a921de356c6653db ]

There are few places on the receive path where packet drops and packet
errors were not accounted for. This patch fixes that issue.

Signed-off-by: Girish Moodalbail <girish.moodalbail@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/geneve.c |   36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -209,6 +209,7 @@ static void geneve_rx(struct geneve_dev
 	struct genevehdr *gnvh = geneve_hdr(skb);
 	struct metadata_dst *tun_dst = NULL;
 	struct pcpu_sw_netstats *stats;
+	unsigned int len;
 	int err = 0;
 	void *oiph;
 
@@ -222,8 +223,10 @@ static void geneve_rx(struct geneve_dev
 		tun_dst = udp_tun_rx_dst(skb, geneve_get_sk_family(gs), flags,
 					 vni_to_tunnel_id(gnvh->vni),
 					 gnvh->opt_len * 4);
-		if (!tun_dst)
+		if (!tun_dst) {
+			geneve->dev->stats.rx_dropped++;
 			goto drop;
+		}
 		/* Update tunnel dst according to Geneve options. */
 		ip_tunnel_info_opts_set(&tun_dst->u.tun_info,
 					gnvh->options, gnvh->opt_len * 4);
@@ -231,8 +234,11 @@ static void geneve_rx(struct geneve_dev
 		/* Drop packets w/ critical options,
 		 * since we don't support any...
 		 */
-		if (gnvh->critical)
+		if (gnvh->critical) {
+			geneve->dev->stats.rx_frame_errors++;
+			geneve->dev->stats.rx_errors++;
 			goto drop;
+		}
 	}
 
 	skb_reset_mac_header(skb);
@@ -243,8 +249,10 @@ static void geneve_rx(struct geneve_dev
 		skb_dst_set(skb, &tun_dst->dst);
 
 	/* Ignore packet loops (and multicast echo) */
-	if (ether_addr_equal(eth_hdr(skb)->h_source, geneve->dev->dev_addr))
+	if (ether_addr_equal(eth_hdr(skb)->h_source, geneve->dev->dev_addr)) {
+		geneve->dev->stats.rx_errors++;
 		goto drop;
+	}
 
 	oiph = skb_network_header(skb);
 	skb_reset_network_header(skb);
@@ -276,13 +284,15 @@ static void geneve_rx(struct geneve_dev
 		}
 	}
 
-	stats = this_cpu_ptr(geneve->dev->tstats);
-	u64_stats_update_begin(&stats->syncp);
-	stats->rx_packets++;
-	stats->rx_bytes += skb->len;
-	u64_stats_update_end(&stats->syncp);
-
-	gro_cells_receive(&geneve->gro_cells, skb);
+	len = skb->len;
+	err = gro_cells_receive(&geneve->gro_cells, skb);
+	if (likely(err == NET_RX_SUCCESS)) {
+		stats = this_cpu_ptr(geneve->dev->tstats);
+		u64_stats_update_begin(&stats->syncp);
+		stats->rx_packets++;
+		stats->rx_bytes += len;
+		u64_stats_update_end(&stats->syncp);
+	}
 	return;
 drop:
 	/* Consume bad packet */
@@ -332,7 +342,7 @@ static int geneve_udp_encap_recv(struct
 	struct geneve_sock *gs;
 	int opts_len;
 
-	/* Need Geneve and inner Ethernet header to be present */
+	/* Need UDP and Geneve header to be present */
 	if (unlikely(!pskb_may_pull(skb, GENEVE_BASE_HLEN)))
 		goto drop;
 
@@ -355,8 +365,10 @@ static int geneve_udp_encap_recv(struct
 	opts_len = geneveh->opt_len * 4;
 	if (iptunnel_pull_header(skb, GENEVE_BASE_HLEN + opts_len,
 				 htons(ETH_P_TEB),
-				 !net_eq(geneve->net, dev_net(geneve->dev))))
+				 !net_eq(geneve->net, dev_net(geneve->dev)))) {
+		geneve->dev->stats.rx_dropped++;
 		goto drop;
+	}
 
 	geneve_rx(geneve, gs, skb);
 	return 0;
