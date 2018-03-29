Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48lJR9qNCKTJ7JecJGzzg1VTvCQZVA89WE2IIZckMwRnvke+lFK4cX49HoruS1ZGXPPDjO/
ARC-Seal: i=1; a=rsa-sha256; t=1522346514; cv=none;
        d=google.com; s=arc-20160816;
        b=WCPrEFgcNtAJKcuYudv0guNyxSH1nXL5eePGLXdIyjA7JiIbrzlsjZJPJw/0a1lRyi
         bm6lJBiExqYpjxDxneddAX/33u9f3vdrcyDOW9AgmDPje6Nj7SslykJrYDi95P0kY8dg
         X9Azm3JHQa4cloqQEGeGRlpEv/5GHFv7rrsRqJ2vxgi2p3yH60m0g13LyyUk/HfacBMH
         ZFzpekdF/rrhsJSvdCLGHmlwoqnH2hde5I+KP0nw4Dg/xea7c3r9sgFjIy0Ls1RahsSn
         lPpdJkxxxwaYPN6UK6FwocSSTa5A64sn4TJPKwOOPj5vJYwz7m7f3WgykR6BGPeSwlad
         Akfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=c0jCr0nO12wmok9WRkydLsvI5uBb6we4U5FXgmZ9+Y4=;
        b=ZlBfrmz5rXwe8cEy2VxF47ezDas5l7y5/2VBf6/zhiKvb9HPPmDs8rDo8HHTluUGx+
         ghr+VSpAHXKxv6/JqtJLwbXnnykXBiVv+Bqce2NYAcYhKbVjOOdHkcduI5aVGOD0sYPj
         5mEUKLu0dCG/nLxchr7HdnyE2xC6I3pfdKfgFpgKtYAJ1TVKZ4ezqCarYvUf8OTe+e3y
         WhSEPfKyuB1VrCNGWqPDCJaNeIxgj/xWdhGFS/cT9wtvSqP93/9Tz6pu/eAeDLimKa5Y
         73SflwdPkmvmkJVi+a7O5Vg2JOdcRReMsdvGBxH4zyBU4DpdyabsJJ9aa36oSp0JFmtc
         upQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Yuchung Cheng <ycheng@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 04/47] tcp: purge write queue upon aborting the connection
Date: Thu, 29 Mar 2018 19:59:45 +0200
Message-Id: <20180329175729.480077131@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296018203827825?=
X-GMAIL-MSGID: =?utf-8?q?1596296018203827825?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Soheil Hassas Yeganeh <soheil@google.com>


[ Upstream commit e05836ac07c77dd90377f8c8140bce2a44af5fe7 ]

When the connection is aborted, there is no point in
keeping the packets on the write queue until the connection
is closed.

Similar to a27fd7a8ed38 ('tcp: purge write queue upon RST'),
this is essential for a correct MSG_ZEROCOPY implementation,
because userspace cannot call close(fd) before receiving
zerocopy signals even when the connection is aborted.

Fixes: f214f915e7db ("tcp: enable MSG_ZEROCOPY")
Signed-off-by: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp.c       |    1 +
 net/ipv4/tcp_timer.c |    1 +
 2 files changed, 2 insertions(+)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3542,6 +3542,7 @@ int tcp_abort(struct sock *sk, int err)
 
 	bh_unlock_sock(sk);
 	local_bh_enable();
+	tcp_write_queue_purge(sk);
 	release_sock(sk);
 	return 0;
 }
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -34,6 +34,7 @@ static void tcp_write_err(struct sock *s
 	sk->sk_err = sk->sk_err_soft ? : ETIMEDOUT;
 	sk->sk_error_report(sk);
 
+	tcp_write_queue_purge(sk);
 	tcp_done(sk);
 	__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONTIMEOUT);
 }
