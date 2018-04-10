Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49vhg2r/Ecqp41EBUkoUkcJt8hl4YkkhuthSI4uMlKoVOLJOexYKvAu9h8hl/h8K//ypEVW
ARC-Seal: i=1; a=rsa-sha256; t=1523399488; cv=none;
        d=google.com; s=arc-20160816;
        b=mo9YXjjPAwo2ehVEt9YYe5NdJ1reUUy/TMI32XNUIAzLGfrfEG8b8Lx+yO0bsPTS7F
         612MGAADLLUhJsPRyW2Wia91WU+gddSEJmYGdooacWrerUFl1ND2FvxubF9cCai8sZI/
         S82/WbOjsA0lXF2OrxONcYGxTRv1v09AvqmyAO/al30tEL9qMdcAvhtVVn+AkspYlHt5
         kdHWmHlZJx7I39uvESoWtqshGRyDKuO6bA7WAdfB/4oV2z43Pocrd8rl62HH3drI2R4s
         RdpO/PlaSqtLeeEude2n9JJoiIuNdPFD0GWDLtAiJ31QAWOwXQYhgUwDcq68oYGGbfOR
         DdkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yZDFanwnwjK/GCeVQS3dYQEHz1/G7MlapZcauY3SiKw=;
        b=rRUBY7/lJ0DfjvCxSkDcFh4llXUAIgn14H+CAPr7a7xRhmibpVpF/vgL0RKAE9u3R7
         xJXf7IGv8nlbPmWl771pYBWNLp0Od/ML63ut7YTMHOSpPYn9GbUN8bEx5YejbYSlV2ru
         EwLr88Fo16O4GiMMjJgYwApnMpppkBZQWiJaK8FAnI/OBKLVsbGjZSWUcwOxmsCynHCh
         jaHrUH8eVkoM4Lxv/bW4I5Pf5rP6MmV9hvrxeW9ESxnFTR61soO1yELA7zNLkG+7UVBP
         YhPsgDfrUvocrQj26TDG+6umLpqaaxMYZr9i9YBBuPCfumoQSaj5OhVGjND0/JI6Mv84
         lmeA==
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
Subject: [PATCH 4.15 126/168] net/ipv6: Fix route leaking between VRFs
Date: Wed, 11 Apr 2018 00:24:28 +0200
Message-Id: <20180410212806.062178301@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400142276464050?=
X-GMAIL-MSGID: =?utf-8?q?1597400142276464050?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -922,6 +922,9 @@ static struct rt6_info *ip6_pol_route_lo
 	struct rt6_info *rt, *rt_cache;
 	struct fib6_node *fn;
 
+	if (fl6->flowi6_flags & FLOWI_FLAG_SKIP_NH_OIF)
+		flags &= ~RT6_LOOKUP_F_IFACE;
+
 	rcu_read_lock();
 	fn = fib6_lookup(&table->tb6_root, &fl6->daddr, &fl6->saddr);
 restart:
