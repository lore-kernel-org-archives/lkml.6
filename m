Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48rKpR47DOzp0j1OMCZT6F9AyYWyMk9Hzno0CrYf3lVnXrChtGCXFlZurPR3JSoTIub6sze
ARC-Seal: i=1; a=rsa-sha256; t=1523472716; cv=none;
        d=google.com; s=arc-20160816;
        b=i1vlCIT62w5XZPvPvCaOJeYGLpS913HK/d/4bovSqTvV8TxMlluYJ2HtU9Ytz5Igec
         2OgPysiKWYuUbXhGkqGdxBcrBQOwWUI4sKomT13Mwv6apZ/WD8dwR/iSFDo9syBQA0NJ
         qwBSuNatQeYYvc3YAPZbHVfnAre20OObfeUIDzLsawFapt7Ozg6uPktxMa16mGlMHjWQ
         r552csWDbT8iYKaSkVILzDE8mqE5rBgKk8a0c6a5uSGWjVVUzIgin+Dzn6GikRMh1/rr
         ZjDVy0ZTquN/SzFNrD5dTN33rrj1+Gmxb2x5w0bbnK1jlwkyFPs+SC63YsZqL4MZydzR
         3utQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1YPhWVDd5DzI8dML+otg7fnozswtV+ZSK4rofZ5Mjfw=;
        b=CHMimofel0OHW48I0fc5HhjgS4oh41lTrN16tZFdx7+mSeCEs6HoAssHDfoMmP1bc0
         0LuRND9YvvyR9euPnJ9Ga2dfXSpZ8evJRDpNKzKsUEEOI/30rp7QxBJvkBFA7DBETBFM
         Bp1ELVGKFuQ5CsNaPEg6aPLTJz3xTr2XPkJ9JH+T6oi7LvlK/bLlCyumSz2IutEGa2h5
         B8PpcIjZ8UhbAGqDuBF5KA8zgqbZZiD9LtZ9mjJ7bVfMLDMlyO2jjsUpvZbI/e0j+mvx
         o8ikQJRPHDyVoj7sLB2618GYkhcpXxrIaWFznkZXHhsKJHI9cB1k4Ns2PI/tS90usGff
         v2JA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 184/190] ip6_tunnel: better validate user provided tunnel names
Date: Wed, 11 Apr 2018 20:37:10 +0200
Message-Id: <20180411183604.291731735@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476374644156023?=
X-GMAIL-MSGID: =?utf-8?q?1597476926984952166?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit db7a65e3ab78e5b1c4b17c0870ebee35a4ee3257 ]

Use valid_name() to make sure user does not provide illegal
device name.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_tunnel.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -286,13 +286,16 @@ static struct ip6_tnl *ip6_tnl_create(st
 	struct net_device *dev;
 	struct ip6_tnl *t;
 	char name[IFNAMSIZ];
-	int err = -ENOMEM;
+	int err = -E2BIG;
 
-	if (p->name[0])
+	if (p->name[0]) {
+		if (!dev_valid_name(p->name))
+			goto failed;
 		strlcpy(name, p->name, IFNAMSIZ);
-	else
+	} else {
 		sprintf(name, "ip6tnl%%d");
-
+	}
+	err = -ENOMEM;
 	dev = alloc_netdev(sizeof(*t), name, NET_NAME_UNKNOWN,
 			   ip6_tnl_dev_setup);
 	if (!dev)
