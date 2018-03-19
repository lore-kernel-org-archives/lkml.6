Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsFbtvGflQc0lsOcndqmqkxs9q1bgT4XnMb8oJVHaVHMXEme7gWckQv2ZZ78pHRyu66hsHT
ARC-Seal: i=1; a=rsa-sha256; t=1521483634; cv=none;
        d=google.com; s=arc-20160816;
        b=MAw+thYPhNZUVT/2EmQoe4BIM99rhX13hrATLmbZHYA3rPux5bfntDvsMeBjO82V7U
         YOmA/B9lZ2+yH/0hmxpztr+9lLTm0Gb+dYOElc8e4YsFhqMnMI/QTwVyrAfNV0WxgjbH
         cae3ihX0igY0I70A/8VP6WeVI8K2a0B906S6jnGN42Mgkb1OF/4b1o+cmOZJj4Chjsl5
         5Uj73fiOr8SZDl2ej9qwE3yL2YNt/x6J3tzWWVIiK7wvJcG0aERYV02tWVpmnUa6bAu7
         toKnDLE8Y8BY0EikBGsBDtWOHai7Doa+PTACrWqnsa0G76aqhM25nzIGq6Wyuhgi6zz/
         xl5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PKtOp/wfoMbARtH4Cgrn9iL30G3pXV6ypDo7L08T/Cg=;
        b=O3MOvK/UgrI+HkDhaMj3tmq1Fnzuon6Sk/bQRXN5X5fsbKN0srAjVzfPOroxIzuifF
         5WgY7NwEBMIbsopuJ4WTIG+b+EAPywskn/RnKi3EPy2HbF1l6IUhX++X+rKEMrdDyqRE
         lFOUoZkmZugjKya1pSBsOPoKsIHahI6mOa+Dhq5+UwAPmdBmsj9yYAdZMSVxKatUqXH6
         BPCib9Oh3b009EVZYVocRbsHL5nKCZknJgdsWp8g7VK4i1DDnDS4mSQoFGjzsfRbSzZY
         XGEFgBNKhIU23b5taJE4O+oWMg/nGIyprODGbDZsjtpfxeNme5AfRs0WGsVi85z2EhgO
         F/fQ==
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
Subject: [PATCH 4.9 059/241] sched: act_csum: dont mangle TCP and UDP GSO packets
Date: Mon, 19 Mar 2018 19:05:24 +0100
Message-Id: <20180319180753.649869136@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390518256431155?=
X-GMAIL-MSGID: =?utf-8?q?1595391223831772664?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -180,6 +180,9 @@ static int tcf_csum_ipv4_tcp(struct sk_b
 	struct tcphdr *tcph;
 	const struct iphdr *iph;
 
+	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4)
+		return 1;
+
 	tcph = tcf_csum_skb_nextlayer(skb, ihl, ipl, sizeof(*tcph));
 	if (tcph == NULL)
 		return 0;
@@ -201,6 +204,9 @@ static int tcf_csum_ipv6_tcp(struct sk_b
 	struct tcphdr *tcph;
 	const struct ipv6hdr *ip6h;
 
+	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6)
+		return 1;
+
 	tcph = tcf_csum_skb_nextlayer(skb, ihl, ipl, sizeof(*tcph));
 	if (tcph == NULL)
 		return 0;
@@ -224,6 +230,9 @@ static int tcf_csum_ipv4_udp(struct sk_b
 	const struct iphdr *iph;
 	u16 ul;
 
+	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type & SKB_GSO_UDP)
+		return 1;
+
 	/*
 	 * Support both UDP and UDPLITE checksum algorithms, Don't use
 	 * udph->len to get the real length without any protocol check,
@@ -277,6 +286,9 @@ static int tcf_csum_ipv6_udp(struct sk_b
 	const struct ipv6hdr *ip6h;
 	u16 ul;
 
+	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type & SKB_GSO_UDP)
+		return 1;
+
 	/*
 	 * Support both UDP and UDPLITE checksum algorithms, Don't use
 	 * udph->len to get the real length without any protocol check,
