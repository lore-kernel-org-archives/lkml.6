Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48rfc24qjdwMDdnJqNd776BWnEh/pBhy5ZIldb9N+sMgAGJmL3JxBIUltlECh5oVOJPanGz
ARC-Seal: i=1; a=rsa-sha256; t=1523022042; cv=none;
        d=google.com; s=arc-20160816;
        b=y4qiKkEOahFdg5Pk10s8WQJd6fV9j9gOIdBjjOTvaU26fommM8fF53hg4hM5i8Olb9
         SpkivEygUMIHM2HAShn4qcrGCcWWZA5KiT9Wnc5kgTQHdIaYJkRKxV82zrjSTXIaNDy/
         lD51HLLftWIc1OE5VDx1IrlrAnCICEyHfOlyEPt5WiEwRuovolwUFzkrxHr3+5+Ttppr
         ErMDfZqM8wJPCWvDqPFDe/UDLiwPVdbSTfQBsd3lPzqfrCkDEmrN6b9NmZhuIz/QOrjd
         wYXg9DiEYR+HpLaFcc9drzkEUMiQclhSXnN5Y1xpGNoSWYM4J172XDp+xsD1Khw9SKJT
         3Sjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=P9wKPI7eQgqtoR20lVMqpUTx6sGLgtmi8MgZcqq5Ces=;
        b=f5YoK2QfdLjh+gNUd+d8YJUrJIcofgnQxrRk6K8PLVrPJaSdIPD+GFA8OB85avvUDu
         9XKx9HA4h+rtabm7JgHco5Bldnn/AUN7rca0sX57TMblNqpcW1kttwWVQuChn+le0CT1
         cA5SmspzP6Mk1qofwluQArrRYbOBpby7OPdAxuG0Ew3590qTS/bG2I3za+9cnlBgOar4
         ZBcsGr/9j4LGVkzbDozOzZ8H0gQCGo9C7Cb9MZi3laK/C/3k64dLAHaDnmBCQXTWKSyp
         wgnwaJovY+QVeOTAW80hRXTCqkEbsgbjfdwG0LS9ZdAhhPYJ8R/t5qHvpfhryGN4t+ux
         HLxA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	Petr Vorel <pvorel@suse.cz>,
	Alexey Kodanev <alexey.kodanev@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Stefano Brivio <sbrivio@redhat.com>
Subject: [PATCH 4.14 67/67] Revert "ip6_vti: adjust vti mtu according to mtu of lower device"
Date: Fri,  6 Apr 2018 15:24:37 +0200
Message-Id: <20180406084348.954911674@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003832036889355?=
X-GMAIL-MSGID: =?utf-8?q?1597004361000510724?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit e6cfc525163ea3375113a9dcc234c2cdd8dbf643 which is
commit 53c81e95df1793933f87748d36070a721f6cb287 upstream.

Ben writes that there are a number of follow-on patches needed to fix
this up, but they get complex to backport, and some custom fixes are
needed, so let's just revert this and wait for a "real" set of patches
to resolve this to be submitted if it is really needed.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Petr Vorel <pvorel@suse.cz>
Cc: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_vti.c |   20 --------------------
 1 file changed, 20 deletions(-)

--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -626,7 +626,6 @@ static void vti6_link_config(struct ip6_
 {
 	struct net_device *dev = t->dev;
 	struct __ip6_tnl_parm *p = &t->parms;
-	struct net_device *tdev = NULL;
 
 	memcpy(dev->dev_addr, &p->laddr, sizeof(struct in6_addr));
 	memcpy(dev->broadcast, &p->raddr, sizeof(struct in6_addr));
@@ -639,25 +638,6 @@ static void vti6_link_config(struct ip6_
 		dev->flags |= IFF_POINTOPOINT;
 	else
 		dev->flags &= ~IFF_POINTOPOINT;
-
-	if (p->flags & IP6_TNL_F_CAP_XMIT) {
-		int strict = (ipv6_addr_type(&p->raddr) &
-			      (IPV6_ADDR_MULTICAST | IPV6_ADDR_LINKLOCAL));
-		struct rt6_info *rt = rt6_lookup(t->net,
-						 &p->raddr, &p->laddr,
-						 p->link, strict);
-
-		if (rt)
-			tdev = rt->dst.dev;
-		ip6_rt_put(rt);
-	}
-
-	if (!tdev && p->link)
-		tdev = __dev_get_by_index(t->net, p->link);
-
-	if (tdev)
-		dev->mtu = max_t(int, tdev->mtu - dev->hard_header_len,
-				 IPV6_MIN_MTU);
 }
 
 /**
