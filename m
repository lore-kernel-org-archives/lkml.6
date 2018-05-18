Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrP9pbMv/mr4nXQQ+965CXXJMV+I0RCg4an0LcDJAY5Y+F6/w4wQy00i/KUvYnXQWFFQupc
ARC-Seal: i=1; a=rsa-sha256; t=1526631461; cv=none;
        d=google.com; s=arc-20160816;
        b=TYSfna7detd6wMX/HLEGK7IaYigzHc0stcUlySK7WCrCTBOujz7prqmpkKzmXQogvU
         fyqTIrP9tTGyuwE26YOSOwF/uZI3i1PVq/KaNrR+3h2eGaqFFVZuDlHSQm++nP2ZWFdo
         lK8UEhLxPJsyV5zJxxDVi9AFLdNsY5XoCOlHtlbG6hTn6+omBLOm6WFS8FhrjJ1XLR4m
         Gwr7ZX0fIf2nwD4DNhYCf1PcLcR6B2lxAF92nZ3G1mH5CvOQqhHO9X4vADzn6ufuF/H3
         a7Bf9KYlueDRtQr5BlCrG+l/eNlXi7TAUWOXL0EykDtVjyCre3v6AvVKA+8aBaxPlVKP
         LAaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=smcLnP9/I4CMYocvjyjppDELZXC5zexd9aNRV7h46g4=;
        b=01p8pFAQunFv84S7ntUCZlsMlAbIWIVQKnNjymzSCKTPiNxm+iow5KA49c/+g9hVrg
         8eJ8pEwtGhGoZwPbDLIrej9MS1FCbTDC8Tg6uOsRGEaQDTYoHpNTot4nHiyZG/TXLX7a
         rfStzm3we4Unulk+3iGxL5OWqYFUKsDKwLmeuEr4nAWgdQcKXxXGINs6Il+hey9UMEy/
         rqKEqxkIqbQDIGhqmyL8to+QGPIeV3tgq+IiBpcsVZPEQ/BTgFulm0wEFCu3LTIiuuyc
         8IT4U7BcpGP76texSUBAE1ANpz9O0LdjPXQL2oFOR617OxXrVSvZ+GqulikA9s3/3rIA
         oUbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=fH3W1Pqx;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=fH3W1Pqx;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot <syzkaller@googlegroups.com>,
	Yuchung Cheng <ycheng@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 29/55] tcp: ignore Fast Open on repair mode
Date: Fri, 18 May 2018 10:15:25 +0200
Message-Id: <20180518081458.875332555@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789110988167227?=
X-GMAIL-MSGID: =?utf-8?q?1600789110988167227?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuchung Cheng <ycheng@google.com>

[ Upstream commit 16ae6aa1705299789f71fdea59bfb119c1fbd9c0 ]

The TCP repair sequence of operation is to first set the socket in
repair mode, then inject the TCP stats into the socket with repair
socket options, then call connect() to re-activate the socket. The
connect syscall simply returns and set state to ESTABLISHED
mode. As a result Fast Open is meaningless for TCP repair.

However allowing sendto() system call with MSG_FASTOPEN flag half-way
during the repair operation could unexpectedly cause data to be
sent, before the operation finishes changing the internal TCP stats
(e.g. MSS).  This in turn triggers TCP warnings on inconsistent
packet accounting.

The fix is to simply disallow Fast Open operation once the socket
is in the repair mode.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1210,7 +1210,8 @@ int tcp_sendmsg_locked(struct sock *sk,
 			uarg->zerocopy = 0;
 	}
 
-	if (unlikely(flags & MSG_FASTOPEN || inet_sk(sk)->defer_connect)) {
+	if (unlikely(flags & MSG_FASTOPEN || inet_sk(sk)->defer_connect) &&
+	    !tp->repair) {
 		err = tcp_sendmsg_fastopen(sk, msg, &copied_syn, size);
 		if (err == -EINPROGRESS && copied_syn > 0)
 			goto out;
