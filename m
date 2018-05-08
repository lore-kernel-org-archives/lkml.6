Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr1yeKeswPpLozOe8CWC4D7HipUBh0dMN8AjAJfc1lUxtvCG5CLmy2HK9rjmhWGoDG7t7vZ
ARC-Seal: i=1; a=rsa-sha256; t=1525767257; cv=none;
        d=google.com; s=arc-20160816;
        b=flL+kuSM+sPketsX96q5k+36XFb35B6eYn+3mKo+P0hebYPSPPqwglVLo4FmIHOOWb
         tN599PiK4j1ujEMAPN16PfOhpag6Zz+iVZQAP9KPx7sR2gM6QLbizCRf2kJlpwe4ibbT
         CEUUSE06/Ok+Lz0q48XZDwabN+WHNxfLmEFrNBEoF1wg8BVHuPPaXKVSwkin4g8Fmbks
         GfAxlg6PLapvBd4NqclpiJZNFyJ0Wr/8tMZDU0x9hkOoqy2Qc2tER7Y7qvsGTK2Wptte
         Zim7zHeNskH3xcnORJJzs1lp48qNAGtWNHz8WklYlZlwAS4pVluAS7tIwvBvswt/pwr8
         jsLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=29sJeNJ8gtrFCdNhUgmRP7N5RlzvJJLBOt0VDtB/yTk=;
        b=llN4YABKFuf3tszJP0C8A9PZ1JNVOCfr3g5FMHToPzvUn4QgJb6q5bf7OBUlNIrqON
         P3kh9oeh6DdBYku2UHLycGcrnbOY/puzvJLhLhXyD9JfX3sdG45Fjayx62050ZrbcLCi
         ksiy1LdEjWOmKRmznFUkR2DKzb/IIl2w2CUHuDOY7gMpi4J2hjpOPs4nXVugjKB9k+Hp
         MRkGwRG1ytLLDl6x6OorRJKbVk0BK8Xq5pwVosT83UwYb65EFURFmIq9E30LhhuuV4n2
         Yv+gEYev5EZQm28bhN2R0n2x7DwjQCwmDyJUFragBezsvVRl5SthUd6d4t2pTm8fr7sT
         rpZA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=eAEFjzsq;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=eAEFjzsq;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Thomas Deutschmann <whissi@gentoo.org>,
	Eddie Chapman <eddie@ehuk.net>
Subject: [PATCH 4.14 01/43] geneve: update skb dst pmtu on tx path
Date: Tue,  8 May 2018 10:10:20 +0200
Message-Id: <20180508074004.200044963@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882927406420096?=
X-GMAIL-MSGID: =?utf-8?q?1599882927406420096?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

commit 52a589d51f1008f62569bf89e95b26221ee76690 upstream.

Commit a93bf0ff4490 ("vxlan: update skb dst pmtu on tx path") has fixed
a performance issue caused by the change of lower dev's mtu for vxlan.

The same thing needs to be done for geneve as well.

Note that geneve cannot adjust it's mtu according to lower dev's mtu
when creating it. The performance is very low later when netperfing
over it without fixing the mtu manually. This patch could also avoid
this issue.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Thomas Deutschmann <whissi@gentoo.org>
Cc: Eddie Chapman <eddie@ehuk.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/geneve.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -825,6 +825,13 @@ static int geneve_xmit_skb(struct sk_buf
 	if (IS_ERR(rt))
 		return PTR_ERR(rt);
 
+	if (skb_dst(skb)) {
+		int mtu = dst_mtu(&rt->dst) - sizeof(struct iphdr) -
+			  GENEVE_BASE_HLEN - info->options_len - 14;
+
+		skb_dst(skb)->ops->update_pmtu(skb_dst(skb), NULL, skb, mtu);
+	}
+
 	sport = udp_flow_src_port(geneve->net, skb, 1, USHRT_MAX, true);
 	if (geneve->collect_md) {
 		tos = ip_tunnel_ecn_encap(key->tos, ip_hdr(skb), skb);
@@ -864,6 +871,13 @@ static int geneve6_xmit_skb(struct sk_bu
 	if (IS_ERR(dst))
 		return PTR_ERR(dst);
 
+	if (skb_dst(skb)) {
+		int mtu = dst_mtu(dst) - sizeof(struct ipv6hdr) -
+			  GENEVE_BASE_HLEN - info->options_len - 14;
+
+		skb_dst(skb)->ops->update_pmtu(skb_dst(skb), NULL, skb, mtu);
+	}
+
 	sport = udp_flow_src_port(geneve->net, skb, 1, USHRT_MAX, true);
 	if (geneve->collect_md) {
 		prio = ip_tunnel_ecn_encap(key->tos, ip_hdr(skb), skb);
