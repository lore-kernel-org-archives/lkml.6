Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49oG6eFo2ReC0xVilNf8I24Hx/z6tSwz62m1PmCI+Yd9AS0IHqs7ts8K9V93TrMbDMDwm8D
ARC-Seal: i=1; a=rsa-sha256; t=1523399068; cv=none;
        d=google.com; s=arc-20160816;
        b=iil/Jo5XNo6pJWm2nCXCtqnXkFEEWuTAUTUJjg10jbfdvI6LmUhOWjdUAvGRg9lqkH
         19L+b1/D8w0dMpetk5C1fiLodts/vBbAYuiW1h9buVc8brISDljoxzuQ9XccMIPpicAF
         2ALBlmsG6ZRKbObTT9V+f1ynyx94NbeyX/sWMQt9ijKchINZglrBt0OaRAVXigmFvNq/
         31M8Uwqzs6NPfKjZLIvYLlCwf7kelVIdB257xirCFUivH7LMlA0fCjEcELN2lpsb7XCD
         U5JQFWIH+0CPnwGkz01v1cMnFUMwGuvtRYKJXVWKLyyvyhZn/uOuaydxLJH80EAdTVlO
         9B7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4Cz7Ze6YbUW5TFBA9do3olmTZ/E2MkUmynO1AEk/eMs=;
        b=EEe/W9YSn9av9l87/lK6aMr3ueP6lP7WZ23LALIlLdeZfBtRyFeeZfhiYhyQIg0r6Y
         dmVGQSZTHMQlYJ5MBw9iij9Q82mmefE9Uc+2ofNdJOUSiMFb6fU5ZWINuGrUDSO5Clu9
         St8u7HPQimjmCk4O3zkpHmL627OvrMUKGZ77NDjd9CfGXDk2FvZiMJGXaPTscVEBJDCD
         tdAJqkk79ZbTMioET+C36g/0vIpYwnIOl3Os1Sq+5RQm9xZ54ZAOCAiJcsqoD3jK3yJa
         q+JeIMka6qfd+puy0QA958p91FylnQvO/UXr6dZbzjXoeGqstNUszL3ALXBLn3wweCH3
         5gDw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 16/18] vti6: better validate user provided tunnel names
Date: Wed, 11 Apr 2018 00:23:51 +0200
Message-Id: <20180410212759.435007511@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212758.564682823@linuxfoundation.org>
References: <20180410212758.564682823@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399701425557681?=
X-GMAIL-MSGID: =?utf-8?q?1597399701425557681?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit 537b361fbcbcc3cd6fe2bb47069fd292b9256d16 ]

Use valid_name() to make sure user does not provide illegal
device name.

Fixes: ed1efb2aefbb ("ipv6: Add support for IPsec virtual tunnel interfaces")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_vti.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -212,10 +212,13 @@ static struct ip6_tnl *vti6_tnl_create(s
 	char name[IFNAMSIZ];
 	int err;
 
-	if (p->name[0])
+	if (p->name[0]) {
+		if (!dev_valid_name(p->name))
+			goto failed;
 		strlcpy(name, p->name, IFNAMSIZ);
-	else
+	} else {
 		sprintf(name, "ip6_vti%%d");
+	}
 
 	dev = alloc_netdev(sizeof(*t), name, NET_NAME_UNKNOWN, vti6_dev_setup);
 	if (!dev)
