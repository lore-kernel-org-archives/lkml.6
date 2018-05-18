Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrd1t5eAuZDH8iZYRuTLjPfKmJrofu+xo36D+Eu3dpcUsjWTYwSF6lspD76RkhuhfwKUQQB
ARC-Seal: i=1; a=rsa-sha256; t=1526631641; cv=none;
        d=google.com; s=arc-20160816;
        b=Iqdhu3q1MhISLhC9p2kLlaVBBu8z9FcNF+S2Kk6CZ00ootUO2JYjSyv9ftRe2Ra3dB
         rwL3WHeZrf+vptifAknjABe0Lb+PbbsJndM6wNtgyn02ghjRYqrxeESfSpdPQ6BaCQGQ
         rtrcdIN3GN9eiKRUAFfN31/hfw+EN9DYf/+Kuxnk/QedXCR3PPo6p/VjjJAYQGT899Lg
         r9EEC97D69SZyBYEw6hlXOdPvcqLf2r5ilhdfYNTn2YuBcmqieAULWSBkxVSosz8Sx0P
         Wje2z5Y0Zu8nJ5C4vysdTsz7zX8pdW8/xm73w3SQE2dOEU6YOkP7eqtMBXv+V/EYAxQu
         QnlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=unGXYIw0O963paC/eQ3kOsNHbGoZ0Qo7+14aiflt3VM=;
        b=u3oIqisY0sI7uLCceOzmyL4+e3GIO9rJ5s5AXh4IqCKPzSctP4wUZ0XMlfd8aXnjkO
         hbI2ceIQc98xJatJz7OS6/dqKuvbYanIULqMrlropUXIiNEgGBr1eaNH58e2N3LsPCzf
         A1NjE4YXIWgdy41TzFQXg/xYxPZi9cvWJQgMhfSRHiOhRpSVvHbCgZS15bbqLeDRZ2BJ
         uTusVl31qyRRPR8QSDcBacxRsUTx4+IzqZeVS80O/rLrE6U0iIqu3c34gFmt9pKktueF
         M/a68JvPcrSsXBUNXtLJfVKpkzhuiyhd0Sq1WAnki1OpRjRZ8GRjJNnmA5rA4owuhSLE
         VYhA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=He6OAU4n;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=He6OAU4n;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Damir Mansurov <dnman@oktetlabs.ru>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 39/45] udp: fix SO_BINDTODEVICE
Date: Fri, 18 May 2018 10:15:56 +0200
Message-Id: <20180518081532.364931787@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789145041813810?=
X-GMAIL-MSGID: =?utf-8?q?1600789299952455856?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 69678bcd4d2dedbc3e8fcd6d7d99f283d83c531a ]

Damir reported a breakage of SO_BINDTODEVICE for UDP sockets.
In absence of VRF devices, after commit fb74c27735f0 ("net:
ipv4: add second dif to udp socket lookups") the dif mismatch
isn't fatal anymore for UDP socket lookup with non null
sk_bound_dev_if, breaking SO_BINDTODEVICE semantics.

This changeset addresses the issue making the dif match mandatory
again in the above scenario.

Reported-by: Damir Mansurov <dnman@oktetlabs.ru>
Fixes: fb74c27735f0 ("net: ipv4: add second dif to udp socket lookups")
Fixes: 1801b570dd2a ("net: ipv6: add second dif to udp socket lookups")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/udp.c |    4 ++--
 net/ipv6/udp.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -413,9 +413,9 @@ static int compute_score(struct sock *sk
 		bool dev_match = (sk->sk_bound_dev_if == dif ||
 				  sk->sk_bound_dev_if == sdif);
 
-		if (exact_dif && !dev_match)
+		if (!dev_match)
 			return -1;
-		if (sk->sk_bound_dev_if && dev_match)
+		if (sk->sk_bound_dev_if)
 			score += 4;
 	}
 
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -164,9 +164,9 @@ static int compute_score(struct sock *sk
 		bool dev_match = (sk->sk_bound_dev_if == dif ||
 				  sk->sk_bound_dev_if == sdif);
 
-		if (exact_dif && !dev_match)
+		if (!dev_match)
 			return -1;
-		if (sk->sk_bound_dev_if && dev_match)
+		if (sk->sk_bound_dev_if)
 			score++;
 	}
 
