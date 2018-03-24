Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeCXAbx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 20:31:53 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46360 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751999AbeCXAbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 20:31:41 -0400
X-Google-Smtp-Source: AG47ELsG+u1TJYCCmdiTVlBjTsXpOOYN8MzzKuarpF8CByqDt19s/4L0OL9GYROuvG1iprYHHM+bTA==
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH 4/4] tty/nozomi: refactor conditional statements
Date: Fri, 23 Mar 2018 14:31:27 -1000
Message-Id: <20180324003127.4287-5-joeypabalinas@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180324003127.4287-1-joeypabalinas@gmail.com>
References: <20180324003127.4287-1-joeypabalinas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce unnecessarily deep nesting of blocks and simplify
control flow (e.g. "if/else" constructs changed to "if/return"
and single case "switch" statements changed to "if" conditionals
where possible).

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

 1 file changed, 52 insertions(+), 50 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index a5074a59d3e3d33e68..0ea3e1de23c093e808 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -694,12 +694,13 @@ static void enable_transmit_ul(enum port_type port, struct nozomi *dc)
 {
 	static const u16 mask[] = {MDM_UL, DIAG_UL, APP1_UL, APP2_UL, CTRL_UL};
 
-	if (port < NOZOMI_MAX_PORTS) {
-		dc->last_ier |= mask[port];
-		writew(dc->last_ier, dc->reg_ier);
-	} else {
+	if (port >= NOZOMI_MAX_PORTS) {
 		dev_err(&dc->pdev->dev, "Called with wrong port?\n");
+		return;
 	}
+
+	dc->last_ier |= mask[port];
+	writew(dc->last_ier, dc->reg_ier);
 }
 
 /* Disable uplink interrupts  */
@@ -708,12 +709,13 @@ static void disable_transmit_ul(enum port_type port, struct nozomi *dc)
 	static const u16 mask[] =
 		{~MDM_UL, ~DIAG_UL, ~APP1_UL, ~APP2_UL, ~CTRL_UL};
 
-	if (port < NOZOMI_MAX_PORTS) {
-		dc->last_ier &= mask[port];
-		writew(dc->last_ier, dc->reg_ier);
-	} else {
+	if (port >= NOZOMI_MAX_PORTS) {
 		dev_err(&dc->pdev->dev, "Called with wrong port?\n");
+		return;
 	}
+
+	dc->last_ier &= mask[port];
+	writew(dc->last_ier, dc->reg_ier);
 }
 
 /* Enable downlink interrupts */
@@ -721,12 +723,13 @@ static void enable_transmit_dl(enum port_type port, struct nozomi *dc)
 {
 	static const u16 mask[] = {MDM_DL, DIAG_DL, APP1_DL, APP2_DL, CTRL_DL};
 
-	if (port < NOZOMI_MAX_PORTS) {
-		dc->last_ier |= mask[port];
-		writew(dc->last_ier, dc->reg_ier);
-	} else {
+	if (port >= NOZOMI_MAX_PORTS) {
 		dev_err(&dc->pdev->dev, "Called with wrong port?\n");
+		return;
 	}
+
+	dc->last_ier |= mask[port];
+	writew(dc->last_ier, dc->reg_ier);
 }
 
 /* Disable downlink interrupts */
@@ -735,12 +738,13 @@ static void disable_transmit_dl(enum port_type port, struct nozomi *dc)
 	static const u16 mask[] =
 		{~MDM_DL, ~DIAG_DL, ~APP1_DL, ~APP2_DL, ~CTRL_DL};
 
-	if (port < NOZOMI_MAX_PORTS) {
-		dc->last_ier &= mask[port];
-		writew(dc->last_ier, dc->reg_ier);
-	} else {
+	if (port >= NOZOMI_MAX_PORTS) {
 		dev_err(&dc->pdev->dev, "Called with wrong port?\n");
+		return;
 	}
+
+	dc->last_ier &= mask[port];
+	writew(dc->last_ier, dc->reg_ier);
 }
 
 /*
@@ -1028,33 +1032,31 @@ static int handle_data_dl(struct nozomi *dc, enum port_type port, u8 *toggle,
 	if (*toggle == 0 && read_iir & mask1) {
 		if (receive_data(port, dc)) {
 			writew(mask1, dc->reg_fcr);
-			*toggle = !(*toggle);
+			*toggle = !*toggle;
 		}
 
-		if (read_iir & mask2) {
-			if (receive_data(port, dc)) {
-				writew(mask2, dc->reg_fcr);
-				*toggle = !(*toggle);
-			}
+		if (read_iir & mask2 && receive_data(port, dc)) {
+			writew(mask2, dc->reg_fcr);
+			*toggle = !*toggle;
 		}
+
+		return 1;
 	} else if (*toggle == 1 && read_iir & mask2) {
 		if (receive_data(port, dc)) {
 			writew(mask2, dc->reg_fcr);
-			*toggle = !(*toggle);
+			*toggle = !*toggle;
 		}
 
-		if (read_iir & mask1) {
-			if (receive_data(port, dc)) {
-				writew(mask1, dc->reg_fcr);
-				*toggle = !(*toggle);
-			}
+		if (read_iir & mask1 && receive_data(port, dc)) {
+			writew(mask1, dc->reg_fcr);
+			*toggle = !*toggle;
 		}
-	} else {
-		dev_err(&dc->pdev->dev, "port out of sync!, toggle:%d\n",
-			*toggle);
-		return 0;
+
+		return 1;
 	}
-	return 1;
+
+	dev_err(&dc->pdev->dev, "port out of sync!, toggle:%d\n", *toggle);
+	return 0;
 }
 
 /*
@@ -1087,6 +1089,7 @@ static int handle_data_ul(struct nozomi *dc, enum port_type port, u16 read_iir)
 			}
 		}
 
+		return 1;
 	} else if (*toggle == 1 && read_iir & MDM_UL2) {
 		dc->last_ier &= ~MDM_UL;
 		writew(dc->last_ier, dc->reg_ier);
@@ -1107,12 +1110,13 @@ static int handle_data_ul(struct nozomi *dc, enum port_type port, u16 read_iir)
 				*toggle = !*toggle;
 			}
 		}
-	} else {
-		writew(read_iir & MDM_UL, dc->reg_fcr);
-		dev_err(&dc->pdev->dev, "port out of sync!\n");
-		return 0;
+
+		return 1;
 	}
-	return 1;
+
+	writew(read_iir & MDM_UL, dc->reg_fcr);
+	dev_err(&dc->pdev->dev, "port out of sync!\n");
+	return 0;
 }
 
 static irqreturn_t interrupt_handler(int irq, void *dev_id)
@@ -1121,7 +1125,7 @@ static irqreturn_t interrupt_handler(int irq, void *dev_id)
 	unsigned int i;
 	u16 read_iir;
 
-	if (!dc)
+	if (unlikely(!dc))
 		return IRQ_NONE;
 
 	spin_lock(&dc->spin_mutex);
@@ -1344,8 +1348,9 @@ static int nozomi_card_init(struct pci_dev *pdev,
 
 	ret = pci_request_regions(dc->pdev, NOZOMI_NAME);
 	if (ret) {
-		/* nozomi_private.io_addr */
-		dev_err(&pdev->dev, "I/O address 0x%04x already in use\n", 0);
+		dev_err(&pdev->dev, "I/O address 0x%04x already in use\n",
+			/* (int) nozomi_private.io_addr */ 0);
+
 		goto err_disable_device;
 	}
 
@@ -1752,18 +1757,15 @@ static int ntty_ioctl(struct tty_struct *tty,
 
 	DBG1("******** IOCTL, cmd: %d", cmd);
 
-	switch (cmd) {
-	case TIOCMIWAIT: {
-		struct async_icount cprev = port->tty_icount;
-		rval = wait_event_interruptible(port->tty_wait,
-				ntty_cflags_changed(port, arg, &cprev));
-		break;
-	}
-	default:
+	if (cmd != TIOCMIWAIT) {
 		DBG1("ERR: 0x%08X, %d", cmd, cmd);
-		break;
+		goto no_ioctl;
 	}
 
+	rval = wait_event_interruptible(port->tty_wait,
+			ntty_cflags_changed(port, arg, &port->tty_icount));
+
+no_ioctl:
 	return rval;
 }
 
-- 
2.16.3
