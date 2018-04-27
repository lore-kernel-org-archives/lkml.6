Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpiCCGkdHXZHoz94pP4wzjGknJswJQQ20SgecQnYEoKBfVSvCReTqM2GtmZY9a1VqVb9KVN
ARC-Seal: i=1; a=rsa-sha256; t=1524837610; cv=none;
        d=google.com; s=arc-20160816;
        b=XUamzzhSPIfJZmieviNyU8uRqVg5TrZYrWfAHyVehlyGtH6xLXc7buuqbYvRTQ770Y
         xcfNZUYHH8nDwV3m2MaHRSimL2U3sH8FcfMKnI5iPaw+6ePnnm2Bi0H22KbZKw1ecwTT
         e81WGHBgj+xobc71LMbLTi2IHRFWQzaTDN4C72+wmIfJyPv3CkcrARisrapDuXlZEAON
         wU3551RYKYqI0YhaXvNLPoTN1YNp/derCCNk9Muj1WgiYsH8lQJC8LL+NqWgqvPN8WgI
         hjKXK8RWJmsKZcQOxBBUIXNz76mlECPd0p9hgr8sxOOfOeFbftxbP2Xu1XbBeA9OAjjG
         ScCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=+m+lNOhILdo+zk+q10NzmHTfcsE9L+HoL65Op+iqW/g=;
        b=oaMMDhbHK4Qpl8cCXHqu0WAY/XS2L3Hm2377/XBIy7l/oW2tpOOKCafenm76TNFf7O
         rIiqp5lLryOgdMFqiHI/4mcPIljoDsYLwh6pTXLZvaY5DluiFJU/0Ha+jmxnG1AgLpUo
         +7Hg7yHYxZOBJANVXVpUf3+fkYz30a0JBck+rhBRXGI3OgsiDk3yzw+IOfvw4znzHFsJ
         jjQbRRnlLDqeqtnNqliyAGl3vmJRJ3oHfOycQf3CmCIlZxYQXyOOEvPDZsZi+S3Zhj5L
         niqUIEij6JdKR0/HmROL1vNvir1BwDQQ1hKxn4bm/R1I/IJsvJtROt7EsCnQvR/FL6SV
         dZ3g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463E52185A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	David Ahern <dsahern@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 22/24] ipv6: add RTA_TABLE and RTA_PREFSRC to rtm_ipv6_policy
Date: Fri, 27 Apr 2018 15:57:57 +0200
Message-Id: <20180427135632.489869213@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135631.584839868@linuxfoundation.org>
References: <20180427135631.584839868@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908121828703202?=
X-GMAIL-MSGID: =?utf-8?q?1598908121828703202?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit aa8f8778493c85fff480cdf8b349b1e1dcb5f243 ]

KMSAN reported use of uninit-value that I tracked to lack
of proper size check on RTA_TABLE attribute.

I also believe RTA_PREFSRC lacks a similar check.

Fixes: 86872cb57925 ("[IPv6] route: FIB6 configuration using struct fib6_config")
Fixes: c3968a857a6b ("ipv6: RTA_PREFSRC support for ipv6 route source address selection")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Acked-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2333,11 +2333,13 @@ void rt6_mtu_change(struct net_device *d
 
 static const struct nla_policy rtm_ipv6_policy[RTA_MAX+1] = {
 	[RTA_GATEWAY]           = { .len = sizeof(struct in6_addr) },
+	[RTA_PREFSRC]		= { .len = sizeof(struct in6_addr) },
 	[RTA_OIF]               = { .type = NLA_U32 },
 	[RTA_IIF]		= { .type = NLA_U32 },
 	[RTA_PRIORITY]          = { .type = NLA_U32 },
 	[RTA_METRICS]           = { .type = NLA_NESTED },
 	[RTA_MULTIPATH]		= { .len = sizeof(struct rtnexthop) },
+	[RTA_TABLE]		= { .type = NLA_U32 },
 };
 
 static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
