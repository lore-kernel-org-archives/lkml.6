Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvE06vmLyjFb1OAyR4lHMW90dMWT8fDiQAtxIoo+4i39xfsV6Pz494eKjgMpg5wCLRksCwy
ARC-Seal: i=1; a=rsa-sha256; t=1521800115; cv=none;
        d=google.com; s=arc-20160816;
        b=IXH3e7ZIp6z0O+61W/W0HqHlni1qhgZqBWaZA6P/n+rerEsbGbmwe7HsVbLt9KyLiq
         I19xvMX5LZCM/5KOi0Dn+JPBirlxyNDwFnT0g1uTa+I89F1RYMD04k1qrFPPQSoQXKWV
         29CeQeT0Tvcqbocd88XrGmWUZ4nVh9nH2xWVPlY19xpeXXUYEk/67VYhB625KkShoLyT
         E6XcJMCP4kxd3NfAjpXz5YpmA58VLrRQAbaeQs7BO4l7IHJIOUWhmALMpnEOWS/zvlol
         w4QKmxw3/mJvxn/lvRbETQczNNM5/D05jongWGOthZ4Yn2fDjuhvi/cfb7r4R2Rya6Ew
         xnkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rG1gKJcnujbVrE9RytPDqoRAVz6scRhqIST/Qvn1vJ4=;
        b=W7OA/0QB1gAlPP19OfxwuNK7m/viYC9npCoPq2xp9ay2qGv26jMAK9/vk7xubi76WC
         uwEeOmR3UbXQJdjp68gGbFynZ3ynQK2kgwOJBp5b3bOQrn8tTpau3g+rWhCtkdoYhu9G
         yaRbjsL+JoIsjLs20o9R0zEtGedyTS2VnuuXiSoynRhwIK4dSV5kyPequ64EP7wv+/La
         fNzN+4V3PYC81SToX6XCLa5JQW5Ucbn0qZER0Jxx8kpIHPZmrk4UCGOonos5YX8sf6BX
         sKsSiw0c4NteiP7/szsKhQVWZAp3DfMsT6VlInE3+18Hxv57bVQH8Gfe7NyhwaGxeP0k
         a0Ag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yang Song <yangsong@vmware.com>,
	Jarno Rajahalme <jarno@ovn.org>,
	Joe Stringer <joe@ovn.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 39/97] openvswitch: Delete conntrack entry clashing with an expectation.
Date: Fri, 23 Mar 2018 10:54:26 +0100
Message-Id: <20180323094159.856017645@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722580602323313?=
X-GMAIL-MSGID: =?utf-8?q?1595723078119329995?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jarno Rajahalme <jarno@ovn.org>


[ Upstream commit cf5d70918877c6a6655dc1e92e2ebb661ce904fd ]

Conntrack helpers do not check for a potentially clashing conntrack
entry when creating a new expectation.  Also, nf_conntrack_in() will
check expectations (via init_conntrack()) only if a conntrack entry
can not be found.  The expectation for a packet which also matches an
existing conntrack entry will not be removed by conntrack, and is
currently handled inconsistently by OVS, as OVS expects the
expectation to be removed when the connection tracking entry matching
that expectation is confirmed.

It should be noted that normally an IP stack would not allow reuse of
a 5-tuple of an old (possibly lingering) connection for a new data
connection, so this is somewhat unlikely corner case.  However, it is
possible that a misbehaving source could cause conntrack entries be
created that could then interfere with new related connections.

Fix this in the OVS module by deleting the clashing conntrack entry
after an expectation has been matched.  This causes the following
nf_conntrack_in() call also find the expectation and remove it when
creating the new conntrack entry, as well as the forthcoming reply
direction packets to match the new related connection instead of the
old clashing conntrack entry.

Fixes: 7f8a436eaa2c ("openvswitch: Add conntrack action")
Reported-by: Yang Song <yangsong@vmware.com>
Signed-off-by: Jarno Rajahalme <jarno@ovn.org>
Acked-by: Joe Stringer <joe@ovn.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/openvswitch/conntrack.c |   30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -361,10 +361,38 @@ ovs_ct_expect_find(struct net *net, cons
 		   u16 proto, const struct sk_buff *skb)
 {
 	struct nf_conntrack_tuple tuple;
+	struct nf_conntrack_expect *exp;
 
 	if (!nf_ct_get_tuplepr(skb, skb_network_offset(skb), proto, net, &tuple))
 		return NULL;
-	return __nf_ct_expect_find(net, zone, &tuple);
+
+	exp = __nf_ct_expect_find(net, zone, &tuple);
+	if (exp) {
+		struct nf_conntrack_tuple_hash *h;
+
+		/* Delete existing conntrack entry, if it clashes with the
+		 * expectation.  This can happen since conntrack ALGs do not
+		 * check for clashes between (new) expectations and existing
+		 * conntrack entries.  nf_conntrack_in() will check the
+		 * expectations only if a conntrack entry can not be found,
+		 * which can lead to OVS finding the expectation (here) in the
+		 * init direction, but which will not be removed by the
+		 * nf_conntrack_in() call, if a matching conntrack entry is
+		 * found instead.  In this case all init direction packets
+		 * would be reported as new related packets, while reply
+		 * direction packets would be reported as un-related
+		 * established packets.
+		 */
+		h = nf_conntrack_find_get(net, zone, &tuple);
+		if (h) {
+			struct nf_conn *ct = nf_ct_tuplehash_to_ctrack(h);
+
+			nf_ct_delete(ct, 0, 0);
+			nf_conntrack_put(&ct->ct_general);
+		}
+	}
+
+	return exp;
 }
 
 /* Determine whether skb->nfct is equal to the result of conntrack lookup. */
