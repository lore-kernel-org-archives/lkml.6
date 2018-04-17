Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48oIjwT2Vimxxxfjd2jdWXkU9PwWlcjml+ITi26ErkQN3b/s+n3UN+DzTw6kKJwTTPDLMWs
ARC-Seal: i=1; a=rsa-sha256; t=1523981446; cv=none;
        d=google.com; s=arc-20160816;
        b=lTkPV/IporxvtXkRIwGnoUly5vTXWVCGZ8o8t9NQhDpz11XIlsivys3hdItD8X5r5E
         H3vQ531vSHmrTx1A1o304EbgEAbKkSRzX9dJdfGp8UbaVaNkwjOBosoyG/d+Fjw8A/AY
         PhgdeNj1eNJcyjVtECrbIZSpBzAjt7byNePd6yBDLe8UBAEhH8cMSS0V02WLpV89Mzkq
         Nqal87kDsa0R3wj/XbqTeZnLha6xWEQvkmX+23U8FHpmlH7Vgz3tN3c59YA93D9vjDJm
         FK1AZdJHv4FJf0iTdyBWSdopR7qvMq6RI+aUg/ndvfnOfi6XTn48mZyCnpuPumO1rgrQ
         Iy3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k3R0Y45trS3LUFs0fKR/16PcZlfNrzW6CGbZhefF4zo=;
        b=TvM5Bswy0iOAq0Y7HaIvJfDABwSSPNMwQdUK8voNSATpUPZ615O3Q3aEROnOmAyuVw
         C0qPjrBkCtgEn+/4roSTu9oNjf7dh/T2yVWibAlH9sACc86tDkczhwmEy35qyjCn0Emx
         BGelY+vlN3GDAGWN3Obk54u0XvZN6IZLfqSnDsz1TRYB9EBlgZF4M22tVvjYu9DTKjj1
         4QPP6b1MT73d1NVrQE0wd9svszcp8yubIEa4f10N/LY0V/iyNgkzVIXzJ77DK6Q3/m2E
         clbeQcq6sx6l5qdct5mqz1Xka6hiWOKRKREOjUCFk5fJ1zQGbeOk3Iv8o3rBJM2wJfef
         gVXQ==
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
Subject: [PATCH 4.9 64/66] slip: Check if rstate is initialized before uncompressing
Date: Tue, 17 Apr 2018 17:59:37 +0200
Message-Id: <20180417155648.634011654@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009735919872133?=
X-GMAIL-MSGID: =?utf-8?q?1598010369887428235?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
