Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpE+dSqB+TMD9swFoeY3LHez7LiD1TwZQostluJyxIxPNj2xDTVktUWpOEN+IHaxzLbc99J
ARC-Seal: i=1; a=rsa-sha256; t=1526631607; cv=none;
        d=google.com; s=arc-20160816;
        b=tBNumbZyGGlGpPtyesq9l3Pf3G1vvo3+HWMVDLewT0GGUfix6RT8Vn/wYf2neeOD0W
         nVM+yNd/aB43P5mEQuM9o3GVDC0XFBkvDjg9dM57R6Kv+k+RTFRaJJxNJaUWFBf/3A5F
         Zw0LIJVSnGtdDdoaPRbihHW1mNb8PxTLOzpwEka7JRIHNEMlG6trljYhK3rVGuT3Hi1e
         Poi6e+BjU+WaHxWKnDPW9dmIiWGKUVrG9lsqxTovbr3MZF7bikrZnwWGY4q8x8gzy+kl
         mtm4Y8A6hToXByz5e8s2ovmyqTjxT7k/gNt1u8fe5kM1+sCO4Agb1C22HWePZyXPv90t
         FuaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=9+GMQqOoUY2yF8KIK2FRs3NzrWGaRkRMHnluVV8aGsg=;
        b=H1dghVhxTDgs9frHiWPkpeMw2Tq5AJHSZIeygY2RMrhRr/RuyEomPXRPVzmVFwJ+Ov
         E272N/a87N/25rzF7x848TBdlLZsWHMK4gJfOtHTO4nod9jMR4dN6TDHNVJReevAxcmU
         HpNghiEgGyf6DYKVBPg6M5tS9OXlNhvbf9UhFPGnhrmOVy0YKClnrY1Fni0ed4ZXzSF/
         ZY4bP3I19as0o2+U4RKWnjoyP0UJlURcgTyHXi0tPoQl61IEF7x2Vq/reDCd2rKQWIL4
         p4RuasjmVMR5rIftSRZPdFBMuypqPIyuThU9OWNuAlKTj8g5TC2u/tPCMA3rFXsPyP/1
         k7yg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=V0bg6zT4;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=V0bg6zT4;
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
Subject: [PATCH 4.14 28/45] tcp: ignore Fast Open on repair mode
Date: Fri, 18 May 2018 10:15:45 +0200
Message-Id: <20180518081531.774261127@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789110988167227?=
X-GMAIL-MSGID: =?utf-8?q?1600789264367558429?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1194,7 +1194,8 @@ int tcp_sendmsg_locked(struct sock *sk,
 			uarg->zerocopy = 0;
 	}
 
-	if (unlikely(flags & MSG_FASTOPEN || inet_sk(sk)->defer_connect)) {
+	if (unlikely(flags & MSG_FASTOPEN || inet_sk(sk)->defer_connect) &&
+	    !tp->repair) {
 		err = tcp_sendmsg_fastopen(sk, msg, &copied_syn, size);
 		if (err == -EINPROGRESS && copied_syn > 0)
 			goto out;
