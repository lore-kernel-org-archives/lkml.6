Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoVOPGG4q/hXJP1T5wJOBXGXAw2T5Ysmbz+4ke2jR86ZVjveoAfAZB/uWLHPD+3CY/XZq1a
ARC-Seal: i=1; a=rsa-sha256; t=1524837918; cv=none;
        d=google.com; s=arc-20160816;
        b=xnPHIUSkDCB2TanitE3eFDn8Hes19bjER60ikS4Pd15kCiYRX8a3hwfhA6ihl97o7R
         3AKWs0tXa/SrdUgfRnfA3rlA/r56f1bMqOX0vkdjK8d70mCfuTbHrNjPnS4JQle47eie
         VqEiDW55er5Ay1gMVwUikq/SQBsLEl48xOScjRT7iPchOLvmscdv5Kz8bi3g03NynNbn
         hCHZXXKEVDzbgz7AlejF2mNqPVVezjr6OW/w9M3GjNSVPlyJxUqtFqI8+TeEbBHQa4Y9
         gCrT5rCdI4cZbQebcDYU25KBPmR5/mnhbwEezhaTz1qpXq5GeVcNG/mn+hdnQifOaWhn
         hTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=A2wa7AdGOveQw6iTPLTjqZ6bun4Q/h/j0V84mApgbaI=;
        b=eyg5GKRiLxAIQKN1O/ulEPJvUnUxIKkI6qx0Q1GS7lvlckUljafnAGMLtnzQsUrhsb
         0bgJ9PJqnMXnQ0iySAlPuvCT6eLsSKLCj80YyQpGBnkmchBlwjIs58rEiHcwWu6kzoXP
         pO9fzFnXIwOiMwTnmsyc7RJOAdmq8jcI7xI7GLcswWJx79PBIDsagVX7JabQSGdvrDp8
         KZMMzOe3e+3GWPHTHX68e9N5RNTnI7ULvGSvW7eefTKRV7OqiQ3cwzEr26dFr0ui6TiH
         pu90fZPWErJbVKs58Qoc+qK18PYJk22kpCQkoDdqrG2ptpRGefHaSsG1ex+JtyLF90Zo
         nwFw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2321621890
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
Subject: [PATCH 4.9 67/74] ipv6: add RTA_TABLE and RTA_PREFSRC to rtm_ipv6_policy
Date: Fri, 27 Apr 2018 15:58:57 +0200
Message-Id: <20180427135712.717204643@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908121828703202?=
X-GMAIL-MSGID: =?utf-8?q?1598908444947438348?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2811,6 +2811,7 @@ void rt6_mtu_change(struct net_device *d
 
 static const struct nla_policy rtm_ipv6_policy[RTA_MAX+1] = {
 	[RTA_GATEWAY]           = { .len = sizeof(struct in6_addr) },
+	[RTA_PREFSRC]		= { .len = sizeof(struct in6_addr) },
 	[RTA_OIF]               = { .type = NLA_U32 },
 	[RTA_IIF]		= { .type = NLA_U32 },
 	[RTA_PRIORITY]          = { .type = NLA_U32 },
@@ -2820,6 +2821,7 @@ static const struct nla_policy rtm_ipv6_
 	[RTA_ENCAP_TYPE]	= { .type = NLA_U16 },
 	[RTA_ENCAP]		= { .type = NLA_NESTED },
 	[RTA_EXPIRES]		= { .type = NLA_U32 },
+	[RTA_TABLE]		= { .type = NLA_U32 },
 };
 
 static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
