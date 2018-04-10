Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/aApiSryEzDgFAVWXZCM9Awua3MOzAugHwoWaexwpBJ/Oxzk+4xBOKXOxUfNjAhrHar8uH
ARC-Seal: i=1; a=rsa-sha256; t=1523399948; cv=none;
        d=google.com; s=arc-20160816;
        b=l7r+ry/bn0bCebCSxonkL5F8tPjfORS/tWAAj4eAe3Hey65zwUOHgkmwMYSHSWm020
         szFZrprlift/DtU1HugeTlUBPJHwVsua+Ed9OIzRtRvz4x7IQ+bl6mfrtNs1ZVy6qI82
         e65FYEMZKK0W6slSJ/80stfj1Eohhjq7wRREaUctLC4XWEfeC2kzVN0OGgm45mrqdx3H
         iI4c7w3C5jPMMngYnvKopVr7alikiahOv8k8yT+isZBjA41D1mUDZ+8DHw+no1doS3SA
         3KG4TSADVC2+9MxML9L0A1CPAsARapOPrT9lafjeL3hT1nVTGrYJ4/GEnkk3f53L5b66
         itcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fZ7VWn7KO7U3UeuuOlojxhtaEXP2fXwM7qS18TNcS1Y=;
        b=aJJgWI2XsyuZKbaKJMDJCSRm81gVGncPxDSiOTurqVoAs8y1/HyqdtgXdMnaZM+2hu
         Wp60lZCTu3tPRnpC4A0JfTcDl9NAgyeeuGgk4VZ+PEmUrWc3C0aL2717sL42v/JUVAH4
         dajB84+sJ+7h/QAaK1skOQDuK7ccZJs1iBbRH+mlElnZ2poC8m9QMpBsqe3VcJhqlvud
         7pmoaeuUqcIZKKf2ezhaF1m4vXppo7fnk2MY6DeBfumnSTaaUmcguct5efHI1ytgzuYy
         9hELV3HBy6QKNls+0s054bXMSgpcg3Z3kKuSXLYAdes87zm8NE5MAgJ67Ey1w35nwj5L
         tp9w==
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
Subject: [PATCH 4.14 121/138] ip6_tunnel: better validate user provided tunnel names
Date: Wed, 11 Apr 2018 00:25:11 +0200
Message-Id: <20180410212916.268036160@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399698628036818?=
X-GMAIL-MSGID: =?utf-8?q?1597400624172377390?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
