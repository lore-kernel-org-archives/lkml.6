Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELud5hV0YONq2+9ym+key+B0hn4vs9ixAnD9jAIU/k+uLIw7SI6YRgJcoEFN7EuTxBLiV6vb
ARC-Seal: i=1; a=rsa-sha256; t=1519981063; cv=none;
        d=google.com; s=arc-20160816;
        b=IdRFNnjZ9C9V5+NWZux0ekd1s9BC5B5/2jSTuwF6JqQNVRZcbSiQEgyIed/k2o26Yb
         dL7gKsZG9fKz6W7cx5iYaiUpoTda01KzRdZGQvGr2EJAodHLid9q5JqEzkDltCV+umkY
         oDUnOFo8K9A3bt+4xGzyolPUhg/hJcnPwnQU/OtJfF/AtbzNju4xbwHz0s9KMRnRJsQO
         xF/nc3iOIvRZX47tvQNb2gNlJEx81P3gHw9ZlFJAWNYX2cvUvyzGrTEOiSFFQkFmihv3
         ne9Rd/c+dZ/QlsA0s0PyLTYYb1ku8Foyvot7QjmiBpmQ+V6vsOmbMh75Wa3g2go+RI6R
         acBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=E9UTBSATOSL5bSwvIi+DUOlOBmGtx03ix8DCeSvRdco=;
        b=KZWhgyh/Y5zS6YUuWafIU7EGMjlC560ain3ZKRkuIlMGp/WiDQAEmOGf0WqzTVRmvJ
         Qtrw+5O94aj17nBB5Bb27CjFG0M+2YepRkIpAVp5At0CYRXAcZQWpvrhlm/avBGxXNpK
         TORLrLL9LG68dSxlxecV6xqqF/1PVbe3R6DbGCcX6qAYgCXCM9rIX0GLTlSAOZisKFxS
         OI9hQv8wU72d4wa4YiW4R6cuBuTPLKMwgyq1k6DPiZL+bFSVFcmHyvU3POEqgbKgGxGK
         96UgZM8f5rtkc45TQd4k9gdkXLbAy6c56NapbpaCAgRzQRc9g2AfltRfsZDnP5KQ0ekD
         4P4Q==
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
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 38/56] macvlan: Fix one possible double free
Date: Fri,  2 Mar 2018 09:51:24 +0100
Message-Id: <20180302084451.506174136@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815663437822141?=
X-GMAIL-MSGID: =?utf-8?q?1593815663437822141?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/macvlan.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1377,9 +1377,14 @@ int macvlan_common_newlink(struct net *s
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
