Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48NpKKSUqg4rimkuteK6xsnZm1SQqXdCZCeNmq+n1uZWAauUivpLt+wk0HneMeVcA8KjQvF
ARC-Seal: i=1; a=rsa-sha256; t=1522346695; cv=none;
        d=google.com; s=arc-20160816;
        b=F9oJ80XB96jJBWgNXp2B1pQ97vJ0Ethf8y6H8QCOwbTKQtvBoL/O5nMHENX048FFHH
         xA2lM6U9EXVIkkONxBaTij3sMwf5DClKYndoGEYUv3I82rFyppSndj9SM2INvLp+I9Le
         almiKzz+gIPa7sJ6krRawYiEPph/RnZIcNIpC5NXAVOod3SriZesSEADOGwQ4VA6svTI
         AyjDZuMLboBwzG/TboCzIqonEDPa4uTgVetuPJrFC6/sJ4ZabwSNmUFACnTa/ACEW/wo
         Hoz9pmW+IFKl1HpKo065dtbZdBqeelD69QgcguMbosqcdLJ4dGoYiJ8BXTPVBb32dnpb
         2jtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LuUMLAE+PdGRw+N53USStlNatBMz0X90mKEkwMbQ+Mo=;
        b=QAj7mrD+DqsAU4HH/ubln0f7ey98TAusV4V4/HKBCK47s5cFSzXF1cqa/jrT34PILo
         JUfcldP6mzeOAXr54B78v5AVlOurWr+GiEVxUIELrGDNt8bu/WPTTzNEd9hgFqaDJaeD
         Y/EMG4rBmSeKZ/opb3VVXlgaTTJu89r6gy6BHVqodU19rwwmOastNNVQXDmAATgbn9VG
         xe6AbV3L90O2pRwK6mP3opvvFUw+ETxkFIZFquzUCb3hfpogThvBllz2aHJxpmJs2gZz
         bjMIaCZ3hTeW1Dd2b5rUiejl8Lbu/AGCOTmWDIwa0wohNjUpPCGr6wQaRBF3FTZT8NVX
         iCeg==
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
Subject: [PATCH 4.14 08/43] net: ipv6: keep sk status consistent after datagram connect failure
Date: Thu, 29 Mar 2018 20:00:03 +0200
Message-Id: <20180329175730.961864384@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296121064789785?=
X-GMAIL-MSGID: =?utf-8?q?1596296207924216439?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
