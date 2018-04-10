Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx482PQzOgl86TicUprUgJUATjEh0cQufWk+jD/xqIGQYrYefSCbm/H0E7ocCs+7mK7gja60/
ARC-Seal: i=1; a=rsa-sha256; t=1523399065; cv=none;
        d=google.com; s=arc-20160816;
        b=OiLxajd7vTouBsfVp9/mEJ6Z6mnWih8tD0Ev1w6v1yIEDgHgTPCvqvlBFgRkYkluOV
         ABbH9FsDxHuBpxy1Wn/u8Yj+4CGBIninGLnvxuxQIj81ZPHz8OeIsa136flAzHK3duo9
         OFEDER6gqU8XN5mS7+jPBGnwmwIK46wp0j6TvmZ/XpT3N/E5DYA0L11JpSgRqvOldnbE
         oDXQhO5Xl/3hFN8kQklCCBCGakSP86fMW4EgWptPPnaL2U+AibNLWYM8nmEEfyIPKppT
         FLdj8qf08NOxInfXnCRJwOwilSZKPKfAG6SwnPgrHoDLWItuV28NfxKYmIVWOTJ2O05s
         zqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VVEXSbCJLs+A+xn6z8FjdXvgcUQtjayvYD5btt7e9Nw=;
        b=scJtNv5z6MIN00NaeXZhbKcAl9tcVjHtScS0tTKwa1eKO6Wp1n+99pI3DKB+icMOy4
         UQApDQBOp8/flhqRzTyd1aPJF99lO39b5pPkNlI2zrXw0P6jeV6pMQCiXwhyjhkIQZbI
         2LzB5l+ziFxBNbpqOM/iA3xnlIuhttPsEqN2ls4DWDGqQHadmu0PFtjeuPEdIdLjwCYp
         WCAkpYETb2vF4dbQYIz0jgJodwgegPgwo/WJD4SY26v31VqGfwOuajIqTZvgJMJFZthu
         akh9NTt8YwHMmQKJTRN/LOtUDPz37qxFhkZXoGKeVkFVnjqcMbGtfOmzgGqyTxHutgsr
         hhJw==
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
Subject: [PATCH 4.16 15/18] ip6_tunnel: better validate user provided tunnel names
Date: Wed, 11 Apr 2018 00:23:50 +0200
Message-Id: <20180410212759.384487900@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212758.564682823@linuxfoundation.org>
References: <20180410212758.564682823@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399698628036818?=
X-GMAIL-MSGID: =?utf-8?q?1597399698628036818?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -297,13 +297,16 @@ static struct ip6_tnl *ip6_tnl_create(st
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
