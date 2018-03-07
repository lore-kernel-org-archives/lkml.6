Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt8fyQ4BaxcxF6Ug1uUOxe9PLJ+a0H5PXe7hxaxmlrWP13knBzBEso4icHce2MZsRtGh/Y2
ARC-Seal: i=1; a=rsa-sha256; t=1520451960; cv=none;
        d=google.com; s=arc-20160816;
        b=HWRIwkP9DmvGw0hPIgr8XYVd5qlLHW85kAmVlWGPzDSVcMvThnV6R6WMvqqGAGiPRZ
         zjmfe/UuwNYWqVLH9qc8kAuLIWxSY/OqBTFLYtkPkrFM/2ebP8471hLFZ7TJ31TZsFLQ
         ReiKAPPXjBGaNZFsaAfY5BEHjSZsAejeEdeNMmXMmqyDCOqIYS0624+YVFwKKjpby119
         Zwf7xUyYIf6UU0rOUXOOTDJkbotVjSzn47MkxMj/hkY9ZNtvX+QtIcrOzjsW9Ui10Poo
         pBovv3LYoBVeEX3vRziF8d67K/wsul+kI02+m7wfV7cPCTj80DC2cte16vBdd36ATjE1
         XunQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YcxxbHPlUGcgUJnwKAz+zQDyuZr32Jhc1p4pberEVfo=;
        b=cFg269bGWSzLch4vO0JLEfarj693THLZSseoTg+u/jbUR65ODhuTqJyEyUxf5V01Dk
         HTzM0GcAAnwniNEP++QmZ37mnpqQ75hKF//gp1Fgli/i0UuHmbRv0mp9ij9J6Q3quNJg
         hxIOHym8K75eF4mCMvH66AitiVKMLtpMFxjvjW6PclLe+Zxwrj4srfm5nCXGonKM4pPe
         qdlEfQi1F2iDB7g/jcgzvMVaLAynsXGGEPh2fgmFI5vi2CQ2asUo8TttoQY+klKKbkM8
         fuxaIaHfWVFlS4hgMjv8YLD8L0Jvo6Fb8LvadWpUEsPTLpi488KwKnvusrmJ9F63eVzm
         xQ6w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gal Pressman <galp@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.14 047/110] net/mlx5e: Fix TCP checksum in LRO buffers
Date: Wed,  7 Mar 2018 11:38:30 -0800
Message-Id: <20180307191045.744657805@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309146234864843?=
X-GMAIL-MSGID: =?utf-8?q?1594309434835629693?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gal Pressman <galp@mellanox.com>


[ Upstream commit 8babd44d2079079f9d5a4aca7005aed80236efe0 ]

When receiving an LRO packet, the checksum field is set by the hardware
to the checksum of the first coalesced packet. Obviously, this checksum
is not valid for the merged LRO packet and should be fixed.  We can use
the CQE checksum which covers the checksum of the entire merged packet
TCP payload to help us calculate the checksum incrementally.

Tested by sending IPv4/6 traffic with LRO enabled, RX checksum disabled
and watching nstat checksum error counters (in addition to the obvious
bandwidth drop caused by checksum errors).

This bug is usually "hidden" since LRO packets would go through the
CHECKSUM_UNNECESSARY flow which does not validate the packet checksum.

It's important to note that previous to this patch, LRO packets provided
with CHECKSUM_UNNECESSARY are indeed packets with a correct validated
checksum (even though the checksum inside the TCP header is incorrect),
since the hardware LRO aggregation is terminated upon receiving a packet
with bad checksum.

Fixes: e586b3b0baee ("net/mlx5: Ethernet Datapath files")
Signed-off-by: Gal Pressman <galp@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c |   47 +++++++++++++++++-------
 1 file changed, 34 insertions(+), 13 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -36,6 +36,7 @@
 #include <linux/tcp.h>
 #include <linux/bpf_trace.h>
 #include <net/busy_poll.h>
