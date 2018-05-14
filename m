Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpw632BSu59GdOc8qphWJuh5uRmAbcYhmAM5fmbJTI7JS0V70O3pm7bpBpUSzbEwLn4gr0O
ARC-Seal: i=1; a=rsa-sha256; t=1526281153; cv=none;
        d=google.com; s=arc-20160816;
        b=tAjuXOwYqK8uYiVRtnM/BKMVARhi/2XoE9TBHUQK2MGJ33Ai3NWIaFh8qfoz+WvMKK
         VTvP8RtRZV9Q2uc/QM+lZWmcVmQE0m5M5mAOnRGaBPEGJs8ScR+xcHWNSTHQdGVnLMe2
         5WmjwyoxQF0CMXNFpzVVKijBcnglV9feQDZ2NwWSi3VijpyuWXU2UxVH0LqWkw8n9KCt
         TnD8ph64gZpKgDmE/CAkMh1pYujVmseOTUY2Kbci+Pc6Sn5WvEqWP7zMJhgzyHyxyOKp
         NtqXltEHt55U/OGalKn2HYK629tm5M0N47KIDtqVEEtnCz6vUEvsyEaDKp2zoll+igOc
         dhjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=pikD2AIFnZVeGZ96izErMLnUi88XZS1owU28H6yqRQI=;
        b=bIz7a0yLViQs72Ilm6xNEvYuViT8KbXvfA5+yZvjhZ0Le1IrJZ3H9KSA4rLNZjGulx
         xyUL+8sHBPJH5IcRZcGEr1KHbMu3dupzBo1DpkjiAUs5Pt2x3i0ebhJ/TIWpPou4O5w9
         gztSpeZ3OfnQUIAprcZZ5jU5HHxDo7V+MNLK6e3Y5/l0rkOYO6n3j295SiJ4SBIltwpx
         uhy5+wy3HVgwRGkQ0lZZ71HnzqK+h1Px09hF/fot1obYHdGpJSDUp7dtz0W8eYqUMCqe
         M2Dn9oorDI/ZuO57NlW8Sl2F2r8WrklSCpnb8MnT3UZu5y9Xyn4z8VIj7TBrvsKBsfcq
         ixkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=bl/SNEqB;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=bl/SNEqB;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 08/72] net: fix rtnh_ok()
Date: Mon, 14 May 2018 08:48:25 +0200
Message-Id: <20180514064823.399965674@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421242429293362?=
X-GMAIL-MSGID: =?utf-8?q?1600421786779735218?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
