Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/dYS5s+Z07XKwPFksUIuoxBVmS6s1z8i1wxyc3rsslI/T5u+yLCOFC5PuAXYS1+D54Zuz0
ARC-Seal: i=1; a=rsa-sha256; t=1523472671; cv=none;
        d=google.com; s=arc-20160816;
        b=QUu3DOd6lFAdXVybM8oX4zeKfRidoNZMtHzDGYuBbcoTYW0+DtTPI7t2TGvW51M0/G
         O2k+XFZ4k0rMyvltaUwPs4kG2KZ+/yY6O//LPNL9FJhECjoiFXnHl3gMRkCr18PuAgO4
         5RDY2rcmUz4tQqKiVJGdL+b0/4FiUhXtz3KGHNoGOaSHQbRhssIBuExE4fy1LK5orybe
         rSQqf5G25t0kVVHSYFvDUY/vpxUQZzUrc6/jnvBV25xAzSwMS8g5BoKmNel8TemcXjVs
         ZjJdlIZnI6b/oxrRjplYDJPTC/S6Vdshk9kdCcujRq2S6gMrB48nV6Ss57R8ZRCSpR77
         z11w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QlAMZWzETliGD53Sgy9iP0mZKKvn/y485Nu+/SUkMJI=;
        b=FBcn9H6w8n0KzQfQ2AqTR4+NlibM6ThK/LO2S8+guurDUFZY6Uo1goY5fcYMr5wMPH
         AV27YnNPUF7HbILoK+pD8aRudAfefrcv5rMfGvIZCuVf5oGHmP4d0v0jqdxPRqnGQnFC
         BVgWGej280udzq9iDSM3meML4iibTIinjhqd8OprhIaBsyKKOcnsFsJyce2zD6EV2EYf
         MV4q7Xv3W4ZgDn9ggFuLm+hVYd8SDcz2+Kb+08yLziX6jnZWtwl0H1gGtfaycqqRv6Pu
         zomvmTYo0VKBUrrMzwa3vfHQmKHrJWoFjnqyiNu77ybXDECyhBHIME9iGovKCjFO2RDT
         ecFA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Donald Sharp <sharpd@cumulusnetworks.com>,
	David Ahern <dsahern@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 168/190] net/ipv6: Fix route leaking between VRFs
Date: Wed, 11 Apr 2018 20:36:54 +0200
Message-Id: <20180411183602.330118361@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476880189975813?=
X-GMAIL-MSGID: =?utf-8?q?1597476880189975813?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Ahern <dsahern@gmail.com>


[ Upstream commit b6cdbc85234b072340b8923e69f49ec293f905dc ]

Donald reported that IPv6 route leaking between VRFs is not working.
The root cause is the strict argument in the call to rt6_lookup when
validating the nexthop spec.

ip6_route_check_nh validates the gateway and device (if given) of a
route spec. It in turn could call rt6_lookup (e.g., lookup in a given
table did not succeed so it falls back to a full lookup) and if so
sets the strict argument to 1. That means if the egress device is given,
the route lookup needs to return a result with the same device. This
strict requirement does not work with VRFs (IPv4 or IPv6) because the
oif in the flow struct is overridden with the index of the VRF device
to trigger a match on the l3mdev rule and force the lookup to its table.

The right long term solution is to add an l3mdev index to the flow
struct such that the oif is not overridden. That solution will not
backport well, so this patch aims for a simpler solution to relax the
strict argument if the route spec device is an l3mdev slave. As done
in other places, use the FLOWI_FLAG_SKIP_NH_OIF to know that the
RT6_LOOKUP_F_IFACE flag needs to be removed.

Fixes: ca254490c8df ("net: Add VRF support to IPv6 stack")
Reported-by: Donald Sharp <sharpd@cumulusnetworks.com>
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -851,6 +851,9 @@ static struct rt6_info *ip6_pol_route_lo
 	struct fib6_node *fn;
 	struct rt6_info *rt;
 
+	if (fl6->flowi6_flags & FLOWI_FLAG_SKIP_NH_OIF)
+		flags &= ~RT6_LOOKUP_F_IFACE;
+
 	read_lock_bh(&table->tb6_lock);
 	fn = fib6_lookup(&table->tb6_root, &fl6->daddr, &fl6->saddr);
 restart:
