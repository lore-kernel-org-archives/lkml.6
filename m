Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqOTdFDoBUZCirUHogrAPSipb7wJ77B4kgnNMDu/tEIDUEzjV7uIEI+X5erwj1KjO7Miknf
ARC-Seal: i=1; a=rsa-sha256; t=1526280634; cv=none;
        d=google.com; s=arc-20160816;
        b=FV/ThYwtbSC75NgQoqrfhCw7lQKCvvRRxv4hjIrkOOnD8lRIiaGQ78hSXO47P/6trM
         4flLRuqIqZAT5vfq68/uF4i0UzHSeijCtehq2wr6yF6ftqJjTqRsDx9Ng9SswzuiY/7c
         FexNa3Ih5H/KU7eFVfXEBqDgats0YMaP1prL9j9kXQfZ8Mtge/l8br6IOZ7GwMxALNub
         MevtO70GIo/E7Gjl8qDogcX9gdAhPb9fQkBgHd96t0yLpqKe5A2UwutWqqulPF2YgE1h
         PPFMqm99pjc3J2NJTabgY4GEfjjP3Xtvn2tdXJCS8Vv8T+a1BHTMgfnTFNnsUG4lskc/
         j96g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=GvobVdLpZrcoPi/79W8qTbDQj0y7z8/kOd+qYm75ij0=;
        b=z1REZ+aGE+CkW8GWmWnfYSbnjS+wyqjyxOYrgFYZJJR/8fFQ8q4FU+/buNDc7evR5L
         QIV7BoEQnkRog6tOr2mYaXnUyN3Lw54u44zejO1oPsNvEWTDLDVRQ2mgzz070YwwFlNJ
         JgnI90evTBwxs5zbYEy+K7TL4PrVZt5H+qqyXIzTGOSnUJPdvjdiiAJ3QuY+rOoQ2rEO
         172vNOq2RkFztEAFUn2b5x7cMlLLv0pZYzMF1xZYoOh46zasJSk2PBgrNr0PFARvBaHy
         rBtP7ByXS8tCJesd/ui8tIBCWyhftJHnSEFAqXDVWCudvpiLC+2/bj9uLAvIu8uV40ha
         GN7g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=gEnFZlnf;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=gEnFZlnf;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 13/23] net: fix rtnh_ok()
Date: Mon, 14 May 2018 08:48:42 +0200
Message-Id: <20180514064704.622427901@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064704.046463679@linuxfoundation.org>
References: <20180514064704.046463679@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421242429293362?=
X-GMAIL-MSGID: =?utf-8?q?1600421242429293362?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
