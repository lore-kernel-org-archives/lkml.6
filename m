Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+9dF2CndfrkHRNsEFhAt6FSRYfb2Rhv2ewYBloFH6MbyvgwbqRiuXQ8SXFjlbz2JNeo0iB
ARC-Seal: i=1; a=rsa-sha256; t=1522346517; cv=none;
        d=google.com; s=arc-20160816;
        b=idv4RDBF/Xr7j6k4Dfo9ytDOX5jLda1DJp1NLC4t9Gs0T3KuBC/ZWeSJorV2sE046X
         mlDBh4+xVQgqea5nKtTDy7qspiqTtHBwR7/DlwNd/8G38w34lBYLRA+uGyAYUm1UZv6D
         POnqG01FGpkREms2PYRWZzU+KfU7lYSU34XC3PvWEFshbkXraXfVau5uSmO/kqGGzfMB
         POMnr7miU4oxvqtVtB31ShQzBW8Z3AITwM/EFX5PjTKlQH3c5bN9X6EGOJKg0B04mPwF
         BaSXqmwRQ4z98KqauNNAhSoxBM6hscqSYFCDaJtbiXVcjqbo8Ux5GNBwkaO4saT27xe8
         J1sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=t8Bckoy+/+tILWyKtZTUD8QuW6IgQldTErmbiEIYNk0=;
        b=vJxYgsc05w44fkxe2iU/yrobFPyhoVguqwu4YtTuNTe4T7gl7t1KoCKcqjvnQ0YCOV
         36TM2KeS6iMgLHqrrWpRPFJ7JydNcEg8qQpJjL6J7sayxpOoNwSwC3zcAc3GF15rt25Z
         3lZym3PnnfesoA5rdT98SMJFSZ86QXs6DEjnXmBn1mdRpzuBiWCJLP4S66yvygsbrr9O
         sxG4hfIsRZl3cD85FEk6kEThqlZ0BP8pzQVY+KkjPCAxwhkgjjdwyue+0tVX3ICETu7B
         eIR+kSEHMybSoUEycSYGfMwP4hQfQXGwEEaUsbz9Ui04zmVMhATa718Y1sGEM6bnUFKw
         aHjQ==
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
Subject: [PATCH 4.15 05/47] qed: Fix non TCP packets should be dropped on iWARP ll2 connection
Date: Thu, 29 Mar 2018 19:59:46 +0200
Message-Id: <20180329175729.533834724@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296021593210759?=
X-GMAIL-MSGID: =?utf-8?q?1596296021593210759?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1681,6 +1681,13 @@ qed_iwarp_parse_rx_pkt(struct qed_hwfn *
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
@@ -1689,6 +1696,14 @@ qed_iwarp_parse_rx_pkt(struct qed_hwfn *
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
