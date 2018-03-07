Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvCevCg+RFkwzwG0OmTbwWZ9Ri50PTcyDi23UjyOu8TOUdn9QH4m+pNz0sFD8oGuYsdplsX
ARC-Seal: i=1; a=rsa-sha256; t=1520451695; cv=none;
        d=google.com; s=arc-20160816;
        b=bJB11jzRMij70gl9lHqAKIpMQUjsHLzAuTJA9xEguAqDeY1Ez7oZzguPotgkcF1rLu
         5Pv5ifkAU4RYp0a5vLPl012oVQHT7blXqFONAOn6jLYy+ftCvyyuwubjhyXKWhZn+tDq
         D56h8OUQrDw7UYwzi3sPU5TAd8MnYa6+K3ocSdsE9mBlpt13WxrmKOWLkdp0umSrTGSc
         vmEKmmrgD0zN/jEJA7TwEX8QyDPdKu++RngWJkm9NM4ylBnl4n84K3Ez98wSIU7HT+Rt
         NrLYx+2BjT8aVyxyBMRQOP/AEXRlhpFYpghVDdJhwaXT3bsY4XiY1rvyubcNim3mVxGr
         Unew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uHrmFz6F2TjvqKN9/2GwCxC9h1iJM7ECVx8HmBoKNCs=;
        b=WiQMOYuLHJ1A0ugR0k3fBX3ag2BIzCksykOlQ8pcQZULCuvlWUn7PmuJoIrT68cVqD
         EoZkfCZlKSScaw/ZggjhXd0gLBcegxVb1rN8+OQGBmNho3m+2OsIIfZI1xEG81BhLo5x
         acg2wwkz7UWjxQkMEUZ1fMkCB6ZyShTifNCOpIUHk8ZlPDYmP2bI3YOk5SpgJoCIbOfx
         Ez6tSNhq7QZaen6i1SzKTiwkeezTfC7kguRMd5PUqtPaGVbBNxp/T4aiA5p5iCGnz1jK
         F17Zg5xmPIQWT60TxGFsVu2VH/TjNNgq7Xtc7b46njr4ri7JVFOKGNuZZHLzpzHeu0sg
         9lsg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ilya Lesokhin <ilyal@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 057/122] tcp: Honor the eor bit in tcp_mtu_probe
Date: Wed,  7 Mar 2018 11:37:49 -0800
Message-Id: <20180307191737.450697477@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309157059174410?=
X-GMAIL-MSGID: =?utf-8?q?1594309157059174410?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Lesokhin <ilyal@mellanox.com>


[ Upstream commit 808cf9e38cd7923036a99f459ccc8cf2955e47af ]

Avoid SKB coalescing if eor bit is set in one of the relevant
SKBs.

Fixes: c134ecb87817 ("tcp: Make use of MSG_EOR in tcp_sendmsg")
Signed-off-by: Ilya Lesokhin <ilyal@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_output.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2026,6 +2026,24 @@ static inline void tcp_mtu_check_reprobe
 	}
 }
 
+static bool tcp_can_coalesce_send_queue_head(struct sock *sk, int len)
+{
+	struct sk_buff *skb, *next;
+
+	skb = tcp_send_head(sk);
+	tcp_for_write_queue_from_safe(skb, next, sk) {
+		if (len <= skb->len)
+			break;
+
+		if (unlikely(TCP_SKB_CB(skb)->eor))
+			return false;
+
+		len -= skb->len;
+	}
+
+	return true;
+}
+
 /* Create a new MTU probe if we are ready.
  * MTU probe is regularly attempting to increase the path MTU by
  * deliberately sending larger packets.  This discovers routing
@@ -2098,6 +2116,9 @@ static int tcp_mtu_probe(struct sock *sk
 			return 0;
 	}
 
+	if (!tcp_can_coalesce_send_queue_head(sk, probe_size))
+		return -1;
+
 	/* We're allowed to probe.  Build it now. */
 	nskb = sk_stream_alloc_skb(sk, probe_size, GFP_ATOMIC, false);
 	if (!nskb)
@@ -2133,6 +2154,10 @@ static int tcp_mtu_probe(struct sock *sk
 			/* We've eaten all the data from this skb.
 			 * Throw it away. */
 			TCP_SKB_CB(nskb)->tcp_flags |= TCP_SKB_CB(skb)->tcp_flags;
+			/* If this is the last SKB we copy and eor is set
+			 * we need to propagate it to the new skb.
+			 */
+			TCP_SKB_CB(nskb)->eor = TCP_SKB_CB(skb)->eor;
 			tcp_unlink_write_queue(skb, sk);
 			sk_wmem_free_skb(sk, skb);
 		} else {
