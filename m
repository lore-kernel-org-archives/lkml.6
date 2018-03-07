Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt+4MxhVjHExpkwaK7aiMYI4fuar6jUOwWwXfr/w+LhMcVN/nq6/yjNpNma5xSgxcMyCyRR
ARC-Seal: i=1; a=rsa-sha256; t=1520451686; cv=none;
        d=google.com; s=arc-20160816;
        b=X7foezc5qN6KWsvzt87ABoLlSS+F4WWoyWHiQFMe+X3fD4y0MZfwJYXCwtNwe3KnFB
         7MoYIX+0MgHYE9+smGH3JQyrKFd60QQWaWDvcW4cN170Fmscmogq4sadwD/amV2fIIlk
         Cowypde0i7XZJiWb+q1GEQX5Q0N0Fq5DYdCtu3bFba2dXW1gHlgDxFaDwMGiqjyZctzw
         g0HKS4wmugsvlL4DLMJtvoh0YeLpYcZm2qNPWlt8X/AjmFw/ib4DjmLhsto73ApL0yRR
         rcu1f/gcdRSQnYRCruypefIgpiAgqwnXafR6KdGhhMZzHQZNUGdNIaNcMwjhWEM0kd4o
         YMYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sNq9GiZp9Vi36JwjF87bBg0HofcksJvatkdRi/7BuaI=;
        b=TLGOuQRX4fZMBzZNaHMDmR3JRWhsUFfzU/Ph4Fv0kGIGJCm71aPCAwo4lLOXcxU1b8
         akSxsiTDhI3UA2XFwo0xq4tH/AKOGdXrfVfSBeKRMnV1c2gBnL443QUesNjL+TfDwxAu
         WlqxhqUIdMKrm6pd//eMXkvdkswFusVUw5rqfePv5xOysAWkgFgQer63+dFt3KP1m1hF
         vSx5+wi5EkKEJOQcdPhvMX3MonlJVtqpRQWtJqW2vV9TNklQkhPglTx21yBustomBJyb
         NvWeJCw0KI2qi3niY2Kx8rDU0Hrwo5CkL2hyzWPFhblhwmSbOdyWg+3iFveDdcoSkdah
         Q9JQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tommi Rantala <tommi.t.rantala@nokia.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 053/122] sctp: fix dst refcnt leak in sctp_v4_get_dst
Date: Wed,  7 Mar 2018 11:37:45 -0800
Message-Id: <20180307191736.798327369@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309148513653241?=
X-GMAIL-MSGID: =?utf-8?q?1594309148513653241?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tommi Rantala <tommi.t.rantala@nokia.com>


[ Upstream commit 4a31a6b19f9ddf498c81f5c9b089742b7472a6f8 ]

Fix dst reference count leak in sctp_v4_get_dst() introduced in commit
410f03831 ("sctp: add routing output fallback"):

When walking the address_list, successive ip_route_output_key() calls
may return the same rt->dst with the reference incremented on each call.

The code would not decrement the dst refcount when the dst pointer was
identical from the previous iteration, causing the dst refcnt leak.

Testcase:
  ip netns add TEST
  ip netns exec TEST ip link set lo up
  ip link add dummy0 type dummy
  ip link add dummy1 type dummy
  ip link add dummy2 type dummy
  ip link set dev dummy0 netns TEST
  ip link set dev dummy1 netns TEST
  ip link set dev dummy2 netns TEST
  ip netns exec TEST ip addr add 192.168.1.1/24 dev dummy0
  ip netns exec TEST ip link set dummy0 up
  ip netns exec TEST ip addr add 192.168.1.2/24 dev dummy1
  ip netns exec TEST ip link set dummy1 up
  ip netns exec TEST ip addr add 192.168.1.3/24 dev dummy2
  ip netns exec TEST ip link set dummy2 up
  ip netns exec TEST sctp_test -H 192.168.1.2 -P 20002 -h 192.168.1.1 -p 20000 -s -B 192.168.1.3
  ip netns del TEST

In 4.4 and 4.9 kernels this results to:
  [  354.179591] unregister_netdevice: waiting for lo to become free. Usage count = 1
  [  364.419674] unregister_netdevice: waiting for lo to become free. Usage count = 1
  [  374.663664] unregister_netdevice: waiting for lo to become free. Usage count = 1
  [  384.903717] unregister_netdevice: waiting for lo to become free. Usage count = 1
  [  395.143724] unregister_netdevice: waiting for lo to become free. Usage count = 1
  [  405.383645] unregister_netdevice: waiting for lo to become free. Usage count = 1
  ...

Fixes: 410f03831 ("sctp: add routing output fallback")
Fixes: 0ca50d12f ("sctp: fix src address selection if using secondary addresses")
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/protocol.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -514,22 +514,20 @@ static void sctp_v4_get_dst(struct sctp_
 		if (IS_ERR(rt))
 			continue;
 
-		if (!dst)
-			dst = &rt->dst;
-
 		/* Ensure the src address belongs to the output
 		 * interface.
 		 */
 		odev = __ip_dev_find(sock_net(sk), laddr->a.v4.sin_addr.s_addr,
 				     false);
 		if (!odev || odev->ifindex != fl4->flowi4_oif) {
-			if (&rt->dst != dst)
+			if (!dst)
+				dst = &rt->dst;
+			else
 				dst_release(&rt->dst);
 			continue;
 		}
 
-		if (dst != &rt->dst)
-			dst_release(dst);
+		dst_release(dst);
 		dst = &rt->dst;
 		break;
 	}
