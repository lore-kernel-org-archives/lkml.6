Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuzUuf0Le7FQsygBALJVPJUdyYGcXF4xcdS+Q5yxxUKXwAfqa4Dl4KxZQOJv8VyynDpVgEC
ARC-Seal: i=1; a=rsa-sha256; t=1520641330; cv=none;
        d=google.com; s=arc-20160816;
        b=rj9a7MdPEh4HNcdWeKk3upNgYKiaduuUKqf7TJiCd4NtPJWN/dGAfOguW2giCOrP84
         I9YIqAxSFMiVY+fH1ydZBE2YtMeacFjR4Ay2YnKXTbTwEvWQmE/zL2+k6B0B/jMkAik8
         gbpXcwTfqGoJSyFfkSeiABpTdkezTjKbz88zLF+ZOm1GKvwDjWwSiJ4/cS+Le7yT1KWX
         rjnbM3Q52vok7I2j1RQw9tlPWjrbkBazTXPMpR5yaherspd1GsXp+wQxxGyhetTbrNxt
         oFFPoXTiPpGwPElDWUJyeSlbvn+UaO2AfqnJtwvfpojevAkjiA/Xo0k2e3mZG+HKayTj
         9WtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RLlrNoaDE5vo00tXLSngeiChKTFn+uNj/iYeT7HpYsU=;
        b=q9ryGA1YDhBJJ7m9p/sx2LoFl72YwxPl0kXcdNdjaPHYgjWiOhFnuLL3SW/YuzHYpF
         gg5JEbZOS34HrteQPnrrZNYxF0CCC2KjHwdwlg/MdTbdEO4yOtT1jSx+b7Vt9BzWQhum
         UuT9tkYQO7HTVJzT9+k0IAwIUfG76e/2BiSCPUKK4fxEf4PonJr+0zebhvoUoqpUjiRW
         wntjR5wCm9WgRW5RaEEVHxdjF4FFVWL1b0eUO7Cc6lH70Pu0K5lYTTuEZOL4+DNdJegY
         d5jhmH/gvSB50zXWXiupOGXTFejGVowsNjjmR9izSoEF9/JQqpDM3OxqilS0JenCWUiI
         cOXw==
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
Subject: [PATCH 4.9 42/65] sctp: fix dst refcnt leak in sctp_v4_get_dst
Date: Fri,  9 Mar 2018 16:18:42 -0800
Message-Id: <20180310001828.363900896@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507910260968462?=
X-GMAIL-MSGID: =?utf-8?q?1594508003781472704?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -510,22 +510,20 @@ static void sctp_v4_get_dst(struct sctp_
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
