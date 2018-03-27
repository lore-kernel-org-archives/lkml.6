Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49XCXRWer5nNEw9awGk5T6+yTEfmLix9fzmSncEbGKHJge3LBtCxw3l/Y5nV/zHd7X9pFA9
ARC-Seal: i=1; a=rsa-sha256; t=1522168396; cv=none;
        d=google.com; s=arc-20160816;
        b=SyWrHG7Ic5PtjqLFlfU15o9k2EgE36UTn9SYsE1/S/JWvKZ0P1/zV4lbpanofqa/zw
         joCWPtf05q4aUsl4nHYJomVEX1fnrjisBBcqqW81noLrDBZRAxs9wgq5YkNxHps1SEgp
         zLlvrRGeKK8nwTq/UUTJHp5UoMwocJtVMH8WE1WRDGhH2vX8Q1f7jK8kHEVEKi7zlpsy
         cPx/NPlsbfjjcnBnZZ4H7Y+CyMFr7yF+PzA+v/w4nFpmQ1lt3znrO0OcUOqPmEmoFZL0
         +pZlYRQTrYqZp9dJz+9Tp6dND0VvZ6MwhGD+O3K2Hztsj4HJJ96gc2UuCBtY4BPJ4T4j
         t5Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CnVvLEx0VFxWgPl0tmisgekKuP1zEHi4S3RqoZSv298=;
        b=OxISXRueNSXurPYRLga+AixZSDEl1QjHKnOBRakkVUDD4xcXN2zEYT10CnqQw982xA
         YNUupeJEeBFRC7pAXJB3XkNzJR0AkxkCeT1rG/Iudh4TKkOzpQ/4fp7kXHtejOPxCQw1
         //G6SFsAHDeoJGdPzrQ3ji65RPcQqjhL4nSUxcwz+EuT5P1orsxCbqOIFmbvaHY/fps1
         RnQ4KcP+C6NsDQhZ8Q0iunzqQqjmnwce513TaZyxmPT7jB1DDPnjwu2f1jlaLJlIXC+G
         wYgRk8A2yyvhC+OpgQO0Pl9g/Z75BP6C2yzAPfkHA3h30HfAY4te0yg6OuhP/7SUtofu
         2hrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marek Vasut <marex@denx.de>,
	Heiko Schocher <hs@denx.de>,
	Markus Marb <markus@marb.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.9 43/67] can: ifi: Repair the error handling
Date: Tue, 27 Mar 2018 18:27:35 +0200
Message-Id: <20180327162729.490565349@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109248561588212?=
X-GMAIL-MSGID: =?utf-8?q?1596109248561588212?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marex@denx.de>

commit 880dd464b4304583c557c4e5f5ecebfd55d232b1 upstream.

The new version of the IFI CANFD core has significantly less complex
error state indication logic. In particular, the warning/error state
bits are no longer all over the place, but are all present in the
STATUS register. Moreover, there is a new IRQ register bit indicating
transition between error states (active/warning/passive/busoff).

This patch makes use of this bit to weed out the obscure selective
INTERRUPT register clearing, which was used to carry over the error
state indication into the poll function. While at it, this patch
fixes the handling of the ACTIVE state, since the hardware provides
indication of the core being in ACTIVE state and that in turn fixes
the state transition indication toward userspace. Finally, register
reads in the poll function are moved to the matching subfunctions
since those are also no longer needed in the poll function.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Heiko Schocher <hs@denx.de>
Cc: Markus Marb <markus@marb.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/ifi_canfd/ifi_canfd.c |   64 +++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 27 deletions(-)

--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -30,6 +30,7 @@
 #define IFI_CANFD_STCMD_ERROR_ACTIVE		BIT(2)
 #define IFI_CANFD_STCMD_ERROR_PASSIVE		BIT(3)
 #define IFI_CANFD_STCMD_BUSOFF			BIT(4)
+#define IFI_CANFD_STCMD_ERROR_WARNING		BIT(5)
 #define IFI_CANFD_STCMD_BUSMONITOR		BIT(16)
 #define IFI_CANFD_STCMD_LOOPBACK		BIT(18)
 #define IFI_CANFD_STCMD_DISABLE_CANFD		BIT(24)
@@ -52,7 +53,10 @@
 #define IFI_CANFD_TXSTCMD_OVERFLOW		BIT(13)
 
 #define IFI_CANFD_INTERRUPT			0xc
