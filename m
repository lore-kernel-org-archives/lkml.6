Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48GdS0UVL1abPJrHBOj4wkhpKOFjqHYxOPy/5Sj3C+7aqw33Q+YZh+2ZBYJKtz0oElsmCqZ
ARC-Seal: i=1; a=rsa-sha256; t=1523472674; cv=none;
        d=google.com; s=arc-20160816;
        b=f0+g2ikqF6XdcIAcB9P+7FcbmHayDmoTyzg1hiqHMfawlRCjoMbu50TwfoNuyCJJvR
         BAH0PTI0G/Kn9jUQ+Wg7UdEWb+5w2Sqvm1bvrWqH7WTcS1MZzbkyGXvkqWxJO8/f/0mB
         TsrgRzgyWJsjOwlHauHui8u98Os5Gdn85+QzC+m2RUNRihw0RTZEVHYd4VqaF0SJTivA
         hnx5oQo3Mj7HyPGDpZfI2l3ILISLW4mTuYtx7+hQFM8L27YRmMxByxoPk2Zk5dX4JrAG
         O7zLCJwvr8jSpq42mOTGIRPj7Hw2Nzr2tmFo8eC/GP1GCZcIzq8HGpAPWNvAX2z5qqSV
         PBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tqsSdDYBvLFOCI4xWyoZiNyllB2B9+HNyYd5nraeOe0=;
        b=hjKNGaIZhPjuCCjycZxnuhwjluF1GY45ZIrCkGSluBn+tCmRG599pQCHQrKp8uiHga
         vj3AD4XY6bzYucoPhR6m5v2YpdEBuwZ1TLxSNRmsfBYFk1Ql+u+PKj6hk+muVXi6eQC6
         2G16bnOej1Fpb0RgBozo+9OdEdulvK3r0tZ3rGrZXkkeuvHAzff0Bwtf3wpKvBg/r+2K
         aFMMNnlmJfa9gYkQM23t8sKGXdUsVP5b1g9Lw1WNemaF3h7Sa+Aceuong9OMm7SXxOFQ
         IcVetDWCfdyz7z/iioop5fd2//thCeIawTYBJWY4UEfm5eMLqJCnMBLGafJ8X0LL+2z3
         K12Q==
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
Subject: [PATCH 4.4 169/190] netlink: make sure nladdr has correct size in netlink_connect()
Date: Wed, 11 Apr 2018 20:36:55 +0200
Message-Id: <20180411183602.396992041@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476332058088557?=
X-GMAIL-MSGID: =?utf-8?q?1597476883409787954?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1054,6 +1054,9 @@ static int netlink_connect(struct socket
 	if (addr->sa_family != AF_NETLINK)
 		return -EINVAL;
 
+	if (alen < sizeof(struct sockaddr_nl))
+		return -EINVAL;
+
 	if ((nladdr->nl_groups || nladdr->nl_pid) &&
 	    !netlink_allowed(sock, NL_CFG_F_NONROOT_SEND))
 		return -EPERM;
