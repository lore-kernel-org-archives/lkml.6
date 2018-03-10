Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtrYJgdqhKTlw7WM/MiYzj3/akeab9DU7Z9+6aVOGG9Gf+3gi7R5xtwAydh16Hdx+cY6s2W
ARC-Seal: i=1; a=rsa-sha256; t=1520641336; cv=none;
        d=google.com; s=arc-20160816;
        b=XEv/7Cq7SrPSMwa3TCKwNyCRf5ikXemkEPpk6FitktuFPO3Gg/Ljg9CLQ+rjVbp+KD
         cGB6WjZNQjQ9ssXPOQgPOkfZwyHFM3xYtvkKSg1OSVUjk0hXzc/7tX+m/zfXFkA/IAe+
         kjieD8XiijshKNmb/fNmXKS7Npuj5ZPIfzNp/ftWHQ88IXipxGSe0Q16J8/C0NekVNTq
         RcFJ0fC/nSByRtI3zWaQJr3surSfM0rWUTO70GrLISbMlwxMgkc+oGc79fdDtKXEOGNX
         febC2c8wha8rFPozUdT7sH6EL5bcAPxImsgdUptnLFUvCAqudxhedtv1wK5D+/IlFL6b
         CkGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k0ggsUCzlruSUc+IMO7CIIPVO74LG231s8RrMnw51LA=;
        b=WV45kl6qjCF1Ln6RCSxTlvlWtsJUu2zoZlZ7sNEpnGIeaf/cpT1jtJoVzuwGqSN7RD
         99URNIG1/FXrdePrE08jajVy0rlooK9iuQCHWjRA8nNmPTexWXaFmcY3IYXVYAK20ckw
         PPfbK5IYXaYJBoTzwRkiPFkurOGuGFuMvSexGa8XqE+4Rwz6XfNNCOKB31fjlWdQRwO1
         JTu/V3GgJIl3Y4WXaDZ4oWsycZ2Dcpb1xYbzLbMorjeXYnLNsvDEZabysmlR6BTK6ilf
         +o9vt2b2nJA01pD1DHrNxRfCuL4DRWCUT9wAL3Hi03LrPyAzQps9S0etSWwYDqBVDx6l
         zQ9Q==
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
Subject: [PATCH 4.9 45/65] tcp: Honor the eor bit in tcp_mtu_probe
Date: Fri,  9 Mar 2018 16:18:45 -0800
Message-Id: <20180310001828.552511501@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594508010277988788?=
X-GMAIL-MSGID: =?utf-8?q?1594508010277988788?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1907,6 +1907,24 @@ static inline void tcp_mtu_check_reprobe
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
@@ -1979,6 +1997,9 @@ static int tcp_mtu_probe(struct sock *sk
 			return 0;
 	}
 
+	if (!tcp_can_coalesce_send_queue_head(sk, probe_size))
+		return -1;
+
 	/* We're allowed to probe.  Build it now. */
 	nskb = sk_stream_alloc_skb(sk, probe_size, GFP_ATOMIC, false);
 	if (!nskb)
@@ -2014,6 +2035,10 @@ static int tcp_mtu_probe(struct sock *sk
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