+#define IFI_CANFD_INTERRUPT_ERROR_BUSOFF	BIT(0)
 #define IFI_CANFD_INTERRUPT_ERROR_WARNING	BIT(1)
+#define IFI_CANFD_INTERRUPT_ERROR_STATE_CHG	BIT(2)
+#define IFI_CANFD_INTERRUPT_ERROR_REC_TEC_INC	BIT(3)
 #define IFI_CANFD_INTERRUPT_ERROR_COUNTER	BIT(10)
 #define IFI_CANFD_INTERRUPT_TXFIFO_EMPTY	BIT(16)
 #define IFI_CANFD_INTERRUPT_TXFIFO_REMOVE	BIT(22)
@@ -61,6 +65,10 @@
 #define IFI_CANFD_INTERRUPT_SET_IRQ		((u32)BIT(31))
 
 #define IFI_CANFD_IRQMASK			0x10
+#define IFI_CANFD_IRQMASK_ERROR_BUSOFF		BIT(0)
+#define IFI_CANFD_IRQMASK_ERROR_WARNING		BIT(1)
+#define IFI_CANFD_IRQMASK_ERROR_STATE_CHG	BIT(2)
+#define IFI_CANFD_IRQMASK_ERROR_REC_TEC_INC	BIT(3)
 #define IFI_CANFD_IRQMASK_SET_ERR		BIT(7)
 #define IFI_CANFD_IRQMASK_SET_TS		BIT(15)
 #define IFI_CANFD_IRQMASK_TXFIFO_EMPTY		BIT(16)
