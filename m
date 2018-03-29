Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+ZoI8fijc/DAOBy7LblJg8JQmpZgJrc6a+DYqSjbS2n30+PnbbNMqnhJ+QoJj6gguC9lEG
ARC-Seal: i=1; a=rsa-sha256; t=1522346618; cv=none;
        d=google.com; s=arc-20160816;
        b=Vbg7mxATgiOK298dmED5kfMt3U2JRJMSuK3c28SXfTVx/pKO7v5EpQQ3JwCU9TwYdW
         8S6wI6oIdWPYMYLGNyZzNcgugzqwlhCIVvhogE0w6wLMVTunXW5OUQSLVeKxL6CawQml
         ZF+AzN/exKNrPD84gC///NW7WI3fs9wEElM0kf+2K/ElYPHZVwmjY1uo6RxZLTRLsoj3
         tFFwJOW1Ad4jbV2Ai/Mvwr69RPJV6WyCXhs9VcB4fVuqViO8qrfYxUPr8yb/p6SAnHn2
         lhUDQ37y2/zsx16cFGNGMZaZgrJqYSXDxQGr62Ay30OUxdJevIVpjXqfWX3Possm0KJ5
         JcrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+7ouaDGdO4lMvfs6c3YOZhLQ3X5oyO5AxwEQsM8BIgA=;
        b=hwImK7aiPQc5qt2iKfnsuyjedFTBqKv/FgwUVbMG5oe1zK8wmuCViBamUiEx1pHx9E
         Jpr15H5eZ7Yo0zCzFCH4dtc2IqmLu5sxARLB90cQX0WYX/fnyy1BeTiWzZDJTvMDmHd7
         pjrRFz5pxjmA8dyqDZKzQyiLLmjalB53ZDTUy39HGqJUXh/TAAERpEX9bo+NYtxN2rZk
         QvS/SEE1RWWvIA4/Tv4qy73ssnqFWVX7Em9XVhpp7KEPHZkcUEUzk24F2AaapoinQAEs
         V0AU5kASbwLZEH39XzAFvwe3XHZlie90HbcyebaL2pKN3hK+byDL8hktzfsE/noBlJkD
         b0Fg==
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
Subject: [PATCH 4.15 12/47] ipv6: sr: fix NULL pointer dereference when setting encap source address
Date: Thu, 29 Mar 2018 19:59:53 +0200
Message-Id: <20180329175730.008593841@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296128728424009?=
X-GMAIL-MSGID: =?utf-8?q?1596296128728424009?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Lebrun <dlebrun@google.com>


[ Upstream commit 8936ef7604c11b5d701580d779e0f5684abc7b68 ]

When using seg6 in encap mode, we call ipv6_dev_get_saddr() to set the
source address of the outer IPv6 header, in case none was specified.
Using skb->dev can lead to BUG() when it is in an inconsistent state.
This patch uses the net_device attached to the skb's dst instead.

[940807.667429] BUG: unable to handle kernel NULL pointer dereference at 000000000000047c
[940807.762427] IP: ipv6_dev_get_saddr+0x8b/0x1d0
[940807.815725] PGD 0 P4D 0
[940807.847173] Oops: 0000 [#1] SMP PTI
[940807.890073] Modules linked in:
[940807.927765] CPU: 6 PID: 0 Comm: swapper/6 Tainted: G        W        4.16.0-rc1-seg6bpf+ #2
[940808.028988] Hardware name: HP ProLiant DL120 G6/ProLiant DL120 G6, BIOS O26    09/06/2010
[940808.128128] RIP: 0010:ipv6_dev_get_saddr+0x8b/0x1d0
[940808.187667] RSP: 0018:ffff88043fd836b0 EFLAGS: 00010206
[940808.251366] RAX: 0000000000000005 RBX: ffff88042cb1c860 RCX: 00000000000000fe
[940808.338025] RDX: 00000000000002c0 RSI: ffff88042cb1c860 RDI: 0000000000004500
[940808.424683] RBP: ffff88043fd83740 R08: 0000000000000000 R09: ffffffffffffffff
[940808.511342] R10: 0000000000000040 R11: 0000000000000000 R12: ffff88042cb1c850
[940808.598012] R13: ffffffff8208e380 R14: ffff88042ac8da00 R15: 0000000000000002
[940808.684675] FS:  0000000000000000(0000) GS:ffff88043fd80000(0000) knlGS:0000000000000000
[940808.783036] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[940808.852975] CR2: 000000000000047c CR3: 00000004255fe000 CR4: 00000000000006e0
[940808.939634] Call Trace:
[940808.970041]  <IRQ>
[940808.995250]  ? ip6t_do_table+0x265/0x640
[940809.043341]  seg6_do_srh_encap+0x28f/0x300
[940809.093516]  ? seg6_do_srh+0x1a0/0x210
[940809.139528]  seg6_do_srh+0x1a0/0x210
[940809.183462]  seg6_output+0x28/0x1e0
[940809.226358]  lwtunnel_output+0x3f/0x70
[940809.272370]  ip6_xmit+0x2b8/0x530
[940809.313185]  ? ac6_proc_exit+0x20/0x20
[940809.359197]  inet6_csk_xmit+0x7d/0xc0
[940809.404173]  tcp_transmit_skb+0x548/0x9a0
[940809.453304]  __tcp_retransmit_skb+0x1a8/0x7a0
[940809.506603]  ? ip6_default_advmss+0x40/0x40
[940809.557824]  ? tcp_current_mss+0x24/0x90
[940809.605925]  tcp_retransmit_skb+0xd/0x80
[940809.654016]  tcp_xmit_retransmit_queue.part.17+0xf9/0x210
[940809.719797]  tcp_ack+0xa47/0x1110
[940809.760612]  tcp_rcv_established+0x13c/0x570
[940809.812865]  tcp_v6_do_rcv+0x151/0x3d0
[940809.858879]  tcp_v6_rcv+0xa5c/0xb10
[940809.901770]  ? seg6_output+0xdd/0x1e0
[940809.946745]  ip6_input_finish+0xbb/0x460
[940809.994837]  ip6_input+0x74/0x80
[940810.034612]  ? ip6_rcv_finish+0xb0/0xb0
[940810.081663]  ipv6_rcv+0x31c/0x4c0
...

Fixes: 6c8702c60b886 ("ipv6: sr: add support for SRH encapsulation and injection with lwtunnels")
Reported-by: Tom Herbert <tom@quantonium.net>
Signed-off-by: David Lebrun <dlebrun@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/seg6_iptunnel.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -93,7 +93,8 @@ static void set_tun_src(struct net *net,
 /* encapsulate an IPv6 packet within an outer IPv6 header with a given SRH */
 int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
 {
-	struct net *net = dev_net(skb_dst(skb)->dev);
+	struct dst_entry *dst = skb_dst(skb);
+	struct net *net = dev_net(dst->dev);
 	struct ipv6hdr *hdr, *inner_hdr;
 	struct ipv6_sr_hdr *isrh;
 	int hdrlen, tot_len, err;
@@ -134,7 +135,7 @@ int seg6_do_srh_encap(struct sk_buff *sk
 	isrh->nexthdr = proto;
 
 	hdr->daddr = isrh->segments[isrh->first_segment];
-	set_tun_src(net, skb->dev, &hdr->daddr, &hdr->saddr);
+	set_tun_src(net, ip6_dst_idev(dst)->dev, &hdr->daddr, &hdr->saddr);
 
 #ifdef CONFIG_IPV6_SEG6_HMAC
 	if (sr_has_hmac(isrh)) {