+#include <net/ip6_checksum.h>
 #include "en.h"
 #include "en_tc.h"
 #include "eswitch.h"
@@ -546,20 +547,33 @@ bool mlx5e_post_rx_mpwqes(struct mlx5e_r
 	return true;
 }
 
+static void mlx5e_lro_update_tcp_hdr(struct mlx5_cqe64 *cqe, struct tcphdr *tcp)
+{
+	u8 l4_hdr_type = get_cqe_l4_hdr_type(cqe);
+	u8 tcp_ack     = (l4_hdr_type == CQE_L4_HDR_TYPE_TCP_ACK_NO_DATA) ||
+			 (l4_hdr_type == CQE_L4_HDR_TYPE_TCP_ACK_AND_DATA);
+
+	tcp->check                      = 0;
+	tcp->psh                        = get_cqe_lro_tcppsh(cqe);
+
+	if (tcp_ack) {
+		tcp->ack                = 1;
+		tcp->ack_seq            = cqe->lro_ack_seq_num;
+		tcp->window             = cqe->lro_tcp_win;
+	}
+}
+
 static void mlx5e_lro_update_hdr(struct sk_buff *skb, struct mlx5_cqe64 *cqe,
 				 u32 cqe_bcnt)
 {
 	struct ethhdr	*eth = (struct ethhdr *)(skb->data);
 	struct tcphdr	*tcp;
 	int network_depth = 0;
+	__wsum check;
 	__be16 proto;
 	u16 tot_len;
 	void *ip_p;
 
-	u8 l4_hdr_type = get_cqe_l4_hdr_type(cqe);
-	u8 tcp_ack = (l4_hdr_type == CQE_L4_HDR_TYPE_TCP_ACK_NO_DATA) ||
-		(l4_hdr_type == CQE_L4_HDR_TYPE_TCP_ACK_AND_DATA);
-
 	skb->mac_len = ETH_HLEN;
 	proto = __vlan_get_protocol(skb, eth->h_proto, &network_depth);
 
@@ -577,23 +591,30 @@ static void mlx5e_lro_update_hdr(struct
 		ipv4->check             = 0;
 		ipv4->check             = ip_fast_csum((unsigned char *)ipv4,
 						       ipv4->ihl);
+
+		mlx5e_lro_update_tcp_hdr(cqe, tcp);
+		check = csum_partial(tcp, tcp->doff * 4,
+				     csum_unfold((__force __sum16)cqe->check_sum));
+		/* Almost done, don't forget the pseudo header */
+		tcp->check = csum_tcpudp_magic(ipv4->saddr, ipv4->daddr,
+					       tot_len - sizeof(struct iphdr),
+					       IPPROTO_TCP, check);
 	} else {
+		u16 payload_len = tot_len - sizeof(struct ipv6hdr);
 		struct ipv6hdr *ipv6 = ip_p;
 
 		tcp = ip_p + sizeof(struct ipv6hdr);
 		skb_shinfo(skb)->gso_type = SKB_GSO_TCPV6;
 
 		ipv6->hop_limit         = cqe->lro_min_ttl;
-		ipv6->payload_len       = cpu_to_be16(tot_len -
-						      sizeof(struct ipv6hdr));
-	}
+		ipv6->payload_len       = cpu_to_be16(payload_len);
 
-	tcp->psh = get_cqe_lro_tcppsh(cqe);
-
-	if (tcp_ack) {
-		tcp->ack                = 1;
-		tcp->ack_seq            = cqe->lro_ack_seq_num;
-		tcp->window             = cqe->lro_tcp_win;
+		mlx5e_lro_update_tcp_hdr(cqe, tcp);
+		check = csum_partial(tcp, tcp->doff * 4,
+				     csum_unfold((__force __sum16)cqe->check_sum));
+		/* Almost done, don't forget the pseudo header */
+		tcp->check = csum_ipv6_magic(&ipv6->saddr, &ipv6->daddr, payload_len,
+					     IPPROTO_TCP, check);
 	}
 }
 
