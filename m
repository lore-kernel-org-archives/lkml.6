Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225T6fU+ZqTUvRLuigzHcX2mjY4gDYey+AIZRuxiqJLMADFiMpjYchJ7LsyeArE4uxWf0g+I
ARC-Seal: i=1; a=rsa-sha256; t=1518707934; cv=none;
        d=google.com; s=arc-20160816;
        b=UxupzVc4AxGXzKUrt9M1ly3+NpVkkq4zjV9zVf37V4aA52ePGVjhYN7CuCi9KsKtD4
         xKa1U3mT8iggbWCzQUdgfvGqtStyqCQdkp1VHxbT9XQJwAqQpa3ID9JOx+uCtaEzyNL8
         owclc/4yE+0YoYm9IaYM7y4WZXWbIfEge2ypkwfX+y0RXPSTqFRTL6c+fM64ifQQ32H/
         Y+O3Bpz+qeoa1EJqujjNmaCf+vX+dsvO+tsl0YPs0ADAoWfSTSU4wW64g7K1wSWQt8f3
         nkfDN/CNzIStfYZQdHvJ85uyFuYqHM5R5jH1MIZWH6+rygAIGke72xSO+c3X912oDeEh
         zg7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gzAhokbhuWDr747imKSRauLjoZYx1OBz+h9mzPhRpQM=;
        b=iQ97+sZPg/E6oxuVSvJ2mLqRk15UGT9Zxf8ZdkTrmkJ8+JmNkR8J+lSlNW9aV9r0Mo
         dYKZ+qGHvJDvEZoSj3XIS/kRBexFOgcWVermAXUYjkXTWkqjA7wzAvQil1bo/va358y6
         rIVh/E0wdlbKafi07RN7e4JX3VI81RD0swoOGmh4g99UxWclsrfli9SqmA8gOJIJGs1G
         0UlMYSn8XtqXVeTpCAvzf52e6rPUIyGDzNMK4fdq9TMJin7oqM0eDOawuWZxtB6XI660
         sLnvH5zYnWfOhZ/Xhh60/G5ndvzS5pvqIiqBK/l/yFjH6/cRLRXbuJDLnXDDUmw8kU0C
         2AkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Li RongQing <lirongqing@baidu.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 06/45] tcp: release sk_frag.page in tcp_disconnect
Date: Thu, 15 Feb 2018 16:16:57 +0100
Message-Id: <20180215144117.241653341@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480691683989629?=
X-GMAIL-MSGID: =?utf-8?q?1592480691683989629?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li RongQing <lirongqing@baidu.com>


[ Upstream commit 9b42d55a66d388e4dd5550107df051a9637564fc ]

socket can be disconnected and gets transformed back to a listening
socket, if sk_frag.page is not released, which will be cloned into
a new socket by sk_clone_lock, but the reference count of this page
is increased, lead to a use after free or double free issue

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2280,6 +2280,12 @@ int tcp_disconnect(struct sock *sk, int
 
 	WARN_ON(inet->inet_num && !icsk->icsk_bind_hash);
 
+	if (sk->sk_frag.page) {
+		put_page(sk->sk_frag.page);
+		sk->sk_frag.page = NULL;
+		sk->sk_frag.offset = 0;
+	}
+
 	sk->sk_error_report(sk);
 	return err;
 }
