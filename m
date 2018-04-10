Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49KNaH+fj2PAhT9YrAk2SFEYeWAbqhATImRx6ufrzIJmS6Volh5g+9zzC9fGx74tYNMGJpe
ARC-Seal: i=1; a=rsa-sha256; t=1523399951; cv=none;
        d=google.com; s=arc-20160816;
        b=DSHmErMX7pukleuOzfTKAaUsdJb8JrXJ8fM0uqjEHLzzv8Ctq+m1LS49ek7yapD0iw
         qj2JeIggBQE5YpvhxNVRHIhrj2Mgamue9A+CErXitLvczdcYRe6onsODLsTM7L0dMlwL
         JjL+sBlUckJ6FaQwyJL1f/swklcHTtCD5w7I7lqbJy3UaGVMMqECbYIb3D45cg3M6lnh
         GbNAlfmLqDTA63UhsnG0OlQx8fIw3fj2+sNbzKU2v2ZnsanEMXI1iKdoXwB1MstV9pK1
         qkYGKxmVq0S1/VGs4j1ugepNTmEeZj1aQmEk4Yn2QOUXTYwvOyNNC6WXpGkZbsG9bxBk
         zWwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lsGYO1jWDmD+Dai+VCdvo65kavR1ky+gc411q7QSHnQ=;
        b=PTwyTavfd/mWBpuGOlDIIaR2II/b5sz5aatAKii0qD4B0esDrsVMS3KmN2tylSzgz4
         BAJlin4IWsXXX4YRVoorfLs0frGP2uDsNZIs0tmkN1Dz5JVTTiVnQhwCIm2dNY9hJt8d
         ono4wOEWVrjFfHU4ddePf2V1ppODbRL5Ele+H7Qhk9zkf8ilL+QJz5tt37CsEgWwLaWj
         OinwnGbVvWVWGwTD2g/k07QcksZWbGZvKGDiZI9BGRJSdDPZ/DGNEhUrPEwHBQ4OxCVP
         LgP9/FLLXu+Pqcx/98qz1K1KGVqi3i2QWl5RX5rFVpsasDVKDgSA0uOcV6Vx+gLzEdvM
         +JCg==
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
Subject: [PATCH 4.14 122/138] vti6: better validate user provided tunnel names
Date: Wed, 11 Apr 2018 00:25:12 +0200
Message-Id: <20180410212916.363758583@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399701425557681?=
X-GMAIL-MSGID: =?utf-8?q?1597400627889935543?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
