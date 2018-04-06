Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49y3DYsKnuuXU4/IzB9fe5GKkonQqmXNkUANMC3nfqYR0H3jyBJ30eKgBElCbjVVRbAtBJk
ARC-Seal: i=1; a=rsa-sha256; t=1523022230; cv=none;
        d=google.com; s=arc-20160816;
        b=pWeu9/4G4aEun02bAQ9ePPQkZIjaj/DYPYQvSzpL9B8t3UEJn0soHIXscvx20acHFZ
         hwhdwrhuei2Pk77A41Hi1WEI3E59B+ASzsE17/eMxK5pVLAHTwLjsf0PHInsNStBcDqa
         TJrem/nzz7RnR2O7k7NSfPTLS9uSkAK+6TiWyzEoIrzHoWpVxkdUoJlYRI+s9F7cJNs+
         ulzXYjcP23q8C704lf2yLtxPP1sNXmQOx2Op/9iSlsM0Jj+Hf7lhSQLDP67DkGMcbp4a
         xXGtUWEnM2Od9/dkv1QLlsl0zg/61BDN7JwQ2CloA0ECk0dfyhsyuUln8c/+9PeBfqxE
         YvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Gv0UXK9dZ4JGNVi7aQI4H3e5TwCso/IreQTynL4POEY=;
        b=vx+4pt7u672ltBKLTmO6rXkn66bS3IGvKzm4bq4UIGpkfEvRqK/g6ppgo6L6ka6jSw
         k2WFrTwuLtIElZzgvLjL5zXE00kuw5x9bL9VqY9DsIIptvT6gpmd+ETXhtjmy+KUssn7
         IQGHyZH0qY7M6GFpoWPGRO2/47mBQQ2Cz3+LJkcufGOJeoL7olqE4wFOeIjrqqehkz7+
         Ln1rHgrKPgv+7Ceb5aMWdqMBA0jTpTPmR7oOfMkagXHa0K+ZTVAwcq9i6K+OStPTsOq/
         qQMBNKvT5wf4yINtKo1uB9r0WxtYNl+hCU5WY724+7MPH6EwDC3k9ZPq5MinqmOJxk35
         dEnQ==
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
Subject: [PATCH 4.15 72/72] Revert "ip6_vti: adjust vti mtu according to mtu of lower device"
Date: Fri,  6 Apr 2018 15:24:47 +0200
Message-Id: <20180406084354.177967735@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003832036889355?=
X-GMAIL-MSGID: =?utf-8?q?1597004558438285627?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 813b2dad2cb59d2759f1538e65d56dcccdb18a94 which is
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
