Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48dqbh6I4KkMteKw2BHJ9FbCYYVsDJl6XhaLtawdpm/Agk+G6etr9lcZWvEAeoeH4hGiHT9
ARC-Seal: i=1; a=rsa-sha256; t=1523399892; cv=none;
        d=google.com; s=arc-20160816;
        b=hYur9o11wPu2Mzr+RAee+NXLReB3XFEivUmjPB42z7ISg3fYOjh5vZvbNSolwEBIzP
         zaYxhehKZPLs0I4UB1qCqnFxEqZzppIbbHwFd1HVv1GaLuyCU/z/zfFjU6k7/VE70SJK
         lhjIvCMiiRjJWx7LtqNgJpA8NGlL7YPM72rN1zCHCzPhrJRk6hiV59BCQb2nRfDYLwUq
         CzrIQnsPcXn2kvwAF/TsK+gajxo5EeyYSAMTDpLfLjr4Fo/KdfL03CciTvXnAgYrHW2P
         80nnYXRs6FJqMDTdYPKV3qp3p2qhbyjfSClGKZbugbfOnSMIrNS/6IfHXxkrSi4mHY5M
         z57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KVeUSv6vUCKk8m8GJml0xXyOSzGvrVSgjTlBn94CJHk=;
        b=cSNu2frgviavuXjdGEs8nHE8e1Tim9CJio60Yrn2wNEj5Bh1gmcPtpGIwjiT6y87fL
         aW3NMO4d5n9b7iqeVXA1FEtPGTLLePFsOI/Eqtibq588p0RiDl3QY6U5F6U5jskhOXLF
         i2rZxTel2egRLaw8AxS6Ydta7Mq3ryCZ5+BhFXuutTdjvhMYdLonHIG+qVIzpfw8PE/K
         V9vtI8noWN6SrF5VFNhZZDdTEOpc32I241nqpyaT9lNbQj/A+4opc4u6m86Wa9Tw3Uhs
         roHGRK468BQqZrkdW+XRIUcl0f84CjRo+/CEchuPjuAO8qPY19ofS3srkEmf9tPgi5aI
         IcSA==
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
Subject: [PATCH 4.14 101/138] net/ipv6: Fix route leaking between VRFs
Date: Wed, 11 Apr 2018 00:24:51 +0200
Message-Id: <20180410212913.918104821@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400142276464050?=
X-GMAIL-MSGID: =?utf-8?q?1597400565900136045?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -871,6 +871,9 @@ static struct rt6_info *ip6_pol_route_lo
 	struct fib6_node *fn;
 	struct rt6_info *rt;
 
+	if (fl6->flowi6_flags & FLOWI_FLAG_SKIP_NH_OIF)
+		flags &= ~RT6_LOOKUP_F_IFACE;
+
 	read_lock_bh(&table->tb6_lock);
 	fn = fib6_lookup(&table->tb6_root, &fl6->daddr, &fl6->saddr);
 restart:
