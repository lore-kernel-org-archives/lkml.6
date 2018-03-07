Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuoJio7VD1KvGgQ7RcBVjxtFEnbkIs4aKkieHm+no1pY2MzoxRO1d388MVAsgL9B1dFM8Cz
ARC-Seal: i=1; a=rsa-sha256; t=1520451936; cv=none;
        d=google.com; s=arc-20160816;
        b=iLjodjT1dbhdH9RsW+SLGrbVeyb3DG7KF9Z4V3fvSXvCG5IIH/veOrvBLRgs2G1c/S
         jGdrIh92D/du3n8vvI3A1wBTDtCfmVW3leIxDf4TeQSt1XMWR4B0DBfboW7Md2iHH2vA
         HipNOHRqsikBhWVFbP6orKdwFSlz6zmegeIUka2C2XLnEaH35MWtWuaQRbGdKAA7ujft
         +E4QLGhINiwt4JIYQMuQHLTEeLLSg64+mQeQehRFHEJYGnu4Da4pL1wsOLfasi57U12H
         tMSTxdJjhY2M1wfNwDoh8Z4SmawCcIi1zwyMZk1wGH6KcLjB+9P3n8u2O24LnAJOaLH6
         M+Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qJrtdyGMxPoTeq+4+fftV8xEx1hxmGudM9qKk1P+Qmg=;
        b=ZHCobePGORvwfAqnRBBMGo2lRxpRWv3yz7+sVnMlk54UUeogvZVy9OwMKuSKvI7yqa
         VKebQjRwbOE3lA3QxTazHXh/H2cJDlZtqf7Ek+BnVRVcYanlgORc/ovG5/6PUyXoESep
         cJUfyDzXmNMAMba3aDgrl8PTQM3tLh4A5kowWVoNHQ7UY83YEhxd94JN33vNC49jcFs5
         HzRJfeYxC/nkhh7mTfN4NeUkLfNFVo4MxquqBLyZOlBlO6HLagu5uOWLOw62dM8PrtBW
         +B2cSRiCbYdOKDjRqpY5YAO6o0vx5sz0O2TY0iMwaAgoq7l41FF85PKX3RH8ot9gG2iG
         wHMw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Sebor <msebor@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 037/110] ipv6 sit: work around bogus gcc-8 -Wrestrict warning
Date: Wed,  7 Mar 2018 11:38:20 -0800
Message-Id: <20180307191044.508329918@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309119767792971?=
X-GMAIL-MSGID: =?utf-8?q?1594309409872714241?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>


[ Upstream commit ca79bec237f5809a7c3c59bd41cd0880aa889966 ]

gcc-8 has a new warning that detects overlapping input and output arguments
in memcpy(). It triggers for sit_init_net() calling ipip6_tunnel_clone_6rd(),
which is actually correct:

net/ipv6/sit.c: In function 'sit_init_net':
net/ipv6/sit.c:192:3: error: 'memcpy' source argument is the same as destination [-Werror=restrict]

The problem here is that the logic detecting the memcpy() arguments finds them
to be the same, but the conditional that tests for the input and output of
ipip6_tunnel_clone_6rd() to be identical is not a compile-time constant.

We know that netdev_priv(t->dev) is the same as t for a tunnel device,
and comparing "dev" directly here lets the compiler figure out as well
that 'dev == sitn->fb_tunnel_dev' when called from sit_init_net(), so
it no longer warns.

This code is old, so Cc stable to make sure that we don't get the warning
for older kernels built with new gcc.

Cc: Martin Sebor <msebor@gmail.com>
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83456
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/sit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -176,7 +176,7 @@ static void ipip6_tunnel_clone_6rd(struc
 #ifdef CONFIG_IPV6_SIT_6RD
 	struct ip_tunnel *t = netdev_priv(dev);
 
-	if (t->dev == sitn->fb_tunnel_dev) {
+	if (dev == sitn->fb_tunnel_dev) {
 		ipv6_addr_set(&t->ip6rd.prefix, htonl(0x20020000), 0, 0, 0);
 		t->ip6rd.relay_prefix = 0;
 		t->ip6rd.prefixlen = 16;
