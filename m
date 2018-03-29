Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+jR1OZt9ILp026mrdu58n2F+dqVaFSN+mfKgOtWIDydUUteqrkBnVg/bH3Ls6xgBVx22+l
ARC-Seal: i=1; a=rsa-sha256; t=1522346678; cv=none;
        d=google.com; s=arc-20160816;
        b=0jGMUG69wBWWyCkX1yVWgUSH143GcohXdWUXspjtbq55ZtLHpk7PWaXhbcE+nJ5CMX
         Cu6WdHlG027bPlHON7ENZcnAflgPxeM8uWJWEb7p2zSJuxZmMzZDjaAhZY7mjVKcl6DH
         8p1xVjBOJ6srPmnIa2ROEKhjvmlDdQepmlb5V++TsNy4LI9kDk8VhoTNI+6iVLaLbUf0
         yi55Pb8FAjXpkCUxJ+XlCgMJhc2ToGpv6p2UCguFsaI/dwU+wvpDFrrN+TznKo7z2vcf
         VDK4LWQQhgw8GG/6QhP27YXOmwS1TCMPXjsEnVoKflXxV5nB/9Fr2yysv3etm+zkuKbH
         fugg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=epz/4EYMei5iWqrMtHFyTiGF7UJMABGcpWJZuDbsKog=;
        b=TgvvNleWtmyeMWq/YnN04nvogvgwyaCwB5aw2Hbt6gFmdx8hCJtjwFEtw1Ph2pbMsA
         WHlmQQcXXRVD2qyyjMHxbziOx1uGOx1EhinqWATkBl8mjQQjMLv51bFfnJoe8rXcDDIu
         lPKT2X/KfdYYfZjOpVK8qnv6cL2PzO4kQOGJ+yO0kdcILIRo42+l1DvUWWUYmY2yYADb
         1PzrWEc9Fna6OX6ZwWiS5WtZn8Wv9IlwygsDAg/FP/y5TFLBtI3+pve7fL1piXYxDBKO
         w0ekdwB2UP6dURHLw2xids4ebYdWxJ3v4mDz0QoKGs1WvYuwjMpKCHjyuc0V7XO7PSWJ
         z/bQ==
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
Subject: [PATCH 4.14 02/43] tcp: purge write queue upon aborting the connection
Date: Thu, 29 Mar 2018 19:59:57 +0200
Message-Id: <20180329175730.377602314@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296018203827825?=
X-GMAIL-MSGID: =?utf-8?q?1596296190316955364?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3445,6 +3445,7 @@ int tcp_abort(struct sock *sk, int err)
 
 	bh_unlock_sock(sk);
 	local_bh_enable();
+	tcp_write_queue_purge(sk);
 	release_sock(sk);
 	return 0;
 }
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -36,6 +36,7 @@ static void tcp_write_err(struct sock *s
 	sk->sk_err = sk->sk_err_soft ? : ETIMEDOUT;
 	sk->sk_error_report(sk);
 
+	tcp_write_queue_purge(sk);
 	tcp_done(sk);
 	__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONTIMEOUT);
 }
