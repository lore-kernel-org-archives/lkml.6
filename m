Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqYCLPafYKg0Nwo8A8NeNA3+g4lgcvdtfifObhicwH60b8LxvaKhvR88WhKtE6edD/XDg+f
ARC-Seal: i=1; a=rsa-sha256; t=1524837752; cv=none;
        d=google.com; s=arc-20160816;
        b=DeME4uJBGTJ9MM9HVJfsYpVGiNXFfR9LvQBTGIIDAUNc3odr7WjI7G6c1EclgnT3cB
         0HK4cmoXryYNzll5TAPNlW74E130zmCFdjkICUc+E++yxvGZgXMP3R1oqSz2RdYOVqOS
         ORFd+vEJUOJKMC1zlx719MN+B53ZnWxX46u0iwqkturlJ7367HHLy0OxrqVqjiAwPrxe
         0CFPT+SJ0y3mhvBX+LhqvwJea4NuGJqaNKe6EBf0Ad3LAHnC4NshztTk7o7J3aRxKRqB
         a7SyodD5zHsg2wsg7t5FmCodO4tzdfFhbjfkNcX7jjj1FQZMYsoW7XfWCF+DTBL+gLPq
         4mdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=/C3gNVrBDlieze9XzlayRZv9IqKvMvyWtxqpgDuZzbs=;
        b=A5LTOH8XRIak/urMq3Y9FirGcAZmwLOpd9pslR8mDW40lAm3RQUdeXO8MWvV5eBr2Q
         qJP5QrD8qcpYJa+1QiE8puapGihDdkc58vFPngBMxaFNJA/yq+Cdh+/iLpB3YzF8eZ7S
         hYXxIl/NBOa66K3NBGGrauK8YEKG8FePe3EWmKOu+/S8MXUDtuIWa1q1I7lJcT7LcpyL
         r3S/uCCxQTGzM5l73YIea0rsqMeuEeSYhS/478wMXHY0FJ/SJTLdm96f9bZ34K6MTHNZ
         oDsZwMd2Qby7582dnV4J737P6pndg80vjScu3lBMP31AUo2Gxdc8DwY1qtJagYfcHEUz
         mAwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8F421897
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
Subject: [PATCH 4.4 46/50] ipv6: add RTA_TABLE and RTA_PREFSRC to rtm_ipv6_policy
Date: Fri, 27 Apr 2018 15:58:48 +0200
Message-Id: <20180427135658.391226449@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908121828703202?=
X-GMAIL-MSGID: =?utf-8?q?1598908270911505605?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2711,6 +2711,7 @@ void rt6_mtu_change(struct net_device *d
 
 static const struct nla_policy rtm_ipv6_policy[RTA_MAX+1] = {
 	[RTA_GATEWAY]           = { .len = sizeof(struct in6_addr) },
+	[RTA_PREFSRC]		= { .len = sizeof(struct in6_addr) },
 	[RTA_OIF]               = { .type = NLA_U32 },
 	[RTA_IIF]		= { .type = NLA_U32 },
 	[RTA_PRIORITY]          = { .type = NLA_U32 },
@@ -2719,6 +2720,7 @@ static const struct nla_policy rtm_ipv6_
 	[RTA_PREF]              = { .type = NLA_U8 },
 	[RTA_ENCAP_TYPE]	= { .type = NLA_U16 },
 	[RTA_ENCAP]		= { .type = NLA_NESTED },
+	[RTA_TABLE]		= { .type = NLA_U32 },
 };
 
 static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
