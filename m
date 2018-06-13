Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 25FE4C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B37B20020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="L9Eexou2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B37B20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.bosch.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935927AbeFMOiv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:38:51 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:33644 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935816AbeFMOiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:38:18 -0400
Received: from si0vm1948.rbesz01.com (unknown [139.15.230.188])
        by fe0vms0187.rbdmz01.com (Postfix) with ESMTPS id 415TrR4VfFz1XLFZJ;
        Wed, 13 Jun 2018 16:38:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=2015-01-21; t=1528900695;
        bh=xKWvSJAExCFYwQPkF9cpeARYs1KgGM4+MQ0/Lt2hetU=; l=10;
        h=From:From:Reply-To:Sender;
        b=L9Eexou2SEqSzfQnYDeyVUSs/i2QSsgFVskCSKzJs0NJnsO/dHJXkVYYKXGJA0rMh
         1Ct/cvyXHYNXI3UgR13fagg83L4oNbDslVVftKM77RBTfXZbIgA/pwLDERXdrQiBNS
         3g0v+geWHxgNA4MAp0xGtZGOM4tUWyqMenyAFZGY=
Received: from si0vm2083.rbesz01.com (unknown [10.58.172.176])
        by si0vm1948.rbesz01.com (Postfix) with ESMTPS id 415TrR40N9z4fw;
        Wed, 13 Jun 2018 16:38:15 +0200 (CEST)
X-AuditID: 0a3aad17-513ff70000000e32-d2-5b212c58af15
Received: from si0vm1949.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by si0vm2083.rbesz01.com (SMG Outbound) with SMTP id 5B.4A.03634.85C212B5; Wed, 13 Jun 2018 16:38:16 +0200 (CEST)
Received: from SI-HUB1000.de.bosch.com (si-hub1000.de.bosch.com [10.4.103.106])
        by si0vm1949.rbesz01.com (Postfix) with ESMTPS id 415TrQ4bKNz6D44M5;
        Wed, 13 Jun 2018 16:38:14 +0200 (CEST)
Received: from luchador.grb-fir.grb.de.bosch.com (10.19.187.97) by
 SI-HUB1000.de.bosch.com (10.4.103.106) with Microsoft SMTP Server id
 14.3.319.2; Wed, 13 Jun 2018 16:38:14 +0200
From:   Mark Jonas <mark.jonas@de.bosch.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hs@denx.de>,
        <yi.zhu5@cn.bosch.com>, <petar.petrovic2@de.bosch.com>,
        <stephan.baetge@de.bosch.com>, <andy.shevchenko@gmail.com>,
        <socketcan@hartkopp.net>, <o.rempel@pengutronix.de>,
        Mark Jonas <mark.jonas@de.bosch.com>
Subject: [PATCH v2 2/5] spi: implement companion-spi driver
Date:   Wed, 13 Jun 2018 16:37:18 +0200
Message-ID: <1528900641-18677-3-git-send-email-mark.jonas@de.bosch.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528900641-18677-1-git-send-email-mark.jonas@de.bosch.com>
References: <1528224240-30786-1-git-send-email-mark.jonas@de.bosch.com>
 <1528900641-18677-1-git-send-email-mark.jonas@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA21Sf0wbZRjmu7u2R8Ox47rCuwpjO4M/wLEyNLm4xWiM4fYPm4nOjSbOw560
        kbakV8ggi06GTAoK23BKIYVolugiYw513USWVcBONrJ0kqyCBec0HdQpMlamDry2sPYP//ny
        fu/zPO/zfc/3kThzRaUjzVaHaLcKlaxSTaif7M3ZtPuxjQZ90+wa7mbbt4jzTE7h3InI+zh3
        9VyXkuv7qJ3gRnoyuRtBxF2bWVJxx4NnFU+n8m6Xj+DPun5S8XP+CcQfXB5S8a339Pz86fU7
        lWXqbUax0lwj2jc/9Yra9N7Hy6qquZ+V+8b+9CkOoPFWhROlkkA/DpcOH0VOpCYZ+kMM3H9/
        oohvziOojxwi4pszCBp/iaCoREnnQ8DnwaP1WvpF6Py1MUbC6UEMJr5pjpE09FaIdLliNUHn
        wVgoGPOj6BK47h9f8V4PgbGm2KBUmocvz7ljfIZ+G8H48K44PwMudtwgojVOA1wIhfA2tMaV
        BLmSoB6EnUBayayvsWzRc8WF9nJRqtMXFb5qs5xG8ayzPOj254IX0SRi06g3czcaGIVQI9Va
        vOgJEmO1VGnbBgOTXm4z1poEybTXXl0pSqyOQikpKYzmfluqLreYJclss3oRkDi7lioNyTrK
        KNTWiXZbXOZFD5AEm0W1GPeXMXSF4BBfF8Uq0b6KbiVJFiipQD5Dhl2sEPe9Zq50rMJsTtwz
        MxlJtsXIVC8qJtNk78HoCEqqEiySuWJFvi4uZ1a7Cen36Fly6Y/2FpwhrDarqMuiRvJlPR1l
        mqqt90+gy6YMX8iX0iYBiSkz6AqSM9RQo1FxmvylE95AeTRde5iMlWZCtKVL1tB3nAj8P6aD
        O5ILDc35cOQeD+G7uyA48hIMNu6BbqcJfKdqoenSG7B07CCCxYZ+BIFpeWnrH0DQOeVH0HE7
        iODfjnkEbs8CgstfRRBcC/Ri8MPVkxjMzfZhEA58jcHiwHUMOkfDcvXXAgb+qbdw6Jl6F4fJ
        /sM41PtcOHTP9eHgv+DDZ+Q8MTnP4eHoW0oOwfE/ea50E5fSHUCmQEvD0NBsZvudnArtB2bl
        ds2sP3y0KnLx8hktuz2w8FwzPH/kGWbHpnUPZ9c7Cronvtt26NGTewceWr5b/Jux6Z2SMVtP
        Wavl1u8lpdnODNP0dOu8h+N5zaejRQ9yus3p5/8pKO27Rb0w+XJ4/yM3exc/Cxnycn3HeTFz
        tLAub8MSS0gmoSgft0vCf5QMzExjBAAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhu Yi <yi.zhu5@cn.bosch.com>

The low level companion-spi driver encapsulates the communication
details with the companion processor, and provides interface for
the upper level drivers to access.

Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
---
 drivers/spi/Kconfig                      |    2 +
 drivers/spi/Makefile                     |    2 +
 drivers/spi/companion/Kconfig            |    5 +
 drivers/spi/companion/Makefile           |    2 +
 drivers/spi/companion/core.c             | 1185 ++++++++++++++++++++++++++++++
 drivers/spi/companion/protocol-manager.c | 1032 ++++++++++++++++++++++++++
 drivers/spi/companion/protocol-manager.h |  341 +++++++++
 drivers/spi/companion/protocol.h         |  273 +++++++
 drivers/spi/companion/queue-manager.c    |  144 ++++
 drivers/spi/companion/queue-manager.h    |  245 ++++++
 include/linux/companion.h                |  259 +++++++
 11 files changed, 3490 insertions(+)
 create mode 100644 drivers/spi/companion/Kconfig
 create mode 100644 drivers/spi/companion/Makefile
 create mode 100644 drivers/spi/companion/core.c
 create mode 100644 drivers/spi/companion/protocol-manager.c
 create mode 100644 drivers/spi/companion/protocol-manager.h
 create mode 100644 drivers/spi/companion/protocol.h
 create mode 100644 drivers/spi/companion/queue-manager.c
 create mode 100644 drivers/spi/companion/queue-manager.h
 create mode 100644 include/linux/companion.h

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a75f2a2..8b575ec 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -799,6 +799,8 @@ config SPI_TLE62X0
 # Add new SPI protocol masters in alphabetical order above this line
 #
 
+source "drivers/spi/companion/Kconfig"
+
 endif # SPI_MASTER
 
 #
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 8e0cda7..ae369d9 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -112,3 +112,5 @@ obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+= spi-zynqmp-gqspi.o
 # SPI slave protocol handlers
 obj-$(CONFIG_SPI_SLAVE_TIME)		+= spi-slave-time.o
 obj-$(CONFIG_SPI_SLAVE_SYSTEM_CONTROL)	+= spi-slave-system-control.o
