Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+MAJUH6qBrBZJAqPZ5zw8nYbM7gfRqYd+8YV5+m6QPI29ku8bayekBwlcDQZQj0V2jEw/t
ARC-Seal: i=1; a=rsa-sha256; t=1522168628; cv=none;
        d=google.com; s=arc-20160816;
        b=XILhfg9jotzZgIO1VsAtbXkzkJWZ9wOt1D8f3mgGHivvL8QE254Y+EygFhHx/1Hs1R
         S6lEoKSy68trxw0LuvfnLIkwfCR/qy63GUItyHYgkW1aFXA6cFQyu6K2LqqsMM9/mH7f
         99HZUM/ZuDPqHGME2AcGN8VlGU7RqSiyXc8Ow4WOE6MUQoGI0+i3MKeGRmZAxtXMSzpc
         mdzhsk1RPCG5/chGuIelQ5ZEMD4QrajCKaiZikITMVuHqGJgIJASxoEQ3z+Yd1CODhuy
         I++8hP/fvBTBXAU6OhgV4eI8t7hn8Xrvhn/qtPkQoQt11j66GjBX3nFILp1ypn0LxlpN
         guiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+asYKzsXBQ0+eD84EQgYhahPo0CnHv0y+0HodJABELo=;
        b=NavH6qy9qHbuKB7W7TBGMTh5VB25NK/UJndJHh9062ZCw1u1aZrKiTrcdgy+N3h61t
         N1FIHwuwKx3SFGB8U6FiL/tSaIta8Ashv23/pjoTy9Ua7Fi8snck41XcdHNmDhZKwAs/
         OcqIP9sRJamoR2nsir9pCA12NAIT7hNomhi4H7f4KbZY3sfUiQpVkwL0IucoIzgRS6SE
         tqXvmKCQuLLKchOpLkI/cRRHIw+e0suUTinAeyoVd1pOIXypzvV0yQiiJ0KJgapZRs9x
         ySTqd6exLIaBHsJB9fjh4h/Z1KgfwxqQdIM96EoMwi6Jebsm1ilamczQIN4mXrCNeq6D
         UySg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andri Yngvason <andri.yngvason@marel.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.14 076/101] can: cc770: Fix use after free in cc770_tx_interrupt()
Date: Tue, 27 Mar 2018 18:27:48 +0200
Message-Id: <20180327162754.749117466@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109029474104153?=
X-GMAIL-MSGID: =?utf-8?q?1596109491149594972?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andri Yngvason <andri.yngvason@marel.com>

commit 9ffd7503944ec7c0ef41c3245d1306c221aef2be upstream.

This fixes use after free introduced by the last cc770 patch.

Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
Fixes: 746201235b3f ("can: cc770: Fix queue stall & dropped RTR reply")
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/cc770/cc770.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -706,13 +706,12 @@ static void cc770_tx_interrupt(struct ne
 		return;
 	}
 
-	can_put_echo_skb(priv->tx_skb, dev, 0);
-	can_get_echo_skb(dev, 0);
-
 	cf = (struct can_frame *)priv->tx_skb->data;
 	stats->tx_bytes += cf->can_dlc;
 	stats->tx_packets++;
 
+	can_put_echo_skb(priv->tx_skb, dev, 0);
+	can_get_echo_skb(dev, 0);
 	priv->tx_skb = NULL;
 
 	netif_wake_queue(dev);
