Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtmTae61SzhpNduyMxuZtO4o8poWA3Cgjrxv17m0QCsmIQUwU09ez17Yt2ARp2Ic0ycABko
ARC-Seal: i=1; a=rsa-sha256; t=1519981379; cv=none;
        d=google.com; s=arc-20160816;
        b=F0zJTPxK3LX2luk393OBD3lrNlwYZ7O8dnk1XFJL/IM6er9CzSQ+f99bxq0MLSW1RN
         3KSPUV9+JvCI7WeWpCtRDdm+F2fVv3MUSQQ6OACYjw2+XnmmQBdyJhSh8Z06WgfP0W9V
         He1/p6vuTHD8NVZBQBKIHYX983DCL0U8rVYr0Vetv4ob743bZpuqAdV2IC/vjGbyND0M
         6NJMmqlL+pTrLojM6Ac0v6D0W8YASFU733TFHlIGe9ZXDBf7OxvoCyTAUtiewTHUBWiM
         FGUdhK6DUpaNrj9PGWPW4W1R4oYnDc/Us5g6hEHsxZGj7LCDxAoAGmnKj9As6q+j5N/U
         cDCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jUDMoWwgoDhfmYr+XSBipx7ezpCVny37VI8b/MoG9X8=;
        b=h6IipnaRhbLdQzCyVA6bINSCLn5q++f7BS3JeWuAt3vcUwwHv5gf9avAOYdc4xf8Jd
         erVD8vfZgE83ah7eScpZWSPpL9BZE8Lg9U2lFNwZ4NF0OjEQMrCbaMCGwMXanWlL4j41
         TkFKh6lRGkvjXqnCwPqyCtbRrsnMSx8dH2x/H4vm3iueuQn0H52P2DTa9QaNKyivH69/
         FGSX6b/nZxt8CfKE4qx5QZOmU1EkjspmC5w99Ky0GctgaTgY6cY/4Jg6xUU3Kw0Bjma5
         jmpOjKaLgAn/U800MwU5xNd1MKmVOPjVSn0u0uIbrUFNQMa2eW66A0fKws58tmLp4C/x
         gcTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gao Feng <gfree.wind@vip.163.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 074/115] macvlan: Fix one possible double free
Date: Fri,  2 Mar 2018 09:51:17 +0100
Message-Id: <20180302084506.854345250@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815663437822141?=
X-GMAIL-MSGID: =?utf-8?q?1593815995385815826?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Feng <gfree.wind@vip.163.com>


[ Upstream commit d02fd6e7d2933ede6478a15f9e4ce8a93845824e ]

Because the macvlan_uninit would free the macvlan port, so there is one
double free case in macvlan_common_newlink. When the macvlan port is just
created, then register_netdevice or netdev_upper_dev_link failed and they
would invoke macvlan_uninit. Then it would reach the macvlan_port_destroy
which triggers the double free.

Signed-off-by: Gao Feng <gfree.wind@vip.163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/macvlan.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1441,9 +1441,14 @@ int macvlan_common_newlink(struct net *s
 	return 0;
 
 unregister_netdev:
+	/* macvlan_uninit would free the macvlan port */
 	unregister_netdevice(dev);
+	return err;
 destroy_macvlan_port:
-	if (create)
+	/* the macvlan port may be freed by macvlan_uninit when fail to register.
+	 * so we destroy the macvlan port only when it's valid.
+	 */
+	if (create && macvlan_port_get_rtnl(dev))
 		macvlan_port_destroy(port->dev);
 	return err;
 }
