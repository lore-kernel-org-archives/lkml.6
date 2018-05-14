Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZprFUQYM1FDyXgPcquJg883ou47f7PBPqWk0igMu9avEWxw8JRD1tD6r51oyoZiLL1HtKAQ
ARC-Seal: i=1; a=rsa-sha256; t=1526280966; cv=none;
        d=google.com; s=arc-20160816;
        b=AmkFtssibc0y0TFbQ0XU0V2S1d6AdACOr69sVj0cjp1ClQV2Fy03XbOMb2G7rq4J9M
         0jdeAxpdub18kKrKNSxPPH4oki9lYONttYeXECybCFN/TUri2BxkJ0k/i7iArcHu98Ug
         OH7VA1mYaXf+r40FH21l1cCevnhylNvwrL3U6UGuZtHp3YVHGF/dM2LIUHElzf4+yMsx
         PWGyTMcdK5np4c99pzqosL9uz2L2Z1gqMKvbyxDx2+EDgmVcUL3UIfMiJ2HL95vU9dNZ
         E/DQETD+18JfC0NR1JHWO/aMqlMC0ouv0oAUPDNvLcyHBHX6Lcg3h+VY4570LY0+cRIS
         eWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=mRYPwbe9hwSBum0cKY2NBC3rC9SJ2SIKR4YRUuPbyzM=;
        b=lXdZ4dDxO7WARpuW8kx2Mdh66gV2Mmt1NOL6RhjuII5Fp9r1jIGqDLdF2iqvuvLV7f
         01EpsJBjr0DKaBXKp2/oBoXXdysCBRuVH8r5fdqanZ0QcnX6jeGUJZ1KyxVIf5gnrIHA
         v/SwM+H+3aEkVUMMddUyXQjmaImNZNxFMkxWpHv2Lt/yIkI0sfWDfEauYkyOd7sdL/h2
         zQFja8xL2dUiPK/wju1YalD4lMJz2ZBoyayk/m6DQHFW1A8z9uhyAWsHIpBkh3WC4AYY
         TEV1OJ680pCg7AZ/qq9LqxoXomzMKjvY2IH4EBirptb1W3oJIKu3b/cD+ILSAmypZkk6
         P8ag==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=m4RNs8Va;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=m4RNs8Va;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 06/62] net: fix rtnh_ok()
Date: Mon, 14 May 2018 08:48:22 +0200
Message-Id: <20180514064816.799403973@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421242429293362?=
X-GMAIL-MSGID: =?utf-8?q?1600421591168423643?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -7,7 +7,7 @@
 
 static inline int rtnh_ok(const struct rtnexthop *rtnh, int remaining)
 {
-	return remaining >= sizeof(*rtnh) &&
+	return remaining >= (int)sizeof(*rtnh) &&
 	       rtnh->rtnh_len >= sizeof(*rtnh) &&
 	       rtnh->rtnh_len <= remaining;
 }
