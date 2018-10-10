Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F669C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F4F214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F4F214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeJKArG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:47:06 -0400
Received: from shell.v3.sk ([90.176.6.54]:54589 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727719AbeJKArF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:47:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 092C1BCFE4;
        Wed, 10 Oct 2018 19:23:54 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id F7R3WeAejUjw; Wed, 10 Oct 2018 19:23:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E39F6BCFCA;
        Wed, 10 Oct 2018 19:23:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xdWM2rHv0-aa; Wed, 10 Oct 2018 19:23:06 +0200 (CEST)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 40BB6BCFB8;
        Wed, 10 Oct 2018 19:23:05 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Cameron <quozl@laptop.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 06/15] Platform: OLPC: Add XO-1.75 EC driver
Date:   Wed, 10 Oct 2018 19:22:51 +0200
Message-Id: <20181010172300.317643-7-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181010172300.317643-1-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's based off the driver from the OLPC kernel sources. Somewhat
modernized and cleaned up, for better or worse.

Modified to plug into the olpc-ec driver infrastructure (so that battery
interface and debugfs could be reused) and the SPI slave framework.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/platform/olpc/Kconfig         |  15 +
 drivers/platform/olpc/Makefile        |   1 +
 drivers/platform/olpc/olpc-xo175-ec.c | 755 ++++++++++++++++++++++++++
 3 files changed, 771 insertions(+)
 create mode 100644 drivers/platform/olpc/olpc-xo175-ec.c

diff --git a/drivers/platform/olpc/Kconfig b/drivers/platform/olpc/Kconfi=
g
index 7b736c9e67ac..7c643d24ad0f 100644
--- a/drivers/platform/olpc/Kconfig
+++ b/drivers/platform/olpc/Kconfig
@@ -9,3 +9,18 @@ config OLPC
 	help
 	  Add support for detecting the unique features of the OLPC
 	  XO hardware.
+
+if OLPC
+
+config OLPC_XO175_EC
+	tristate "OLPC XO 1.75 Embedded Controller"
+	depends on ARCH_MMP || COMPILE_TEST
+	select SPI_SLAVE
+	help
+	  Include support for the OLPC XO Embedded Controller (EC). The EC
+	  provides various platform services, including support for the power,
+	  button, restart, shutdown and battery charging status.
+
+	  Unless you have an OLPC XO laptop, you will want to say N.
+
+endif
diff --git a/drivers/platform/olpc/Makefile b/drivers/platform/olpc/Makef=
ile
index dc8b26bc7209..5b43f383289e 100644
--- a/drivers/platform/olpc/Makefile
+++ b/drivers/platform/olpc/Makefile
@@ -2,3 +2,4 @@
 # OLPC XO platform-specific drivers
 #
 obj-$(CONFIG_OLPC)		+=3D olpc-ec.o
