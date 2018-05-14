Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpYlhcOQstYjQf/IA9QW6YjoICzb5V2XkCU1XyZFxf1chIEL763tLv4PtiWjutELb84KhKR
ARC-Seal: i=1; a=rsa-sha256; t=1526280983; cv=none;
        d=google.com; s=arc-20160816;
        b=I800RV5rc7hq/mOAzvCKsQi3H6vIb6REeLAhqSH3724m9VS1YdsVHpBdKq1ypBBR1Z
         J3J4w/7luTpiGeEEAeC+HpcptM1MKCz+DSozoLBS9Ji13XTbkJuWkR9APHCs+5kCQE7Q
         IqSSXWnqSkM1YwqJNboh/UsIE/nCykcbtexk5cxXWHc6t6fXrBRIesYwTcx9bUzf1Jr1
         Kw/8+xNjM8xBBrs58clfdw9iG148RyJKeD5Go6rNYNqy1WwzJJSnjNPRlcNZIHAf7nY6
         9Y7tCm0brnqmMEjFha1pmjXSO6TUrFRsnmcuH5JiCc/fPPQ9GuhX09vu5CdbzEpexQnK
         eRKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=F6k6LJ84XvBJN4dfsNqgYXzZe1wiD5rNqsv8Q3RSvhg=;
        b=jFHLuDMrkS9vt7PPxqjfjZJP7gkI1bqIjAuKIFxhJ9rKAu1pPmlMONqltYWYsYZMax
         CMPajEK5LaZWwweA7tTtdLg9UzPGSjoMLypylUJbx4u2csdPTYEhYArVkR/ucFaiXBvd
         yTEMrYVA638xDVkY3xuX1QCpN8oGDvlOUV6zIpIzEgW7RBK+Uo+TW6jr3cPTheOQmsvj
         di45u3ijlViCFK+et8xazbC+TVdf7UDGmhgYlqESpei7lJTzHLuJL2rwz8cKvjD29Zxm
         viXMab55HeY8RxzvcjYgFk9H7fzs2PQrQNBpIYKTZ4Vx4qNlKoOdQVtmnsIxGudcc1DP
         axoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ieWSRBR5;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ieWSRBR5;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mathias Duckeck <m.duckeck@kunbus.de>,
	Akshay Bhat <akshay.bhat@timesys.com>,
	Casey Fitzpatrick <casey.fitzpatrick@timesys.com>,
	Lukas Wunner <lukas@wunner.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.14 36/62] can: hi311x: Work around TX complete interrupt erratum
Date: Mon, 14 May 2018 08:48:52 +0200
Message-Id: <20180514064818.385778650@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421608296051163?=
X-GMAIL-MSGID: =?utf-8?q?1600421608296051163?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit 32bee8f48fa048a3198109de50e51c092507ff52 upstream.

When sending packets as fast as possible using "cangen -g 0 -i -x", the
HI-3110 occasionally latches the interrupt pin high on completion of a
packet, but doesn't set the TXCPLT bit in the INTF register.  The INTF
register contains 0x00 as if no interrupt has occurred.  Even waiting
for a few milliseconds after the interrupt doesn't help.

Work around this apparent erratum by instead checking the TXMTY bit in
the STATF register ("TX FIFO empty").  We know that we've queued up a
packet for transmission if priv->tx_len is nonzero.  If the TX FIFO is
empty, transmission of that packet must have completed.

Note that this is congruent with our handling of received packets, which
likewise gleans from the STATF register whether a packet is waiting in
the RX FIFO, instead of looking at the INTF register.

Cc: Mathias Duckeck <m.duckeck@kunbus.de>
Cc: Akshay Bhat <akshay.bhat@timesys.com>
Cc: Casey Fitzpatrick <casey.fitzpatrick@timesys.com>
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Acked-by: Akshay Bhat <akshay.bhat@timesys.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/spi/hi311x.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -91,6 +91,7 @@
 #define HI3110_STAT_BUSOFF BIT(2)
 #define HI3110_STAT_ERRP BIT(3)
 #define HI3110_STAT_ERRW BIT(4)
+#define HI3110_STAT_TXMTY BIT(7)
 
 #define HI3110_BTR0_SJW_SHIFT 6
 #define HI3110_BTR0_BRP_SHIFT 0
@@ -737,10 +738,7 @@ static irqreturn_t hi3110_can_ist(int ir
 			}
 		}
 
-		if (intf == 0)
-			break;
-
-		if (intf & HI3110_INT_TXCPLT) {
+		if (priv->tx_len && statf & HI3110_STAT_TXMTY) {
 			net->stats.tx_packets++;
 			net->stats.tx_bytes += priv->tx_len - 1;
 			can_led_event(net, CAN_LED_EVENT_TX);
@@ -750,6 +748,9 @@ static irqreturn_t hi3110_can_ist(int ir
 			}
 			netif_wake_queue(net);
 		}
+
+		if (intf == 0)
+			break;
 	}
 	mutex_unlock(&priv->hi3110_lock);
 	return IRQ_HANDLED;
