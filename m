Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/uDit56nZ+q7/G6NhSgrHIxr+nekFY8QwbxDTdpNHljf3ypiXot7hk/2VB2r8WDI3HXONh
ARC-Seal: i=1; a=rsa-sha256; t=1522346525; cv=none;
        d=google.com; s=arc-20160816;
        b=gub87SEQw97QWw/rWZVUqqEmcgBoakzPEHQiDxSmiRAYgOPz6UaDd0pYpXXdtth7hI
         cD01mW/QYByfR8e4Eh4TW43mJmuSjKpTZM3radT0Nm74LkfrLkKJToF3NkXG7NbfJU7S
         tHOeRSPMq9k3ZWMxu73bMR6a8x7zihNJ4l6TQWfDuLc6Ud540JENRRjSp1CihZbxD2Mc
         4+zD98OMAngz0LTm1dTpK9CcsSNm4tkjMebwsYP0bLcuPWoHqew0zoG75YSjJgWeRHwt
         LkBa1cO+ZiYBvTNvq/teWUwoy34velrrYudzUfc37CRF5kGuJnWbXi+7Knv2lnYpNPra
         D+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gu8nIKo1SR78OdYOk9jbi/ZVYlLrYIep7NpCUpPwTe8=;
        b=HZuuSoe4bmp/tL46jd75D27UMgC0ICs+qeAKmIfqFa1BI0Mh61XYj60DGQ6v3ueXvc
         9gaVDJMAXN530ZgPpGKwG0vTqgQmGFLHt00jVYB7DtzCBkguJXdGIoCdMRcna1u8kcNN
         Mq9F5CnlYhn9n5g3aar6Ka8oK5DQWhxbUR8tHpKSpSfrGmIWUCIHJBHqK9MSyZV+xBAr
         dJHolLSO3cwH7eZmj/6pyIdl1BGvZz5Op+DG+qRAFyBE5irviPaURHkx8TV+RpwxP/2l
         sID4MMeC4Mc+Cj+EMk7tOHwm19R/wUkp5x8NdUO5dHukviHFZ86WMLfu6Cjb8ghccERM
         rd+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xiumei Mu <xmu@redhat.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	David Ahern <dsahern@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 16/47] ipv6: Reflect MTU changes on PMTU of exceptions for MTU-less routes
Date: Thu, 29 Mar 2018 19:59:57 +0200
Message-Id: <20180329175730.282656709@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296030104659502?=
X-GMAIL-MSGID: =?utf-8?q?1596296030104659502?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefano Brivio <sbrivio@redhat.com>


[ Upstream commit e9fa1495d738e34fcec88a3d2ec9101a9ee5b310 ]

Currently, administrative MTU changes on a given netdevice are
not reflected on route exceptions for MTU-less routes, with a
set PMTU value, for that device:

 # ip -6 route get 2001:db8::b
 2001:db8::b from :: dev vti_a proto kernel src 2001:db8::a metric 256 pref medium
 # ping6 -c 1 -q -s10000 2001:db8::b > /dev/null
 # ip netns exec a ip -6 route get 2001:db8::b
 2001:db8::b from :: dev vti_a src 2001:db8::a metric 0
     cache expires 571sec mtu 4926 pref medium
 # ip link set dev vti_a mtu 3000
 # ip -6 route get 2001:db8::b
 2001:db8::b from :: dev vti_a src 2001:db8::a metric 0
     cache expires 571sec mtu 4926 pref medium
 # ip link set dev vti_a mtu 9000
 # ip -6 route get 2001:db8::b
 2001:db8::b from :: dev vti_a src 2001:db8::a metric 0
     cache expires 571sec mtu 4926 pref medium

The first issue is that since commit fb56be83e43d ("net-ipv6: on
device mtu change do not add mtu to mtu-less routes") we don't
call rt6_exceptions_update_pmtu() from rt6_mtu_change_route(),
which handles administrative MTU changes, if the regular route
is MTU-less.

However, PMTU exceptions should be always updated, as long as
RTAX_MTU is not locked. Keep the check for MTU-less main route,
as introduced by that commit, but, for exceptions,
call rt6_exceptions_update_pmtu() regardless of that check.

Once that is fixed, one problem remains: MTU changes are not
reflected if the new MTU is higher than the previous one,
because rt6_exceptions_update_pmtu() doesn't allow that. We
should instead allow PMTU increase if the old PMTU matches the
local MTU, as that implies that the old MTU was the lowest in the
path, and PMTU discovery might lead to different results.

The existing check in rt6_mtu_change_route() correctly took that
case into account (for regular routes only), so factor it out
and re-use it also in rt6_exceptions_update_pmtu().

While at it, fix comments style and grammar, and try to be a bit
more descriptive.

Reported-by: Xiumei Mu <xmu@redhat.com>
Fixes: fb56be83e43d ("net-ipv6: on device mtu change do not add mtu to mtu-less routes")
Fixes: f5bbe7ee79c2 ("ipv6: prepare rt6_mtu_change() for exception table")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
Acked-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |   71 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 29 deletions(-)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1510,7 +1510,30 @@ static void rt6_exceptions_remove_prefsr
 	}
 }
 
