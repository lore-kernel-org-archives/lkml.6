Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48ZHGDrhbCMPVB2hHiC77cprt9mrJXVQCuhg5RbOqXYA7oBOckKZgqhqhZCzz+FqjQUxxX5
ARC-Seal: i=1; a=rsa-sha256; t=1522346612; cv=none;
        d=google.com; s=arc-20160816;
        b=Pee9pJqGEti09l+YHyT7DSyvTrY5jZKxZ+B5UXH7HiOXBAQV3+OSIHePBiW2CLX2hw
         h0t2l14LUMp59bslpHryxwH1CuIA0GCWlSwW+POhKv25Y6Ec51+Hc+brJ8dgedbE+xbA
         oJ20s1zQ8W4ZqPO7a0jWo4hxz/F2tMhhMvOceaqSX0JBRtUsmLk0PctArUUHMw8vkMj7
         /zfu6JsSzEMH16+f4Xe7ugY2HaRHLAnihlJ6MNx7en2wW4prUTFmrfRDlf8I7EZMQKsB
         8014sDT9xNDIHKl6jdj5mvVbHJ+8wlzExUrsJaOaFHcTZjevaLUrxBZGgFMtyCNf6+M4
         A9GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/318yZp6tU6WcKc8e1yN4cVownzoXQcy4Z8JGZxzRS4=;
        b=vj1shz9luXrkX98SXZ/PTChhQkJJRlXYmWuGydVpI9R1Aa3AANx5NAmGskbZpWbwiN
         lWSslQ9Cf7DbQl2fjXrlHmxWYG5/GIFvu7jr/icl5phjORx7MkO7h0mI4JomX1kNYtMt
         EgyiDUsksKoPNHwHcY6q7de0HoTss6qKcVbtN6XRmvmV3fnOC+6DC9yGhx+ZmWRY1nia
         zjL+U3Q+xN5Moiz/AEtXSkBty9PjhNWP4xFummdA8TeHCM67l78na2nlVFQY2kFSZipB
         9W9LN/4bzDK4P78Y/FBWyqAP9CMIhIhWgG1oVK5zbV/KTjIKNoKqNxqRJ9XJizOmGCsL
         FjhA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 10/47] net: ipv6: keep sk status consistent after datagram connect failure
Date: Thu, 29 Mar 2018 19:59:51 +0200
Message-Id: <20180329175729.895341261@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296121064789785?=
X-GMAIL-MSGID: =?utf-8?q?1596296121064789785?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>


[ Upstream commit 2f987a76a97773beafbc615b9c4d8fe79129a7f4 ]

On unsuccesful ip6_datagram_connect(), if the failure is caused by
ip6_datagram_dst_update(), the sk peer information are cleared, but
the sk->sk_state is preserved.

If the socket was already in an established status, the overall sk
status is inconsistent and fouls later checks in datagram code.

Fix this saving the old peer information and restoring them in
case of failure. This also aligns ipv6 datagram connect() behavior
with ipv4.

v1 -> v2:
 - added missing Fixes tag

Fixes: 85cb73ff9b74 ("net: ipv6: reset daddr and dport in sk if connect() fails")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/datagram.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -146,10 +146,12 @@ int __ip6_datagram_connect(struct sock *
 	struct sockaddr_in6	*usin = (struct sockaddr_in6 *) uaddr;
 	struct inet_sock	*inet = inet_sk(sk);
 	struct ipv6_pinfo	*np = inet6_sk(sk);
-	struct in6_addr		*daddr;
+	struct in6_addr		*daddr, old_daddr;
+	__be32			fl6_flowlabel = 0;
+	__be32			old_fl6_flowlabel;
+	__be32			old_dport;
 	int			addr_type;
 	int			err;
-	__be32			fl6_flowlabel = 0;
 
 	if (usin->sin6_family == AF_INET) {
 		if (__ipv6_only_sock(sk))
@@ -239,9 +241,13 @@ ipv4_connected:
 		}
 	}
 
+	/* save the current peer information before updating it */
+	old_daddr = sk->sk_v6_daddr;
+	old_fl6_flowlabel = np->flow_label;
+	old_dport = inet->inet_dport;
+
 	sk->sk_v6_daddr = *daddr;
 	np->flow_label = fl6_flowlabel;
-
 	inet->inet_dport = usin->sin6_port;
 
 	/*
@@ -251,11 +257,12 @@ ipv4_connected:
 
 	err = ip6_datagram_dst_update(sk, true);
 	if (err) {
-		/* Reset daddr and dport so that udp_v6_early_demux()
-		 * fails to find this socket
+		/* Restore the socket peer info, to keep it consistent with
+		 * the old socket state
 		 */
-		memset(&sk->sk_v6_daddr, 0, sizeof(sk->sk_v6_daddr));
-		inet->inet_dport = 0;
+		sk->sk_v6_daddr = old_daddr;
+		np->flow_label = old_fl6_flowlabel;
+		inet->inet_dport = old_dport;
 		goto out;
 	}
 
