Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoQ8mM1Wa7fkVr73XUx7ZWvAN3kOJ7i1BLW7UZD4+Zk/yQ/pFgb/y/Sos98zO+kOnKyB1YL
ARC-Seal: i=1; a=rsa-sha256; t=1526280828; cv=none;
        d=google.com; s=arc-20160816;
        b=bFpNWwIbyTIYQNg8azKnnytUdpkzne7uWhhVT+IePHHmMFxzG44ia9zY3xThGQt7vT
         IGzWy9XARroJM/7ty/ARK/IBJyGR3LGnoIKvcEEclZ96cXwK9lgLMukvgMQDmZj6ZFac
         KEdockgG2cXc0jvBkvx57ucAnA198zHubpWAAOw1OYO7JnBKp7cTnm8k08qUsiRWCavW
         /NN58MdmXvK7JaHsiqxH0EpurEP8RqQWKbG73RVHBjKFKMFiyL99YZuNk+IrdEKUObIg
         FpPHNSKmIwbZ+o7f29AdSI3UY6Ype9adSiYMhdPx27Zrvz0eI9rA3onCo4hPzI+B57tb
         OiXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=NEe7pUVhNvYIfCMYlrNeEQlXdbbdicD5boDwAQ9XqcI=;
        b=R8D7EUrV9bVftPqo2JaehXjWKJhNE3xjM3kJaT+5A+52weRjI0KKfv321T7fji4oaU
         6W68RDyI0RbWJw1moEb6mTivXCfF1/YyY2VucACnZTzYfWJMxD5kEexLN1M6C7bMA5Mo
         QgpvGHWh2U92vs8QIE1GwItw+V6zItTcSMDmgADz7i3PxY/DEarbiG2bG2k48VmHLUfT
         2BQyjDigrAUTZJV4QWhktOmzXE/agOd7g5jUf/AP2kaQgmgHwefGtkTkaWnWqtup3rtj
         ioa3tHf5+qN9UadRKXAk9o8Tvl2pNw43UKPbUYAZ3p/hfVTs6Ly5NGVBFvIMWqUFqOla
         fsiw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=r6AgGcVE;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=r6AgGcVE;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 06/36] net: fix rtnh_ok()
Date: Mon, 14 May 2018 08:48:40 +0200
Message-Id: <20180514064804.756184864@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421242429293362?=
X-GMAIL-MSGID: =?utf-8?q?1600421445896552941?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit b1993a2de12c9e75c35729e2ffbc3a92d50c0d31 upstream.

syzbot reported :

BUG: KMSAN: uninit-value in rtnh_ok include/net/nexthop.h:11 [inline]
BUG: KMSAN: uninit-value in fib_count_nexthops net/ipv4/fib_semantics.c:469 [inline]
BUG: KMSAN: uninit-value in fib_create_info+0x554/0x8d20 net/ipv4/fib_semantics.c:1091

@remaining is an integer, coming from user space.
If it is negative we want rtnh_ok() to return false.

Fixes: 4e902c57417c ("[IPv4]: FIB configuration using struct fib_config")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/net/nexthop.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -6,7 +6,7 @@
 
 static inline int rtnh_ok(const struct rtnexthop *rtnh, int remaining)
 {
-	return remaining >= sizeof(*rtnh) &&
+	return remaining >= (int)sizeof(*rtnh) &&
 	       rtnh->rtnh_len >= sizeof(*rtnh) &&
 	       rtnh->rtnh_len <= remaining;
 }
