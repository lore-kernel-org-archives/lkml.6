Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs4E8cp3avrVgrZlfTyiOe7u+VVYGXfE4/1mcyd9+svBlR3D/yaeZ3pLb23bJza45l4HtLa
ARC-Seal: i=1; a=rsa-sha256; t=1520452029; cv=none;
        d=google.com; s=arc-20160816;
        b=J2o0tOdUxj5UctgWei8gbkrhJ5j6JlWWscn2CDBqL/tvl+zjdu2OHAJ08gmUqb4QzS
         Lwo10bctnXX9CVhO9ddoFUVszIswxnwqnnd9EM9n8E43DJozqSkgdaOg6/Xxi3a89Ski
         EAu46g4ojzaLqYKXE4+VSFiuqxnIKK4WOW9Vk7Kbi2BzgggEeKui753M64Yg2afQeKJd
         M2/2ckgEUbLoGNhxDmEAkN87GunXihT7bfw3gkiWBufPqf2hSvFP91N6IAOYjTIExDet
         xTZeLK0mu9vsRjXM1Xl95kZSPX1WLWhvUyS0fddo3VBPWRBmjiOt60X7QGnTkOHwha1+
         XdlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4TXJ72C4INth/PqKa9HvPWb10Fam4Sbn8FOo5COKlhM=;
        b=sRUrTdxVk1TvoWfzm/RhLCc4HBQB0g8EfnbkkFBY+6ZkbNboGObgeGkDIPMP2rVBm/
         3VMvaAeBjQby06fWMCKSvPaSbaJFomWY3YlCQj6chChU4PAduojlb97vm61uo/51Sg4Q
         ll7/mygNjmEqjzDdX+c3kCVA/CiBnB6AP/guS58Z5d/JLBnQZCmFbJ6hL+9I2HTNNpTC
         zJx08YmxTwT0mcs1P4kRIIZvo2HFJe5KhH42/IMZLcz5J7dhvmp4b67JYrCO6trF/7Ft
         Xk/UGyi/KtHkG+snEiQNDzH8LVrCrSVMsBfr7t+lwSi122xr1AohKWSUJXq3GdI+4tRQ
         DW5Q==
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
Subject: [PATCH 4.14 052/110] tcp: Honor the eor bit in tcp_mtu_probe
Date: Wed,  7 Mar 2018 11:38:35 -0800
Message-Id: <20180307191046.344937554@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309157059174410?=
X-GMAIL-MSGID: =?utf-8?q?1594309507330497932?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1973,6 +1973,24 @@ static inline void tcp_mtu_check_reprobe
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
@@ -2045,6 +2063,9 @@ static int tcp_mtu_probe(struct sock *sk
 			return 0;
 	}
 
+	if (!tcp_can_coalesce_send_queue_head(sk, probe_size))
+		return -1;
+
 	/* We're allowed to probe.  Build it now. */
 	nskb = sk_stream_alloc_skb(sk, probe_size, GFP_ATOMIC, false);
 	if (!nskb)
@@ -2080,6 +2101,10 @@ static int tcp_mtu_probe(struct sock *sk
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
