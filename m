Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49vHOQYB1Nsx5TP33w4IAWC7YHD9C1AzTj+vxtrsv/MLmCObYBbwrI5ipjjq3f2VywoHzY0
ARC-Seal: i=1; a=rsa-sha256; t=1522168407; cv=none;
        d=google.com; s=arc-20160816;
        b=i+UkA689qGzF3+lvRrN45UgavfGpnAJRDcCZ0Y1rhQbK9Rk0UfOkufV4o0WmatOUEd
         XYsIJyoMtek/lqxk+7ZA0JcTsqIuf18PteWmFEhdBJO6VRfg2tXZMOHXhNaQgyJL6zYJ
         ZkB7c8WApjiM63lMV4mvLSQQaaPlP0tzdHZymxWHFwsJuVBdTWajAnCm0w7ugbAnKf6o
         pqylFf6opHXjD13XUAJXY1TIKktAFmxTq0i0ByoLOkJaCnNRHwoXb1FRonqSbpC1pa7h
         ByDViny/DyoC0XYRIjYYM8lKNzxh4KsW+b5ubuiMbdfS+9wiVAYXsazq5ck2yas1iYu7
         L+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rZYYRP9TnrMTfYCyYGrhz/okhv/zYboBWJwUaYTWRbM=;
        b=bySkhhoA9XL/YUSN1sS1PC8gZ0xO1wi+djXAWAvBkiY+oDaQt+NDepCmOPRf9oz1jG
         K5Wtg7Ka3l2ra7ALPP5fmSjMzp1LQqdhL8wOgKbbdaZ+qOPLjmvJTvDaTCqwO9thUPbe
         wr6TIYRwSXDyITTdisdE73z574iSNGh6jyqHtGd52HAXicfpl6kDQJmvXzkxMdI0meRC
         2RdI6EiJ6OCfojsxP4Sp0i0q4qCbVYdZqZvOXWY17OGvvEtdDRaVUjuhx4ANF6y3yDpY
         yzuibjJWN7f3L2deSBqxdIGyQ5Nktb25+TxL27FQ8Atsy6FwCY4kiynXk33va/5PTj/9
         Uc7g==
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
Subject: [PATCH 4.9 47/67] can: cc770: Fix use after free in cc770_tx_interrupt()
Date: Tue, 27 Mar 2018 18:27:39 +0200
Message-Id: <20180327162729.842500777@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109029474104153?=
X-GMAIL-MSGID: =?utf-8?q?1596109259732814815?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
