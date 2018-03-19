Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvSUAhdqQz5gf5KBGzFivPbczJgca/R1y3wWGHDtMEI0OgtIHcvRBScPWTAuapq728hiB6x
ARC-Seal: i=1; a=rsa-sha256; t=1521483188; cv=none;
        d=google.com; s=arc-20160816;
        b=Wy1WV0SXRfFbS0gja7AYiQMlc2o8WbBH2O9d1HZxrQRM6ZqOhB0QMqoKTgyetYYKhf
         eo12bll22jhnnapXT/GOWIihpHttfsY6hidAzZ/q1ZlfeRH7bx/bqkVfSzpkbR+6xDww
         MDeqI/VGs1TEcSLIiXSbKThpf0NuY+Lf1rhBemLAumbE728YUj2WU3GMdbpIR3M5hEcr
         0HcBubxFSqvkZNglXNZN+I2avl6KaUIdcpDy5TaeHz0O7VBFWWX2zqXM7SYLvSjN+afS
         7qefnPZQRzerfSG83H+LETovqICLzbBC+NqqpqgElX+5x2RX8sQtp5r/2bl4p2V85C0G
         6AWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ypSQPiRC6lAWnx66fPeGlz2N3rI369ywyMRbl7Z20pM=;
        b=h0560BFxy4/LESCo/ZtHRmbUesdBzJ3x6J6omgP0oxG39RlVOlCH2/kI1B9RU3fKZU
         xT2Aa7alWb33tDaGCWPrpWiviphUwZf/nF3u6W9k4bKsPeevxnEcdv6iWSIuidZciJCv
         /Hb+PmqG9YIccitCZOsN19F32jF0DyqnSrXyFnQYp2PIp1a2Z/8AMP5DEEDXOfin7lTh
         eDJ19CfXPBMDJJ6NBbr7xXURZYaDdGWBA2/vfdzF4CCECSTFJCEML42+lyGYolVqJWRY
         KeOGzorBI2GGalsFIIVtzW+B7vRxZZ7IiIkw2iG95S7txumWIhBhHyj1jFTzrgK9rKnX
         gn6A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Davide Caratti <dcaratti@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 030/134] sched: act_csum: dont mangle TCP and UDP GSO packets
Date: Mon, 19 Mar 2018 19:05:13 +0100
Message-Id: <20180319171853.609141589@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390518256431155?=
X-GMAIL-MSGID: =?utf-8?q?1595390755499944223?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Davide Caratti <dcaratti@redhat.com>


[ Upstream commit add641e7dee31b36aee83412c29e39dd1f5e0c9c ]

after act_csum computes the checksum on skbs carrying GSO TCP/UDP packets,
subsequent segmentation fails because skb_needs_check(skb, true) returns
true. Because of that, skb_warn_bad_offload() is invoked and the following
message is displayed:

WARNING: CPU: 3 PID: 28 at net/core/dev.c:2553 skb_warn_bad_offload+0xf0/0xfd
<...>

  [<ffffffff8171f486>] skb_warn_bad_offload+0xf0/0xfd
  [<ffffffff8161304c>] __skb_gso_segment+0xec/0x110
  [<ffffffff8161340d>] validate_xmit_skb+0x12d/0x2b0
  [<ffffffff816135d2>] validate_xmit_skb_list+0x42/0x70
  [<ffffffff8163c560>] sch_direct_xmit+0xd0/0x1b0
  [<ffffffff8163c760>] __qdisc_run+0x120/0x270
  [<ffffffff81613b3d>] __dev_queue_xmit+0x23d/0x690
  [<ffffffff81613fa0>] dev_queue_xmit+0x10/0x20

Since GSO is able to compute checksum on individual segments of such skbs,
we can simply skip mangling the packet.

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_csum.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -175,6 +175,9 @@ static int tcf_csum_ipv4_tcp(struct sk_b
 	struct tcphdr *tcph;
 	const struct iphdr *iph;
 
+	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4)
+		return 1;
+
 	tcph = tcf_csum_skb_nextlayer(skb, ihl, ipl, sizeof(*tcph));
 	if (tcph == NULL)
 		return 0;
@@ -196,6 +199,9 @@ static int tcf_csum_ipv6_tcp(struct sk_b
 	struct tcphdr *tcph;
 	const struct ipv6hdr *ip6h;
 
+	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6)
+		return 1;
+
 	tcph = tcf_csum_skb_nextlayer(skb, ihl, ipl, sizeof(*tcph));
 	if (tcph == NULL)
 		return 0;
@@ -219,6 +225,9 @@ static int tcf_csum_ipv4_udp(struct sk_b
 	const struct iphdr *iph;
 	u16 ul;
 
+	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type & SKB_GSO_UDP)
+		return 1;
+
 	/*
 	 * Support both UDP and UDPLITE checksum algorithms, Don't use
 	 * udph->len to get the real length without any protocol check,
@@ -272,6 +281,9 @@ static int tcf_csum_ipv6_udp(struct sk_b
 	const struct ipv6hdr *ip6h;
 	u16 ul;
 
+	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type & SKB_GSO_UDP)
+		return 1;
+
 	/*
 	 * Support both UDP and UDPLITE checksum algorithms, Don't use
 	 * udph->len to get the real length without any protocol check,