-static void rt6_exceptions_update_pmtu(struct rt6_info *rt, int mtu)
+static bool rt6_mtu_change_route_allowed(struct inet6_dev *idev,
+					 struct rt6_info *rt, int mtu)
+{
+	/* If the new MTU is lower than the route PMTU, this new MTU will be the
+	 * lowest MTU in the path: always allow updating the route PMTU to
+	 * reflect PMTU decreases.
+	 *
+	 * If the new MTU is higher, and the route PMTU is equal to the local
+	 * MTU, this means the old MTU is the lowest in the path, so allow
+	 * updating it: if other nodes now have lower MTUs, PMTU discovery will
+	 * handle this.
+	 */
+
+	if (dst_mtu(&rt->dst) >= mtu)
+		return true;
+
+	if (dst_mtu(&rt->dst) == idev->cnf.mtu6)
+		return true;
+
+	return false;
+}
+
+static void rt6_exceptions_update_pmtu(struct inet6_dev *idev,
+				       struct rt6_info *rt, int mtu)
 {
 	struct rt6_exception_bucket *bucket;
 	struct rt6_exception *rt6_ex;
@@ -1519,20 +1542,22 @@ static void rt6_exceptions_update_pmtu(s
 	bucket = rcu_dereference_protected(rt->rt6i_exception_bucket,
 					lockdep_is_held(&rt6_exception_lock));
 
-	if (bucket) {
-		for (i = 0; i < FIB6_EXCEPTION_BUCKET_SIZE; i++) {
-			hlist_for_each_entry(rt6_ex, &bucket->chain, hlist) {
-				struct rt6_info *entry = rt6_ex->rt6i;
-				/* For RTF_CACHE with rt6i_pmtu == 0
-				 * (i.e. a redirected route),
-				 * the metrics of its rt->dst.from has already
-				 * been updated.
-				 */
-				if (entry->rt6i_pmtu && entry->rt6i_pmtu > mtu)
-					entry->rt6i_pmtu = mtu;
-			}
-			bucket++;
+	if (!bucket)
+		return;
+
+	for (i = 0; i < FIB6_EXCEPTION_BUCKET_SIZE; i++) {
+		hlist_for_each_entry(rt6_ex, &bucket->chain, hlist) {
+			struct rt6_info *entry = rt6_ex->rt6i;
+
+			/* For RTF_CACHE with rt6i_pmtu == 0 (i.e. a redirected
+			 * route), the metrics of its rt->dst.from have already
+			 * been updated.
+			 */
+			if (entry->rt6i_pmtu &&
+			    rt6_mtu_change_route_allowed(idev, entry, mtu))
+				entry->rt6i_pmtu = mtu;
 		}
+		bucket++;
 	}
 }
 
@@ -3521,25 +3546,13 @@ static int rt6_mtu_change_route(struct r
 	   Since RFC 1981 doesn't include administrative MTU increase
 	   update PMTU increase is a MUST. (i.e. jumbo frame)
 	 */
-	/*
-	   If new MTU is less than route PMTU, this new MTU will be the
-	   lowest MTU in the path, update the route PMTU to reflect PMTU
-	   decreases; if new MTU is greater than route PMTU, and the
-	   old MTU is the lowest MTU in the path, update the route PMTU
-	   to reflect the increase. In this case if the other nodes' MTU
-	   also have the lowest MTU, TOO BIG MESSAGE will be lead to
-	   PMTU discovery.
-	 */
 	if (rt->dst.dev == arg->dev &&
-	    dst_metric_raw(&rt->dst, RTAX_MTU) &&
 	    !dst_metric_locked(&rt->dst, RTAX_MTU)) {
 		spin_lock_bh(&rt6_exception_lock);
-		if (dst_mtu(&rt->dst) >= arg->mtu ||
-		    (dst_mtu(&rt->dst) < arg->mtu &&
-		     dst_mtu(&rt->dst) == idev->cnf.mtu6)) {
+		if (dst_metric_raw(&rt->dst, RTAX_MTU) &&
+		    rt6_mtu_change_route_allowed(idev, rt, arg->mtu))
 			dst_metric_set(&rt->dst, RTAX_MTU, arg->mtu);
-		}
-		rt6_exceptions_update_pmtu(rt, arg->mtu);
+		rt6_exceptions_update_pmtu(idev, rt, arg->mtu);
 		spin_unlock_bh(&rt6_exception_lock);
 	}
 	return 0;
