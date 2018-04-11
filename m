Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49j5YQY0B1gN0j85RKeUrrF2u/H/EgWQylKdtcalC61xVxwWX8+PYz4pg4MjbE9totmY0m3
ARC-Seal: i=1; a=rsa-sha256; t=1523473283; cv=none;
        d=google.com; s=arc-20160816;
        b=BD25uAtX4qATU5ZvvPJiaD4aMPfSdTigFOnxKQwRI7jqrzTbYm927OWJlr16cZNZV+
         fdflFxIb5EfFWnSrwx5Xz9WooKf2FKGIj0D2BjSKAa98+4dNlTFE/wlBQFKGrqL3FKIR
         sAqSV+lB77U2kQCaAPH5z78/IPw2ux6i/abElRd4GPQKuGJw3MkibV8VZsszTitun46p
         XzYlkC7G1Iv/dDTzuihBEG7yiDMsK4pzxOeazbbEWAkqyGqdgi+e+8NG8TOWS/xUZLqm
         hMqDurhs6TexPVxwkMR1hDMiwkixx/3jBGG0lnG3u1ekOnWFJXkMu46AwKsty1L/3Ctc
         UIQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wWe8T3lad2L3BIuGKRzdJ4TBHns40ItRUAZLCmNy4wM=;
        b=ja+c/gfZymLUbFeB5B5W01Wq6WAcc+VLwgRF+yrSYsfDts79MEO9JDWTkO37N6dJa+
         JUikzljMIvBrf0fJj14IgdAjtspKsND0uI7yc1cuFpKspzCavi/EApumAxdkr/SyEpSA
         xulqv4OjMEYEjmw+TTAkGdqJbVd/apCMWmHBrIXQkyq/UEs1SMP/FYaEYQV1UTq65KGm
         PJ0MAR3/BXnhqVnxtSm36EViRv37zAoUCMz5sGgro29AApXI97yoEZdGVcZpDn5f1Mce
         F8PjLWlF2+8iOPZY5TTBNrXMxBteP38k9ktpQwy8F+GV4hqVtdcOg3ip/8tu0TiHMVCE
         r7Pg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 192/310] sit: reload iphdr in ipip6_rcv
Date: Wed, 11 Apr 2018 20:35:31 +0200
Message-Id: <20180411183630.851459644@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476727218419788?=
X-GMAIL-MSGID: =?utf-8?q?1597477521777459943?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>


[ Upstream commit b699d0035836f6712917a41e7ae58d84359b8ff9 ]

Since iptunnel_pull_header() can call pskb_may_pull(),
we must reload any pointer that was related to skb->head.

Fixes: a09a4c8dd1ec ("tunnels: Remove encapsulation offloads on decap")
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/sit.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -657,6 +657,7 @@ static int ipip6_rcv(struct sk_buff *skb
 		if (iptunnel_pull_header(skb, 0, htons(ETH_P_IPV6),
 		    !net_eq(tunnel->net, dev_net(tunnel->dev))))
 			goto out;
+		iph = ip_hdr(skb);
 
 		err = IP_ECN_decapsulate(iph, skb);
 		if (unlikely(err)) {