+
+obj-y                                   += companion/
diff --git a/drivers/spi/companion/Kconfig b/drivers/spi/companion/Kconfig
new file mode 100644
index 0000000..490a273
--- /dev/null
+++ b/drivers/spi/companion/Kconfig
@@ -0,0 +1,5 @@
+config COMPANION_SPI
+	tristate "Low level driver for companion communication (Bosch)"
+	depends on SPI
+	help
+	  This driver communicates with the companion processor via SPI.
diff --git a/drivers/spi/companion/Makefile b/drivers/spi/companion/Makefile
new file mode 100644
index 0000000..e60e733
--- /dev/null
+++ b/drivers/spi/companion/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_COMPANION_SPI) += companion-spi.o
+companion-spi-objs := core.o protocol-manager.o queue-manager.o
diff --git a/drivers/spi/companion/core.c b/drivers/spi/companion/core.c
new file mode 100644
index 0000000..515e5ec
--- /dev/null
+++ b/drivers/spi/companion/core.c
@@ -0,0 +1,1185 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Companion low level init/core code
+ *
+ * Copyright (C) 2015-2018 Bosch Sicherheitssysteme GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/spi/spi.h>
+#include <linux/kfifo.h>
+
+#include "protocol-manager.h"
+
+#define DRIVER_NAME "companion-spi"
+
+#define READY_POLL_US      80
+#define READY_POLL_US_GRAN 1
+#define READY_POLL_MS      100
+#define READY_POLL_MS_GRAN 10
+
+/**
+ * struct busy_signal_statistics - spi busy signal statistics
+ * @while_busy_ext:        how many times while_busy loop been waited
+ * @while_busy_fail:       how many times while_busy been timed out
+ * @until_busy_ext:        how many times until_busy loop been waited
+ * @until_busy_fail:       how many times until_busy been timed out
+ * @force_started:         how many times of force started
+ * @force_started_failure: how many times of force started failure
+ * @ready_failure:         how many times of ready failure
+ */
+struct busy_signal_statistics {
+	u32 while_busy_ext;
+	u32 while_busy_fail;
+	u32 until_busy_ext;
+	u32 until_busy_fail;
+	u32 force_started;
+	u32 force_started_failure;
+	u32 ready_failure;
+};
+
+/**
+ * struct companion_spi_priv - companion-spi private data structure
+ * @spi:                  address of spi device
+ * @task:                 address of task struct
+ * @wait:                 wait queue head
+ * @gpiod_request:        gpio line connect to request signal
+ * @gpiod_busy:           gpio line connect to busy signal
+ * @gpiod_cs:             gpio line connect to cs signal
+ * @dump_packet:          flag to control dump spi packet
+ * @stats:                spi busy signal statistics
+ * @pm:                   companion protocol manager
+ */
+struct companion_spi_priv {
+	struct spi_device                *spi;
+	struct task_struct               *task;
+	wait_queue_head_t                 wait;
+
+	struct gpio_desc                 *gpiod_request;
+	struct gpio_desc                 *gpiod_busy;
+	struct gpio_desc                 *gpiod_cs;
+
+	bool                              dump_packets;
+	struct busy_signal_statistics     stats;
+	struct companion_protocol_manager pm;
+};
+
+/**
+ * companion_io_ops_register() - register companion IO packets handler
+ * @parent: address of the parent device
+ * @ops:    address of the IO callbacks
+ * @data:   address of the data passed to the IO callbacks
+ */
+int companion_io_ops_register(struct device           *parent,
+			      struct companion_io_ops *ops,
+			      void                    *data)
+{
+	struct companion_spi_priv *priv = dev_get_drvdata(parent);
+
+	return pm_io_ops_register(&priv->pm, ops, data);
+}
+EXPORT_SYMBOL_GPL(companion_io_ops_register);
+
+/**
+ * companion_io_ops_unregister() - unregister companion IO packets handler
+ * @parent: address of the parent device
+ */
+int companion_io_ops_unregister(struct device *parent)
+{
+	struct companion_spi_priv *priv = dev_get_drvdata(parent);
+
+	return pm_io_ops_unregister(&priv->pm);
+}
+EXPORT_SYMBOL_GPL(companion_io_ops_unregister);
+
+/**
+ * companion_can_ops_register() - register companion CAN packets handler
+ * @parent: address of the parent device
+ * @port:   which CAN port to register
+ * @ops:    address of the CAN callbacks
+ * @data:   address of the data passed to the CAN callbacks
+ */
+int companion_can_ops_register(struct device            *parent,
+			       u8                        port,
+			       struct companion_can_ops *ops,
+			       void                     *data)
+{
+	struct companion_spi_priv *priv = dev_get_drvdata(parent);
+
+	return pm_can_ops_register(&priv->pm, port, ops, data);
+}
+EXPORT_SYMBOL_GPL(companion_can_ops_register);
+
+/**
+ * companion_can_ops_unregister() - unregister companion CAN packets handler
+ * @parent: address of the parent device
+ * @port:   which CAN port to unregister
+ */
+int companion_can_ops_unregister(struct device *parent, u8 port)
+{
+	struct companion_spi_priv *priv = dev_get_drvdata(parent);
+
+	return pm_can_ops_unregister(&priv->pm, port);
+}
+EXPORT_SYMBOL_GPL(companion_can_ops_unregister);
+
+/**
+ * companion_io_txq_is_full() - return true if IO tx queue is full
+ * @parent: address of the parent device
+ */
+bool companion_io_txq_is_full(struct device *parent)
+{
+	struct companion_spi_priv *priv = dev_get_drvdata(parent);
+
+	return qm_io_txq_is_full(&priv->pm.qm);
+}
+EXPORT_SYMBOL_GPL(companion_io_txq_is_full);
+
+/**
+ * companion_io_rxq_is_empty() - return true if IO rx queue is empty
+ * @parent: address of the parent device
+ */
+bool companion_io_rxq_is_empty(struct device *parent)
+{
+	struct companion_spi_priv *priv = dev_get_drvdata(parent);
+
+	return qm_io_rxq_is_empty(&priv->pm.qm);
+}
+EXPORT_SYMBOL_GPL(companion_io_rxq_is_empty);
+
+/**
+ * companion_do_io_tx() - send IO packet
+ * @parent: address of the parent device
+ * @buf:    address of the user space buffer to send
+ * @count:  number of bytes to copy
+ */
+int companion_do_io_tx(struct device     *parent,
+		       const char __user *buf,
+		       size_t             count)
+{
+	struct companion_spi_priv *priv = dev_get_drvdata(parent);
+	unsigned int               copied;
+	int                        err;
+	struct companion_packet    p;
+
+	if (copy_from_user(p.data, buf, sizeof(p))) {
+		dev_err(parent, "copy from user not succeed in one call\n");
+		return -EFAULT;
+	}
+
+	if (is_can_type(&p))
+		return -EINVAL;
+
+	err = qm_io_txq_in(&priv->pm.qm, buf, count, &copied);
+	if (err) {
+		priv->pm.stats.io_tx_overflows++;
+		return err;
+	}
+
+	wake_up_interruptible(&priv->wait);
+	priv->pm.stats.io_tx++;
+	return copied;
+}
+EXPORT_SYMBOL_GPL(companion_do_io_tx);
+
+/**
+ * companion_do_io_rx() - receive IO packet
+ * @parent: address of the parent device
+ * @buf:    address of the user space buffer to receive
+ * @count:  number of bytes to copy
+ */
+int companion_do_io_rx(struct device *parent,
+		       char __user   *buf,
+		       size_t         count)
+{
+	struct companion_spi_priv *priv = dev_get_drvdata(parent);
+	unsigned int               copied;
+	int                        err;
+
+	err = qm_io_rxq_out(&priv->pm.qm, buf, count, &copied);
+	return err ? err : copied;
+}
+EXPORT_SYMBOL_GPL(companion_do_io_rx);
+
+/**
+ * companion_do_can_tx() - send CAN packet
+ * @parent: address of the parent device
+ * @port:   which CAN port to send
+ * @prio:   priority of the CAN frame
+ * @cf:     address of the CAN frame to send
+ */
+int companion_do_can_tx(struct device          *parent,
+			u8                      port,
+			u8                      prio,
+			const struct can_frame *cf)
+{
+	struct companion_spi_priv *priv = dev_get_drvdata(parent);
+	int                        err;
+
+	err = pm_can_data_tx(&priv->pm, port, prio, cf);
+	if (err)
+		return err;
+
+	wake_up_interruptible(&priv->wait);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(companion_do_can_tx);
+
+/**
+ * companion_do_can_rx() - receive CAN packet
+ * @parent: address of the parent device
+ * @port:   which CAN port to receive
+ * @cf:     address of the CAN frame to receive
+ */
+int companion_do_can_rx(struct device    *parent,
+			u8                port,
+			struct can_frame *cf)
+{
+	struct companion_spi_priv *priv = dev_get_drvdata(parent);
+
+	return pm_can_data_rx(&priv->pm, port, cf);
+}
+EXPORT_SYMBOL_GPL(companion_do_can_rx);
+
+/**
+ * companion_do_can_err() - receive CAN error packet
+ * @parent: address of the parent device
+ * @port:   which CAN port to receive
+ * @bec:    address to store CAN error counter
+ * @state:  address to store CAN state
+ * @code:   address to store CAN error code
+ */
+int companion_do_can_err(struct device           *parent,
+			 u8                       port,
+			 struct can_berr_counter *bec,
+			 u8                      *state,
+			 u8                      *code)
+{
+	struct companion_spi_priv *priv = dev_get_drvdata(parent);
+
+	return pm_can_err(&priv->pm, port, bec, state, code);
+}
+EXPORT_SYMBOL_GPL(companion_do_can_err);
+
+/**
+ * companion_do_set_can_bittiming() - set CAN bittiming
+ * @parent:    address of the parent device
+ * @port:      which CAN port to set
+ * @bittiming: address of the bittiming to set
+ */
+int companion_do_set_can_bittiming(struct device              *parent,
+				   u8                          port,
+				   const struct can_bittiming *bittiming)
+{
+	struct companion_spi_priv *priv = dev_get_drvdata(parent);
+	int                        err;
+
+	err = pm_can_set_bittiming(&priv->pm, port, bittiming);
+	if (err)
+		return err;
+
+	wake_up_interruptible(&priv->wait);
+	return pm_wait_for_response(&priv->pm, port, bcp_can_bittiming);
+}
+EXPORT_SYMBOL_GPL(companion_do_set_can_bittiming);
+
+/**
+ * companion_do_set_can_mode() - set CAN mode
+ * @parent: address of the parent device
+ * @port:   which CAN port to set
+ * @mode:   the CAN mode to set
+ */
+int companion_do_set_can_mode(struct device *parent,
+			      u8             port,
+			      enum can_mode  mode)
+{
+	struct companion_spi_priv *priv = dev_get_drvdata(parent);
+	int                        err;
+
+	err = pm_can_set_mode(&priv->pm, port, mode);
+	if (err)
+		return err;
+
+	wake_up_interruptible(&priv->wait);
+	return pm_wait_for_response(&priv->pm, port, bcp_can_mode);
+}
+EXPORT_SYMBOL_GPL(companion_do_set_can_mode);
+
+/**
+ * companion_do_set_can_ctrlmode() - set CAN control mode
+ * @parent: address of the parent device
+ * @port:   which CAN port to set
+ * @ctrl:   the CAN control mode to set
+ */
+int companion_do_set_can_ctrlmode(struct device *parent,
+				  u8             port,
+				  u32            ctrl)
+{
+	struct companion_spi_priv *priv = dev_get_drvdata(parent);
+	int                        err;
+
+	err = pm_can_set_ctrlmode(&priv->pm, port, ctrl);
+	if (err)
+		return err;
+
+	wake_up_interruptible(&priv->wait);
+	return pm_wait_for_response(&priv->pm, port, bcp_can_mode);
+}
+EXPORT_SYMBOL_GPL(companion_do_set_can_ctrlmode);
+
+/**
+ * companion_do_get_can_status() - get CAN status
+ * @parent: address of the parent device
+ * @port:   which CAN port to receive
+ * @bec:    address of the CAN error counter to store
+ */
+int companion_do_get_can_status(struct device           *parent,
+				u8                       port,
+				struct can_berr_counter *bec)
+{
+	struct companion_spi_priv *priv = dev_get_drvdata(parent);
+	int                        err;
+
+	err = pm_can_get_status(&priv->pm, port);
+	if (err)
+		return err;
+
+	wake_up_interruptible(&priv->wait);
+	err = pm_wait_for_response(&priv->pm, port, bcp_can_status);
+	if (err)
+		return err;
+
+	bec->rxerr = priv->pm.rx_err[port];
+	bec->txerr = priv->pm.tx_err[port];
+	return 0;
+}
+EXPORT_SYMBOL_GPL(companion_do_get_can_status);
+
+/**
+ * companion_do_get_can_txq_status() - get single CAN tx queue status
+ * @parent:        address of the parent device
+ * @port:          which CAN port to inquiry
+ * @prio:          which CAN queue to inquiry
+ * @lost_txq_sync: address of flag to store whether tx queue lost sync
+ */
+int companion_do_get_can_txq_status(struct device *parent,
+				    u8             port,
+				    u8             prio,
+				    bool          *lost_txq_sync)
+{
+	struct companion_spi_priv         *priv = dev_get_drvdata(parent);
+	struct companion_protocol_manager *pm   = &priv->pm;
+	u8                                 local, remote;
+	int                                err;
+
+	if (prio >= BCP_CAN_PRIOS)
+		return -EINVAL;
+
+	err = pm_can_get_txq_status(pm, port);
+	if (err)
+		return err;
+
+	wake_up_interruptible(&priv->wait);
+	err = pm_wait_for_response(pm, port, bcp_can_txq_status);
+	if (err)
+		return err;
+
+	local  = pm->local_txq[port][prio];
+	remote = pm->remote_txq[port][prio];
+
+	if (local != remote) {
+		*lost_txq_sync = true;
+		pm->stats.can_lost_txq_sync[port][prio]++;
+	} else {
+		*lost_txq_sync = false;
+		pm->stats.can_ack_timeout[port][prio]++;
+	}
+
+	pm->local_txq[port][prio] = remote;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(companion_do_get_can_txq_status);
+
+/**
+ * companion_do_get_can_txq_status_all() - get all CAN tx queue status
+ * @parent: address of the parent device
+ * @port:   which CAN port to inquiry
+ */
+int companion_do_get_can_txq_status_all(struct device *parent, u8 port)
+{
+	struct companion_spi_priv *priv = dev_get_drvdata(parent);
+	int                        err;
+
+	err = pm_can_get_txq_status(&priv->pm, port);
+	if (err)
+		return err;
+
+	wake_up_interruptible(&priv->wait);
+	err = pm_wait_for_response(&priv->pm, port, bcp_can_txq_status);
+	if (err)
+		return err;
+
+	memcpy(priv->pm.local_txq[port],
+	       priv->pm.remote_txq[port],
+	       BCP_CAN_PRIOS);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(companion_do_get_can_txq_status_all);
+
+/**
+ * companion_do_can_txq_is_full() - inquiry CAN tx queue is full
+ * @parent:  address of the parent device
+ * @port:    which CAN port to inquiry
+ * @prio:    which CAN queue to inquiry
+ * @is_full: address of flag to store is full or not
+ */
+int companion_do_can_txq_is_full(struct device *parent,
+				 u8             port,
+				 u8             prio,
+				 bool          *is_full)
+{
+	struct companion_spi_priv *priv = dev_get_drvdata(parent);
+
+	return pm_can_txq_is_full(&priv->pm, port, prio, is_full);
+}
+EXPORT_SYMBOL_GPL(companion_do_can_txq_is_full);
+
+/**
+ * companion_do_can_txq_has_space() - inquiry CAN tx queue has space
+ * @parent:    address of the parent device
+ * @port:      which CAN port to inquiry
+ * @prio:      which CAN queue to inquiry
+ * @has_space: address of flag to store has space or not
+ */
+int companion_do_can_txq_has_space(struct device *parent,
+				   u8             port,
+				   u8             prio,
+				   bool          *has_space)
+{
+	struct companion_spi_priv *priv = dev_get_drvdata(parent);
+
+	return pm_can_txq_has_space(&priv->pm, port, prio, has_space);
+}
+EXPORT_SYMBOL_GPL(companion_do_can_txq_has_space);
+
+/**
+ * companion_do_can_start_tx_timer() - start CAN tx timeout detection
+ * @parent: address of the parent device
+ * @port:   which CAN port to start
+ * @prio:   which CAN queue to start
+ */
+int companion_do_can_start_tx_timer(struct device *parent,
+				    u8             port,
+				    u8             prio)
+{
+	struct companion_spi_priv *priv = dev_get_drvdata(parent);
+
+	return pm_can_start_tx_timer(&priv->pm, port, prio);
+}
+EXPORT_SYMBOL_GPL(companion_do_can_start_tx_timer);
+
+/**
+ * companion_do_can_stop_tx_timer() - stop CAN tx timeout detection
+ * @parent: address of the parent device
+ * @port:   which CAN port to stop
+ * @prio:   which CAN queue to stop
+ */
+int companion_do_can_stop_tx_timer(struct device *parent,
+				   u8             port,
+				   u8             prio)
+{
+	struct companion_spi_priv *priv = dev_get_drvdata(parent);
+
+	return pm_can_stop_tx_timer(&priv->pm, port, prio);
+}
+EXPORT_SYMBOL_GPL(companion_do_can_stop_tx_timer);
+
+/**
+ * dump_packets_show() - display dump_packets value in sysfs entry
+ * @dev:  address of the device associated with sysfs entry
+ * @attr: address of the device attribute
+ * @buf:  address of the buffer to encode value
+ */
+static ssize_t dump_packets_show(struct device           *dev,
+				 struct device_attribute *attr,
+				 char                    *buf)
+{
+	struct spi_device         *spi  = to_spi_device(dev);
+	struct companion_spi_priv *priv = spi_get_drvdata(spi);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", priv->dump_packets);
+}
+
+/**
+ * dump_packets_store() - store dump_packets value from sysfs entry
+ * @dev:   address of the device associated with sysfs entry
+ * @attr:  address of the device attribute
+ * @buf:   address of the buffer to decode value
+ * @count: number of bytes in the buffer
+ */
+static ssize_t dump_packets_store(struct device           *dev,
+				  struct device_attribute *attr,
+				  const char              *buf,
+				  size_t                   count)
+{
+	struct spi_device         *spi  = to_spi_device(dev);
+	struct companion_spi_priv *priv = spi_get_drvdata(spi);
+	int                        err;
+
+	err = kstrtobool(buf, &priv->dump_packets);
+	if (err) {
+		dev_err(&spi->dev, "input invalid value: %s\n", buf);
+		return err;
+	}
+
+	return count;
+}
+static DEVICE_ATTR_RW(dump_packets);
+
+/**
+ * overflows_show() - display overflows value in sysfs entry
+ * @dev:  address of the device associated with sysfs entry
+ * @attr: address of the device attribute
+ * @buf:  address of the buffer to encode value
+ */
+static ssize_t overflows_show(struct device           *dev,
+			      struct device_attribute *attr,
+			      char                    *buf)
+{
+	struct spi_device         *spi  = to_spi_device(dev);
+	struct companion_spi_priv *priv = spi_get_drvdata(spi);
+	int                        ret, pos, i, j, total = 0;
+
+	ret = snprintf(buf, PAGE_SIZE, "io\ntx: %u, rx: %u\n\n",
+		       priv->pm.stats.io_tx_overflows,
+		       priv->pm.stats.io_rx_overflows);
+	pos = ret;
+
+	for (i = 0; i < BCP_CAN_PORTS; ++i) {
+		ret  = snprintf(buf + pos, PAGE_SIZE - pos, "can%u\n", i);
+		pos += ret;
+
+		for (j = 0; j < BCP_CAN_PRIOS; ++j) {
+			ret = snprintf(buf + pos, PAGE_SIZE - pos,
+				       "[%u]:%u ", j,
+				       priv->pm.stats.can_tx_overflows[i][j]);
+			total += priv->pm.stats.can_tx_overflows[i][j];
+			pos   += ret;
+		}
+
+		ret  = snprintf(buf + pos, PAGE_SIZE - pos,
+				"\ntx: %u, rx: %u, err: %u\n\n",
+				total,
+				priv->pm.stats.can_rx_overflows[i],
+				priv->pm.stats.can_err_overflows[i]);
+		pos += ret;
+	}
+	return pos;
+}
+static DEVICE_ATTR_RO(overflows);
+
+/**
+ * traffic_show() - display traffic of IO and CAN in sysfs entry
+ * @dev:  address of the device associated with sysfs entry
+ * @attr: address of the device attribute
+ * @buf:  address of the buffer to encode value
+ */
+static ssize_t traffic_show(struct device           *dev,
+			    struct device_attribute *attr,
+			    char                    *buf)
+{
+	struct spi_device         *spi  = to_spi_device(dev);
+	struct companion_spi_priv *priv = spi_get_drvdata(spi);
+	int                        ret, pos, i, j;
+
+	ret = snprintf(buf, PAGE_SIZE, "io\ntx: %u, rx: %u\n\n",
+		       priv->pm.stats.io_tx, priv->pm.stats.io_rx);
+	pos = ret;
+
+	for (i = 0; i < BCP_CAN_PORTS; ++i) {
+		ret  = snprintf(buf + pos, PAGE_SIZE - pos, "can%u\n", i);
+		pos += ret;
+
+		ret  = snprintf(buf + pos, PAGE_SIZE - pos, "tx         : ");
+		pos += ret;
+		for (j = 0; j < BCP_CAN_PRIOS; ++j) {
+			ret  = snprintf(buf + pos, PAGE_SIZE - pos,
+					"[%u]:%u ", j,
+					priv->pm.stats.can_tx[i][j]);
+			pos += ret;
+		}
+
+		ret  = snprintf(buf + pos, PAGE_SIZE - pos, "\nack success: ");
+		pos += ret;
+		for (j = 0; j < BCP_CAN_PRIOS; ++j) {
+			ret  = snprintf(buf + pos, PAGE_SIZE - pos,
+					"[%u]:%u ", j,
+					priv->pm.stats.can_ack_success[i][j]);
+			pos += ret;
+		}
+
+		ret  = snprintf(buf + pos, PAGE_SIZE - pos, "\nack failure: ");
+		pos += ret;
+		for (j = 0; j < BCP_CAN_PRIOS; ++j) {
+			ret  = snprintf(buf + pos, PAGE_SIZE - pos,
+					"[%u]:%u ", j,
+					priv->pm.stats.can_ack_failure[i][j]);
+			pos += ret;
+		}
+
+		ret  = snprintf(buf + pos, PAGE_SIZE - pos, "\nlost seq   : ");
+		pos += ret;
+		for (j = 0; j < BCP_CAN_PRIOS; ++j) {
+			ret  = snprintf(buf + pos, PAGE_SIZE - pos,
+					"[%u]:%u ", j,
+					priv->pm.stats.can_lost_seq_sync[i][j]);
+			pos += ret;
+		}
+
+		ret  = snprintf(buf + pos, PAGE_SIZE - pos, "\nlost txq   : ");
+		pos += ret;
+		for (j = 0; j < BCP_CAN_PRIOS; ++j) {
+			ret  = snprintf(buf + pos, PAGE_SIZE - pos,
+					"[%u]:%u ", j,
+					priv->pm.stats.can_lost_txq_sync[i][j]);
+			pos += ret;
+		}
+
+		ret  = snprintf(buf + pos, PAGE_SIZE - pos, "\nack timeout: ");
+		pos += ret;
+		for (j = 0; j < BCP_CAN_PRIOS; ++j) {
+			ret  = snprintf(buf + pos, PAGE_SIZE - pos,
+					"[%u]:%u ", j,
+					priv->pm.stats.can_ack_timeout[i][j]);
+			pos += ret;
+		}
+
+		ret  = snprintf(buf + pos, PAGE_SIZE - pos, "\nack unexpect:");
+		pos += ret;
+		for (j = 0; j < BCP_CAN_PRIOS; ++j) {
+			ret  = snprintf(buf + pos, PAGE_SIZE - pos,
+					"[%u]:%u ", j,
+					priv->pm.stats.can_ack_unexpect[i][j]);
+			pos += ret;
+		}
+
+		ret  = snprintf(buf + pos, PAGE_SIZE - pos,
+				"\nrx         : %u\nerr        : %u\n\n",
+				priv->pm.stats.can_rx[i],
+				priv->pm.stats.can_err[i]);
+		pos += ret;
+	}
+	return pos;
+}
+static DEVICE_ATTR_RO(traffic);
+
+/**
+ * can_space_show() - display CAN queue space in sysfs entry
+ * @dev:  address of the device associated with sysfs entry
+ * @attr: address of the device attribute
+ * @buf:  address of the buffer to encode value
+ */
+static ssize_t can_space_show(struct device           *dev,
+			      struct device_attribute *attr,
+			      char                    *buf)
+{
+	struct spi_device         *spi  = to_spi_device(dev);
+	struct companion_spi_priv *priv = spi_get_drvdata(spi);
+	int                        i, j, ret, pos = 0;
+
+	for (i = 0; i < BCP_CAN_PORTS; ++i) {
+		ret  = snprintf(buf + pos, PAGE_SIZE - pos, "can%u\n", i);
+		pos += ret;
+
+		ret  = snprintf(buf + pos, PAGE_SIZE - pos, "local : ");
+		pos += ret;
+		for (j = 0; j < BCP_CAN_PRIOS; ++j) {
+			ret  = snprintf(buf + pos, PAGE_SIZE - pos,
+					"[%u]:%u ", j,
+					priv->pm.local_txq[i][j]);
+			pos += ret;
+		}
+
+		ret  = snprintf(buf + pos, PAGE_SIZE - pos, "\nremote: ");
+		pos += ret;
+		for (j = 0; j < BCP_CAN_PRIOS; ++j) {
+			ret  = snprintf(buf + pos, PAGE_SIZE - pos,
+					"[%u]:%u ", j,
+					priv->pm.remote_txq[i][j]);
+			pos += ret;
+		}
+
+		ret  = snprintf(buf + pos, PAGE_SIZE - pos, "\n\n");
+		pos += ret;
+	}
+	return pos;
+}
+static DEVICE_ATTR_RO(can_space);
+
+/**
+ * busy_show() - display busy signal statisitics in sysfs entry
+ * @dev:  address of the device associated with sysfs entry
+ * @attr: address of the device attribute
+ * @buf:  address of the buffer to encode value
+ */
+static ssize_t busy_show(struct device           *dev,
+			 struct device_attribute *attr,
+			 char                    *buf)
+{
+	struct spi_device         *spi  = to_spi_device(dev);
+	struct companion_spi_priv *priv = spi_get_drvdata(spi);
+
+	return snprintf(buf, PAGE_SIZE,
+			"while_busy_ext       : %u\n"
+			"while_busy_fail      : %u\n"
+			"until_busy_ext       : %u\n"
+			"until_busy_fail      : %u\n"
+			"force_started        : %u\n"
+			"force_started_failure: %u\n"
+			"ready_failure        : %u\n",
+			priv->stats.while_busy_ext,
+			priv->stats.while_busy_fail,
+			priv->stats.until_busy_ext,
+			priv->stats.until_busy_fail,
+			priv->stats.force_started,
+			priv->stats.force_started_failure,
+			priv->stats.ready_failure);
+}
+static DEVICE_ATTR_RO(busy);
+
+static struct attribute *companion_spi_sysfs_attrs[] = {
+	&dev_attr_dump_packets.attr,
+	&dev_attr_overflows.attr,
+	&dev_attr_traffic.attr,
+	&dev_attr_can_space.attr,
+	&dev_attr_busy.attr,
+	NULL
+};
+
+static struct attribute_group companion_spi_attribute_group = {
+	.attrs = companion_spi_sysfs_attrs
+};
+
+/**
+ * slave_has_request() - inquiry spi slave has request
+ * @priv: address of companion-spi private data
+ */
+static inline bool slave_has_request(struct companion_spi_priv *priv)
+{
+	return gpiod_get_value_cansleep(priv->gpiod_request) != 0;
+}
+
+/**
+ * slave_is_busy() - inquiry spi slave is busy
+ * @priv: address of companion-spi private data
+ */
+static inline bool slave_is_busy(struct companion_spi_priv *priv)
+{
+	return gpiod_get_value_cansleep(priv->gpiod_busy) != 0;
+}
+
+/**
+ * slave_is_not_busy() - inquiry spi slave is not busy
+ * @priv: address of companion-spi private data
+ */
+static inline bool slave_is_not_busy(struct companion_spi_priv *priv)
+{
+	return gpiod_get_value_cansleep(priv->gpiod_busy) == 0;
+}
+
+/**
+ * slave_select() - select spi slave
+ * @priv: address of companion-spi private data
+ */
+static inline void slave_select(struct companion_spi_priv *priv)
+{
+	gpiod_set_value_cansleep(priv->gpiod_cs, 1);
+}
+
+/**
+ * slave_deselect() - deselect spi slave
+ * @priv: address of companion-spi private data
+ */
+static inline void slave_deselect(struct companion_spi_priv *priv)
+{
+	gpiod_set_value_cansleep(priv->gpiod_cs, 0);
+}
+
+/**
+ * companion_spi_wait_while_busy() - wait while spi slave is busy
+ * @priv: address of companion-spi private data
+ */
+static int companion_spi_wait_while_busy(struct companion_spi_priv *priv)
+{
+	unsigned int count;
+
+	/*
+	 * as short as possible wait while busy polling which shall
+	 * succeed most of the times
+	 */
+	count = READY_POLL_US / READY_POLL_US_GRAN;
+	do {
+		if (slave_is_not_busy(priv))
+			return 0;
+
+		udelay(READY_POLL_US_GRAN);
+	} while (--count);
+
+	/*
+	 * wait while busy polling with sleeping, in case companion
+	 * is busy with other things, this shall happen rarely
+	 */
+	count = READY_POLL_MS / READY_POLL_MS_GRAN;
+	do {
+		if (slave_is_not_busy(priv)) {
+			priv->stats.while_busy_ext++;
+			dev_info(&priv->spi->dev,
+				 "waited long while busy (%u)\n",
+				 priv->stats.while_busy_ext);
+			return 0;
+		}
+
+		msleep(READY_POLL_MS_GRAN);
+	} while (--count);
+
+	priv->stats.while_busy_fail++;
+	dev_err(&priv->spi->dev,
+		"time out waiting for busy deassertion (%u)\n",
+		priv->stats.while_busy_fail);
+	return -EBUSY;
+}
+
+/**
+ * companion_spi_wait_until_busy() - wait until spi slave is busy
+ * @priv: address of companion-spi private data
+ */
+static int companion_spi_wait_until_busy(struct companion_spi_priv *priv)
+{
+	unsigned int count;
+
+	/*
+	 * as short as possible wait until busy polling which shall
+	 * succeed most of the times
+	 */
+	count = READY_POLL_US / READY_POLL_US_GRAN;
+	do {
+		if (slave_is_busy(priv))
+			return 0;
+
+		udelay(READY_POLL_US_GRAN);
+	} while (--count);
+
+	/*
+	 * wait until busy polling with sleeping, in case companion
+	 * is busy with other things, this shall happen rarely
+	 */
+	count = READY_POLL_MS / READY_POLL_MS_GRAN;
+	do {
+		if (slave_is_busy(priv)) {
+			priv->stats.until_busy_ext++;
+			dev_info(&priv->spi->dev,
+				 "waited long until busy (%u)\n",
+				 priv->stats.until_busy_ext);
+			return 0;
+		}
+
+		msleep(READY_POLL_MS_GRAN);
+	} while (--count);
+
+	priv->stats.until_busy_fail++;
+	dev_err(&priv->spi->dev,
+		"time out waiting for busy assertion (%u)\n",
+		priv->stats.until_busy_fail);
+	return -EBUSY;
+}
+
+/**
+ * companion_spi_cpu_to_be32() - convert companion packet to big endian 32 bit
+ * @buf: address of the packet to convert
+ */
+static void companion_spi_cpu_to_be32(char *buf)
+{
+	u32 *buf32 = (u32 *)buf;
+	int  i;
+
+	for (i = 0; i < (BCP_PACKET_SIZE / sizeof(u32)); i++, buf32++)
+		*buf32 = cpu_to_be32(*buf32);
+}
+
+/**
+ * companion_spi_be32_to_cpu() - convert companion packet from big endian 32 bit
+ * @buf: address of the packet to convert
+ */
+static void companion_spi_be32_to_cpu(char *buf)
+{
+	u32 *buf32 = (u32 *)buf;
+	int  i;
+
+	for (i = 0; i < (BCP_PACKET_SIZE / sizeof(u32)); i++, buf32++)
+		*buf32 = be32_to_cpu(*buf32);
+}
+
+/**
+ * companion_spi_transceive() - transceive spi message
+ * @priv:     address of companion-spi private data
+ * @message:  address of the spi message to transceive
+ * @transfer: address of the spi transfer
+ */
+static void companion_spi_transceive(struct companion_spi_priv *priv,
+				     struct spi_message        *message,
+				     struct spi_transfer       *transfer)
+{
+	const struct companion_packet *p;
+	int                            err;
+
+	if (priv->dump_packets) {
+		p = transfer->tx_buf;
+		dump_packet(p, KERN_INFO, DRIVER_NAME" Tx: ");
+	}
+
+	companion_spi_cpu_to_be32((char *)transfer->tx_buf);
+
+	spi_message_init_with_transfers(message, transfer, 1);
+
+	err = companion_spi_wait_while_busy(priv);
+
+	slave_select(priv);
+
+	if (err) {
+		priv->stats.force_started++;
+		dev_err(&priv->spi->dev,
+			"force started transfer (%u)\n",
+			priv->stats.force_started);
+
+		/* wait slave to pull up busy line in case force started */
+		err = companion_spi_wait_while_busy(priv);
+		if (err) {
+			priv->stats.force_started_failure++;
+			dev_err(&priv->spi->dev,
+				"force started failed, continuing (%u)\n",
+				priv->stats.force_started_failure);
+		}
+	}
+
+	err = companion_spi_wait_until_busy(priv);
+	if (err) {
+		priv->stats.ready_failure++;
+		dev_err(&priv->spi->dev,
+			"started transfer in case not ready (%u)\n",
+			priv->stats.ready_failure);
+	}
+
+	err = spi_sync(priv->spi, message);
+	if (err)
+		dev_err(&priv->spi->dev,
+			"sending spi message failed: %d\n",
+			message->status);
+
+	slave_deselect(priv);
+
+	companion_spi_be32_to_cpu(transfer->rx_buf);
+
+	if (priv->dump_packets) {
+		p = transfer->rx_buf;
+		dump_packet(p, KERN_INFO, DRIVER_NAME" Rx: ");
+	}
+}
+
+/**
+ * companion_spi_request_irq() - irq handler of request signal
+ * @irq:  irq number of request signal
+ * @data: address of user supplied data for irq handler
+ */
+static irqreturn_t companion_spi_request_irq(int irq, void *data)
+{
+	struct companion_spi_priv *priv = data;
+
+	wake_up_interruptible(&priv->wait);
+	return IRQ_HANDLED;
+}
+
+/**
+ * companion_spi_thread() - main thread to drive spi communication
+ * @data: address of user supplied data for thread
+ */
+static int companion_spi_thread(void *data)
+{
+	struct companion_spi_priv *priv = data;
+	struct companion_packet    tx_packet;
+	struct companion_packet    rx_packet;
+	struct spi_message         message;
+	struct spi_transfer        transfer;
+
+	memset(&transfer, 0, sizeof(transfer));
+	transfer.tx_buf        = tx_packet.data;
+	transfer.rx_buf        = rx_packet.data;
+	transfer.len           = sizeof(struct companion_packet);
+	transfer.cs_change     = 0;
+	transfer.bits_per_word = 32;
+
+	do {
+		if (wait_event_interruptible(priv->wait,
+					     kthread_should_stop()   ||
+					     slave_has_request(priv) ||
+					     qm_has_tx_data(&priv->pm.qm)))
+			continue;
+
+		if (kthread_should_stop())
+			break;
+
+		pm_prepare_tx(&priv->pm, &tx_packet);
+		companion_spi_transceive(priv, &message, &transfer);
+		pm_on_tx_done(&priv->pm);
+		pm_on_rx_done(&priv->pm, &rx_packet);
+	} while (!kthread_should_stop());
+
+	return 0;
+}
+
+static const struct of_device_id companion_spi_of_match[] = {
+	{ .compatible = "bosch,companion-spi", .data = NULL, },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, companion_spi_of_match);
+
+/**
+ * companion_spi_parse_dt() - parse device tree
+ * @priv: address of companion-spi private data
+ */
+static int companion_spi_parse_dt(struct companion_spi_priv *priv)
+{
+	struct device      *dev = &priv->spi->dev;
+	struct device_node *np  = dev->of_node;
+	int                 err;
+
+	if (!np) {
+		dev_err(dev, "no device tree data\n");
+		return -EINVAL;
+	}
+
+	priv->gpiod_request = devm_gpiod_get(dev, "request", GPIOD_IN);
+	if (IS_ERR(priv->gpiod_request)) {
+		err = PTR_ERR(priv->gpiod_request);
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "invalid 'request-gpios':%d\n", err);
+		return err;
+	}
+
+	priv->gpiod_busy = devm_gpiod_get(dev, "busy", GPIOD_IN);
+	if (IS_ERR(priv->gpiod_busy)) {
+		err = PTR_ERR(priv->gpiod_busy);
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "invalid 'busy-gpios':%d\n", err);
+		return err;
+	}
+
+	priv->gpiod_cs = devm_gpiod_get(dev, "cs", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->gpiod_cs)) {
+		err = PTR_ERR(priv->gpiod_cs);
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "invalid 'cs-gpios':%d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+/**
+ * companion_spi_probe() - probe callback
+ * @spi: address of the spi device
+ */
+static int companion_spi_probe(struct spi_device *spi)
+{
+	struct companion_spi_priv *priv;
+	u8                         null_packet[BCP_PACKET_SIZE] = {0};
+	int                        err;
+
+	priv = devm_kzalloc(&spi->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->spi = spi;
+	init_waitqueue_head(&priv->wait);
+	pm_init(&priv->pm);
+
+	err = companion_spi_parse_dt(priv);
+	if (err)
+		return err;
+
+	spi->mode = SPI_MODE_1;
+
+	err = spi_setup(spi);
+	if (err) {
+		dev_err(&spi->dev, "spi_setup() returns: %d\n", err);
+		return err;
+	}
+
+	err = spi_write(spi, null_packet, sizeof(null_packet));
+	if (err) {
+		dev_err(&spi->dev, "dummy transfer failed: %d\n", err);
+		return err;
+	}
+
+	spi_set_drvdata(spi, priv);
+
+	err = sysfs_create_group(&spi->dev.kobj,
+				 &companion_spi_attribute_group);
+	if (err) {
+		dev_err(&spi->dev, "sysfs_create_group() returns: %d\n", err);
+		return err;
+	}
+
+	priv->task = kthread_run(companion_spi_thread, priv, DRIVER_NAME);
+	if (!priv->task)
+		return -EIO;
+
+	err = devm_request_irq(&spi->dev,
+			       gpiod_to_irq(priv->gpiod_request),
+			       companion_spi_request_irq,
+			       IRQF_TRIGGER_FALLING,
+			       "companion-spi-request",
+			       priv);
+	if (err)
+		return -ENODEV;
+
+	return of_platform_populate(spi->dev.of_node, NULL, NULL, &spi->dev);
+}
+
+/**
+ * companion_spi_remove() - remove callback
+ * @spi: address of the spi device
+ */
+static int companion_spi_remove(struct spi_device *spi)
+{
+	struct companion_spi_priv *priv = spi_get_drvdata(spi);
+
+	qm_reset(&priv->pm.qm);
+	kthread_stop(priv->task);
+	sysfs_remove_group(&spi->dev.kobj, &companion_spi_attribute_group);
+	of_platform_depopulate(&spi->dev);
+	return 0;
+}
+
+static struct spi_driver companion_spi_driver = {
+	.driver = {
+		.name           = DRIVER_NAME,
+		.of_match_table = of_match_ptr(companion_spi_of_match),
+	},
+	.probe  = companion_spi_probe,
+	.remove = companion_spi_remove,
+};
+module_spi_driver(companion_spi_driver);
+
+MODULE_AUTHOR("Zhu Yi <yi.zhu5@cn.bosch.com>");
+MODULE_DESCRIPTION("Companion low level init/core code");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/spi/companion/protocol-manager.c b/drivers/spi/companion/protocol-manager.c
new file mode 100644
index 0000000..1b09c27
--- /dev/null
+++ b/drivers/spi/companion/protocol-manager.c
@@ -0,0 +1,1032 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Companion protocol manager code
+ *
+ * Copyright (C) 2015-2018 Bosch Sicherheitssysteme GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "protocol-manager.h"
+
+#define PM_RESPONSE_TIMEOUT HZ
+#define PM_CAN_TX_TIMEOUT   msecs_to_jiffies(30000)
+
+/**
+ * struct companion_filter - companion packet filter
+ * @node:    filter list node
+ * @match:   address of match callback
+ * @process: address of process callback
+ */
+struct companion_filter {
+	struct list_head node;
+	bool (*match)(const struct companion_packet *p);
+	void (*process)(struct companion_protocol_manager *pm,
+			const struct companion_packet     *p);
+};
+
+/**
+ * null_match() - match null packet
+ * @p: address of the packet to handle
+ */
+static bool null_match(const struct companion_packet *p)
+{
+	return is_null_type(p);
+}
+
+/**
+ * io_match() - match IO packet
+ * @p: address of the packet to handle
+ */
+static bool io_match(const struct companion_packet *p)
+{
+	return is_io_type(p);
+}
+
+/**
+ * io_process() - process IO packet
+ * @pm: address of the protocol manager
+ * @p:  address of the packet to handle
+ */
+static void io_process(struct companion_protocol_manager *pm,
+		       const struct companion_packet     *p)
+{
+	if (qm_io_rxq_in(&pm->qm, p)) {
+		down_read(&pm->io_lock);
+		if (pm->io_ops && pm->io_ops->on_rx_done)
+			pm->io_ops->on_rx_done(pm->io_data);
+		up_read(&pm->io_lock);
+
+		pm->stats.io_rx++;
+	} else {
+		pm->stats.io_rx_overflows++;
+	}
+}
+
+/**
+ * can_data_match() - match CAN data packet
+ * @p: address of the packet to handle
+ */
+static bool can_data_match(const struct companion_packet *p)
+{
+	return ((const struct can_data_frame *)p)->type == BCP_CAN_DATA;
+}
+
+/**
+ * can_data_process() - process CAN data packet
+ * @pm: address of the protocol manager
+ * @p:  address of the packet to handle
+ */
+static void can_data_process(struct companion_protocol_manager *pm,
+			     const struct companion_packet     *p)
+{
+	u8 port = ((const struct can_data_frame *)p)->port - 1;
+
+	if (port >= BCP_CAN_PORTS)
+		return;
+
+	if (qm_can_rxq_in(&pm->qm, p, port)) {
+		down_read(&pm->can_lock[port]);
+		if (pm->can_ops[port] && pm->can_ops[port]->on_rx_done)
+			pm->can_ops[port]->on_rx_done(pm->can_data[port]);
+		up_read(&pm->can_lock[port]);
+
+		pm->stats.can_rx[port]++;
+	} else {
+		pm->stats.can_rx_overflows[port]++;
+	}
+}
+
+/**
+ * can_bittiming_match() - match CAN bittiming packet
+ * @p: address of the packet to handle
+ */
+static bool can_bittiming_match(const struct companion_packet *p)
+{
+	return ((const struct can_bittiming_response *)p)->type ==
+		BCP_CAN_BITTIMING;
+}
+
+/**
+ * can_bittiming_process() - process CAN bittiming packet
+ * @pm: address of the protocol manager
+ * @p:  address of the packet to handle
+ */
+static void can_bittiming_process(struct companion_protocol_manager *pm,
+				  const struct companion_packet     *p)
+{
+	u8 port   = ((const struct can_bittiming_response *)p)->port - 1;
+	u8 status = ((const struct can_bittiming_response *)p)->status;
+
+	if (port >= BCP_CAN_PORTS)
+		return;
+
+	if (status == BCP_STATUS_SUCCESS) {
+		pm->response[port][bcp_can_bittiming] = 0;
+		pm->stats.can_ack_success[port][0]++;
+	} else {
+		pm->response[port][bcp_can_bittiming] = -EINVAL;
+		pm->stats.can_ack_failure[port][0]++;
+	}
+
+	if (test_and_clear_bit(bcp_can_bittiming, &pm->flags[port]))
+		wake_up_interruptible_all(&pm->wait[port]);
+}
+
+/**
+ * can_mode_match() - match CAN mode packet
+ * @p: address of the packet to handle
+ */
+static bool can_mode_match(const struct companion_packet *p)
+{
+	return ((const struct can_mode_response *)p)->type ==
+		BCP_CAN_MODE;
+}
+
+/**
+ * can_mode_process() - process CAN mode packet
+ * @pm: address of the protocol manager
+ * @p:  address of the packet to handle
+ */
+static void can_mode_process(struct companion_protocol_manager *pm,
+			     const struct companion_packet     *p)
+{
+	u8 port   = ((const struct can_mode_response *)p)->port - 1;
+	u8 status = ((const struct can_mode_response *)p)->status;
+
+	if (port >= BCP_CAN_PORTS)
+		return;
+
+	if (status == BCP_STATUS_SUCCESS) {
+		pm->response[port][bcp_can_mode] = 0;
+		pm->stats.can_ack_success[port][0]++;
+	} else {
+		pm->response[port][bcp_can_mode] = -EINVAL;
+		pm->stats.can_ack_failure[port][0]++;
+	}
+
+	if (test_and_clear_bit(bcp_can_mode, &pm->flags[port]))
+		wake_up_interruptible_all(&pm->wait[port]);
+}
+
+/**
+ * can_status_match() - match CAN status packet
+ * @p: address of the packet to handle
+ */
+static bool can_status_match(const struct companion_packet *p)
+{
+	return ((const struct can_status_response *)p)->type ==
+		BCP_CAN_STATUS;
+}
+
+/**
+ * can_status_process() - process CAN status packet
+ * @pm: address of the protocol manager
+ * @p:  address of the packet to handle
+ */
+static void can_status_process(struct companion_protocol_manager *pm,
+			       const struct companion_packet     *p)
+{
+	u8 port   = ((const struct can_status_response *)p)->port - 1;
+	u8 rx_err = ((const struct can_status_response *)p)->rx_err;
+	u8 tx_err = ((const struct can_status_response *)p)->tx_err;
+	u8 status = ((const struct can_status_response *)p)->status;
+
+	if (port >= BCP_CAN_PORTS)
+		return;
+
+	if (status == BCP_STATUS_SUCCESS) {
+		pm->response[port][bcp_can_status] = 0;
+		pm->rx_err[port]                   = rx_err;
+		pm->tx_err[port]                   = tx_err;
+
+		if (test_bit(bcp_can_status, &pm->flags[port])) {
+			pm->stats.can_ack_success[port][0]++;
+			goto polling_out;
+		}
+
+		if (qm_can_err_in(&pm->qm, p, port)) {
+			down_read(&pm->can_lock[port]);
+			if (pm->can_ops[port] && pm->can_ops[port]->on_error)
+				pm->can_ops[port]->on_error(pm->can_data[port]);
+			up_read(&pm->can_lock[port]);
+
+			pm->stats.can_err[port]++;
+		} else {
+			pm->stats.can_err_overflows[port]++;
+		}
+	} else {
+		pm->response[port][bcp_can_status] = -EINVAL;
+		if (test_bit(bcp_can_status, &pm->flags[port]))
+			pm->stats.can_ack_failure[port][0]++;
+	}
+
+polling_out:
+	if (test_and_clear_bit(bcp_can_status, &pm->flags[port]))
+		wake_up_interruptible_all(&pm->wait[port]);
+}
+
+/**
+ * can_tx_ack_match() - match CAN tx acknowledge packet
+ * @p: address of the packet to handle
+ */
+static bool can_tx_ack_match(const struct companion_packet *p)
+{
+	return ((const struct can_tx_acknowledge *)p)->type ==
+		BCP_CAN_TX_ACK;
+}
+
+/**
+ * can_tx_ack_process() - process CAN tx acknowledge packet
+ * @pm: address of the protocol manager
+ * @p:  address of the packet to handle
+ */
+static void can_tx_ack_process(struct companion_protocol_manager *pm,
+			       const struct companion_packet     *p)
+{
+	u8   port     = ((const struct can_tx_acknowledge *)p)->port - 1;
+	u8   prio     = ((const struct can_tx_acknowledge *)p)->prio;
+	u8   sequence = ((const struct can_tx_acknowledge *)p)->sequence;
+	u8   status   = ((const struct can_tx_acknowledge *)p)->status;
+	u8   space    = ((const struct can_tx_acknowledge *)p)->space;
+	bool lost_seq = false;
+
+	if (port >= BCP_CAN_PORTS || prio >= BCP_CAN_PRIOS)
+		return;
+
+	/* local_txq will be decreased after kernel sent data to companion,
+	 * remote_txq will be increased after companion send ack to kernel,
+	 * so local_txq < remote_txq should be guaranteed. Otherwise, kernel
+	 * received unexpected ack, hence ignore it.
+	 */
+	pm->remote_txq[port][prio] = space;
+	if (pm->local_txq[port][prio] >= space) {
+		pm->stats.can_ack_unexpect[port][prio]++;
+		return;
+	}
+
+	pm->local_txq[port][prio]++;
+	pm->sequence[port][prio]++;
+	if (pm->sequence[port][prio] != sequence) {
+		lost_seq                 = true;
+		pm->sequence[port][prio] = sequence;
+		pm->stats.can_lost_seq_sync[port][prio]++;
+	}
+
+	down_read(&pm->can_lock[port]);
+	if (pm->can_ops[port] && pm->can_ops[port]->on_tx_done)
+		pm->can_ops[port]->on_tx_done(pm->can_data[port],
+					      prio,
+					      lost_seq,
+					      status == BCP_STATUS_SUCCESS);
+	up_read(&pm->can_lock[port]);
+
+	if (status == BCP_STATUS_SUCCESS)
+		pm->stats.can_ack_success[port][prio]++;
+	else
+		pm->stats.can_ack_failure[port][prio]++;
+}
+
+/**
+ * can_txq_status_match() - match CAN tx queue status packet
+ * @p: address of the packet to handle
+ */
+static bool can_txq_status_match(const struct companion_packet *p)
+{
+	return ((const struct can_txq_status_response *)p)->type ==
+		BCP_CAN_TX_QUEUE_STATUS;
+}
+
+/**
+ * can_txq_status_process() - process CAN tx queue status packet
+ * @pm: address of the protocol manager
+ * @p:  address of the packet to handle
+ */
+static void can_txq_status_process(struct companion_protocol_manager *pm,
+				   const struct companion_packet     *p)
+{
+	u8        port  = ((const struct can_txq_status_response *)p)->port - 1;
+	const u8 *space = ((const struct can_txq_status_response *)p)->space;
+	u8       status = ((const struct can_txq_status_response *)p)->status;
+
+	if (port >= BCP_CAN_PORTS)
+		return;
+
+	if (status == BCP_STATUS_SUCCESS) {
+		memcpy(pm->remote_txq[port], space, BCP_CAN_PRIOS);
+		pm->response[port][bcp_can_txq_status] = 0;
+		pm->stats.can_ack_success[port][0]++;
+	} else {
+		pm->response[port][bcp_can_txq_status] = -EINVAL;
+		pm->stats.can_ack_failure[port][0]++;
+	}
+
+	if (test_and_clear_bit(bcp_can_txq_status, &pm->flags[port]))
+		wake_up_interruptible_all(&pm->wait[port]);
+}
+
+/**
+ * unknown_match() - match unknown packet
+ * @p: address of the packet to handle
+ */
+static bool unknown_match(const struct companion_packet *p)
+{
+	return true;
+}
+
+/**
+ * unknown_process() - process unknown packet
+ * @pm: address of the protocol manager
+ * @p:  address of the packet to handle
+ */
+static void unknown_process(struct companion_protocol_manager *pm,
+			    const struct companion_packet     *p)
+{
+	dump_packet(p, KERN_ERR, "Unknown packet: ");
+}
+
+static struct companion_filter null_filter = {
+	.node    = LIST_HEAD_INIT(null_filter.node),
+	.match   = null_match,
+	.process = NULL,
+};
+
+static struct companion_filter io_filter = {
+	.node    = LIST_HEAD_INIT(io_filter.node),
+	.match   = io_match,
+	.process = io_process,
+};
+
+static struct companion_filter can_data_filter = {
+	.node    = LIST_HEAD_INIT(can_data_filter.node),
+	.match   = can_data_match,
+	.process = can_data_process,
+};
+
+static struct companion_filter can_bittiming_filter = {
+	.node    = LIST_HEAD_INIT(can_bittiming_filter.node),
+	.match   = can_bittiming_match,
+	.process = can_bittiming_process,
+};
+
+static struct companion_filter can_mode_filter = {
+	.node    = LIST_HEAD_INIT(can_mode_filter.node),
+	.match   = can_mode_match,
+	.process = can_mode_process,
+};
+
+static struct companion_filter can_status_filter = {
+	.node    = LIST_HEAD_INIT(can_status_filter.node),
+	.match   = can_status_match,
+	.process = can_status_process,
+};
+
+static struct companion_filter can_tx_ack_filter = {
+	.node    = LIST_HEAD_INIT(can_tx_ack_filter.node),
+	.match   = can_tx_ack_match,
+	.process = can_tx_ack_process,
+};
+
+static struct companion_filter can_txq_status_filter = {
+	.node    = LIST_HEAD_INIT(can_txq_status_filter.node),
+	.match   = can_txq_status_match,
+	.process = can_txq_status_process,
+};
+
+static struct companion_filter unknown_filter = {
+	.node    = LIST_HEAD_INIT(unknown_filter.node),
+	.match   = unknown_match,
+	.process = unknown_process,
+};
+
+/**
+ * to_timer_data() - helper to access companion_timer_data in work_struct
+ * @ws: address of the work_struct object
+ */
+static struct companion_timer_data *to_timer_data(struct work_struct *ws)
+{
+	return container_of(ws, struct companion_timer_data, work);
+}
+
+/**
+ * pm_can_tx_timeout_callback() - CAN tx timeout callback
+ * @ws: address of the work_struct object
+ */
+static void pm_can_tx_timeout_callback(struct work_struct *ws)
+{
+	struct companion_timer_data       *td   = to_timer_data(ws);
+	struct companion_protocol_manager *pm   = td->pm;
+	u8                                 port = td->port;
+	u8                                 prio = td->prio;
+
+	down_read(&pm->can_lock[port]);
+	if (pm->can_ops[port] && pm->can_ops[port]->on_tx_timeout)
+		pm->can_ops[port]->on_tx_timeout(pm->can_data[port], prio);
+	up_read(&pm->can_lock[port]);
+}
+
+/**
+ * pm_can_on_tx_timeout() - CAN tx timeout handler
+ * @tl: address of the timer_list object
+ */
+static void pm_can_on_tx_timeout(struct timer_list *tl)
+{
+	struct companion_timer *ct = from_timer(ct, tl, timer);
+
+	schedule_work(&ct->data.work);
+}
+
+#define CHECK_SIZE(x) \
+	BUILD_BUG_ON(sizeof(struct companion_packet) != sizeof(x))
+
+/**
+ * pm_init() - initialize the protocol manager
+ * @pm: address of the protocol manager to be initialized
+ */
+void pm_init(struct companion_protocol_manager *pm)
+{
+	int i;
+
+	/* sanity check for correct packet size at compile time */
+	CHECK_SIZE(struct can_data_frame);
+	CHECK_SIZE(struct can_bittiming_request);
+	CHECK_SIZE(struct can_bittiming_response);
+	CHECK_SIZE(struct can_mode_request);
+	CHECK_SIZE(struct can_mode_response);
+	CHECK_SIZE(struct can_status_request);
+	CHECK_SIZE(struct can_status_response);
+	CHECK_SIZE(struct can_tx_acknowledge);
+	CHECK_SIZE(struct can_txq_status_request);
+	CHECK_SIZE(struct can_txq_status_response);
+
+
+	init_rwsem(&pm->io_lock);
+	for (i = 0; i < BCP_CAN_PORTS; ++i) {
+		init_rwsem(&pm->can_lock[i]);
+		init_waitqueue_head(&pm->wait[i]);
+	}
+
+	qm_init(&pm->qm);
+
+	INIT_LIST_HEAD(&pm->filters);
+	list_add_tail(&null_filter.node,           &pm->filters);
+	list_add_tail(&io_filter.node,             &pm->filters);
+	list_add_tail(&can_data_filter.node,       &pm->filters);
+	list_add_tail(&can_tx_ack_filter.node,     &pm->filters);
+	list_add_tail(&can_bittiming_filter.node,  &pm->filters);
+	list_add_tail(&can_mode_filter.node,       &pm->filters);
+	list_add_tail(&can_status_filter.node,     &pm->filters);
+	list_add_tail(&can_txq_status_filter.node, &pm->filters);
+	list_add_tail(&unknown_filter.node,        &pm->filters);
+}
+
+/**
+ * pm_io_ops_register() - register companion IO packets handler
+ * @pm:   address of the protocol manager to be registered
+ * @ops:  address of the IO packets callback
+ * @data: address of the IO packets callback argument
+ */
+int pm_io_ops_register(struct companion_protocol_manager *pm,
+		       struct companion_io_ops           *ops,
+		       void                              *data)
+{
+	int result = 0;
+
+	down_write(&pm->io_lock);
+	if (pm->io_ops) {
+		result = -EEXIST;
+		goto out;
+	}
+
+	qm_reset_io(&pm->qm);
+	pm->io_ops  = ops;
+	pm->io_data = data;
+
+out:
+	up_write(&pm->io_lock);
+	return result;
+}
+
+/**
+ * pm_io_ops_unregister() - unregister companion IO packets handler
+ * @pm: address of the protocol manager to be unregistered
+ */
+int pm_io_ops_unregister(struct companion_protocol_manager *pm)
+{
+	int result = 0;
+
+	down_write(&pm->io_lock);
+	if (!pm->io_ops) {
+		result = -ENODEV;
+		goto out;
+	}
+
+	pm->io_ops  = NULL;
+	pm->io_data = NULL;
+	qm_reset_io(&pm->qm);
+
+out:
+	up_write(&pm->io_lock);
+	return result;
+}
+
+/**
+ * pm_can_ops_register() -  register companion CAN packets handler
+ * @pm:   address of the protocol manager to be registered
+ * @port: port number of which CAN to be registered
+ * @ops:  address of the CAN packets callback
+ * @data: address of the CAN packets callback argument
+ */
+int pm_can_ops_register(struct companion_protocol_manager *pm,
+			u8                                 port,
+			struct companion_can_ops          *ops,
+			void                              *data)
+{
+	int i, result = 0;
+
+	if (port >= BCP_CAN_PORTS)
+		return -EINVAL;
+
+	down_write(&pm->can_lock[port]);
+	if (pm->can_ops[port]) {
+		result = -EEXIST;
+		goto out;
+	}
+
+	qm_reset_can(&pm->qm, port);
+	pm->can_ops[port]  = ops;
+	pm->can_data[port] = data;
+
+	for (i = 0; i < BCP_CAN_PRIOS; ++i) {
+		pm->timer[port][i].data.pm   = pm;
+		pm->timer[port][i].data.port = port;
+		pm->timer[port][i].data.prio = i;
+		INIT_WORK(&pm->timer[port][i].data.work,
+			  pm_can_tx_timeout_callback);
+		timer_setup(&pm->timer[port][i].timer, pm_can_on_tx_timeout, 0);
+	}
+
+out:
+	up_write(&pm->can_lock[port]);
+	return result;
+}
+
+/**
+ * pm_can_ops_unregister() - unregister companion CAN packets handler
+ * @pm:   address of the protocol manager to be unregistered
+ * @port: port number of which CAN to be unregistered
+ */
+int pm_can_ops_unregister(struct companion_protocol_manager *pm, u8 port)
+{
+	int i, result = 0;
+
+	if (port >= BCP_CAN_PORTS)
+		return -EINVAL;
+
+	down_write(&pm->can_lock[port]);
+	if (!pm->can_ops[port]) {
+		result = -ENODEV;
+		goto out;
+	}
+
+	pm->can_ops[port]  = NULL;
+	pm->can_data[port] = NULL;
+	qm_reset_can(&pm->qm, port);
+
+	for (i = 0; i < BCP_CAN_PRIOS; ++i) {
+		del_timer_sync(&pm->timer[port][i].timer);
+		cancel_work_sync(&pm->timer[port][i].data.work);
+		pm->timer[port][i].data.pm   = NULL;
+		pm->timer[port][i].data.port = 0;
+		pm->timer[port][i].data.prio = 0;
+	}
+
+out:
+	up_write(&pm->can_lock[port]);
+	return result;
+}
+
+/**
+ * pm_prepare_tx() - prepare tx data
+ * @pm: address of the protocol manager to be used
+ * @p:  address of the data to be sent
+ */
+void pm_prepare_tx(struct companion_protocol_manager *pm,
+		   struct companion_packet           *p)
+{
+	pm->is_io_type = false;
+
+	if (qm_get_tx_data(&pm->qm, p)) {
+		if (is_io_type(p))
+			pm->is_io_type = true;
+	} else {
+		memset(p, BCP_NOOP, sizeof(*p));
+	}
+}
+
+/**
+ * pm_on_tx_done() - handle tx done
+ * @pm: address of the protocol manager to be used
+ */
+void pm_on_tx_done(struct companion_protocol_manager *pm)
+{
+	if (!pm->is_io_type)
+		return;
+
+	down_read(&pm->io_lock);
+	if (pm->io_ops && pm->io_ops->on_tx_done)
+		pm->io_ops->on_tx_done(pm->io_data);
+	up_read(&pm->io_lock);
+}
+
+/**
+ * pm_on_rx_done() - handle rx done
+ * @pm: address of the protocol manager to be used
+ * @p:  address of the recevied data
+ */
+void pm_on_rx_done(struct companion_protocol_manager *pm,
+		   const struct companion_packet     *p)
+{
+	struct companion_filter *filter;
+
+	list_for_each_entry(filter, &pm->filters, node) {
+		if (filter->match && filter->match(p)) {
+			if (filter->process)
+				filter->process(pm, p);
+
+			break;
+		}
+	}
+}
+
+/**
+ * pm_can_data_tx() - send CAN data according to protocol
+ * @pm:   address of the protocol manager to be used
+ * @port: port number of which CAN to be sent
+ * @prio: priority of the data to be sent
+ * @cf:   the raw CAN frame to be send
+ */
+int pm_can_data_tx(struct companion_protocol_manager *pm,
+		   u8                                 port,
+		   u8                                 prio,
+		   const struct can_frame            *cf)
+{
+	struct can_data_frame p;
+
+	if (port >= BCP_CAN_PORTS || prio >= BCP_CAN_PRIOS)
+		return -EINVAL;
+
+	if (pm->local_txq[port][prio] == 0)
+		return -ENOSPC;
+
+	p.type = BCP_CAN_DATA;
+	p.port = port + 1;
+	p.prio = prio;
+	p.dlc  = cf->can_dlc;
+	p.id   = cf->can_id;
+	memcpy(p.data, cf->data, sizeof(cf->data));
+
+	if (!qm_can_txq_in(&pm->qm,
+			   (struct companion_packet *)&p,
+			   port,
+			   prio)) {
+		pm->stats.can_tx_overflows[port][prio]++;
+		return -ENOSPC;
+	}
+
+	pm->local_txq[port][prio]--;
+
+	pm->stats.can_tx[port][prio]++;
+	return 0;
+}
+
+/**
+ * pm_can_data_rx() - receive CAN data according to protocol
+ * @pm:   address of the protocol manager to be used
+ * @port: port number of which CAN to be received
+ * @cf:   address of the raw CAN frame to be copied
+ */
+int pm_can_data_rx(struct companion_protocol_manager *pm,
+		   u8                                 port,
+		   struct can_frame                  *cf)
+{
+	struct can_data_frame p;
+
+	if (port >= BCP_CAN_PORTS)
+		return -EINVAL;
+
+	if (!qm_can_rxq_out(&pm->qm, (struct companion_packet *)&p, port))
+		return -EIO;
+
+	cf->can_id  = p.id;
+	cf->can_dlc = p.dlc;
+	memcpy(cf->data, p.data, sizeof(cf->data));
+	return 0;
+}
+
+/**
+ * pm_can_err() - receive CAN error according to protocol
+ * @pm:    address of the protocol manager to be used
+ * @port:  port number of which CAN to be received
+ * @bec:   address of the error counter to be copied
+ * @state: address of the error state to be copied
+ * @code:  address of the error code to be copied
+ */
+int pm_can_err(struct companion_protocol_manager *pm,
+	       u8                                 port,
+	       struct can_berr_counter           *berr,
+	       u8                                *state,
+	       u8                                *code)
+{
+	struct can_status_response p;
+
+	if (port >= BCP_CAN_PORTS)
+		return -EINVAL;
+
+	if (!qm_can_err_out(&pm->qm, (struct companion_packet *)&p, port))
+		return -EIO;
+
+	berr->rxerr = p.rx_err;
+	berr->txerr = p.tx_err;
+	*state      = p.state;
+	*code       = p.code;
+	return 0;
+}
+
+/**
+ * pm_wait_for_response() - wait for CAN packets response
+ * @pm:   address of the protocol manager to be used
+ * @port: port number of which CAN to be wait
+ * @flag: flag to be wait
+ */
+int pm_wait_for_response(struct companion_protocol_manager *pm,
+			 u8                                 port,
+			 enum bcp_can_flag                  flag)
+{
+	unsigned long *flags = &pm->flags[port];
+	long           ret;
+
+	if (test_bit(flag, flags)) {
+		ret = wait_event_interruptible_timeout(pm->wait[port],
+						       !test_bit(flag, flags),
+						       PM_RESPONSE_TIMEOUT);
+
+		if (ret < 0)
+			return ret;
+
+		if (ret == 0)
+			return -ETIMEDOUT;
+	}
+
+	return pm->response[port][flag];
+}
+
+/**
+ * pm_can_set_bittiming() - set CAN bittiming according to protocol
+ * @pm:        address of the protocol manager to be used
+ * @port:      port number of which CAN to be set
+ * @bittiming: the bittiming to be set
+ */
+int pm_can_set_bittiming(struct companion_protocol_manager *pm,
+			 u8                                 port,
+			 const struct can_bittiming        *bittiming)
+{
+	struct can_bittiming_request p;
+
+	if (port >= BCP_CAN_PORTS)
+		return -EINVAL;
+
+	memset(&p, 0, sizeof(p));
+	p.type       = BCP_CAN_BITTIMING;
+	p.port       = port + 1;
+	p.prescaler  = bittiming->brp;
+	p.prop_seg   = bittiming->prop_seg;
+	p.phase_seg1 = bittiming->phase_seg1;
+	p.phase_seg2 = bittiming->phase_seg2;
+	p.sjw        = bittiming->sjw;
+
+	if (!qm_can_txq_in(&pm->qm,
+			   (struct companion_packet *)&p,
+			   port,
+			   0)) {
+		pm->stats.can_tx_overflows[port][0]++;
+		return -ENOSPC;
+	}
+
+	set_bit(bcp_can_bittiming, &pm->flags[port]);
+	pm->stats.can_tx[port][0]++;
+	return 0;
+}
+
+/**
+ * pm_can_set_mode() - set CAN mode according to protocol
+ * @pm:   address of the protocol manager to be used
+ * @port: port number of which CAN to be set
+ * @mode: the mode to be set
+ */
+int pm_can_set_mode(struct companion_protocol_manager *pm,
+		    u8                                 port,
+		    enum can_mode                      mode)
+{
+	struct can_mode_request p;
+
+	if (port >= BCP_CAN_PORTS)
+		return -EINVAL;
+
+	memset(&p, 0, sizeof(p));
+	p.type = BCP_CAN_MODE;
+	p.port = port + 1;
+
+	switch (mode) {
+	case CAN_MODE_START:
+		p.mode = BCP_CAN_MODE_NORMAL;
+		break;
+
+	case CAN_MODE_STOP:
+		p.mode = BCP_CAN_MODE_OFF;
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	if (!qm_can_txq_in(&pm->qm,
+			   (struct companion_packet *)&p,
+			   port,
+			   0)) {
+		pm->stats.can_tx_overflows[port][0]++;
+		return -ENOSPC;
+	}
+
+	set_bit(bcp_can_mode, &pm->flags[port]);
+	pm->stats.can_tx[port][0]++;
+	return 0;
+}
+
+/**
+ * pm_can_set_ctrlmode() - set CAN control mode according to protocol
+ * @pm:   address of the protocol manager to be used
+ * @port: port number of which CAN to be set
+ * @ctrl: the control mode to be set
+ */
+int pm_can_set_ctrlmode(struct companion_protocol_manager *pm,
+			u8                                 port,
+			u32                                ctrl)
+{
+	struct can_mode_request p;
+
+	if (port >= BCP_CAN_PORTS)
+		return -EINVAL;
+
+	if (!(ctrl & CAN_CTRLMODE_LISTENONLY))
+		return -EOPNOTSUPP;
+
+	memset(&p, 0, sizeof(p));
+	p.type = BCP_CAN_MODE;
+	p.port = port + 1;
+	p.mode = BCP_CAN_MODE_LISTEN;
+
+	if (!qm_can_txq_in(&pm->qm,
+			   (struct companion_packet *)&p,
+			   port,
+			   0)) {
+		pm->stats.can_tx_overflows[port][0]++;
+		return -ENOSPC;
+	}
+
+	set_bit(bcp_can_mode, &pm->flags[port]);
+	pm->stats.can_tx[port][0]++;
+	return 0;
+}
+
+/**
+ * pm_can_get_status() - get CAN status according to protocol
+ * @pm:   address of the protocol manager to be used
+ * @port: port number of which CAN to be inquiry
+ */
+int pm_can_get_status(struct companion_protocol_manager *pm, u8 port)
+{
+	struct can_status_request p;
+
+	if (port >= BCP_CAN_PORTS)
+		return -EINVAL;
+
+	memset(&p, 0, sizeof(p));
+	p.type = BCP_CAN_STATUS;
+	p.port = port + 1;
+
+	if (!qm_can_txq_in(&pm->qm,
+			   (struct companion_packet *)&p,
+			   port,
+			   0)) {
+		pm->stats.can_tx_overflows[port][0]++;
+		return -ENOSPC;
+	}
+
+	set_bit(bcp_can_status, &pm->flags[port]);
+	pm->stats.can_tx[port][0]++;
+	return 0;
+}
+
+/**
+ * pm_can_get_txq_status() - get CAN tx queue status according to protocol
+ * @pm:   address of the protocol manager to be used
+ * @port: port number of which CAN to be inquiry
+ */
+int pm_can_get_txq_status(struct companion_protocol_manager *pm, u8 port)
+{
+	struct can_txq_status_request p;
+
+	if (port >= BCP_CAN_PORTS)
+		return -EINVAL;
+
+	memset(&p, 0, sizeof(p));
+	p.type = BCP_CAN_TX_QUEUE_STATUS;
+	p.port = port + 1;
+
+	if (!qm_can_txq_in(&pm->qm,
+			   (struct companion_packet *)&p,
+			   port,
+			   0)) {
+		pm->stats.can_tx_overflows[port][0]++;
+		return -ENOSPC;
+	}
+
+	set_bit(bcp_can_txq_status, &pm->flags[port]);
+	pm->stats.can_tx[port][0]++;
+	return 0;
+}
+
+/**
+ * pm_can_txq_is_full() - inquiry CAN tx queue is full
+ * @pm:      address of the protocol manager to be used
+ * @port:    port number of which CAN to be inquiry
+ * @prio:    queue number of which tx queue to be inquiry
+ * @is_full: address of the is full result to be copied
+ */
+int pm_can_txq_is_full(struct companion_protocol_manager *pm,
+		       u8                                 port,
+		       u8                                 prio,
+		       bool                              *is_full)
+{
+	if (port >= BCP_CAN_PORTS || prio >= BCP_CAN_PRIOS)
+		return -EINVAL;
+
+	*is_full = (pm->local_txq[port][prio] == 0);
+	return 0;
+}
+
+/**
+ * pm_can_txq_has_space() - inquiry CAN tx queue has space
+ * @pm:        address of the protocol manager to be used
+ * @port:      port number of which CAN to be inquiry
+ * @prio:      queue number of which tx queue to be inquiry
+ * @has_space: address of the has space result to be copied
+ */
+int pm_can_txq_has_space(struct companion_protocol_manager *pm,
+			 u8                                 port,
+			 u8                                 prio,
+			 bool                              *has_space)
+{
+	if (port >= BCP_CAN_PORTS || prio >= BCP_CAN_PRIOS)
+		return -EINVAL;
+
+	*has_space = (pm->local_txq[port][prio] > 0);
+	return 0;
+}
+
+/**
+ * pm_can_start_tx_timer() - start CAN tx timeout detection
+ * @pm:   address of the protocol manager to be used
+ * @port: port number of which CAN to be used
+ * @prio: queue number of which tx queue's timer to be used
+ */
+int pm_can_start_tx_timer(struct companion_protocol_manager *pm,
+			  u8                                 port,
+			  u8                                 prio)
+{
+	if (port >= BCP_CAN_PORTS || prio >= BCP_CAN_PRIOS)
+		return -EINVAL;
+
+	mod_timer(&pm->timer[port][prio].timer, jiffies + PM_CAN_TX_TIMEOUT);
+	return 0;
+}
+
+/**
+ * pm_can_stop_tx_timer() - stop CAN tx timeout detection
+ * @pm:   address of the protocol manager to be used
+ * @port: port number of which CAN to be used
+ * @prio: queue number of which tx queue's timer to be used
+ */
+int pm_can_stop_tx_timer(struct companion_protocol_manager *pm,
+			 u8                                 port,
+			 u8                                 prio)
+{
+	if (port >= BCP_CAN_PORTS || prio >= BCP_CAN_PRIOS)
+		return -EINVAL;
+
+	del_timer_sync(&pm->timer[port][prio].timer);
+	return 0;
+}
diff --git a/drivers/spi/companion/protocol-manager.h b/drivers/spi/companion/protocol-manager.h
new file mode 100644
index 0000000..2cf10fa
--- /dev/null
+++ b/drivers/spi/companion/protocol-manager.h
@@ -0,0 +1,341 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Companion protocol manager code
+ *
+ * Copyright (C) 2015-2018 Bosch Sicherheitssysteme GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _BOSCH_COMPANION_PROTOCOL_MANAGER_H
+#define _BOSCH_COMPANION_PROTOCOL_MANAGER_H
+
+#include <linux/can/dev.h>
+#include <linux/list.h>
+#include <linux/rwsem.h>
+#include <linux/timer.h>
+#include <linux/workqueue.h>
+#include <linux/companion.h>
+#include "queue-manager.h"
+
+/**
+ * enum bcp_can_flag - companion CAN packet event flag
+ */
+enum bcp_can_flag {
+	bcp_can_bittiming,
+	bcp_can_mode,
+	bcp_can_status,
+	bcp_can_txq_status,
+
+	bcp_can_max
+};
+
+/**
+ * struct companion_statistics - statistics information of companion
+ * @io_tx_overflows:   counter of IO packets transmit overflow
+ * @io_rx_overflows:   counter of IO packets receive overflow
+ * @can_tx_overflows:  counter of CAN packets transmit overflow
+ * @can_rx_overflows:  counter of CAN packets receive overflow
+ * @can_err_overflows: counter of CAN error packets receive overflow
+ * @io_tx:             counter of IO packets transmitted
+ * @io_rx:             counter of IO packets received
+ * @can_tx:            counter of CAN packets transmitted
+ * @can_ack_success:   counter of CAN response success packets received
+ * @can_ack_failure:   counter of CAN response failure packets received
+ * @can_rx:            counter of CAN packets received
+ * @can_err:           counter of CAN error packets received
+ * @can_lost_seq_sync: counter of CAN packets sequence lost sync
+ * @can_lost_txq_sync: counter of CAN tx queue status lost sync
+ * @can_ack_timeout:   counter of CAN tx ack timeout
+ * @can_ack_unexpect:  counter of CAN unexpected tx ack
+ */
+struct companion_statistics {
+	u32 io_tx_overflows;
+	u32 io_rx_overflows;
+	u32 can_tx_overflows[BCP_CAN_PORTS][BCP_CAN_PRIOS];
+	u32 can_rx_overflows[BCP_CAN_PORTS];
+	u32 can_err_overflows[BCP_CAN_PORTS];
+
+	u32 io_tx;
+	u32 io_rx;
+	u32 can_tx[BCP_CAN_PORTS][BCP_CAN_PRIOS];
+	u32 can_ack_success[BCP_CAN_PORTS][BCP_CAN_PRIOS];
+	u32 can_ack_failure[BCP_CAN_PORTS][BCP_CAN_PRIOS];
+	u32 can_rx[BCP_CAN_PORTS];
+	u32 can_err[BCP_CAN_PORTS];
+	u32 can_lost_seq_sync[BCP_CAN_PORTS][BCP_CAN_PRIOS];
+	u32 can_lost_txq_sync[BCP_CAN_PORTS][BCP_CAN_PRIOS];
+	u32 can_ack_timeout[BCP_CAN_PORTS][BCP_CAN_PRIOS];
+	u32 can_ack_unexpect[BCP_CAN_PORTS][BCP_CAN_PRIOS];
+};
+
+struct companion_protocol_manager;
+/**
+ * struct companion_timer_data - encapsulate data passed to timer
+ * @pm:   companion protocol manager
+ * @port: port number of which CAN associated with the timer
+ * @prio: priority of which CAN tx queue associated with the timer
+ * @work: work for execute timeout callback in thread context
+ */
+struct companion_timer_data {
+	struct companion_protocol_manager *pm;
+	u8                                 port;
+	u8                                 prio;
+	struct work_struct                 work;
+};
+
+/**
+ * struct companion_timer - encapsulate timer and data
+ * @timer: timer_list object for timeout
+ * @data:  data associated with the timer
+ */
+struct companion_timer {
+	struct timer_list           timer;
+	struct companion_timer_data data;
+};
+
+/**
+ * struct companion_protocol_manager - encapsulate companion protocol handling
+ * @io_ops:     callback of IO packet handling
+ * @io_data:    callback argument of io_ops
+ * @io_lock:    lock to protect IO callback
+ * @can_ops:    callback of CAN packet handling
+ * @can_data:   callback argument of can_ops
+ * @can_lock:   lock to protect CAN callback
+ * @wait:       wait queue head for CAN packet response
+ * @flags:      event flags for CAN packet response
+ * @response:   response result of each CAN packet event flag
+ * @rx_err:     receive error counter of CAN port
+ * @tx_err:     transmit error counter of CAN port
+ * @sequence:   sequence counter of each CAN tx queue
+ * @remote_txq: CAN tx queue space status at remote
+ * @local_txq:  CAN tx queue space status at local
+ * @timer:      timer for detect CAN tx ack timeout for each CAN tx queue
+ * @stats:      statistics information of companion
+ * @is_io_type: flag to record the sent packet is IO type or not
+ * @qm:         queue manager
+ * @filters:    filter list to handle receveid companion packets
+ */
+struct companion_protocol_manager {
+	struct companion_io_ops       *io_ops;
+	void                          *io_data;
+	struct rw_semaphore            io_lock;
+	struct companion_can_ops      *can_ops[BCP_CAN_PORTS];
+	void                          *can_data[BCP_CAN_PORTS];
+	struct rw_semaphore            can_lock[BCP_CAN_PORTS];
+	wait_queue_head_t              wait[BCP_CAN_PORTS];
+	unsigned long                  flags[BCP_CAN_PORTS];
+	int                            response[BCP_CAN_PORTS][bcp_can_max];
+	u8                             rx_err[BCP_CAN_PORTS];
+	u8                             tx_err[BCP_CAN_PORTS];
+	u8                             sequence[BCP_CAN_PORTS][BCP_CAN_PRIOS];
+	u8                             remote_txq[BCP_CAN_PORTS][BCP_CAN_PRIOS];
+	u8                             local_txq[BCP_CAN_PORTS][BCP_CAN_PRIOS];
+	struct companion_timer         timer[BCP_CAN_PORTS][BCP_CAN_PRIOS];
+
+	struct companion_statistics    stats;
+	bool                           is_io_type;
+
+	struct companion_queue_manager qm;
+	struct list_head               filters;
+};
+
+/**
+ * pm_init() - initialize the protocol manager
+ * @pm: address of the protocol manager to be initialized
+ */
+void pm_init(struct companion_protocol_manager *pm);
+
+/**
+ * pm_io_ops_register() - register companion IO packets handler
+ * @pm:   address of the protocol manager to be registered
+ * @ops:  address of the IO packets callback
+ * @data: address of the IO packets callback argument
+ */
+int pm_io_ops_register(struct companion_protocol_manager *pm,
+		       struct companion_io_ops           *ops,
+		       void                              *data);
+
+/**
+ * pm_io_ops_unregister() - unregister companion IO packets handler
+ * @pm: address of the protocol manager to be unregistered
+ */
+int pm_io_ops_unregister(struct companion_protocol_manager *pm);
+
+/**
+ * pm_can_ops_register() -  register companion CAN packets hanler
+ * @pm:   address of the protocol manager to be registered
+ * @port: port number of which CAN to be registered
+ * @ops:  address of the CAN packets callback
+ * @data: address of the CAN packets callback argument
+ */
+int pm_can_ops_register(struct companion_protocol_manager *pm,
+			u8                                 port,
+			struct companion_can_ops          *ops,
+			void                              *data);
+
+/**
+ * pm_can_ops_unregister() - unregister companion CAN packets handler
+ * @pm:   address of the protocol manager to be unregistered
+ * @port: port number of which CAN to be unregistered
+ */
+int pm_can_ops_unregister(struct companion_protocol_manager *pm, u8 port);
+
+/**
+ * pm_prepare_tx() - prepare tx data
+ * @pm: address of the protocol manager to be used
+ * @p:  address of the data to be sent
+ */
+void pm_prepare_tx(struct companion_protocol_manager *pm,
+		   struct companion_packet           *p);
+
+/**
+ * pm_on_tx_done() - handle tx done
+ * @pm: address of the protocol manager to be used
+ */
+void pm_on_tx_done(struct companion_protocol_manager *pm);
+
+/**
+ * pm_on_rx_done() - handle rx done
+ * @pm: address of the protocol manager to be used
+ * @p:  address of the recevied data
+ */
+void pm_on_rx_done(struct companion_protocol_manager *pm,
+		   const struct companion_packet     *p);
+
+/**
+ * pm_can_data_tx() - send CAN data according to protocol
+ * @pm:   address of the protocol manager to be used
+ * @port: port number of which CAN to be sent
+ * @prio: priority of the data to be sent
+ * @cf:   the raw CAN frame to be send
+ */
+int pm_can_data_tx(struct companion_protocol_manager *pm,
+		   u8                                 port,
+		   u8                                 prio,
+		   const struct can_frame            *cf);
+
+/**
+ * pm_can_data_rx() - receive CAN data according to protocol
+ * @pm:   address of the protocol manager to be used
+ * @port: port number of which CAN to be received
+ * @cf:   address of the raw CAN frame to be copied
+ */
+int pm_can_data_rx(struct companion_protocol_manager *pm,
+		   u8                                 port,
+		   struct can_frame                  *cf);
+
+/**
+ * pm_can_err() - receive CAN error according to protocol
+ * @pm:    address of the protocol manager to be used
+ * @port:  port number of which CAN to be received
+ * @bec:   address of the error counter to be copied
+ * @state: address of the error state to be copied
+ * @code:  address of the error code to be copied
+ */
+int pm_can_err(struct companion_protocol_manager *pm,
+	       u8                                 port,
+	       struct can_berr_counter           *bec,
+	       u8                                *state,
+	       u8                                *code);
+
+/**
+ * pm_wait_for_response() - wait for CAN packets response
+ * @pm:   address of the protocol manager to be used
+ * @port: port number of which CAN to be wait
+ * @flag: flag to be wait
+ */
+int pm_wait_for_response(struct companion_protocol_manager *pm,
+			 u8                                 port,
+			 enum bcp_can_flag                  flag);
+
+/**
+ * pm_can_set_bittiming() - set CAN bittiming according to protocol
+ * @pm:        address of the protocol manager to be used
+ * @port:      port number of which CAN to be set
+ * @bittiming: the bittiming to be set
+ */
+int pm_can_set_bittiming(struct companion_protocol_manager *pm,
+			 u8                                 port,
+			 const struct can_bittiming        *bittiming);
+
+/**
+ * pm_can_set_mode() - set CAN mode according to protocol
+ * @pm:   address of the protocol manager to be used
+ * @port: port number of which CAN to be set
+ * @mode: the mode to be set
+ */
+int pm_can_set_mode(struct companion_protocol_manager *pm,
+		    u8                                 port,
+		    enum can_mode                      mode);
+
+/**
+ * pm_can_set_ctrlmode() - set CAN control mode according to protocol
+ * @pm:   address of the protocol manager to be used
+ * @port: port number of which CAN to be set
+ * @ctrl: the control mode to be set
+ */
+int pm_can_set_ctrlmode(struct companion_protocol_manager *pm,
+			u8                                 port,
+			u32                                ctrl);
+
+/**
+ * pm_can_get_status() - get CAN status according to protocol
+ * @pm:   address of the protocol manager to be used
+ * @port: port number of which CAN to be inquiry
+ */
+int pm_can_get_status(struct companion_protocol_manager *pm, u8 port);
+
+/**
+ * pm_can_get_txq_status() - get CAN tx queue status according to protocol
+ * @pm:   address of the protocol manager to be used
+ * @port: port number of which CAN to be inquiry
+ */
+int pm_can_get_txq_status(struct companion_protocol_manager *pm, u8 port);
+
+/**
+ * pm_can_txq_is_full() - inquiry CAN tx queue is full
+ * @pm:      address of the protocol manager to be used
+ * @port:    port number of which CAN to be inquiry
+ * @prio:    queue number of which tx queue to be inquiry
+ * @is_full: address of the is full result to be copied
+ */
+int pm_can_txq_is_full(struct companion_protocol_manager *pm,
+		       u8                                 port,
+		       u8                                 prio,
+		       bool                              *is_full);
+
+/**
+ * pm_can_txq_has_space() - inquiry CAN tx queue has space
+ * @pm:        address of the protocol manager to be used
+ * @port:      port number of which CAN to be inquiry
+ * @prio:      queue number of which tx queue to be inquiry
+ * @has_space: address of the has space result to be copied
+ */
+int pm_can_txq_has_space(struct companion_protocol_manager *pm,
+			 u8                                 port,
+			 u8                                 prio,
+			 bool                              *has_space);
+
+/**
+ * pm_can_start_tx_timer() - start CAN tx timeout detection
+ * @pm:   address of the protocol manager to be used
+ * @port: port number of which CAN to be used
+ * @prio: queue number of which tx queue's timer to be used
+ */
+int pm_can_start_tx_timer(struct companion_protocol_manager *pm,
+			  u8                                 port,
+			  u8                                 prio);
+
+/**
+ * pm_can_stop_tx_timer() - stop CAN tx timeout detection
+ * @pm:   address of the protocol manager to be used
+ * @port: port number of which CAN to be used
+ * @prio: queue number of which tx queue's timer to be used
+ */
+int pm_can_stop_tx_timer(struct companion_protocol_manager *pm,
+			 u8                                 port,
+			 u8                                 prio);
+#endif
diff --git a/drivers/spi/companion/protocol.h b/drivers/spi/companion/protocol.h
new file mode 100644
index 0000000..7f70ed6
--- /dev/null
+++ b/drivers/spi/companion/protocol.h
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Companion protocol kernel space API
+ *
+ * Copyright (C) 2015-2018 Bosch Sicherheitssysteme GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _BOSCH_COMPANION_PROTOCOL_KERNEL_H
+#define _BOSCH_COMPANION_PROTOCOL_KERNEL_H
+
+#include <linux/kernel.h>
+
+#define BCP_CAN_PORTS 2u
+#define BCP_CAN_PRIOS 8u
+
+/**
+ * BCP type field definitions (CAN)
+ */
+#define BCP_NOOP                0x00u
+#define BCP_CAN_DATA            0x01u
+#define BCP_CAN_BITTIMING       0x03u
+#define BCP_CAN_MODE            0x04u
+#define BCP_CAN_STATUS          0x06u
+#define BCP_CAN_TX_ACK          0x07u
+#define BCP_CAN_TX_QUEUE_STATUS 0x0Fu
+
+/**
+ * BCP status field definitions
+ */
+#define BCP_STATUS_SUCCESS 0x00u
+#define BCP_STATUS_UNKNOWN 0x01u
+#define BCP_STATUS_OTHER   0x02u
+
+/**
+ * BCP packet size definition
+ */
+#define BCP_PACKET_SIZE    16u
+
+/**
+ * struct companion_packet - companion packet general format
+ * @data: contents of the packet
+ */
+struct companion_packet {
+	u8 data[BCP_PACKET_SIZE];
+};
+
+/**
+ * struct can_data_frame - companion can data frame packet
+ * @type: packet type
+ * @port: can port
+ * @prio: priority of the can frame
+ * @dlc:  can frame payload in bytes
+ * @id:   can frame id
+ * @data: can frame payload
+ */
+struct can_data_frame {
+	u8  type;
+	u8  port;
+	u8  prio;
+	u8  dlc;
+	u32 id;
+	u8  data[8];
+};
+
+/**
+ * struct can_bittiming_request - companion can bittiming request packet
+ * @type:       packet type
+ * @port:       can port
+ * @prescaler:  bitrate prescaler
+ * @prop_seg:   propagation segment in TQs
+ * @phase_seg1: phase buffer segment 1 in TQs
+ * @phase_seg2: phase buffer segment 2 in TQs
+ * @sjw:        synchronisation jump width in TQs
+ * @reserved:   reserved
+ */
+struct can_bittiming_request {
+	u8  type;
+	u8  port;
+	u16 prescaler;
+	u8  prop_seg;
+	u8  phase_seg1;
+	u8  phase_seg2;
+	u8  sjw;
+	u8  reserved[8];
+};
+
+/**
+ * struct can_bittiming_response - companion can bittiming response packet
+ * @type:       packet type
+ * @port:       can port
+ * @prescaler:  bitrate prescaler
+ * @prop_seg:   propagation segment in TQs
+ * @phase_seg1: phase buffer segment 1 in TQs
+ * @phase_seg2: phase buffer segment 2 in TQs
+ * @sjw:        synchronisation jump width in TQs
+ * @reserved:   reserved
+ * @status:     process status
+ */
+struct can_bittiming_response {
+	u8  type;
+	u8  port;
+	u16 prescaler;
+	u8  prop_seg;
+	u8  phase_seg1;
+	u8  phase_seg2;
+	u8  sjw;
+	u8  reserved[7];
+	u8  status;
+};
+
+/**
+ * struct can_mode_request - companion can mode request packet
+ * @type:     packet type
+ * @port:     can port
+ * @mode:     can mode
+ * @reserved: reserved
+ */
+struct can_mode_request {
+	u8 type;
+	u8 port;
+	u8 mode;
+	u8 reserved[13];
+};
+#define BCP_CAN_MODE_OFF    0x00u
+#define BCP_CAN_MODE_NORMAL 0x01u
+#define BCP_CAN_MODE_LISTEN 0x02u
+
+/**
+ * struct can_mode_response - companion can mode response packet
+ * @type:     packet type
+ * @port:     can port
+ * @mode:     can mode
+ * @reserved: reserved
+ * @status:   process status
+ */
+struct can_mode_response {
+	u8 type;
+	u8 port;
+	u8 mode;
+	u8 reserved[12];
+	u8 status;
+};
+
+/**
+ * struct can_status_request - companion can status request packet
+ * @type:     packet type
+ * @port:     can port
+ * @reserved: reserved
+ */
+struct can_status_request {
+	u8 type;
+	u8 port;
+	u8 reserved[14];
+};
+
+/**
+ * struct can_status_response - companion can status response packet
+ * @type:     packet type
+ * @port:     can port
+ * @rx_err:   rx error counter
+ * @tx_err:   tx error counter
+ * @err1:     can controller error status 1
+ * @err2:     can controller error status 2
+ * @reserved: reserved
+ * @status:   process status
+ */
+struct can_status_response {
+	u8 type;
+	u8 port;
+	u8 rx_err;
+	u8 tx_err;
+	u8 state;
+	u8 code;
+	u8 reserved[9];
+	u8 status;
+};
+
+/**
+ * struct can_tx_acknowledge - companion can tx acknowledge packet
+ * @type:     packet type
+ * @port:     can port
+ * @prio:     priority of the can frame
+ * @dlc:      payload length of the can frame
+ * @sequence: monotonic increasing sequence counter of sent can frames
+ * @space:    queue space left of this priority
+ * @reserved: reserved
+ * @status:   process status
+ */
+struct can_tx_acknowledge {
+	u8 type;
+	u8 port;
+	u8 prio;
+	u8 dlc;
+	u8 sequence;
+	u8 space;
+	u8 reserved[9];
+	u8 status;
+};
+
+/**
+ * struct can_txq_status_request - companion can txq status request packet
+ * @type:     packet type
+ * @port:     can port
+ * @reserved: reserved
+ */
+struct can_txq_status_request {
+	u8 type;
+	u8 port;
+	u8 reserved[14];
+};
+
+/**
+ * struct can_txq_status_response - companion can txq status response packet
+ * @type:     packet type
+ * @port:     can port
+ * @space:    queue space left of each priority
+ * @reserved: reserved
+ * @status:   process status
+ */
+struct can_txq_status_response {
+	u8 type;
+	u8 port;
+	u8 space[8];
+	u8 reserved[5];
+	u8 status;
+};
+
+/**
+ * is_null_type() - return true if the packet is null type
+ * @p: the packet to test
+ */
+static inline bool is_null_type(const struct companion_packet *p)
+{
+	return p->data[0] == BCP_NOOP;
+}
+
+/**
+ * is_io_type() - return true if the packet is io type
+ * @p: the packet to test
+ */
+static inline bool is_io_type(const struct companion_packet *p)
+{
+	return (p->data[0] & 0x80);
+}
+
+/**
+ * is_can_type() - return true if the packet is can type
+ * @p: the packet to test
+ */
+static inline bool is_can_type(const struct companion_packet *p)
+{
+	return !is_io_type(p) && !is_null_type(p);
+}
+
+/**
+ * dump_packet() - dump raw packet data in hexadecimal format
+ * @p:      the packet to dump
+ * @level:  the log level of the dump
+ * @prefix: the prefix string of the dump
+ */
+static inline void dump_packet(const struct companion_packet *p,
+			       const char                    *level,
+			       const char                    *prefix)
+{
+	print_hex_dump(level, prefix, DUMP_PREFIX_NONE, 16, 1,
+		       p->data, sizeof(p->data), false);
+}
+
+#endif
diff --git a/drivers/spi/companion/queue-manager.c b/drivers/spi/companion/queue-manager.c
new file mode 100644
index 0000000..f72696f
--- /dev/null
+++ b/drivers/spi/companion/queue-manager.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Companion queue management code
+ *
+ * Copyright (C) 2015-2018 Bosch Sicherheitssysteme GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "queue-manager.h"
+
+/**
+ * qm_init() - initialize all managed queues
+ * @qm: address of the queue manager to be initialized
+ */
+void qm_init(struct companion_queue_manager *qm)
+{
+	int i, j;
+
+	INIT_KFIFO(qm->io_txq.fifo);
+	INIT_KFIFO(qm->io_rxq.fifo);
+
+	for (i = 0; i < BCP_CAN_PORTS; ++i) {
+		for (j = 0; j < BCP_CAN_PRIOS; ++j)
+			INIT_KFIFO(qm->can_txq[i][j].fifo);
+
+		INIT_KFIFO(qm->can_rxq[i].fifo);
+		INIT_KFIFO(qm->can_err[i].fifo);
+		mutex_init(&qm->can_txq_lock[i]);
+	}
+}
+
+/**
+ * qm_reset() - reset all managed queues
+ * @qm: address of the queue manager to be reset
+ */
+void qm_reset(struct companion_queue_manager *qm)
+{
+	int i;
+
+	qm_reset_io(qm);
+
+	for (i = 0; i < BCP_CAN_PORTS; ++i)
+		qm_reset_can(qm, i);
+}
+
+/**
+ * qm_reset_io() - reset managed IO queues
+ * @qm: address of the queue manager to be reset
+ */
+void qm_reset_io(struct companion_queue_manager *qm)
+{
+	kfifo_reset(&qm->io_txq.fifo);
+	kfifo_reset(&qm->io_rxq.fifo);
+}
+
+/**
+ * qm_reset_can() - reset managed CAN queues
+ * @qm:   address of the queue manager to be reset
+ * @port: port number of which CAN queue should be reset
+ */
+void qm_reset_can(struct companion_queue_manager *qm, u8 port)
+{
+	int i;
+
+	for (i = 0; i < BCP_CAN_PRIOS; ++i)
+		kfifo_reset(&qm->can_txq[port][i].fifo);
+
+	kfifo_reset(&qm->can_rxq[port].fifo);
+	kfifo_reset(&qm->can_err[port].fifo);
+}
+
+/**
+ * qm_has_tx_data() - return true if has tx data
+ * @qm: address of the queue manager to be used
+ */
+bool qm_has_tx_data(struct companion_queue_manager *qm)
+{
+	int i, j;
+
+	for (i = 0; i < BCP_CAN_PORTS; ++i)
+		for (j = 0; j < BCP_CAN_PRIOS; ++j)
+			if (!kfifo_is_empty(&qm->can_txq[i][j].fifo))
+				return true;
+
+	return !kfifo_is_empty(&qm->io_txq.fifo);
+}
+
+/*
+ * Define maximum CAN packets can be sent in a row in case there is IO packet
+ * pending or coming, which specifies the minimal bandwidth for IO packets.
+ */
+#define CAN_MAX_IN_A_ROW 8
+
+/**
+ * qm_get_tx_data() - return true if got the tx data
+ * @qm: address of the queue manager to be used
+ * @p:  where the data to be copied
+ */
+bool qm_get_tx_data(struct companion_queue_manager *qm,
+		    struct companion_packet        *p)
+{
+	int i, j;
+
+	/*
+	 * Implement the companion packet scheduling algorithm which guarantees
+	 * IO packets share minimal 1 / (CAN_MAX_IN_A_ROW + 1) bandwidth, and
+	 * the rest bandwidth is shared equally for all CAN ports.
+	 *
+	 * The purpose is to ensure fairness between all CAN ports and also keep
+	 * CAN packets have higher priority than IO packets in general, but
+	 * avoid IO packets starvation in case CAN is very busy.
+	 *
+	 * The bandwidth is not statically allocated, so the active user (IO or
+	 * CAN) can use up to 100% bandwidth if there are no other active users.
+	 */
+
+	if (qm->io_promoted && qm_io_txq_out(qm, p)) {
+		qm->io_promoted = false;
+		return true;
+	}
+
+	for (i = 0; i < BCP_CAN_PORTS; ++i) {
+		/* ensure fairness for all can ports */
+		qm->can_current++;
+		if (qm->can_current >= BCP_CAN_PORTS)
+			qm->can_current = 0;
+
+		for (j = 0; j < BCP_CAN_PRIOS; ++j) {
+			if (qm_can_txq_out(qm, p, qm->can_current, j)) {
+				qm->can_sched++;
+				if (qm->can_sched >= CAN_MAX_IN_A_ROW) {
+					qm->io_promoted = true;
+					qm->can_sched   = 0;
+				}
+				return true;
+			}
+		}
+	}
+
+	return qm_io_txq_out(qm, p);
+}
diff --git a/drivers/spi/companion/queue-manager.h b/drivers/spi/companion/queue-manager.h
new file mode 100644
index 0000000..aa5d31f
--- /dev/null
+++ b/drivers/spi/companion/queue-manager.h
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Companion queue management code
+ *
+ * Copyright (C) 2015-2018 Bosch Sicherheitssysteme GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _BOSCH_COMPANION_QUEUE_MANAGEMENT_H
+#define _BOSCH_COMPANION_QUEUE_MANAGEMENT_H
+
+#include <linux/kernel.h>
+#include <linux/kfifo.h>
+#include "protocol.h"
+
+#define QUEUE_SIZE 16u
+
+/**
+ * struct companion_queue - encapsulate kfifo as companion queue
+ * @fifo: the kfifo object for companion packets
+ */
+struct companion_queue {
+	DECLARE_KFIFO(fifo, struct companion_packet, QUEUE_SIZE);
+};
+
+/**
+ * struct companion_queue_manager - manage all queues for companion
+ * @io_txq:       the tx queue for IO messages
+ * @io_rxq:       the rx queue for IO messages
+ * @can_txq:      the tx queues for CAN messages
+ * @can_rxq:      the rx queues for CAN messages
+ * @can_err:      the queues for CAN error messages
+ * @can_txq_lock: lock for protect CAN tx queue 0
+ * @io_promoted:  flag to indicate promoted IO messages priority
+ * @can_current:  the currently scheduled CAN port
+ * @can_sched:    counter of how many times CAN messages be scheduled
+ */
+struct companion_queue_manager {
+	struct companion_queue io_txq;
+	struct companion_queue io_rxq;
+	struct companion_queue can_txq[BCP_CAN_PORTS][BCP_CAN_PRIOS];
+	struct companion_queue can_rxq[BCP_CAN_PORTS];
+	struct companion_queue can_err[BCP_CAN_PORTS];
+	struct mutex           can_txq_lock[BCP_CAN_PORTS];
+
+	bool                   io_promoted;
+	u8                     can_current;
+	u32                    can_sched;
+};
+
+/**
+ * qm_init() - initialize all managed queues
+ * @qm: address of the queue manager to be initialized
+ */
+void qm_init(struct companion_queue_manager *qm);
+
+/**
+ * qm_reset() - reset all managed queues
+ * @qm: address of the queue manager to be reset
+ */
+void qm_reset(struct companion_queue_manager *qm);
+
+/**
+ * qm_reset_io() - reset managed IO queues
+ * @qm: address of the queue manager to be reset
+ */
+void qm_reset_io(struct companion_queue_manager *qm);
+
+/**
+ * qm_reset_can() - reset managed CAN queues
+ * @qm:   address of the queue manager to be reset
+ * @port: port number of which CAN queue should be reset
+ */
+void qm_reset_can(struct companion_queue_manager *qm, u8 port);
+
+/**
+ * qm_has_tx_data() - return true if has tx data
+ * @qm: address of the queue manager to be used
+ */
+bool qm_has_tx_data(struct companion_queue_manager *qm);
+
+/**
+ * qm_get_tx_data() - return true if got the tx data
+ * @qm: address of the queue manager to be used
+ * @p:  where the data to be copied
+ */
+bool qm_get_tx_data(struct companion_queue_manager *qm,
+		    struct companion_packet        *p);
+
+/**
+ * qm_io_txq_is_full() - return true if IO tx queue is full
+ * @qm: address of the queue manager to be used
+ */
+static inline bool qm_io_txq_is_full(struct companion_queue_manager *qm)
+{
+	return kfifo_is_full(&qm->io_txq.fifo);
+}
+
+/**
+ * qm_io_rxq_is_empty() - return true if IO rx queue is empty
+ * @qm: address of the queue manager to be used
+ */
+static inline bool qm_io_rxq_is_empty(struct companion_queue_manager *qm)
+{
+	return kfifo_is_empty(&qm->io_rxq.fifo);
+}
+
+/**
+ * qm_io_txq_in() - put data from user sapce into IO tx queue
+ * @qm:     address of the queue manager to be used
+ * @buf:    address of the data to be put
+ * @count:  number of bytes to be put
+ * @copied: address to store the number of copied bytes
+ */
+static inline int qm_io_txq_in(struct companion_queue_manager *qm,
+			       const char __user              *buf,
+			       size_t                          count,
+			       unsigned int                   *copied)
+{
+	return kfifo_from_user(&qm->io_txq.fifo, buf, count, copied);
+}
+
+/**
+ * qm_io_txq_out() - get data from the IO tx queue
+ * @qm: address of the queue manager to be used
+ * @p:  address of the data to be copied
+ */
+static inline bool qm_io_txq_out(struct companion_queue_manager *qm,
+				 struct companion_packet        *p)
+{
+	return kfifo_out(&qm->io_txq.fifo, p, 1) == 1;
+}
+
+/**
+ * qm_io_rxq_in() - put data into IO rx queue
+ * @qm: address of the queue manager to be used
+ * @p:  address of the data to be put
+ */
+static inline bool qm_io_rxq_in(struct companion_queue_manager *qm,
+				const struct companion_packet  *p)
+{
+	return kfifo_in(&qm->io_rxq.fifo, p, 1) == 1;
+}
+
+/**
+ * qm_io_rxq_out() - copy data from the IO rx queue into user space
+ * @qm:     address of the queue manager to be used
+ * @buf:    address of the data to be copied
+ * @count:  number of the bytes to be copied
+ * @copied: address to store the number of copied bytes
+ */
+static inline int qm_io_rxq_out(struct companion_queue_manager *qm,
+				char __user                    *buf,
+				size_t                          count,
+				unsigned int                   *copied)
+{
+	return kfifo_to_user(&qm->io_rxq.fifo, buf, count, copied);
+}
+
+/**
+ * qm_can_txq_in() - put data into CAN tx queue
+ * @qm:   address of the queue manager to be used
+ * @p:    address of the data to be put
+ * @port: port number of which CAN queue array to be put
+ * @prio: priority of which CAN queue to be put
+ */
+static inline bool qm_can_txq_in(struct companion_queue_manager *qm,
+				 const struct companion_packet  *p,
+				 u8                              port,
+				 u8                              prio)
+{
+	bool result = false;
+
+	if (prio > 0)
+		return kfifo_in(&qm->can_txq[port][prio].fifo, p, 1) == 1;
+
+	/* queue 0 has multiple writers due to it sends both data and
+	 * administrative frames, while queue 1-7 only send data frame
+	 * (single writer), hence only queue 0 needs lock.
+	 */
+	mutex_lock(&qm->can_txq_lock[port]);
+	result = (kfifo_in(&qm->can_txq[port][prio].fifo, p, 1) == 1);
+	mutex_unlock(&qm->can_txq_lock[port]);
+	return result;
+}
+
+/**
+ * qm_can_txq_out() - get data from the CAN tx queue
+ * @qm:   address of the queue manager to be used
+ * @p:    address of the data to be copied
+ * @port: port number of which CAN queue array to be copied
+ * @prio: priority of which CAN queue to be copied
+ */
+static inline bool qm_can_txq_out(struct companion_queue_manager *qm,
+				  struct companion_packet        *p,
+				  u8                             port,
+				  u8                             prio)
+{
+	return kfifo_out(&qm->can_txq[port][prio].fifo, p, 1) == 1;
+}
+
+/**
+ * qm_can_rxq_in() - put data into CAN rx queue
+ * @qm:   address of the queue manager to be used
+ * @p:    address of the data to be put
+ * @port: port number of which CAN queue to be put
+ */
+static inline bool qm_can_rxq_in(struct companion_queue_manager *qm,
+				 const struct companion_packet  *p,
+				 u8                              port)
+{
+	return kfifo_in(&qm->can_rxq[port].fifo, p, 1) == 1;
+}
+
+/**
+ * qm_can_rxq_out() - get data from the CAN rx queue
+ * @qm:   address of the queue manager to be used
+ * @p:    address of the data to be copied
+ * @port: port number of which CAN queue to be copied
+ */
+static inline bool qm_can_rxq_out(struct companion_queue_manager *qm,
+				  struct companion_packet        *p,
+				  u8                              port)
+{
+	return kfifo_out(&qm->can_rxq[port].fifo, p, 1) == 1;
+}
+
+static inline bool qm_can_err_in(struct companion_queue_manager *qm,
+				 const struct companion_packet  *p,
+				 u8                              port)
+{
+	return kfifo_in(&qm->can_err[port].fifo, p, 1) == 1;
+}
+
+static inline bool qm_can_err_out(struct companion_queue_manager *qm,
+				  struct companion_packet        *p,
+				  u8                              port)
+{
+	return kfifo_out(&qm->can_err[port].fifo, p, 1) == 1;
+}
+
+#endif
diff --git a/include/linux/companion.h b/include/linux/companion.h
new file mode 100644
index 0000000..fdc6258
--- /dev/null
+++ b/include/linux/companion.h
@@ -0,0 +1,259 @@
+/*
+ * Companion low level driver interface
+ *
+ * Copyright (C) 2017 Bosch Sicherheitssysteme GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _BOSCH_COMPANION_H
+#define _BOSCH_COMPANION_H
+
+#include <linux/can/dev.h>
+#include <linux/device.h>
+
+#define COMPANION_PACKET_SIZE 16
+
+/**
+ * struct companion_io_ops - callbacks of companion IO packets handling
+ * @on_tx_done: called when IO packets tx is done
+ * @on_rx_done: called when IO packets rx is done
+ */
+struct companion_io_ops {
+	void (*on_tx_done)(void *data);
+	void (*on_rx_done)(void *data);
+};
+
+/**
+ * struct companion_can_ops - callbacks of companion CAN packets handling
+ * @on_tx_done:    called when CAN packets tx is done
+ * @on_rx_done:    called when CAN packets rx is done
+ * @on_error:      called when CAN error detected
+ * @on_tx_timeout: called when CAN packets tx timeout
+ */
+struct companion_can_ops {
+	void (*on_tx_done)(void *data, u8 prio, bool lost_seq, bool success);
+	void (*on_rx_done)(void *data);
+	void (*on_error)(void *data);
+	void (*on_tx_timeout)(void *data, u8 prio);
+};
+
+/**
+ * companion_io_ops_register() - register companion IO packets handler
+ * @parent: address of the caller parent device to be registered
+ * @ops:    address of the IO packets callback
+ * @data:   address of the IO packets callback argument
+ */
+int companion_io_ops_register(struct device           *parent,
+			      struct companion_io_ops *ops,
+			      void                    *data);
+
+/**
+ * companion_io_ops_unregister() - unregister companion IO packets handler
+ * @parent: address of the caller parent device to be unregistered
+ */
+int companion_io_ops_unregister(struct device *parent);
+
+/**
+ * companion_can_ops_register() - register companion CAN packets handler
+ * @parent: address of the caller parent device to be registered
+ * @ops:    address of the CAN packets callback
+ * @data:   address of the CAN packets callback argument
+ */
+int companion_can_ops_register(struct device            *parent,
+			       u8                        port,
+			       struct companion_can_ops *ops,
+			       void                     *data);
+
+/**
+ * companion_can_ops_unregister() - unregister comapnion CAN packets handler
+ * @parent: address of the caller parent device to be unregistered
+ * @port:   port number of which CAN to be unregistered
+ */
+int companion_can_ops_unregister(struct device *parent, u8 port);
+
+/**
+ * companion_io_txq_is_full() - return true if IO tx queue is full
+ * @parent: address of the caller parent device to be used
+ */
+bool companion_io_txq_is_full(struct device *parent);
+
+/**
+ * companion_io_rxq_is_empty() - return true if IO rx queue is empty
+ * @parent: address of the caller parent device to be used
+ */
+bool companion_io_rxq_is_empty(struct device *parent);
+
+/**
+ * companion_do_io_tx() - send IO packets from user space to companion
+ * @parent: address of the caller parent device to be used
+ * @buf:    address of the user space data to be sent
+ * @count:  number of bytes to be sent
+ */
+int companion_do_io_tx(struct device     *parent,
+		       const char __user *buf,
+		       size_t             count);
+
+/**
+ * companion_do_io_rx() - receive IO packets from companion to user space
+ * @parent: address of the caller parent device to be used
+ * @buf:    address of the data to be copied
+ * @count:  number of bytes to be copied
+ */
+int companion_do_io_rx(struct device *parent,
+		       char __user   *buf,
+		       size_t         count);
+
+/**
+ * companion_do_can_tx() - send CAN data to companion
+ * @parent: address of the caller parent device to be used
+ * @port:   port number of which CAN to be sent
+ * @prio:   priority of the raw CAN frame to be sent
+ * @cf:     address of the raw CAN frame to be sent
+ */
+int companion_do_can_tx(struct device          *parent,
+			u8                      port,
+			u8                      prio,
+			const struct can_frame *cf);
+
+/**
+ * companion_do_can_rx() - receive CAN data from companion
+ * @parent: address of the caller parent device to be used
+ * @port:   port number of which CAN to be received
+ * @cf:     address of the raw CAN frame to be copied
+ */
+int companion_do_can_rx(struct device    *parent,
+			u8                port,
+			struct can_frame *cf);
+
+/**
+ * companion_do_can_err() - receive CAN error from companion
+ * @parent: address of the caller parent device to be used
+ * @port:   port number of which CAN to be received
+ * @bec:    address of the error counter to be copied
+ * @state:  address of the error state to be copied
+ * @code:   address of the error code to be copied
+ */
+int companion_do_can_err(struct device           *parent,
+			 u8                       port,
+			 struct can_berr_counter *bec,
+			 u8                      *state,
+			 u8                      *code);
+
+#define COMPANION_CAN_STATE_WARNING BIT(0)
+#define COMPANION_CAN_STATE_PASSIVE BIT(1)
+#define COMPANION_CAN_STATE_BUS_OFF BIT(2)
+#define COMPANION_CAN_ERROR_STUFF   BIT(0)
+#define COMPANION_CAN_ERROR_FORM    BIT(1)
+#define COMPANION_CAN_ERROR_ACK     BIT(2)
+#define COMPANION_CAN_ERROR_BIT1    BIT(3)
+#define COMPANION_CAN_ERROR_BIT0    BIT(4)
+#define COMPANION_CAN_ERROR_CRC     BIT(5)
+#define COMPANION_CAN_ERROR_RXOV    BIT(7)
+
+/**
+ * companion_do_set_can_bittiming() - set companion CAN bittiming
+ * @parent:    address of the caller parent device to be used
+ * @port:      port number of which CAN to be set
+ * @bittiming: the bittiming to be set
+ */
+int companion_do_set_can_bittiming(struct device              *parent,
+				   u8                          port,
+				   const struct can_bittiming *bittiming);
+
+/**
+ * companion_do_set_can_mode() - set companion CAN mode
+ * @parent: address of the caller parent device to be used
+ * @port:   port number of which CAN to be set
+ * @mode:   the mode to be set
+ */
+int companion_do_set_can_mode(struct device *parent,
+			      u8             port,
+			      enum can_mode  mode);
+
+/**
+ * companion_do_set_can_ctrlmode() - set companion CAN control mode
+ * @parent: address of the caller parent device to be used
+ * @port:   port number of which CAN to be set
+ * @ctrl:   the control mode to be set
+ */
+int companion_do_set_can_ctrlmode(struct device *parent,
+				  u8             port,
+				  u32            ctrl);
+
+/**
+ * companion_do_get_can_status() - get companion CAN status
+ * @parent: address of the caller parent device to be used
+ * @port:   port number of which CAN to be inquiry
+ * @bec:    address of the error counter to be copied
+ */
+int companion_do_get_can_status(struct device           *parent,
+				u8                       port,
+				struct can_berr_counter *bec);
+
+/**
+ * companion_do_get_can_txq_status() - get companion CAN tx queue status
+ * @parent:        address of the caller parent device to be used
+ * @port:          port number of which CAN to be inquiry
+ * @prio:          queue number of which tx queue to be inquiry
+ * @lost_txq_sync: flag of the given CAN tx queue lost sync or not
+ */
+int companion_do_get_can_txq_status(struct device *parent,
+				    u8             port,
+				    u8             prio,
+				    bool          *lost_txq_sync);
+
+/**
+ * companion_do_get_can_txq_status_all() - get all companion CAN tx queue status
+ * @parent: address of the caller parent device to be used
+ * @port:   port number of which CAN to be inquiry
+ */
+int companion_do_get_can_txq_status_all(struct device *parent,
+					u8             port);
+
+/**
+ * companion_do_can_txq_is_full() - inquiry companion CAN tx queue is full
+ * @parent:  address of the caller parent device to be used
+ * @port:    port number of which CAN to be inquiry
+ * @prio:    queue number of which tx queue to be inquiry
+ * @is_full: address of the is full result to be copied
+ */
+int companion_do_can_txq_is_full(struct device *parent,
+				 u8             port,
+				 u8             prio,
+				 bool          *is_full);
+
+/**
+ * companion_do_can_txq_has_space() - inquiry companion CAN tx queue has space
+ * @parent:    address of the caller parent device to be used
+ * @port:      port number of which CAN to be inquiry
+ * @prio:      queue number of which tx queue to be inquiry
+ * @has_space: address of the has_space result to be copied
+ */
+int companion_do_can_txq_has_space(struct device *parent,
+				   u8             port,
+				   u8             prio,
+				   bool          *has_space);
+
+/**
+ * companion_do_can_start_tx_timer() - start companioin CAN tx timeout detection
+ * @parent: address of the caller parent device to be used
+ * @port:   port number of which CAN to be used
+ * @prio:   queue number of which tx queue's timer to be used
+ */
+int companion_do_can_start_tx_timer(struct device *parent,
+				    u8             port,
+				    u8             prio);
+
+/**
+ * companion_do_can_stop_tx_timer() - stop companion CAN tx timeout detection
+ * @parent: address of the caller parent device to be used
+ * @port:   port number of which CAN to be used
+ * @prio:   queue number of which tx queue's timer to be used
+ */
+int companion_do_can_stop_tx_timer(struct device *parent,
+				   u8             port,
+				   u8             prio);
+#endif
-- 
2.7.4

