Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/2HOwRAfgl3bcAfilEa34SquOO2tpjlioJI6ZqOBylCgEhLUKPxIE5ov0s3IxiSkYwNxEQ
ARC-Seal: i=1; a=rsa-sha256; t=1523399548; cv=none;
        d=google.com; s=arc-20160816;
        b=V8L9TP9jy0Z0MCDGRB1uTMOEFn+2INLA/FJ/DytCUdy8EHH1h7dtvJmIyrZudNpYdu
         /kcNxn82lkwCo/nDfaGB6mZi7vMTEMa6tHzP7y2W8pu6lENdNgkS8OEz/2Q59jR9wEds
         /X2s+h1kzIZBCC7+0mhvK/rmTP3ASemRCAO4tBdRIBE5T1WiXomqOvfZkrR5gnrrGI3x
         PMlB6Uu/orcdBdigaQR5zlJC8NTJ7QTJXbnxG2sQALkjxgirDL1bPmCt59fob2rf3qjA
         6v/xWWsQ8pMHSAY3ygYJq/2QKwB9x/duRqJHpY9MTQm7xzZkH938lwIYFGkVJT2pts/F
         KRAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iMdpx+w6oSQUT5hg2PjHGb6fo6jCx5flgZ3px4KbGpA=;
        b=aPwrDh06IUbCOuGMQtp+VPWBjvSiSz7mGzhDsj2oRl68c72+BsGDQ5/ofQ/Bpvwxzz
         GNIYfuwuJSQMXYSsiFptYVVVHGBVgAcas0fnD16ipZRNXgWzIofZwP5CAhRYOvz+tuKP
         VOFTL758v26Xv/CxjXsyVz7z9iS95lAZPeGls7YDERBSf9PLww5GpYzabcXF0fuWLgr5
         IqiY7uyDlRb+Duyakxyo4HE+V1GNqNWyI9suzU+wpwnM0c5sHGTMXJ2i0UZENdp6ue/7
         HIKaC4maoa5SEjkG4rmx7g2jRKsRSLoV7q/KulgDBsBaqk6hPKcftnhs/mdtzC2W4bKo
         lOTQ==
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
Subject: [PATCH 4.15 148/168] vti6: better validate user provided tunnel names
Date: Wed, 11 Apr 2018 00:24:50 +0200
Message-Id: <20180410212807.378662832@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399701425557681?=
X-GMAIL-MSGID: =?utf-8?q?1597400204746154226?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
