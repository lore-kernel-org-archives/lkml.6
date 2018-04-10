Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/C3GqguyMO7bVxX6HFHN+yWhp74wDuQ1cf27wXkfGontOcZrS5y/zCNbAMQkqMaby7wxMR
ARC-Seal: i=1; a=rsa-sha256; t=1523399493; cv=none;
        d=google.com; s=arc-20160816;
        b=AmOtR8mk7hQuORkl0CI4WkqX3Glfrzc6lOY4fT9gEj2kxgArJu9QwkAjk5dV89l2za
         aTxBu7JtA4dbPV07sfeYLVVv/HqwO0wrPhP6aAy3rf0w1cQ5aa7pmVvH4z/6gprTfbM8
         uzT1mpnAsgwXh7Qs/9yezM8gCjQuolQvU4zSEcXM/xPrO+nypvbjOAEPCyK0Xl8Qe7NW
         I8gRsYbK50cbCLl4Uzs3R3qpt3OvuQnwA6qlhpnIDXRorsfWYTpQFRqfkwsbnn4XOSpt
         n++qng7/FBaLrZsy6Olq/MOddYZgzkyn4fOEkRMJ0kK7m0z7rbOxvvONqquOjrDpecuU
         kvbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Na/f6uN8ii6Al/iC2LsWxUILrKAZYdiV5CfWMXfcpJQ=;
        b=EyGU/nRsFoy7L8cqSNIuAnTat1kpvOahCQwgYedDkq/5BjliFXbYqOfhfRMqanGBZo
         4EGNUDoU4gZu7aJ/EVGKhsSQb9kQ8neLwcjhAs5bSeMCvJlZaB0HXCMxOR5qPbB0slH7
         rO1hGcCVGhijsIb/VINwoJE9TNRE6AvwjN2OCTbqMaWBmFHSOJGIvE1S4tnHIXZUu1FN
         j6INsiKnzYg6RdZdQjCugKq8+kAeRas4MkN0cPClb6FfL+TEdHJ3uMFfvf7bNrfRBMzm
         ddDcElkTvcJmbw7P7BvPxaZPnwnFnGeOW8Irkxwyk0ZbZrBQJAvWEkc2ni/ow5XW+R3j
         k1Ng==
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
Subject: [PATCH 4.15 128/168] netlink: make sure nladdr has correct size in netlink_connect()
Date: Wed, 11 Apr 2018 00:24:30 +0200
Message-Id: <20180410212806.210594032@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400147624016207?=
X-GMAIL-MSGID: =?utf-8?q?1597400147624016207?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1052,6 +1052,9 @@ static int netlink_connect(struct socket
 	if (addr->sa_family != AF_NETLINK)
 		return -EINVAL;
 
+	if (alen < sizeof(struct sockaddr_nl))
+		return -EINVAL;
+
 	if ((nladdr->nl_groups || nladdr->nl_pid) &&
 	    !netlink_allowed(sock, NL_CFG_F_NONROOT_SEND))
 		return -EPERM;
