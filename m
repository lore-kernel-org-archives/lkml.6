Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt9pUVX3EJOcLA1MqnCsok4DrtNCfOoauaV9aeX78xraLYVGXDPsaZkJlLnoKZnn2cFi0LY
ARC-Seal: i=1; a=rsa-sha256; t=1520451752; cv=none;
        d=google.com; s=arc-20160816;
        b=doh43BmGsSg0Cj5O8mklFHdcYd5bcB/xtXN8AgKB5fweXrBiA020h4X6V6Ds93CuJx
         toJl/upnaqJXwWYf0AiyvBO1fcT0rs1q08TBjwwPWM6WN1J9RD2RRn2lPDDMjnju3O2f
         trwxukKazDtWokve5Mq7KrYSDAtaqXhuYjJiEuZCZTcya8UfpXvCyASn9FzFupvX7wou
         nqlzze25VgjJl0/LNZ4V3Xbg3EGpY6EAn9BaWGzhm89sOm59EDQRYZdVMcCZ12q9dWaW
         pic/md3YTiNTgTdamX/7g6dB6qO/mCp7PudUKJSX4u3Im2DZ+HkFzpplJnX6AGj4FP3m
         dt7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cDiD/NSWM0Umn2AUaoPeUFd6mPWMxBHcL4EZ0gkAvXU=;
        b=IfG5IWDW8Nva03zlb0j6VzoEwg1cK1G9z0eGoLDWhRr/HdshdL8qZBOGEU62OUSOiK
         /7snmo39cTmSFv8LMMJLg4AEy9kCXwpXYOvPi+2qRrstLVPWpbC+4Gk0QmqCiXh+xrhk
         aKR+Tbe0YKZRKtTaT2aMc+rljMYOkO4LUtb453ZbCExR0hOtci3PpWfc6WL9n/WfTnQn
         uy0kdpyBqTc4QoOi/eN5+EQyAyH+4EllwWAxP/Ct0FxkUdml0A4929NLsc/UTwrDKoYO
         2fiUjva5oBkxPNuWmSq81nWeyOaKz3g9eKYdAMzOZMw1iU9QWeT7sF1wf+EvPuLffgbB
         Z2rw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Lawrence Brakmo <brakmo@fb.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 082/122] tcp: tracepoint: only call trace_tcp_send_reset with full socket
Date: Wed,  7 Mar 2018 11:38:14 -0800
Message-Id: <20180307191741.121970294@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309216538626772?=
X-GMAIL-MSGID: =?utf-8?q?1594309216538626772?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Song Liu <songliubraving@fb.com>


[ Upstream commit 5c487bb9adddbc1d23433e09d2548759375c2b52 ]

tracepoint tcp_send_reset requires a full socket to work. However, it
may be called when in TCP_TIME_WAIT:

        case TCP_TW_RST:
                tcp_v6_send_reset(sk, skb);
                inet_twsk_deschedule_put(inet_twsk(sk));
                goto discard_it;

To avoid this problem, this patch checks the socket with sk_fullsock()
before calling trace_tcp_send_reset().

Fixes: c24b14c46bb8 ("tcp: add tracepoint trace_tcp_send_reset")
Signed-off-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Lawrence Brakmo <brakmo@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_ipv4.c |    3 ++-
 net/ipv6/tcp_ipv6.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -705,7 +705,8 @@ static void tcp_v4_send_reset(const stru
 	 */
 	if (sk) {
 		arg.bound_dev_if = sk->sk_bound_dev_if;
-		trace_tcp_send_reset(sk, skb);
+		if (sk_fullsock(sk))
+			trace_tcp_send_reset(sk, skb);
 	}
 
 	BUILD_BUG_ON(offsetof(struct sock, sk_bound_dev_if) !=
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -943,7 +943,8 @@ static void tcp_v6_send_reset(const stru
 
 	if (sk) {
 		oif = sk->sk_bound_dev_if;
-		trace_tcp_send_reset(sk, skb);
+		if (sk_fullsock(sk))
+			trace_tcp_send_reset(sk, skb);
 	}
 
 	tcp_v6_send_response(sk, skb, seq, ack_seq, 0, 0, 0, oif, key, 1, 0, 0);
