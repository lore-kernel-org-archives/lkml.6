Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+8BhB77qddCiQYK6GE5Q2z4sYNPJAkLuyRBkMrTtjUY6LtzhimBXtQ9L+sGCFlePXwZ+lJ
ARC-Seal: i=1; a=rsa-sha256; t=1523021216; cv=none;
        d=google.com; s=arc-20160816;
        b=ny+AnW7fMMbEu3mT1u0kwuw9ITqIa31iuQUrzk4W/NsjDerokBZ7NXsFxvS7NRTMEy
         oJLJ7u5tqb3eKoMP6xsvU2fw8G1hJ56wgCHxGpuXbt1x92ddarMb60dwgbrYgfQeYavx
         dHyGbCaRwmQiv1HFBx0uD+axxCCL2iRaMahF1CGr5e5FXFLE+N0wW2zbeou3X8jWui83
         R9IFK7tO8mLnr0yFkWrOIrcJ3Mb8nXYNCRDBnUJjjM392nV8vB50rpZBP4hdX9nTBiXd
         SRHTwPEQyOi3kRlekBVoue+7JRNWkUXzHQmDdaC4A7cSDS532WQIsTqt85pevxMNb4z4
         y7bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TLsUx1QSR2d7lMIWheyVbaElpsqmjcz3QUomTbmfwDo=;
        b=PLd+RGZ1RC01qjyfscJ1oONWXjmKdq7XAc+47UEkRR1IJdtCZJu+bdeK9SETZ+hDK9
         YfBcoWwTMrKimy5naUvJ5LQiO2wrLksvvY9S7+Gy9YCrtEE0naHvu3OFvmmot6+xZ3au
         ReEfSNG4AWKvIxbImVUc2k7j8vCpI1kWmzVgN6a9XhzabmgzOpEJmAKa/oAqp/ASAjAy
         3wHxr8ygcDC6KdHqpgaE0LmfoYOMJELKhY3dd+byh3v9bM3qqumT8vKwWiL+URKYFq+f
         JZkbZ+VZ4XQLe/RvYo17N1Eg9BE1aD69EG0S56R5NBKhvz2Cu6mxu6c14E2/u8D2cRmi
         pptg==
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
Subject: [PATCH 3.18 18/93] can: cc770: Fix use after free in cc770_tx_interrupt()
Date: Fri,  6 Apr 2018 15:22:47 +0200
Message-Id: <20180406084225.782375530@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003495073527132?=
X-GMAIL-MSGID: =?utf-8?q?1597003495073527132?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -705,13 +705,12 @@ static void cc770_tx_interrupt(struct ne
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