+obj-$(CONFIG_OLPC_XO175_EC)	+=3D olpc-xo175-ec.o
diff --git a/drivers/platform/olpc/olpc-xo175-ec.c b/drivers/platform/olp=
c/olpc-xo175-ec.c
new file mode 100644
index 000000000000..6333a1366730
--- /dev/null
+++ b/drivers/platform/olpc/olpc-xo175-ec.c
@@ -0,0 +1,755 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for the OLPC XO-1.75 Embedded Controller.
+ *
+ * The EC protocol is documented at:
+ * http://wiki.laptop.org/go/XO_1.75_HOST_to_EC_Protocol
+ *
+ * Copyright (C) 2010 One Laptop per Child Foundation.
+ * Copyright (C) 2018 Lubomir Rintel <lkundrak@v3.sk>
+ */
+
+#include <asm/system_misc.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/ctype.h>
+#include <linux/olpc-ec.h>
+#include <linux/spi/spi.h>
+#include <linux/reboot.h>
+#include <linux/input.h>
+#include <linux/kfifo.h>
+#include <linux/module.h>
+#include <linux/power_supply.h>
+
+struct ec_cmd_t {
+	u8 cmd;
+	u8 bytes_returned;
+};
+
+enum ec_chan_t {
+	CHAN_NONE =3D 0,
+	CHAN_SWITCH,
+	CHAN_CMD_RESP,
+	CHAN_KEYBOARD,
+	CHAN_TOUCHPAD,
+	CHAN_EVENT,
+	CHAN_DEBUG,
+	CHAN_CMD_ERROR,
+};
+
+/*
+ * EC events
+ */
+#define EVENT_AC_CHANGE			1  /* AC plugged/unplugged */
+#define EVENT_BATTERY_STATUS		2  /* Battery low/full/error/gone */
+#define EVENT_BATTERY_CRITICAL		3  /* Battery critical voltage */
+#define EVENT_BATTERY_SOC_CHANGE	4  /* 1% SOC Change */
+#define EVENT_BATTERY_ERROR		5  /* Abnormal error, query for cause */
+#define EVENT_POWER_PRESSED		6  /* Power button was pressed */
+#define EVENT_POWER_PRESS_WAKE		7  /* Woken up with a power button */
+#define EVENT_TIMED_HOST_WAKE		8  /* Host wake timer */
+#define EVENT_OLS_HIGH_LIMIT		9  /* OLS crossed dark threshold */
+#define EVENT_OLS_LOW_LIMIT		10 /* OLS crossed light threshold */
+
+/*
+ * EC commands
+ * (from http://dev.laptop.org/git/users/rsmith/ec-1.75/tree/ec_cmd.h)
+ */
+#define CMD_GET_API_VERSION		0x08 /* out: u8 */
+#define CMD_READ_VOLTAGE		0x10 /* out: u16, *9.76/32, mV */
+#define CMD_READ_CURRENT		0x11 /* out: s16, *15.625/120, mA */
+#define CMD_READ_ACR			0x12 /* out: s16, *6250/15, uAh */
+#define CMD_READ_BATT_TEMPERATURE	0x13 /* out: u16, *100/256, deg C */
+#define CMD_READ_AMBIENT_TEMPERATURE	0x14 /* unimplemented, no hardware =
*/
+#define CMD_READ_BATTERY_STATUS		0x15 /* out: u8, bitmask */
+#define CMD_READ_SOC			0x16 /* out: u8, percentage */
+#define CMD_READ_GAUGE_ID		0x17 /* out: u8 * 8 */
+#define CMD_READ_GAUGE_DATA		0x18 /* in: u8 addr, out: u8 data */
+#define CMD_READ_BOARD_ID		0x19 /* out: u16 (platform id) */
+#define CMD_READ_BATT_ERR_CODE		0x1f /* out: u8, error bitmask */
+#define CMD_SET_DCON_POWER		0x26 /* in: u8 */
+#define CMD_RESET_EC			0x28 /* none */
+#define CMD_READ_BATTERY_TYPE		0x2c /* out: u8 */
+#define CMD_SET_AUTOWAK			0x33 /* out: u8 */
+#define CMD_SET_EC_WAKEUP_TIMER		0x36 /* in: u32, out: ? */
+#define CMD_READ_EXT_SCI_MASK		0x37 /* ? */
+#define CMD_WRITE_EXT_SCI_MASK		0x38 /* ? */
+#define CMD_CLEAR_EC_WAKEUP_TIMER	0x39 /* none */
+#define CMD_ENABLE_RUNIN_DISCHARGE	0x3B /* none */
+#define CMD_DISABLE_RUNIN_DISCHARGE	0x3C /* none */
+#define CMD_READ_MPPT_ACTIVE		0x3d /* out: u8 */
+#define CMD_READ_MPPT_LIMIT		0x3e /* out: u8 */
+#define CMD_SET_MPPT_LIMIT		0x3f /* in: u8 */
+#define CMD_DISABLE_MPPT		0x40 /* none */
+#define CMD_ENABLE_MPPT			0x41 /* none */
+#define CMD_READ_VIN			0x42 /* out: u16 */
+#define CMD_EXT_SCI_QUERY		0x43 /* ? */
+#define RSP_KEYBOARD_DATA		0x48 /* ? */
+#define RSP_TOUCHPAD_DATA		0x49 /* ? */
+#define CMD_GET_FW_VERSION		0x4a /* out: u8 * 16 */
+#define CMD_POWER_CYCLE			0x4b /* none */
+#define CMD_POWER_OFF			0x4c /* none */
+#define CMD_RESET_EC_SOFT		0x4d /* none */
+#define CMD_READ_GAUGE_U16		0x4e /* ? */
+#define CMD_ENABLE_MOUSE		0x4f /* ? */
+#define CMD_ECHO			0x52 /* in: u8 * 5, out: u8 * 5 */
+#define CMD_GET_FW_DATE			0x53 /* out: u8 * 16 */
+#define CMD_GET_FW_USER			0x54 /* out: u8 * 16 */
+#define CMD_TURN_OFF_POWER		0x55 /* none (same as 0x4c) */
+#define CMD_READ_OLS			0x56 /* out: u16 */
+#define CMD_OLS_SMT_LEDON		0x57 /* none */
+#define CMD_OLS_SMT_LEDOFF		0x58 /* none */
+#define CMD_START_OLS_ASSY		0x59 /* none */
+#define CMD_STOP_OLS_ASSY		0x5a /* none */
+#define CMD_OLS_SMTTEST_STOP		0x5b /* none */
+#define CMD_READ_VIN_SCALED		0x5c /* out: u16 */
+#define CMD_READ_BAT_MIN_W		0x5d /* out: u16 */
+#define CMD_READ_BAR_MAX_W		0x5e /* out: u16 */
+#define CMD_RESET_BAT_MINMAX_W		0x5f /* none */
+#define CMD_READ_LOCATION		0x60 /* in: u16 addr, out: u8 data */
+#define CMD_WRITE_LOCATION		0x61 /* in: u16 addr, u8 data */
+#define CMD_KEYBOARD_CMD		0x62 /* in: u8, out: ? */
+#define CMD_TOUCHPAD_CMD		0x63 /* in: u8, out: ? */
+#define CMD_GET_FW_HASH			0x64 /* out: u8 * 16 */
+#define CMD_SUSPEND_HINT		0x65 /* in: u8 */
+#define CMD_ENABLE_WAKE_TIMER		0x66 /* in: u8 */
+#define CMD_SET_WAKE_TIMER		0x67 /* in: 32 */
+#define CMD_ENABLE_WAKE_AUTORESET	0x68 /* in: u8 */
+#define CMD_OLS_SET_LIMITS		0x69 /* in: u16, u16 */
+#define CMD_OLS_GET_LIMITS		0x6a /* out: u16, u16 */
+#define CMD_OLS_SET_CEILING		0x6b /* in: u16 */
+#define CMD_OLS_GET_CEILING		0x6c /* out: u16 */
+
+/*
+ * Accepted EC commands, and how many bytes they return. There are plent=
y
+ * of EC commands that are no longer implemented, or are implemented onl=
y on
+ * certain older boards.
+ */
+static const struct ec_cmd_t olpc_xo175_ec_cmds[] =3D {
+	{ CMD_GET_API_VERSION, 1 },
+	{ CMD_READ_VOLTAGE, 2 },
+	{ CMD_READ_CURRENT, 2 },
+	{ CMD_READ_ACR, 2 },
+	{ CMD_READ_BATT_TEMPERATURE, 2 },
+	{ CMD_READ_BATTERY_STATUS, 1 },
+	{ CMD_READ_SOC, 1 },
+	{ CMD_READ_GAUGE_ID, 8 },
+	{ CMD_READ_GAUGE_DATA, 1 },
+	{ CMD_READ_BOARD_ID, 2 },
+	{ CMD_READ_BATT_ERR_CODE, 1 },
+	{ CMD_SET_DCON_POWER, 0 },
+	{ CMD_RESET_EC, 0 },
+	{ CMD_READ_BATTERY_TYPE, 1 },
+	{ CMD_ENABLE_RUNIN_DISCHARGE, 0 },
+	{ CMD_DISABLE_RUNIN_DISCHARGE, 0 },
+	{ CMD_READ_MPPT_ACTIVE, 1 },
+	{ CMD_READ_MPPT_LIMIT, 1 },
+	{ CMD_SET_MPPT_LIMIT, 0 },
+	{ CMD_DISABLE_MPPT, 0 },
+	{ CMD_ENABLE_MPPT, 0 },
+	{ CMD_READ_VIN, 2 },
+	{ CMD_GET_FW_VERSION, 16 },
+	{ CMD_POWER_CYCLE, 0 },
+	{ CMD_POWER_OFF, 0 },
+	{ CMD_RESET_EC_SOFT, 0 },
+	{ CMD_ECHO, 5 },
+	{ CMD_GET_FW_DATE, 16 },
+	{ CMD_GET_FW_USER, 16 },
+	{ CMD_TURN_OFF_POWER, 0 },
+	{ CMD_READ_OLS, 2 },
+	{ CMD_OLS_SMT_LEDON, 0 },
+	{ CMD_OLS_SMT_LEDOFF, 0 },
+	{ CMD_START_OLS_ASSY, 0 },
+	{ CMD_STOP_OLS_ASSY, 0 },
+	{ CMD_OLS_SMTTEST_STOP, 0 },
+	{ CMD_READ_VIN_SCALED, 2 },
+	{ CMD_READ_BAT_MIN_W, 2 },
+	{ CMD_READ_BAR_MAX_W, 2 },
+	{ CMD_RESET_BAT_MINMAX_W, 0 },
+	{ CMD_READ_LOCATION, 1 },
+	{ CMD_WRITE_LOCATION, 0 },
+	{ CMD_GET_FW_HASH, 16 },
+	{ CMD_SUSPEND_HINT, 0 },
+	{ CMD_ENABLE_WAKE_TIMER, 0 },
+	{ CMD_SET_WAKE_TIMER, 0 },
+	{ CMD_ENABLE_WAKE_AUTORESET, 0 },
+	{ CMD_OLS_SET_LIMITS, 0 },
+	{ CMD_OLS_GET_LIMITS, 4 },
+	{ CMD_OLS_SET_CEILING, 0 },
+	{ CMD_OLS_GET_CEILING, 2 },
+	{ CMD_READ_EXT_SCI_MASK, 2 },
+	{ CMD_WRITE_EXT_SCI_MASK, 0 },
+
+	{ 0 },
+};
+
+#define EC_CMD_LEN		8
+#define EC_MAX_RESP_LEN		16
+#define LOG_BUF_SIZE		127
+
+enum ec_state_t {
+	CMD_STATE_IDLE =3D 0,
+	CMD_STATE_WAITING_FOR_SWITCH,
+	CMD_STATE_CMD_IN_TX_FIFO,
+	CMD_STATE_CMD_SENT,
+	CMD_STATE_RESP_RECEIVED,
+	CMD_STATE_ERROR_RECEIVED,
+};
+
+struct olpc_xo175_ec {
+	struct spi_device *spi;
+
+	struct spi_transfer xfer;
+	struct spi_message msg;
+
+	u8 tx_buf[EC_CMD_LEN];
+	u8 rx_buf[EC_MAX_RESP_LEN];
+
+	bool suspended;
+
+	/* GPIOs for ACK and CMD signals. */
+	struct gpio_desc *gpio_cmd;
+
+	/* Command handling related state. */
+	spinlock_t cmd_state_lock;
+	int cmd_state;
+	bool cmd_running;
+	struct completion cmd_done;
+	u8 cmd[EC_CMD_LEN];
+	int expected_resp_len;
+	u8 resp[EC_MAX_RESP_LEN];
+	int resp_len;
+
+	/* Power button. */
+	struct input_dev *pwrbtn;
+
+	/* Debug handling. */
+	char logbuf[LOG_BUF_SIZE + 1];
+	int logbuf_len;
+};
+
+static int olpc_xo175_ec_is_valid_cmd(u8 cmd)
+{
+	const struct ec_cmd_t *p;
+
+	for (p =3D olpc_xo175_ec_cmds; p->cmd; p++) {
+		if (p->cmd =3D=3D cmd)
+			return p->bytes_returned;
+	}
+
+	return -1;
+}
+
+static void olpc_xo175_ec_flush_logbuf(struct olpc_xo175_ec *priv)
+{
+	priv->logbuf[priv->logbuf_len] =3D 0;
+	priv->logbuf_len =3D 0;
+
+	dev_dbg(&priv->spi->dev, "got debug string [%s]\n", priv->logbuf);
+}
+
+static void olpc_xo175_ec_complete(void *arg);
+
+static void olpc_xo175_ec_send_command(struct olpc_xo175_ec *priv, u8 *c=
md,
+								size_t cmdlen)
+{
+	int ret;
+
+	memcpy(priv->tx_buf, cmd, cmdlen);
+	priv->xfer.len =3D cmdlen;
+
+	spi_message_init_with_transfers(&priv->msg, &priv->xfer, 1);
+
+	priv->msg.complete =3D olpc_xo175_ec_complete;
+	priv->msg.context =3D priv;
+
+	ret =3D spi_async(priv->spi, &priv->msg);
+	if (ret)
+		dev_err(&priv->spi->dev, "spi_async() failed %d\n", ret);
+}
+
+static void olpc_xo175_ec_read_packet(struct olpc_xo175_ec *priv)
+{
+	u8 nonce[] =3D {0xA5, 0x5A};
+
+	olpc_xo175_ec_send_command(priv, nonce, sizeof(nonce));
+}
+
+static void olpc_xo175_ec_complete(void *arg)
+{
+	struct olpc_xo175_ec *priv =3D arg;
+	struct device *dev =3D &priv->spi->dev;
+	struct power_supply *psy;
+	unsigned long flags;
+	u8 channel;
+	u8 byte;
+	int ret;
+
+	ret =3D priv->msg.status;
+	if (ret) {
+		dev_err(dev, "SPI transfer failed: %d\n", ret);
+
+		spin_lock_irqsave(&priv->cmd_state_lock, flags);
+		if (priv->cmd_running) {
+			priv->resp_len =3D 0;
+			priv->cmd_state =3D CMD_STATE_ERROR_RECEIVED;
+			complete(&priv->cmd_done);
+		}
+		spin_unlock_irqrestore(&priv->cmd_state_lock, flags);
+
+		if (ret !=3D -EINTR)
+			olpc_xo175_ec_read_packet(priv);
+
+		return;
+	}
+
+	channel =3D priv->rx_buf[0];
+	byte =3D priv->rx_buf[1];
+
+	switch (channel) {
+	case CHAN_NONE:
+		spin_lock_irqsave(&priv->cmd_state_lock, flags);
+
+		if (!priv->cmd_running) {
+			/* We can safely ignore these */
+			dev_err(dev, "spurious FIFO read packet\n");
+			spin_unlock_irqrestore(&priv->cmd_state_lock, flags);
+			return;
+		}
+
+		priv->cmd_state =3D CMD_STATE_CMD_SENT;
+		if (!priv->expected_resp_len)
+			complete(&priv->cmd_done);
+		olpc_xo175_ec_read_packet(priv);
+
+		spin_unlock_irqrestore(&priv->cmd_state_lock, flags);
+		return;
+
+	case CHAN_SWITCH:
+		spin_lock_irqsave(&priv->cmd_state_lock, flags);
+
+		if (!priv->cmd_running) {
+			/* Just go with the flow */
+			dev_err(dev, "spurious SWITCH packet\n");
+			memset(priv->cmd, 0, sizeof(priv->cmd));
+			priv->cmd[0] =3D CMD_ECHO;
+		}
+
+		priv->cmd_state =3D CMD_STATE_CMD_IN_TX_FIFO;
+
+		/* Throw command into TxFIFO */
+		gpiod_set_value_cansleep(priv->gpio_cmd, 0);
+		olpc_xo175_ec_send_command(priv, priv->cmd, sizeof(priv->cmd));
+
+		spin_unlock_irqrestore(&priv->cmd_state_lock, flags);
+		return;
+
+	case CHAN_CMD_RESP:
+		spin_lock_irqsave(&priv->cmd_state_lock, flags);
+
+		if (!priv->cmd_running) {
+			dev_err(dev, "spurious response packet\n");
+		} else if (priv->resp_len >=3D priv->expected_resp_len) {
+			dev_err(dev, "too many response packets\n");
+		} else {
+			priv->resp[priv->resp_len++] =3D byte;
+
+			if (priv->resp_len =3D=3D priv->expected_resp_len) {
+				priv->cmd_state =3D CMD_STATE_RESP_RECEIVED;
+				complete(&priv->cmd_done);
+			}
+		}
+
+		spin_unlock_irqrestore(&priv->cmd_state_lock, flags);
+		break;
+
+	case CHAN_CMD_ERROR:
+		spin_lock_irqsave(&priv->cmd_state_lock, flags);
+
+		if (!priv->cmd_running) {
+			dev_err(dev, "spurious cmd error packet\n");
+		} else {
+			priv->resp[0] =3D byte;
+			priv->resp_len =3D 1;
+			priv->cmd_state =3D CMD_STATE_ERROR_RECEIVED;
+			complete(&priv->cmd_done);
+		}
+		spin_unlock_irqrestore(&priv->cmd_state_lock, flags);
+		break;
+
+	case CHAN_KEYBOARD:
+	case CHAN_TOUCHPAD:
+		dev_warn(dev, "kbd/tpad not supported\n");
+		break;
+
+	case CHAN_EVENT:
+		dev_dbg(dev, "got event %.2x\n", byte);
+		switch (byte) {
+		case EVENT_AC_CHANGE:
+			psy =3D power_supply_get_by_name("olpc-ac");
+			if (psy) {
+				power_supply_changed(psy);
+				power_supply_put(psy);
+			}
+			break;
+		case EVENT_BATTERY_STATUS:
+		case EVENT_BATTERY_CRITICAL:
+		case EVENT_BATTERY_SOC_CHANGE:
+		case EVENT_BATTERY_ERROR:
+			psy =3D power_supply_get_by_name("olpc-battery");
+			if (psy) {
+				power_supply_changed(psy);
+				power_supply_put(psy);
+			}
+			break;
+		case EVENT_POWER_PRESSED:
+			input_report_key(priv->pwrbtn, KEY_POWER, 1);
+			input_sync(priv->pwrbtn);
+			input_report_key(priv->pwrbtn, KEY_POWER, 0);
+			input_sync(priv->pwrbtn);
+			/* fall through */
+		case EVENT_POWER_PRESS_WAKE:
+		case EVENT_TIMED_HOST_WAKE:
+			pm_wakeup_event(priv->pwrbtn->dev.parent, 1000);
+			break;
+		default:
+			/* For now, we just ignore the unknown events. */
+			break;
+		}
+		break;
+
+	case CHAN_DEBUG:
+		if (byte =3D=3D '\n') {
+			olpc_xo175_ec_flush_logbuf(priv);
+		} else if (isprint(byte)) {
+			priv->logbuf[priv->logbuf_len++] =3D byte;
+			if (priv->logbuf_len =3D=3D LOG_BUF_SIZE)
+				olpc_xo175_ec_flush_logbuf(priv);
+		}
+		break;
+
+	default:
+		dev_warn(dev, "unknown channel: %d, %.2x\n", channel, byte);
+		break;
+	}
+
+	/* Most non-command packets get the TxFIFO refilled and an ACK. */
+	olpc_xo175_ec_read_packet(priv);
+}
+
+/*
+ * This function is protected with a mutex. We can safely assume that
+ * there will be only one instance of this function running at a time.
+ * One of the ways in which we enforce this is by waiting until we get
+ * all response bytes back from the EC, rather than just the number that
+ * the caller requests (otherwise, we might start a new command while an
+ * old command's response bytes are still incoming).
+ */
+static int olpc_xo175_ec_cmd(u8 cmd, u8 *inbuf, size_t inlen, u8 *resp,
+					size_t resp_len, void *ec_cb_arg)
+{
+	struct olpc_xo175_ec *priv =3D ec_cb_arg;
+	struct device *dev =3D &priv->spi->dev;
+	unsigned long flags;
+	int nr_bytes;
+	int ret =3D 0;
+
+	dev_dbg(dev, "CMD %x, %d bytes expected\n", cmd, resp_len);
+
+	if (inlen > 5) {
+		dev_err(dev, "command len %d too big!\n", resp_len);
+		return -EOVERFLOW;
+	}
+
+	/* Suspending in the middle of an EC command hoses things badly! */
+	WARN_ON(priv->suspended);
+	if (priv->suspended)
+		return -EBUSY;
+
+	/* Ensure a valid command and return bytes */
+	nr_bytes =3D olpc_xo175_ec_is_valid_cmd(cmd);
+	if (nr_bytes < 0) {
+		dev_err_ratelimited(dev, "unknown command 0x%x\n", cmd);
+
+		/*
+		 * Assume the best in our callers, and allow unknown commands
+		 * through. I'm not the charitable type, but it was beaten
+		 * into me. Just maintain a minimum standard of sanity.
+		 */
+		if (resp_len > sizeof(priv->resp)) {
+			dev_err(dev, "response too big: %d!\n", resp_len);
+			return -EOVERFLOW;
+		}
+		nr_bytes =3D resp_len;
+	}
+	if (resp_len > nr_bytes)
+		resp_len =3D nr_bytes;
+
+	spin_lock_irqsave(&priv->cmd_state_lock, flags);
+
+	/* Initialize the state machine */
+	init_completion(&priv->cmd_done);
+	priv->cmd_running =3D true;
+	priv->cmd_state =3D CMD_STATE_WAITING_FOR_SWITCH;
+	memset(priv->cmd, 0, sizeof(priv->cmd));
+	priv->cmd[0] =3D cmd;
+	priv->cmd[1] =3D inlen;
+	priv->cmd[2] =3D 0;
+	memcpy(&priv->cmd[3], inbuf, inlen);
+	priv->expected_resp_len =3D nr_bytes;
+	priv->resp_len =3D 0;
+	memset(resp, 0, resp_len);
+
+	/* Tickle the cmd gpio to get things started */
+	gpiod_set_value_cansleep(priv->gpio_cmd, 1);
+
+	spin_unlock_irqrestore(&priv->cmd_state_lock, flags);
+
+	/* The irq handler should do the rest */
+	if (!wait_for_completion_timeout(&priv->cmd_done,
+			msecs_to_jiffies(4000))) {
+		dev_err(dev, "EC cmd error: timeout in STATE %d\n",
+				priv->cmd_state);
+		gpiod_set_value_cansleep(priv->gpio_cmd, 0);
+		spi_slave_abort(priv->spi);
+		olpc_xo175_ec_read_packet(priv);
+		return -ETIMEDOUT;
+	}
+
+	spin_lock_irqsave(&priv->cmd_state_lock, flags);
+
+	/* Deal with the results. */
+	if (priv->cmd_state =3D=3D CMD_STATE_ERROR_RECEIVED) {
+		/* EC-provided error is in the single response byte */
+		dev_err(dev, "command 0x%x returned error 0x%x\n",
+							cmd, priv->resp[0]);
+		ret =3D -EREMOTEIO;
+	} else if (priv->resp_len !=3D nr_bytes) {
+		dev_err(dev, "command 0x%x returned %d bytes, expected %d bytes\n",
+						cmd, priv->resp_len, nr_bytes);
+		ret =3D -ETIMEDOUT;
+	} else {
+		/*
+		 * We may have 8 bytes in priv->resp, but we only care about
+		 * what we've been asked for. If the caller asked for only 2
+		 * bytes, give them that. We've guaranteed that
+		 * resp_len <=3D priv->resp_len and priv->resp_len =3D=3D nr_bytes.
+		 */
+		memcpy(resp, priv->resp, resp_len);
+	}
+
+	/* This should already be low, but just in case. */
+	gpiod_set_value_cansleep(priv->gpio_cmd, 0);
+	priv->cmd_running =3D false;
+
+	spin_unlock_irqrestore(&priv->cmd_state_lock, flags);
+
+	return ret;
+}
+
+static int olpc_xo175_ec_set_event_mask(unsigned int mask)
+{
+	unsigned char args[2];
+
+	args[0] =3D mask & 0xff;
+	args[1] =3D (mask >> 8) & 0xff;
+	return olpc_ec_cmd(CMD_WRITE_EXT_SCI_MASK, args, 2, NULL, 0);
+}
+
+static void olpc_xo175_ec_restart(enum reboot_mode mode, const char *cmd=
)
+{
+	while (1) {
+		olpc_ec_cmd(CMD_POWER_CYCLE, NULL, 0, NULL, 0);
+		mdelay(1000);
+	}
+}
+
+static void olpc_xo175_ec_power_off(void)
+{
+	while (1) {
+		olpc_ec_cmd(CMD_POWER_OFF, NULL, 0, NULL, 0);
+		mdelay(1000);
+	}
+}
+
+#ifdef CONFIG_PM
+static int olpc_xo175_ec_suspend(struct device *dev)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct olpc_xo175_ec *priv =3D platform_get_drvdata(pdev);
+	unsigned char hintargs[5];
+	static unsigned int suspend_count;
+
+	suspend_count++;
+	dev_dbg(dev, "%s: suspend sync %08x\n", __func__, suspend_count);
+
+	/*
+	 * First byte is 1 to indicate suspend, the rest is an integer
+	 * counter.
+	 */
+	hintargs[0] =3D 1;
+	memcpy(&hintargs[1], &suspend_count, 4);
+	olpc_ec_cmd(CMD_SUSPEND_HINT, hintargs, 5, NULL, 0);
+
+	/*
+	 * After we've sent the suspend hint, don't allow further EC commands
+	 * to be run until we've resumed. Userspace tasks should be frozen,
+	 * but kernel threads and interrupts could still schedule EC commands.
+	 */
+	priv->suspended =3D true;
+
+	return 0;
+}
+
+static int olpc_xo175_ec_resume_noirq(struct device *dev)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct olpc_xo175_ec *priv =3D platform_get_drvdata(pdev);
+
+	priv->suspended =3D false;
+
+	return 0;
+}
+
+static int olpc_xo175_ec_resume(struct device *dev)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct olpc_xo175_ec *priv =3D platform_get_drvdata(pdev);
+	unsigned char x =3D 0;
+
+	priv->suspended =3D false;
+
+	/*
+	 * The resume hint is only needed if no other commands are
+	 * being sent during resume. all it does is tell the EC
+	 * the SoC is definitely awake.
+	 */
+	olpc_ec_cmd(CMD_SUSPEND_HINT, &x, 1, NULL, 0);
+
+	/* Enable all EC events while we're awake */
+	olpc_xo175_ec_set_event_mask(0xffff);
+
+	return 0;
+}
+#endif
+
+static struct platform_device *olpc_ec;
+
+static struct olpc_ec_driver olpc_xo175_ec_driver =3D {
+	.ec_cmd =3D olpc_xo175_ec_cmd,
+};
+
+static int olpc_xo175_ec_remove(struct spi_device *spi)
+{
+	if (pm_power_off =3D=3D olpc_xo175_ec_power_off)
+		pm_power_off =3D NULL;
+	if (arm_pm_restart =3D=3D olpc_xo175_ec_restart)
+		arm_pm_restart =3D NULL;
+
+	spi_slave_abort(spi);
+
+	platform_device_unregister(olpc_ec);
+	olpc_ec =3D NULL;
+
+	return 0;
+}
+
+static int olpc_xo175_ec_probe(struct spi_device *spi)
+{
+	struct olpc_xo175_ec *priv;
+	int ret;
+
+	if (olpc_ec) {
+		dev_err(&spi->dev, "OLPC EC already registered.\n");
+		return -EBUSY;
+	}
+
+	priv =3D devm_kzalloc(&spi->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->gpio_cmd =3D devm_gpiod_get(&spi->dev, "cmd", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->gpio_cmd)) {
+		dev_err(&spi->dev, "failed to get cmd gpio: %ld\n",
+					PTR_ERR(priv->gpio_cmd));
+		return PTR_ERR(priv->gpio_cmd);
+	}
+
+	priv->spi =3D spi;
+
+	spin_lock_init(&priv->cmd_state_lock);
+	priv->cmd_state =3D CMD_STATE_IDLE;
+	init_completion(&priv->cmd_done);
+
+	priv->logbuf_len =3D 0;
+
+	/* Set up power button input device */
+	priv->pwrbtn =3D devm_input_allocate_device(&spi->dev);
+	if (!priv->pwrbtn)
+		return -ENOMEM;
+	priv->pwrbtn->name =3D "Power Button";
+	priv->pwrbtn->dev.parent =3D &spi->dev;
+	input_set_capability(priv->pwrbtn, EV_KEY, KEY_POWER);
+	ret =3D input_register_device(priv->pwrbtn);
+	if (ret) {
+		dev_err(&spi->dev, "error registering input device: %d\n", ret);
+		return ret;
+	}
+
+	spi_set_drvdata(spi, priv);
+
+	priv->xfer.rx_buf =3D priv->rx_buf;
+	priv->xfer.tx_buf =3D priv->tx_buf;
+
+	olpc_xo175_ec_read_packet(priv);
+
+	olpc_ec_driver_register(&olpc_xo175_ec_driver, priv);
+	olpc_ec =3D platform_device_register_resndata(&spi->dev, "olpc-ec", -1,
+							NULL, 0, NULL, 0);
+
+	/* Enable all EC events while we're awake */
+	olpc_xo175_ec_set_event_mask(0xffff);
+
+	if (pm_power_off =3D=3D NULL)
+		pm_power_off =3D olpc_xo175_ec_power_off;
+	if (arm_pm_restart =3D=3D NULL)
+		arm_pm_restart =3D olpc_xo175_ec_restart;
+
+	dev_info(&spi->dev, "OLPC XO-1.75 Embedded Controller driver\n");
+
+	return 0;
+}
+
+static const struct dev_pm_ops olpc_xo175_ec_pm_ops =3D {
+#ifdef CONFIG_PM
+	.suspend	=3D olpc_xo175_ec_suspend,
+	.resume_noirq	=3D olpc_xo175_ec_resume_noirq,
+	.resume		=3D olpc_xo175_ec_resume,
+#endif
+};
+
+static const struct of_device_id olpc_xo175_ec_of_match[] =3D {
+	{ .compatible =3D "olpc,xo1.75-ec" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, olpc_xo175_ec_of_match);
+
+static struct spi_driver olpc_xo175_ec_spi_driver =3D {
+	.driver =3D {
+		.name	=3D "olpc-xo175-ec",
+		.of_match_table =3D olpc_xo175_ec_of_match,
+		.pm =3D &olpc_xo175_ec_pm_ops,
+	},
+	.probe		=3D olpc_xo175_ec_probe,
+	.remove		=3D olpc_xo175_ec_remove,
+};
+module_spi_driver(olpc_xo175_ec_spi_driver);
+
+MODULE_DESCRIPTION("OLPC XO-1.75 Embedded Controller driver");
+MODULE_AUTHOR("Lennert Buytenhek <buytenh@wantstofly.org>"); /* Function=
ality */
+MODULE_AUTHOR("Lubomir Rintel <lkundrak@v3.sk>"); /* Bugs */
+MODULE_LICENSE("GPL");
--=20
2.19.0

