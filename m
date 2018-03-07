Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu/2v+o22abeegJ9cJ8NLk62rFL1tAOIzVwi9YAiEUvxD33IClLpSsQHLRiczpXR73nnCX0
ARC-Seal: i=1; a=rsa-sha256; t=1520451962; cv=none;
        d=google.com; s=arc-20160816;
        b=aQp4Vop5R/HukUsOGP4yUeiZ5x+8bDdQV1ZpREHMD56OuewPTOeKDmraP3woLqHFIp
         4V+fVOKrYgclRBeNyAinygyGK1Vcgm+sf8tm69BrrFai802NdJjsNma8Q1Q0c7R6V9fB
         /kNqM0MyeepD9ugsjQ0fJgUNNlH9p+vv8wK2QDmkMqb4AL86Au2P3LrzozjWwb0kiGAj
         Wr4iRL6bxE/+I7KOHS+QNEAhOUGylwBb/CS1tp2otg+gRLcLxwSGsr39Jv7m3aqGASUY
         7cSCvy/qttEXmaTkbsSCyZPAcTLttv17rtUbGv8qTx3hkvtBpAIbRpKBk6O+tOoHK72l
         53vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RvYIcvU61ivm+3eFfEu/8nQVXqQaqIaw1jdVLaA4tHY=;
        b=clJozIOEhe8hCB3CbsFV4P6RF+sKZ1mtJZovvyidY5msF3j+ycdxozPJCipO+gXCvv
         SnwQ4SWUwLJ9CPHSBYHBTzKFzts2Pswbe9DjKhtwA50B+KaXmNJVFIOfDZTA2RKbYxhl
         zFFlLFO1yePnuA7WnCioJg+oqP26bgYoBOowEQBW4RfhqHqU8q/HPzSi1XGGkg3vOc5t
         ejtPv7sBtfRQTmp5lDBNvX4lxN3JUVbzE9zHfCUX/57Etm7YeQrIfwWIuSio8jEKLpND
         rx8+NWum8DNa294u7qXLqn9yqJeevA4HQPtz5G2YCSfunn7bcFrP6s5SvRx4TWiP3hS/
         ynNw==
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
Subject: [PATCH 4.14 048/110] sctp: fix dst refcnt leak in sctp_v4_get_dst
Date: Wed,  7 Mar 2018 11:38:31 -0800
Message-Id: <20180307191045.865516721@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309148513653241?=
X-GMAIL-MSGID: =?utf-8?q?1594309437047192040?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