@@ -220,7 +228,10 @@ static void ifi_canfd_irq_enable(struct
 
 	if (enable) {
 		enirq = IFI_CANFD_IRQMASK_TXFIFO_EMPTY |
-			IFI_CANFD_IRQMASK_RXFIFO_NEMPTY;
+			IFI_CANFD_IRQMASK_RXFIFO_NEMPTY |
+			IFI_CANFD_IRQMASK_ERROR_STATE_CHG |
+			IFI_CANFD_IRQMASK_ERROR_WARNING |
+			IFI_CANFD_IRQMASK_ERROR_BUSOFF;
 		if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
 			enirq |= IFI_CANFD_INTERRUPT_ERROR_COUNTER;
 	}
@@ -361,12 +372,13 @@ static int ifi_canfd_handle_lost_msg(str
 	return 1;
 }
 
-static int ifi_canfd_handle_lec_err(struct net_device *ndev, const u32 errctr)
+static int ifi_canfd_handle_lec_err(struct net_device *ndev)
 {
 	struct ifi_canfd_priv *priv = netdev_priv(ndev);
 	struct net_device_stats *stats = &ndev->stats;
 	struct can_frame *cf;
 	struct sk_buff *skb;
+	u32 errctr = readl(priv->base + IFI_CANFD_ERROR_CTR);
 	const u32 errmask = IFI_CANFD_ERROR_CTR_OVERLOAD_FIRST |
 			    IFI_CANFD_ERROR_CTR_ACK_ERROR_FIRST |
 			    IFI_CANFD_ERROR_CTR_BIT0_ERROR_FIRST |
@@ -449,6 +461,11 @@ static int ifi_canfd_handle_state_change
 
 	switch (new_state) {
 	case CAN_STATE_ERROR_ACTIVE:
+		/* error active state */
+		priv->can.can_stats.error_warning++;
+		priv->can.state = CAN_STATE_ERROR_ACTIVE;
+		break;
+	case CAN_STATE_ERROR_WARNING:
 		/* error warning state */
 		priv->can.can_stats.error_warning++;
 		priv->can.state = CAN_STATE_ERROR_WARNING;
@@ -477,7 +494,7 @@ static int ifi_canfd_handle_state_change
 	ifi_canfd_get_berr_counter(ndev, &bec);
 
 	switch (new_state) {
-	case CAN_STATE_ERROR_ACTIVE:
+	case CAN_STATE_ERROR_WARNING:
 		/* error warning state */
 		cf->can_id |= CAN_ERR_CRTL;
 		cf->data[1] = (bec.txerr > bec.rxerr) ?
@@ -510,22 +527,21 @@ static int ifi_canfd_handle_state_change
 	return 1;
 }
 
-static int ifi_canfd_handle_state_errors(struct net_device *ndev, u32 stcmd)
+static int ifi_canfd_handle_state_errors(struct net_device *ndev)
 {
 	struct ifi_canfd_priv *priv = netdev_priv(ndev);
+	u32 stcmd = readl(priv->base + IFI_CANFD_STCMD);
 	int work_done = 0;
-	u32 isr;
 
-	/*
-	 * The ErrWarn condition is a little special, since the bit is
-	 * located in the INTERRUPT register instead of STCMD register.
-	 */
-	isr = readl(priv->base + IFI_CANFD_INTERRUPT);
-	if ((isr & IFI_CANFD_INTERRUPT_ERROR_WARNING) &&
+	if ((stcmd & IFI_CANFD_STCMD_ERROR_ACTIVE) &&
+	    (priv->can.state != CAN_STATE_ERROR_ACTIVE)) {
+		netdev_dbg(ndev, "Error, entered active state\n");
+		work_done += ifi_canfd_handle_state_change(ndev,
+						CAN_STATE_ERROR_ACTIVE);
+	}
+
+	if ((stcmd & IFI_CANFD_STCMD_ERROR_WARNING) &&
 	    (priv->can.state != CAN_STATE_ERROR_WARNING)) {
-		/* Clear the interrupt */
-		writel(IFI_CANFD_INTERRUPT_ERROR_WARNING,
-		       priv->base + IFI_CANFD_INTERRUPT);
 		netdev_dbg(ndev, "Error, entered warning state\n");
 		work_done += ifi_canfd_handle_state_change(ndev,
 						CAN_STATE_ERROR_WARNING);
@@ -552,18 +568,11 @@ static int ifi_canfd_poll(struct napi_st
 {
 	struct net_device *ndev = napi->dev;
 	struct ifi_canfd_priv *priv = netdev_priv(ndev);
-	const u32 stcmd_state_mask = IFI_CANFD_STCMD_ERROR_PASSIVE |
-				     IFI_CANFD_STCMD_BUSOFF;
-	int work_done = 0;
-
-	u32 stcmd = readl(priv->base + IFI_CANFD_STCMD);
 	u32 rxstcmd = readl(priv->base + IFI_CANFD_RXSTCMD);
-	u32 errctr = readl(priv->base + IFI_CANFD_ERROR_CTR);
+	int work_done = 0;
 
 	/* Handle bus state changes */
-	if ((stcmd & stcmd_state_mask) ||
-	    ((stcmd & IFI_CANFD_STCMD_ERROR_ACTIVE) == 0))
-		work_done += ifi_canfd_handle_state_errors(ndev, stcmd);
+	work_done += ifi_canfd_handle_state_errors(ndev);
 
 	/* Handle lost messages on RX */
 	if (rxstcmd & IFI_CANFD_RXSTCMD_OVERFLOW)
@@ -571,7 +580,7 @@ static int ifi_canfd_poll(struct napi_st
 
 	/* Handle lec errors on the bus */
 	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
-		work_done += ifi_canfd_handle_lec_err(ndev, errctr);
+		work_done += ifi_canfd_handle_lec_err(ndev);
 
 	/* Handle normal messages on RX */
 	if (!(rxstcmd & IFI_CANFD_RXSTCMD_EMPTY))
@@ -592,12 +601,13 @@ static irqreturn_t ifi_canfd_isr(int irq
 	struct net_device_stats *stats = &ndev->stats;
 	const u32 rx_irq_mask = IFI_CANFD_INTERRUPT_RXFIFO_NEMPTY |
 				IFI_CANFD_INTERRUPT_RXFIFO_NEMPTY_PER |
+				IFI_CANFD_INTERRUPT_ERROR_COUNTER |
+				IFI_CANFD_INTERRUPT_ERROR_STATE_CHG |
 				IFI_CANFD_INTERRUPT_ERROR_WARNING |
-				IFI_CANFD_INTERRUPT_ERROR_COUNTER;
+				IFI_CANFD_INTERRUPT_ERROR_BUSOFF;
 	const u32 tx_irq_mask = IFI_CANFD_INTERRUPT_TXFIFO_EMPTY |
 				IFI_CANFD_INTERRUPT_TXFIFO_REMOVE;
-	const u32 clr_irq_mask = ~((u32)(IFI_CANFD_INTERRUPT_SET_IRQ |
-					 IFI_CANFD_INTERRUPT_ERROR_WARNING));
+	const u32 clr_irq_mask = ~((u32)IFI_CANFD_INTERRUPT_SET_IRQ);
 	u32 isr;
 
 	isr = readl(priv->base + IFI_CANFD_INTERRUPT);
