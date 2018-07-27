Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68506C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF2A20895
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF2A20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388993AbeG0LKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:10:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52964 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbeG0LKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:10:53 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 36248898;
        Fri, 27 Jul 2018 09:49:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>,
        Michal Simek <michal.simek@xilinx.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.17 58/66] can: xilinx_can: fix power management handling
Date:   Fri, 27 Jul 2018 11:45:51 +0200
Message-Id: <20180727093815.567301861@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727093809.043856530@linuxfoundation.org>
References: <20180727093809.043856530@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anssi Hannula <anssi.hannula@bitwise.fi>

commit 8ebd83bdb027f29870d96649dba18b91581ea829 upstream.

There are several issues with the suspend/resume handling code of the
driver:

- The device is attached and detached in the runtime_suspend() and
  runtime_resume() callbacks if the interface is running. However,
  during xcan_chip_start() the interface is considered running,
  causing the resume handler to incorrectly call netif_start_queue()
  at the beginning of xcan_chip_start(), and on xcan_chip_start() error
  return the suspend handler detaches the device leaving the user
  unable to bring-up the device anymore.

- The device is not brought properly up on system resume. A reset is
  done and the code tries to determine the bus state after that.
  However, after reset the device is always in Configuration mode
  (down), so the state checking code does not make sense and
  communication will also not work.

- The suspend callback tries to set the device to sleep mode (low-power
  mode which monitors the bus and brings the device back to normal mode
  on activity), but then immediately disables the clocks (possibly
  before the device reaches the sleep mode), which does not make sense
  to me. If a clean shutdown is wanted before disabling clocks, we can
  just bring it down completely instead of only sleep mode.

Reorganize the PM code so that only the clock logic remains in the
runtime PM callbacks and the system PM callbacks contain the device
bring-up/down logic. This makes calling the runtime PM callbacks during
e.g. xcan_chip_start() safe.

The system PM callbacks now simply call common code to start/stop the
HW if the interface was running, replacing the broken code from before.

xcan_chip_stop() is updated to use the common reset code so that it will
wait for the reset to complete. Reset also disables all interrupts so do
not do that separately.

Also, the device_may_wakeup() checks are removed as the driver does not
have wakeup support.

Tested on Zynq-7000 integrated CAN.

Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/xilinx_can.c |   69 +++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 41 deletions(-)

--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -811,13 +811,9 @@ static irqreturn_t xcan_interrupt(int ir
 static void xcan_chip_stop(struct net_device *ndev)
 {
 	struct xcan_priv *priv = netdev_priv(ndev);
-	u32 ier;
 
 	/* Disable interrupts and leave the can in configuration mode */
-	ier = priv->read_reg(priv, XCAN_IER_OFFSET);
-	ier &= ~XCAN_INTR_ALL;
-	priv->write_reg(priv, XCAN_IER_OFFSET, ier);
-	priv->write_reg(priv, XCAN_SRR_OFFSET, XCAN_SRR_RESET_MASK);
+	set_reset_mode(ndev);
 	priv->can.state = CAN_STATE_STOPPED;
 }
 
@@ -950,10 +946,15 @@ static const struct net_device_ops xcan_
  */
 static int __maybe_unused xcan_suspend(struct device *dev)
 {
-	if (!device_may_wakeup(dev))
-		return pm_runtime_force_suspend(dev);
+	struct net_device *ndev = dev_get_drvdata(dev);
 
-	return 0;
+	if (netif_running(ndev)) {
+		netif_stop_queue(ndev);
+		netif_device_detach(ndev);
+		xcan_chip_stop(ndev);
+	}
+
+	return pm_runtime_force_suspend(dev);
 }
 
 /**
@@ -965,11 +966,27 @@ static int __maybe_unused xcan_suspend(s
  */
 static int __maybe_unused xcan_resume(struct device *dev)
 {
-	if (!device_may_wakeup(dev))
-		return pm_runtime_force_resume(dev);
+	struct net_device *ndev = dev_get_drvdata(dev);
+	int ret;
 
-	return 0;
+	ret = pm_runtime_force_resume(dev);
+	if (ret) {
+		dev_err(dev, "pm_runtime_force_resume failed on resume\n");
+		return ret;
+	}
+
+	if (netif_running(ndev)) {
+		ret = xcan_chip_start(ndev);
+		if (ret) {
+			dev_err(dev, "xcan_chip_start failed on resume\n");
+			return ret;
+		}
+
+		netif_device_attach(ndev);
+		netif_start_queue(ndev);
+	}
 
+	return 0;
 }
 
 /**
@@ -984,14 +1001,6 @@ static int __maybe_unused xcan_runtime_s
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct xcan_priv *priv = netdev_priv(ndev);
 
-	if (netif_running(ndev)) {
-		netif_stop_queue(ndev);
-		netif_device_detach(ndev);
-	}
-
-	priv->write_reg(priv, XCAN_MSR_OFFSET, XCAN_MSR_SLEEP_MASK);
-	priv->can.state = CAN_STATE_SLEEPING;
-
 	clk_disable_unprepare(priv->bus_clk);
 	clk_disable_unprepare(priv->can_clk);
 
@@ -1010,7 +1019,6 @@ static int __maybe_unused xcan_runtime_r
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct xcan_priv *priv = netdev_priv(ndev);
 	int ret;
-	u32 isr, status;
 
 	ret = clk_prepare_enable(priv->bus_clk);
 	if (ret) {
@@ -1024,27 +1032,6 @@ static int __maybe_unused xcan_runtime_r
 		return ret;
 	}
 
-	priv->write_reg(priv, XCAN_SRR_OFFSET, XCAN_SRR_RESET_MASK);
-	isr = priv->read_reg(priv, XCAN_ISR_OFFSET);
-	status = priv->read_reg(priv, XCAN_SR_OFFSET);
-
-	if (netif_running(ndev)) {
-		if (isr & XCAN_IXR_BSOFF_MASK) {
-			priv->can.state = CAN_STATE_BUS_OFF;
-			priv->write_reg(priv, XCAN_SRR_OFFSET,
-					XCAN_SRR_RESET_MASK);
-		} else if ((status & XCAN_SR_ESTAT_MASK) ==
-					XCAN_SR_ESTAT_MASK) {
-			priv->can.state = CAN_STATE_ERROR_PASSIVE;
-		} else if (status & XCAN_SR_ERRWRN_MASK) {
-			priv->can.state = CAN_STATE_ERROR_WARNING;
-		} else {
-			priv->can.state = CAN_STATE_ERROR_ACTIVE;
-		}
-		netif_device_attach(ndev);
-		netif_start_queue(ndev);
-	}
-
 	return 0;
 }
 


