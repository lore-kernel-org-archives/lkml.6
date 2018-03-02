Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuZ49OyYvovwSmVDdZb+W1sl43KfsPWQ9wAWjy7i0OmVRsiBSAQMBT2VHnQQKLrKJN8Sp5q
ARC-Seal: i=1; a=rsa-sha256; t=1519980989; cv=none;
        d=google.com; s=arc-20160816;
        b=j02t9aNQbYYA2479vdGCJ5M+K1W9Zle0aMXXSjmGDkNVtgALcwtNAJwp/QptPtJOfY
         SG52L5gV+03TW/sDM0/JhMLr4+GVKoA3xYUDfeW7Rl4CYKzcAc/dX39c6TwKWmVLbXr4
         MdbY+PlpuijeETu4ILZhz4uHuyhDtK9bzjTqzVkJHxRzoV8z3FeKTeZoxG1PYt/TeODi
         DYegsH2R1NsuZ76lkWo/CooT+wu5U40xKvhem61XLf+FWsy5R1p/IevJUXJd38wHfZqb
         XsS5UsVzTn6iBY5de5wXuWbVgFyNxl9ar1JkhLrffpATz2CsYBAZoVHLn4WLrxsfVpBM
         sRmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MXO7DuXnwk6CAHXv++9jXiZDYMsxk+OAXYCDQle96R8=;
        b=N90N1g3JDmtr39hDMYKtHnQwx4zD6AoEFYv7XHunK7nbg9WYeiGFyc4/apl/sKAHDR
         ifVnfrI6U5t1jmqf4OV+fG7Wa1PB3OGgq2MfV2b+voPHyJ/reEoS+kBCiDoWOER0GN1P
         GozSvmvqqwivrIBj6aDXeBECFULkOZJP1Prum/LhrjmpSRaPmHIUY7ZmRViDk4bYCdtb
         cEzDidfSqPG4hP03GHFlPQx5EKqVhIFkV8mX6zev6ztovKLyLOjFiFIp3DPsx9uZAHGn
         cK51NbSDZFkxva4NpgMaqjAdHJTqFsYNQrMKHz4ZwC1vARtcDPx0AumOGbnuMWrIY7CL
         k08A==
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
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 09/56] ipv6: icmp6: Allow icmp messages to be looped back
Date: Fri,  2 Mar 2018 09:50:55 +0100
Message-Id: <20180302084450.098758743@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815416857818806?=
X-GMAIL-MSGID: =?utf-8?q?1593815586484283180?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1651,6 +1651,7 @@ struct dst_entry *icmp6_dst_alloc(struct
 	}
 
 	rt->dst.flags |= DST_HOST;
+	rt->dst.input = ip6_input;
 	rt->dst.output  = ip6_output;
 	atomic_set(&rt->dst.__refcnt, 1);
 	rt->rt6i_gateway  = fl6->daddr;
