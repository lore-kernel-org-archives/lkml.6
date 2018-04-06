Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+cdlulS7kZRFwKw4wTpd8Ludswxk3dBa8ePPL5eHBDxO7sSUTgO0cPeMjFUKDHo+RU7Lp9
ARC-Seal: i=1; a=rsa-sha256; t=1523021538; cv=none;
        d=google.com; s=arc-20160816;
        b=jucOIDFex45TTBzSgbFCzdI2S4/XYvacAS338nbZCQ3IVUdfTDkne4cZjnn+0EVNLL
         lltX6psVF7Tz2e114jlPW/H6qJM5WwEZGK2CI737Cka1GY/FjC9G9NX4opoxBujvWJ6C
         wjul3KWl1qwWn5/5JxLa7Y4SQwT2lrZzlxdEdI7nJ3Uf1UL47os+z4lruPGtlY8ryq+9
         tgj+1HO43cqzeG866vrPurBZVMc1cq71DB+OpTmNA9t6Pit7G+YIj86S9zGDVISX4f6E
         loU6TiXVQt2mduawfEgYrl9NhT8tBzRuEG37kZpdr/pHCRzSrxa+KCDil2hwRU2uilaD
         ZBsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BR9TqmW1nMs0n5ke/hpJfxlYl+s0uEAuBOOK89SMPUU=;
        b=vsR1TKB3Ltu9mO1igqH/iMMkuHe1LDibDsBqIDqDVJb6Echvny/gFDF1EbbbZFx674
         S6FY0D7RvOAG/I2SI8t4KWRwuZthhkemKl2v4BBgbIVTsgHsu5p9Lq1qU3gCDK1ZkJPc
         Q3wQpt+PcroG/GoiRha3uJmGpEvi27UWFDeRaFKfmyq+XhO1Qu7h6x2ncUcI+v/hdceW
         UH0aXlRBwENsOZcGEX9Qoq+rYbJnnGGQJBASwugG9HHxDVArBzHHzIYS7UINcKbdwiq4
         g0Ov+4j7gGgMxzA4M7I5tcfoqHweEy2Moq0jwXocj545MZKcg1y1UiY7CpIpybIkbKKH
         b0rA==
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
Subject: [PATCH 4.4 72/72] Revert "ip6_vti: adjust vti mtu according to mtu of lower device"
Date: Fri,  6 Apr 2018 15:24:13 +0200
Message-Id: <20180406084311.965317203@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003832036889355?=
X-GMAIL-MSGID: =?utf-8?q?1597003832036889355?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 2fe832c678189d6b19b5ff282e7e70df79c1406b which is
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
 net/ipv6/ip6_vti.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index e4b0fb2f06a3..d7105422bc63 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -614,7 +614,6 @@ static void vti6_link_config(struct ip6_tnl *t)
 {
 	struct net_device *dev = t->dev;
 	struct __ip6_tnl_parm *p = &t->parms;
-	struct net_device *tdev = NULL;
 
 	memcpy(dev->dev_addr, &p->laddr, sizeof(struct in6_addr));
 	memcpy(dev->broadcast, &p->raddr, sizeof(struct in6_addr));
@@ -627,25 +626,6 @@ static void vti6_link_config(struct ip6_tnl *t)
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
-- 
2.17.0
