Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpja6ET0h0NHz411pbCwBs8WwpgxYYqKINWjz7runmv3OgKGEQ+dfkWXBK3HQU87w3JBMMw
ARC-Seal: i=1; a=rsa-sha256; t=1524838046; cv=none;
        d=google.com; s=arc-20160816;
        b=opORuCkLgxocR3hy7NsnD9PCakHX4SpJk1QX973bpBryEMncxBDVKzH2yOauGQ6yr8
         +l6kJtD30VHisSTswY26VipEPIlFmZUKXBKkQ7Hx5yF03rEuC7GO1krGBGNPTmxdeHXc
         Xa6s1h3XHPnFseDfZKbdYaPKNyV4QN6RQStnylFcaA7QZvakcQgpsYKf74rW9ZFSi711
         3/0dIeP6iGatARq8K62oMdb/pLaOfnXcRScwR0XgywhFy+PBhX1e74mHYh/+hLsF3PRf
         T4PVYzzGN73+PgvzAFZ5PbiaROPjU6fdRQeYbDWSAQM1ABBkDh8hCPTkK6B/gkP/kW0b
         kAmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=PfZO5/kB52EWxITM/aW/CuCzVSZM93fvXrr3v29B4A0=;
        b=ukfYlmuebkF9ZYZqdl4z8gT02noE9Rbnwb6IsswqeRP8jiFstaIRkFn6gBU2wYV5K0
         M/R1BoLT7YfVOBbp/6wfV3//9q2f2E9V5exj6F4AQyNXUjGNdZVNuZnCcYfbpk6wLT87
         +0Wv+gISIvLpw27+uOAeaRKZBhunz31jBcA+WD2HF0Jtlgc5SP1lK18Y8mli0YEc5n9b
         zyWT2FBxxMiAp0V5okpeMQQpv74YbzFQ5woSQ8AoBZonZ9kxigP/HR+KCw4m1S+ZWxaQ
         vMAxDb2cWamstzwxTNpteFpaG722AhvHBUkHmApRHZqXl3gyV/BFvM9SPHpptt0VVHJ6
         Jggw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5310A218C5
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
Subject: [PATCH 4.14 09/80] ipv6: add RTA_TABLE and RTA_PREFSRC to rtm_ipv6_policy
Date: Fri, 27 Apr 2018 15:58:02 +0200
Message-Id: <20180427135733.408783956@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908121828703202?=
X-GMAIL-MSGID: =?utf-8?q?1598908579157234418?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2959,6 +2959,7 @@ void rt6_mtu_change(struct net_device *d
 
 static const struct nla_policy rtm_ipv6_policy[RTA_MAX+1] = {
 	[RTA_GATEWAY]           = { .len = sizeof(struct in6_addr) },
+	[RTA_PREFSRC]		= { .len = sizeof(struct in6_addr) },
 	[RTA_OIF]               = { .type = NLA_U32 },
 	[RTA_IIF]		= { .type = NLA_U32 },
 	[RTA_PRIORITY]          = { .type = NLA_U32 },
@@ -2970,6 +2971,7 @@ static const struct nla_policy rtm_ipv6_
 	[RTA_EXPIRES]		= { .type = NLA_U32 },
 	[RTA_UID]		= { .type = NLA_U32 },
 	[RTA_MARK]		= { .type = NLA_U32 },
+	[RTA_TABLE]		= { .type = NLA_U32 },
 };
 
 static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
