Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48k6rmuNfNDn7xQihrTjRU1/sgD7jnkhyVQwOIQY/+3eEjwkNkWxPf4B6WSLxNaeOmN56WU
ARC-Seal: i=1; a=rsa-sha256; t=1523980842; cv=none;
        d=google.com; s=arc-20160816;
        b=ZhlK/iTlPc+anmJVdiF5vZqhgEa64n3sVy3awSaW9aRL4bzDYvcsRJJhROxJLyG1UZ
         q0wcSQSConajKAR1jwrtc6XVYgT/VCQZ/vN3ILHlnckl0HnxJzLdKVj5XwIXNkv0UwPL
         rvo8DdwnQq9VQ0t4s7NeP2n7EjJziM7gkOdsUptd0wfwJ0nf5jfz5wZFtQLMJU/d0XXn
         fJYjZVNnjpPf4ngPB8TRrAsIGfTkTXHjtjjGk5qisJ4BTG4ZMLY5PrqpzD9oDIiXKBhQ
         3nd7SkbSCTb+J7LiLWnpqZOTyFOLQdmLaS7sqJYfMoE7k850H2paxLMDZeTp2bWMTWif
         Xe/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=r6whvmAO1Qc0c3X6ezIbBhSh+89bOXmHGF5sMzgiM2A=;
        b=GjD2IJYkUySn3AMem2FZlvBWiJzlk24RiRVYv5ourgP7d/JRLzb5EUzlZgk1GKPuAO
         Wiot8UFFzvrop7KHlvSgZH19wYwpSFGiRMSKz0De7DySHcx2a2mETXD0HR5hQZRHsRRf
         mRJr6UKYe5pBNNbifG9UV7AK+27jXnfDyN/W25t0mDsy5GLG8NKowrN4PaREyO5OgHSc
         5jh9Gi//IxJWJszaYE2qTufOS4pg1kuwqN0P5l6yCdHf4JorII64QDzwRxqzIy5ps0Gf
         qaEM7hdR2ZyOECof3AyHzdtQYcDdP5IgqDRX45x4VXkuHaTgCM+Xd1A8E4oYR4jEq0Wu
         YOpw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tejaswi Tanikella <tejaswit@codeaurora.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 03/68] slip: Check if rstate is initialized before uncompressing
Date: Tue, 17 Apr 2018 17:57:16 +0200
Message-Id: <20180417155749.483327520@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009735919872133?=
X-GMAIL-MSGID: =?utf-8?q?1598009735919872133?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tejaswi Tanikella <tejaswit@codeaurora.org>


[ Upstream commit 3f01ddb962dc506916c243f9524e8bef97119b77 ]

On receiving a packet the state index points to the rstate which must be
used to fill up IP and TCP headers. But if the state index points to a
rstate which is unitialized, i.e. filled with zeros, it gets stuck in an
infinite loop inside ip_fast_csum trying to compute the ip checsum of a
header with zero length.

89.666953:   <2> [<ffffff9dd3e94d38>] slhc_uncompress+0x464/0x468
89.666965:   <2> [<ffffff9dd3e87d88>] ppp_receive_nonmp_frame+0x3b4/0x65c
89.666978:   <2> [<ffffff9dd3e89dd4>] ppp_receive_frame+0x64/0x7e0
89.666991:   <2> [<ffffff9dd3e8a708>] ppp_input+0x104/0x198
89.667005:   <2> [<ffffff9dd3e93868>] pppopns_recv_core+0x238/0x370
89.667027:   <2> [<ffffff9dd4428fc8>] __sk_receive_skb+0xdc/0x250
89.667040:   <2> [<ffffff9dd3e939e4>] pppopns_recv+0x44/0x60
89.667053:   <2> [<ffffff9dd4426848>] __sock_queue_rcv_skb+0x16c/0x24c
89.667065:   <2> [<ffffff9dd4426954>] sock_queue_rcv_skb+0x2c/0x38
89.667085:   <2> [<ffffff9dd44f7358>] raw_rcv+0x124/0x154
89.667098:   <2> [<ffffff9dd44f7568>] raw_local_deliver+0x1e0/0x22c
89.667117:   <2> [<ffffff9dd44c8ba0>] ip_local_deliver_finish+0x70/0x24c
89.667131:   <2> [<ffffff9dd44c92f4>] ip_local_deliver+0x100/0x10c

./scripts/faddr2line vmlinux slhc_uncompress+0x464/0x468 output:
 ip_fast_csum at arch/arm64/include/asm/checksum.h:40
 (inlined by) slhc_uncompress at drivers/net/slip/slhc.c:615

Adding a variable to indicate if the current rstate is initialized. If
such a packet arrives, move to toss state.

Signed-off-by: Tejaswi Tanikella <tejaswit@codeaurora.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/slip/slhc.c |    5 +++++
 include/net/slhc_vj.h   |    1 +
 2 files changed, 6 insertions(+)

--- a/drivers/net/slip/slhc.c
+++ b/drivers/net/slip/slhc.c
@@ -509,6 +509,10 @@ slhc_uncompress(struct slcompress *comp,
 		if(x < 0 || x > comp->rslot_limit)
 			goto bad;
 
+		/* Check if the cstate is initialized */
+		if (!comp->rstate[x].initialized)
+			goto bad;
+
 		comp->flags &=~ SLF_TOSS;
 		comp->recv_current = x;
 	} else {
@@ -673,6 +677,7 @@ slhc_remember(struct slcompress *comp, u
 	if (cs->cs_tcp.doff > 5)
 	  memcpy(cs->cs_tcpopt, icp + ihl*4 + sizeof(struct tcphdr), (cs->cs_tcp.doff - 5) * 4);
 	cs->cs_hsize = ihl*2 + cs->cs_tcp.doff*2;
+	cs->initialized = true;
 	/* Put headers back on packet
 	 * Neither header checksum is recalculated
 	 */
--- a/include/net/slhc_vj.h
+++ b/include/net/slhc_vj.h
@@ -127,6 +127,7 @@ typedef __u32 int32;
  */
 struct cstate {
 	byte_t	cs_this;	/* connection id number (xmit) */
+	bool	initialized;	/* true if initialized */
 	struct cstate *next;	/* next in ring (xmit) */
 	struct iphdr cs_ip;	/* ip/tcp hdr from most recent packet */
 	struct tcphdr cs_tcp;
