Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqvmQSKv1V5+9Ntq28KKN1Qg1HLgmYqRF+Aa3GVR2q9/9+o1yIXEGcxQZWDL7fz7/1C9ODz
ARC-Seal: i=1; a=rsa-sha256; t=1526631419; cv=none;
        d=google.com; s=arc-20160816;
        b=PJt7s3bCOrVn2DQ1/gvKX9Fvopy7Un9I+shR7z//jGrZvJ/eqJ5YdWHzmctyUrSo63
         M9tQdropKRXNurDCnilHC3j/1E8Qhyek1wqd7DptIHW0lpFi3a8rdLKa2wKtyYWbuCYH
         eKASogLXSsoXd+IlmllwIctR0xNrsq2WthDkD0P/CMnGkucFWpAoDTc9llfg7TVY4tRm
         BDR3JmmMQXudW4bwWSpOnYl16WWT1bgNSJfe0sFiouMIZZlzWrdCuqqOw3oVUiRT9E/9
         K874br8R83bBoBPrlr2o9aD3xdROBkgYBhdUGx0vjS0f5wPKJH5CtAhPcAdxY8JE5uPR
         W9dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=enRYFkeMjT4pTZQHBzPqJnvgqiusa0NO5hKF2zdKaSg=;
        b=kwtVQ7L05vpVS8SJtLu5o2wTwixo4QNCcaajLqbqpZnKyLZvOYQBmVVyAzEfrlpsWp
         cuKkmxXMLEVPFmDYIJ92IHxCqauJyKR6Y1dq47ncLNgSoXvSsGaYPyJbAY4j3dAvdxUL
         KgBjuZ7j25iI9Xl+LVDDzP8vOP455m2OEd5k+Yx1vTMhFov3ZIPUkBIfIpwb8Ihj1tWa
         vDZJ4DhFc1YPYIbRMzQQdCkklBm+HtMik9090KM2ungVdaVPiiPqGotapbhYPbmI1I5s
         HQTUb9B7m4QrQ9ziAGw+V21piQHXR8fgHIInyEas74EOpGFmlfcPrm7hseVDi49NEA/H
         1jqg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Uhv7fpYq;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Uhv7fpYq;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com,
	Hangbin Liu <liuhangbin@gmail.com>,
	Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 02/55] bridge: check iface upper dev when setting master via ioctl
Date: Fri, 18 May 2018 10:14:58 +0200
Message-Id: <20180518081457.520324691@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789066927104198?=
X-GMAIL-MSGID: =?utf-8?q?1600789066927104198?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit e8238fc2bd7b4c3c7554fa2df067e796610212fc ]

When we set a bond slave's master to bridge via ioctl, we only check
the IFF_BRIDGE_PORT flag. Although we will find the slave's real master
at netdev_master_upper_dev_link() later, it already does some settings
and allocates some resources. It would be better to return as early
as possible.

v1 -> v2:
use netdev_master_upper_dev_get() instead of netdev_has_any_upper_dev()
to check if we have a master, because not all upper devs are masters,
e.g. vlan device.

Reported-by: syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bridge/br_if.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -509,8 +509,8 @@ int br_add_if(struct net_bridge *br, str
 		return -ELOOP;
 	}
 
-	/* Device is already being bridged */
-	if (br_port_exists(dev))
+	/* Device has master upper dev */
+	if (netdev_master_upper_dev_get(dev))
 		return -EBUSY;
 
 	/* No bridging devices that dislike that (e.g. wireless) */
