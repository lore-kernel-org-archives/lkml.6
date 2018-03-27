Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48AzBtcxj/Nm6YW1JiHNERKoE0ymtPQj87uEKDA6RGIjGs0/OAHM7JS4NlfDdr7uHjEa6LS
ARC-Seal: i=1; a=rsa-sha256; t=1522168609; cv=none;
        d=google.com; s=arc-20160816;
        b=FNGIv9S0WQ4PG2Rf5Gg47yMDTlGdbTVGdjXsao771MyC4p2lR4M5JoCjGV4q0oqpmZ
         CNE2spW5kNHBPzsFjOZ42MeXOKiT/pTICjDzvSO7/5256VQ3mat80OHnxAc10XXIv3JJ
         vv2bMx+CcDJuxD8z6EmJuMTDLDWMKjpg0wVYeKao0e9BqUV8U3/VIYIeqXCW/XKbHcDD
         qsczp/vHm7YIzKkOKSCJq11uLyO4mO8Pp/iiSCth93YMhyYvkmQ226bqUtYjj2E+y7l7
         m8gx0M20wiZ8ds1C/J+2wsSG2rCMiLrp7Npm9PrTDyj6JKAXe5epL2bnpHCNVL+xzcK4
         rSBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nhnUAiLTYSkCaPrOv1mvBS8RfjJrTcG9uyU1O4BJdTc=;
        b=DNnPTNENmEAOpcoxB61tLmluNu18Jmb+rRGnPOS0aOV+p4Cr9wdWfVtrkSSGYG9okd
         M8qQIAf0zBvExzceIi2G17AcE8DlCUkspubMyP/p3b//D99YvjDOcYmUrnY1DJcgbXqf
         DbgCfpIhvCN7cXZPpjrlmow4wTycKUfp/6cynalUaoSsc9l7zJ7MHoDjEqhZRFtPqrrC
         50yiQD7UY1nFa4WMa66tS2xEut+w8U8f9c002pH5HIwkY0Dpi3Zq78oDqlH7f8+www5y
         IGoSiUl535gATZoY7FaAIb1Oo/rUpQr8xGwk2dEYvNKRhinRW7/OWv8Mp/pIblOk7rk6
         l/cw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Diana Burgess <diana@peloton-tech.com>,
	Stephane Grosjean <s.grosjean@peak-system.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.14 070/101] can: peak/pcie_fd: fix echo_skb is occupied! bug
Date: Tue, 27 Mar 2018 18:27:42 +0200
Message-Id: <20180327162754.363213582@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109471989770116?=
X-GMAIL-MSGID: =?utf-8?q?1596109471989770116?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephane Grosjean <s.grosjean@peak-system.com>

commit e6048a00cfd0863d32f53b226e0b9a3633fc3332 upstream.

This patch makes atomic the handling of the linux-can echo_skb array and
the network tx queue. This prevents from the "BUG! echo_skb is occupied!"
message to be printed by the linux-can core, in SMP environments.

Reported-by: Diana Burgess <diana@peloton-tech.com>
Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/peak_canfd/peak_canfd.c       |   12 ++++++------
 drivers/net/can/peak_canfd/peak_pciefd_main.c |    8 ++++++--
 2 files changed, 12 insertions(+), 8 deletions(-)

--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -262,7 +262,6 @@ static int pucan_handle_can_rx(struct pe
 
 		spin_lock_irqsave(&priv->echo_lock, flags);
 		can_get_echo_skb(priv->ndev, msg->client);
-		spin_unlock_irqrestore(&priv->echo_lock, flags);
 
 		/* count bytes of the echo instead of skb */
 		stats->tx_bytes += cf_len;
@@ -271,6 +270,7 @@ static int pucan_handle_can_rx(struct pe
 		/* restart tx queue (a slot is free) */
 		netif_wake_queue(priv->ndev);
 
+		spin_unlock_irqrestore(&priv->echo_lock, flags);
 		return 0;
 	}
 
@@ -726,11 +726,6 @@ static netdev_tx_t peak_canfd_start_xmit
 	 */
 	should_stop_tx_queue = !!(priv->can.echo_skb[priv->echo_idx]);
 
-	spin_unlock_irqrestore(&priv->echo_lock, flags);
-
-	/* write the skb on the interface */
-	priv->write_tx_msg(priv, msg);
-
 	/* stop network tx queue if not enough room to save one more msg too */
 	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
 		should_stop_tx_queue |= (room_left <
@@ -742,6 +737,11 @@ static netdev_tx_t peak_canfd_start_xmit
 	if (should_stop_tx_queue)
 		netif_stop_queue(ndev);
 
+	spin_unlock_irqrestore(&priv->echo_lock, flags);
+
+	/* write the skb on the interface */
+	priv->write_tx_msg(priv, msg);
+
 	return NETDEV_TX_OK;
 }
 
--- a/drivers/net/can/peak_canfd/peak_pciefd_main.c
+++ b/drivers/net/can/peak_canfd/peak_pciefd_main.c
@@ -349,8 +349,12 @@ static irqreturn_t pciefd_irq_handler(in
 		priv->tx_pages_free++;
 		spin_unlock_irqrestore(&priv->tx_lock, flags);
 
-		/* wake producer up */
-		netif_wake_queue(priv->ucan.ndev);
+		/* wake producer up (only if enough room in echo_skb array) */
+		spin_lock_irqsave(&priv->ucan.echo_lock, flags);
+		if (!priv->ucan.can.echo_skb[priv->ucan.echo_idx])
+			netif_wake_queue(priv->ucan.ndev);
+
+		spin_unlock_irqrestore(&priv->ucan.echo_lock, flags);
 	}
 
 	/* re-enable Rx DMA transfer for this CAN */
