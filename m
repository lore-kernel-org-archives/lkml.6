Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvti7KyVWzWCUL4K9ubJftE1i4sj3RVH/4UHgpN6keZ+cQkSnlOjqpd+TMkIz5BDrGd7egM
ARC-Seal: i=1; a=rsa-sha256; t=1519981169; cv=none;
        d=google.com; s=arc-20160816;
        b=jHwmKrozRtZ9hKZE7Ttjh7JcBej7wrIfhWus0RAb9cz3CFQZV5ctBxJDwrN5sNVBy3
         BqmH5MwJ6TfzwlCatg27Kl7pTZ0o+J3EXmkh2N20zHMQdJQnZV7R2Mzu2qn2QnO/5JDt
         +JSOT2Hhzo4GKDWhGKmfG0eK5nooAdUYGUnyhzkdyu2TK3TO1zT/g8ujjLvN5njXOyrd
         ZRIa1pg8GgZc8jhF0Ycnral0nh2sx3agDq1lZ5eDJHIaFLd6bpjsoxEHK+IikVe1koBw
         hBqn/EYlzi9YCw52BxzYsiVLGfqWtSEHDtdpGaeGnTga7ytTsn/rC69YAeDsGTesnyAn
         oMNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5nJDcYITWpjAbo0gaKX/ijHwVCPYigy2QJeyKxVZh70=;
        b=0mJBTJmFwmQz4D/lM/buAI+bRmr7acyCjSNwDHE7IoWqZ+JqaF2g2aoipr3yvBVKbP
         7XjIlgWvf+XeBHQ0EgZNkHZ3P2DXJ30cot0CkdxDnaH4edht+YCfZGg/0iwFq+5zE/jq
         PPfFxlOPhpr1zP923+qOD3Tq+hnJePqmpF8fbctzRnKFgtkGhNxDUdzhHJL36AqyleLG
         PucfdSahmXU7WfGTWDvO7fUeHJ61mTzL15eLNRi2FQPiKvCFZUAZJiZxNlTwuGX5xbhD
         /vxEmmloIhQCHlrjSe85hjqd4CzBCo4NvYANihhEymWf72lm1m9fuPCMqvf7yMWxpEBT
         cv3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Brendan McGrath <redmcg@redmandi.dyndns.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 014/115] ipv6: icmp6: Allow icmp messages to be looped back
Date: Fri,  2 Mar 2018 09:50:17 +0100
Message-Id: <20180302084504.443999705@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815416857818806?=
X-GMAIL-MSGID: =?utf-8?q?1593815774594436069?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brendan McGrath <redmcg@redmandi.dyndns.org>


[ Upstream commit 588753f1eb18978512b1c9b85fddb457d46f9033 ]

One example of when an ICMPv6 packet is required to be looped back is
when a host acts as both a Multicast Listener and a Multicast Router.

A Multicast Router will listen on address ff02::16 for MLDv2 messages.

Currently, MLDv2 messages originating from a Multicast Listener running
on the same host as the Multicast Router are not being delivered to the
Multicast Router. This is due to dst.input being assigned the default
value of dst_discard.

This results in the packet being looped back but discarded before being
delivered to the Multicast Router.

This patch sets dst.input to ip6_input to ensure a looped back packet
is delivered to the Multicast Router.

Signed-off-by: Brendan McGrath <redmcg@redmandi.dyndns.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1755,6 +1755,7 @@ struct dst_entry *icmp6_dst_alloc(struct
 	}
 
 	rt->dst.flags |= DST_HOST;
+	rt->dst.input = ip6_input;
 	rt->dst.output  = ip6_output;
 	rt->rt6i_gateway  = fl6->daddr;
 	rt->rt6i_dst.addr = fl6->daddr;
