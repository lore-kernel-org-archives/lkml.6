Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48rZfdFp8FmD3KwRdjebq1dziL2W9xLBk+IRf8845tnsM0/9LY7Q5Nk/uMGSkzIiSY5NOY7
ARC-Seal: i=1; a=rsa-sha256; t=1523399545; cv=none;
        d=google.com; s=arc-20160816;
        b=Jt4ZXPyzOtLLO7whZtXbc9epQws1pFg+vLCxG9GMoT7yx2/+w0U+kq1gsFIlTtVkqU
         A3LlAfw0/4TDACc1DWKx/9iVm8JdEEHk9HY+t9WN2EtHmSs9+MyqTgVU8nrmT8NpkeKG
         oQJd9vL/A9wjv2BlcAF6KIruCL6ahRGsxMAjlxQCKEtDtRz0zDuCPupYLuFtdJCfeNTV
         X43zL8F7xvHaXylSExKGVZREzDeOdb4OckIosmwoPHnikpAKR2/ihvCLvm03wqte11Mm
         SosMfUcRdNJqIXYpD5R7G8zyysOMcmUDt/ZTHCDis8ziPdAtm+t3/D3v87zlqv9sPgh+
         L0VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=O3PyblxV2gcNo0PNFwK8vwE+/jCWhOk42XOFk5POh2s=;
        b=hu5HJfaHqTnBXXuQAH4oYzK0s2xmLuMJn0LeZTquXpgS2rLcoFHI9JSHbx5U3b59cb
         nGhT+yaOG+u996/e8zzGa9CGI2MCC/8FHE0ccEsCuHSn2MJdZUTxEVX0Xr1A4FpTTof3
         88cIb/zzOJ52+CWbB9e0Hje++itnUMohqb5tqX4IfBOBZpdykCzIDQAlM7rFjkO1UP0/
         8LGlX+31tT4bg8YG/KldyA2rMbN1+YkOEQrsU9oLupy6U82+coTc+d7S0fXdrzjfuV1j
         0UVR3sLKd5m5CM1fgO7iqY/aRQk8OdaIfuxPVfIIOYGb7TWYUo6LF8uMA+NxvILUTAWk
         m7Vg==
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
Subject: [PATCH 4.15 147/168] ip6_tunnel: better validate user provided tunnel names
Date: Wed, 11 Apr 2018 00:24:49 +0200
Message-Id: <20180410212807.340871231@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399698628036818?=
X-GMAIL-MSGID: =?utf-8?q?1597400201529614160?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
