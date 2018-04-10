Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49KKRz9FOECAK53G3uI36kStvv7PX/+rIaVccj8Qwaf6nRi0DdN7aOyrEunHTZ94dB909pp
ARC-Seal: i=1; a=rsa-sha256; t=1523399897; cv=none;
        d=google.com; s=arc-20160816;
        b=JVEoLSe8hAaoU7igTqbi0uKgg1xXMLXbzYHhpYYZWj9hVIw9QMDYZcdxjfUHw7BHDY
         VR+do5lBrRMNSY7C71gf80roxrSVivc6aPtia1zYcV137s1hR4rHpt2XGch4rCyneL7i
         Bq4Ih7mbtMuWN1RBanDL6AzP3Ss5JMqZeZgv6UzfSgkKcGIz3WiP1Ri9AYi00KvEwbk/
         T7+Dno9/I8JYWyQxdizIToe5lSvWReVL0x5p5u7T6/o8XzYjgkdY13iB8xJI184WhmQq
         CFp9RxhFbdzcmn8s2NmxS68aGwa0qH4VdE8AoXfeo9A9pwI1USIQqVK+Pb2YgjXGXQD/
         MEug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HryqammWS/7SLFkOhwjYb+eyV0BNED21zX4dUE70vy0=;
        b=mOs5H51zsOSqgE+zQFqYP1Me9sEFOAwVOORp2ZxQhhy+BaPYKDRWTYSPRYKY4gZd8Y
         gYWOuK+A1jxU+RYhJLOTl8Gtl5M9ruebEPbKtn3zp0EmgoWkMA0qbGbcguHx5oIVV3Vk
         Xj598mfs1aX7zAH+rL+FNJMsbu9cDFZOKrgvKlJirHlAMJkowKq1Y8tfq7fZ5fJg/l8B
         SwSB2umZA37quW3Atj7hY/owGMoYBjAI4bZgI+D0TiIx2eeJCjAAcyD7iGU/t+5L9n3/
         GaMYglKuqvyA2dd5JYwmsygUY9FNCwFvW0NP9RpSvZcaYIbP6cmlr+XhNWqroMpt2o3q
         COug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexander Potapenko <glider@google.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 103/138] netlink: make sure nladdr has correct size in netlink_connect()
Date: Wed, 11 Apr 2018 00:24:53 +0200
Message-Id: <20180410212914.154737115@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400147624016207?=
X-GMAIL-MSGID: =?utf-8?q?1597400571231113842?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Potapenko <glider@google.com>


[ Upstream commit 7880287981b60a6808f39f297bb66936e8bdf57a ]

KMSAN reports use of uninitialized memory in the case when |alen| is
smaller than sizeof(struct sockaddr_nl), and therefore |nladdr| isn't
fully copied from the userspace.

Signed-off-by: Alexander Potapenko <glider@google.com>
Fixes: 1da177e4c3f41524 ("Linux-2.6.12-rc2")
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netlink/af_netlink.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1053,6 +1053,9 @@ static int netlink_connect(struct socket
 	if (addr->sa_family != AF_NETLINK)
 		return -EINVAL;
 
+	if (alen < sizeof(struct sockaddr_nl))
+		return -EINVAL;
+
 	if ((nladdr->nl_groups || nladdr->nl_pid) &&
 	    !netlink_allowed(sock, NL_CFG_F_NONROOT_SEND))
 		return -EPERM;
