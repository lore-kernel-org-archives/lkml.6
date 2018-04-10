Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49RuMpmcObrt5O08RSDeYf/pVifW5TiM5TOQKyPJIME9MMR0JHXCv7yLlgg08yazwG/1Fmv
ARC-Seal: i=1; a=rsa-sha256; t=1523399604; cv=none;
        d=google.com; s=arc-20160816;
        b=qRKCcvDF+BBziaiyqxLKlVJMLudkWJCCEMZCYNtzOPDZ9TEqgtIhiIQs9h76tebtFu
         CUETW6xBLRiYxGTR31mp7HTblp1V34pctkH/VD+8VNHovdlpsKDxma0Dx6B0WgfjlKjg
         KOVrp3TC0hRI4QltfU48/ofzfNn4bZO58lZzq9vT6yJzJ3QAK9QybMQmiC3rqa9wWwNA
         EVsduk1cYK94CbR5BFp/T80rsnqda453m/6mjQhV6RjLU8VoqIAElhMbYU8QzBhgXnce
         tVYJj8CilZkZH6bremF1mj4twCjXzpD99kbjS98eB40zEagnjKMpG4HwmNEjVgJFjHZe
         GkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Gc899m3NPxXKll5a68wg9nzbGR5GHlBAuUUAMOrAZlU=;
        b=kGJ1vi5gMMpKecOHCaZNyMvNZlje9sGQY43/bFJ+Aj+CHBZH5Yi69igEfeK0lQxk31
         aAjhQYslEtpTEsuDJ327SUHSzviwlZ83aWM1/VrX9mHZMVqUGtB9Jkch9CelCfuG+M1P
         WewydH288t1nWYVpVPcb1DIGsG1KawPL+ZnhoijUK88hSTbsYTiktUErLtHcUCrRl3tI
         KFQ03/plS19hmaBLrfB3qcQfjKaVx/+TsajGL230SFFBnvasWq0uPLwCN2/mpdmi4zgX
         bTUXf7rtBI6giuOFuhh4jrhwqbUdctJTX78pE5PT9Inh2WdsXTrl8OKeq4lNYHP+YEp/
         /E1A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tom Herbert <tom@quantonium.net>,
	David Lebrun <dlebrun@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 156/168] ipv6: sr: fix seg6 encap performances with TSO enabled
Date: Wed, 11 Apr 2018 00:24:58 +0200
Message-Id: <20180410212807.720578017@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400263793116012?=
X-GMAIL-MSGID: =?utf-8?q?1597400263793116012?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Lebrun <dlebrun@google.com>


[ Upstream commit 5807b22c9164a21cd1077a9bc587f0bba361f72d ]

Enabling TSO can lead to abysmal performances when using seg6 in
encap mode, such as with the ixgbe driver. This patch adds a call to
iptunnel_handle_offloads() to remove the encapsulation bit if needed.

Before:
root@comp4-seg6bpf:~# iperf3 -c fc00::55
Connecting to host fc00::55, port 5201
[  4] local fc45::4 port 36592 connected to fc00::55 port 5201
[ ID] Interval           Transfer     Bandwidth       Retr  Cwnd
[  4]   0.00-1.00   sec   196 KBytes  1.60 Mbits/sec   47   6.66 KBytes
[  4]   1.00-2.00   sec   304 KBytes  2.49 Mbits/sec  100   5.33 KBytes
[  4]   2.00-3.00   sec   284 KBytes  2.32 Mbits/sec   92   5.33 KBytes

After:
root@comp4-seg6bpf:~# iperf3 -c fc00::55
Connecting to host fc00::55, port 5201
[  4] local fc45::4 port 43062 connected to fc00::55 port 5201
[ ID] Interval           Transfer     Bandwidth       Retr  Cwnd
[  4]   0.00-1.00   sec  1.03 GBytes  8.89 Gbits/sec    0    743 KBytes
[  4]   1.00-2.00   sec  1.03 GBytes  8.87 Gbits/sec    0    743 KBytes
[  4]   2.00-3.00   sec  1.03 GBytes  8.87 Gbits/sec    0    743 KBytes

Reported-by: Tom Herbert <tom@quantonium.net>
Fixes: 6c8702c60b88 ("ipv6: sr: add support for SRH encapsulation and injection with lwtunnels")
Signed-off-by: David Lebrun <dlebrun@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/seg6_iptunnel.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -16,6 +16,7 @@
 #include <linux/net.h>
 #include <linux/module.h>
 #include <net/ip.h>
+#include <net/ip_tunnels.h>
 #include <net/lwtunnel.h>
 #include <net/netevent.h>
 #include <net/netns/generic.h>
@@ -211,11 +212,6 @@ static int seg6_do_srh(struct sk_buff *s
 
 	tinfo = seg6_encap_lwtunnel(dst->lwtstate);
 
-	if (likely(!skb->encapsulation)) {
-		skb_reset_inner_headers(skb);
-		skb->encapsulation = 1;
-	}
-
 	switch (tinfo->mode) {
 	case SEG6_IPTUN_MODE_INLINE:
 		if (skb->protocol != htons(ETH_P_IPV6))
@@ -224,10 +220,12 @@ static int seg6_do_srh(struct sk_buff *s
 		err = seg6_do_srh_inline(skb, tinfo->srh);
 		if (err)
 			return err;
-
-		skb_reset_inner_headers(skb);
 		break;
 	case SEG6_IPTUN_MODE_ENCAP:
+		err = iptunnel_handle_offloads(skb, SKB_GSO_IPXIP6);
+		if (err)
+			return err;
+
 		if (skb->protocol == htons(ETH_P_IPV6))
 			proto = IPPROTO_IPV6;
 		else if (skb->protocol == htons(ETH_P_IP))
@@ -239,6 +237,8 @@ static int seg6_do_srh(struct sk_buff *s
 		if (err)
 			return err;
 
+		skb_set_inner_transport_header(skb, skb_transport_offset(skb));
+		skb_set_inner_protocol(skb, skb->protocol);
 		skb->protocol = htons(ETH_P_IPV6);
 		break;
 	case SEG6_IPTUN_MODE_L2ENCAP:
@@ -262,8 +262,6 @@ static int seg6_do_srh(struct sk_buff *s
 	ipv6_hdr(skb)->payload_len = htons(skb->len - sizeof(struct ipv6hdr));
 	skb_set_transport_header(skb, sizeof(struct ipv6hdr));
 
-	skb_set_inner_protocol(skb, skb->protocol);
-
 	return 0;
 }
 
