Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD366C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C39D21757
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C39D21757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388945AbeHGPTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:19:15 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:26785 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733298AbeHGPTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:19:14 -0400
X-IronPort-AV: E=Sophos;i="5.51,455,1526367600"; 
   d="scan'208";a="17190659"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Aug 2018 06:04:59 -0700
Received: from ibiza.rfo.atmel.com (10.10.76.4) by chn-sv-exch02.mchp-main.com
 (10.10.76.38) with Microsoft SMTP Server id 14.3.352.0; Tue, 7 Aug 2018
 06:04:58 -0700
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     <linux-serial@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>, <arnd@arndb.de>,
        <richard.genoud@gmail.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH v3 1/2] tty/serial_core: add ISO7816 infrastructure
Date:   Tue, 7 Aug 2018 15:00:48 +0200
Message-ID: <20180807130049.5957-2-ludovic.desroches@microchip.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20180807130049.5957-1-ludovic.desroches@microchip.com>
References: <20180807130049.5957-1-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Add the ISO7816 ioctl and associated accessors and data structure.
Drivers can then use this common implementation to handle ISO7816.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
[ludovic.desroches@microchip.com: squash and rebase, removal of gpios, checkpatch fixes]
Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 arch/alpha/include/uapi/asm/ioctls.h   |  2 ++
 arch/mips/include/uapi/asm/ioctls.h    |  2 ++
 arch/parisc/include/uapi/asm/ioctls.h  |  2 ++
 arch/powerpc/include/uapi/asm/ioctls.h |  2 ++
 arch/sh/include/uapi/asm/ioctls.h      |  2 ++
 arch/sparc/include/uapi/asm/ioctls.h   |  2 ++
 arch/xtensa/include/uapi/asm/ioctls.h  |  2 ++
 drivers/tty/serial/serial_core.c       | 60 ++++++++++++++++++++++++++++++++++
 include/linux/serial_core.h            |  3 ++
 include/uapi/asm-generic/ioctls.h      |  2 ++
 include/uapi/linux/serial.h            | 17 ++++++++++
 11 files changed, 96 insertions(+)

diff --git a/arch/alpha/include/uapi/asm/ioctls.h b/arch/alpha/include/uapi/asm/ioctls.h
index 3729d92d3fa8..1e9121c9b3c7 100644
--- a/arch/alpha/include/uapi/asm/ioctls.h
+++ b/arch/alpha/include/uapi/asm/ioctls.h
@@ -102,6 +102,8 @@
 #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
 #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
 #define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
+#define TIOCGISO7816	_IOR('T', 0x42, struct serial_iso7816)
+#define TIOCSISO7816	_IOWR('T', 0x43, struct serial_iso7816)
 
 #define TIOCSERCONFIG	0x5453
 #define TIOCSERGWILD	0x5454
diff --git a/arch/mips/include/uapi/asm/ioctls.h b/arch/mips/include/uapi/asm/ioctls.h
index 890245a9f0c4..16aa8a766aec 100644
--- a/arch/mips/include/uapi/asm/ioctls.h
+++ b/arch/mips/include/uapi/asm/ioctls.h
@@ -93,6 +93,8 @@
 #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
 #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
 #define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
+#define TIOCGISO7816	_IOR('T', 0x42, struct serial_iso7816)
+#define TIOCSISO7816	_IOWR('T', 0x43, struct serial_iso7816)
 
 /* I hope the range from 0x5480 on is free ... */
 #define TIOCSCTTY	0x5480		/* become controlling tty */
diff --git a/arch/parisc/include/uapi/asm/ioctls.h b/arch/parisc/include/uapi/asm/ioctls.h
index aafb1c0ca0af..82d1148c6379 100644
--- a/arch/parisc/include/uapi/asm/ioctls.h
+++ b/arch/parisc/include/uapi/asm/ioctls.h
@@ -62,6 +62,8 @@
 #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
 #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
 #define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
+#define TIOCGISO7816	_IOR('T', 0x42, struct serial_iso7816)
+#define TIOCSISO7816	_IOWR('T', 0x43, struct serial_iso7816)
 
 #define FIONCLEX	0x5450  /* these numbers need to be adjusted. */
 #define FIOCLEX		0x5451
diff --git a/arch/powerpc/include/uapi/asm/ioctls.h b/arch/powerpc/include/uapi/asm/ioctls.h
index 41b1a5c15734..2c145da3b774 100644
--- a/arch/powerpc/include/uapi/asm/ioctls.h
+++ b/arch/powerpc/include/uapi/asm/ioctls.h
@@ -102,6 +102,8 @@
 #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
 #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
 #define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
+#define TIOCGISO7816	_IOR('T', 0x42, struct serial_iso7816)
+#define TIOCSISO7816	_IOWR('T', 0x43, struct serial_iso7816)
 
 #define TIOCSERCONFIG	0x5453
 #define TIOCSERGWILD	0x5454
diff --git a/arch/sh/include/uapi/asm/ioctls.h b/arch/sh/include/uapi/asm/ioctls.h
index cc62f6f98103..11866d4f60e1 100644
--- a/arch/sh/include/uapi/asm/ioctls.h
+++ b/arch/sh/include/uapi/asm/ioctls.h
@@ -95,6 +95,8 @@
 #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
 #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
 #define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
+#define TIOCGISO7816	_IOR('T', 0x42, struct serial_iso7816)
+#define TIOCSISO7816	_IOWR('T', 0x43, struct serial_iso7816)
 
 #define TIOCSERCONFIG	_IO('T', 83) /* 0x5453 */
 #define TIOCSERGWILD	_IOR('T', 84,  int) /* 0x5454 */
diff --git a/arch/sparc/include/uapi/asm/ioctls.h b/arch/sparc/include/uapi/asm/ioctls.h
index 2df52711e170..7fd2f5873c9e 100644
--- a/arch/sparc/include/uapi/asm/ioctls.h
+++ b/arch/sparc/include/uapi/asm/ioctls.h
@@ -27,6 +27,8 @@
 #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
 #define TIOCGRS485	_IOR('T', 0x41, struct serial_rs485)
 #define TIOCSRS485	_IOWR('T', 0x42, struct serial_rs485)
+#define TIOCGISO7816	_IOR('T', 0x43, struct serial_iso7816)
+#define TIOCSISO7816	_IOWR('T', 0x44, struct serial_iso7816)
 
 /* Note that all the ioctls that are not available in Linux have a
  * double underscore on the front to: a) avoid some programs to
diff --git a/arch/xtensa/include/uapi/asm/ioctls.h b/arch/xtensa/include/uapi/asm/ioctls.h
index ec43609cbfc5..6d4a87296c95 100644
--- a/arch/xtensa/include/uapi/asm/ioctls.h
+++ b/arch/xtensa/include/uapi/asm/ioctls.h
@@ -107,6 +107,8 @@
 #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
 #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
 #define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
+#define TIOCGISO7816	_IOR('T', 0x42, struct serial_iso7816)
+#define TIOCSISO7816	_IOWR('T', 0x43, struct serial_iso7816)
 
 #define TIOCSERCONFIG	_IO('T', 83)
 #define TIOCSERGWILD	_IOR('T', 84,  int)
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 9c14a453f73c..af8d5b12fba9 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1301,6 +1301,58 @@ static int uart_set_rs485_config(struct uart_port *port,
 	return 0;
 }
 
+static int uart_get_iso7816_config(struct uart_port *port,
+				   struct serial_iso7816 __user *iso7816)
+{
+	unsigned long flags;
+	struct serial_iso7816 aux;
+
+	if (!port->iso7816_config)
+		return -ENOIOCTLCMD;
+
+	spin_lock_irqsave(&port->lock, flags);
+	aux = port->iso7816;
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	if (copy_to_user(iso7816, &aux, sizeof(aux)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int uart_set_iso7816_config(struct uart_port *port,
+				   struct serial_iso7816 __user *iso7816_user)
+{
+	struct serial_iso7816 iso7816;
+	int i, ret;
+	unsigned long flags;
+
+	if (!port->iso7816_config)
+		return -ENOIOCTLCMD;
+
+	if (copy_from_user(&iso7816, iso7816_user, sizeof(*iso7816_user)))
+		return -EFAULT;
+
+	/*
+	 * There are 5 words reserved for future use. Check that userspace
+	 * doesn't put stuff in there to prevent breakages in the future.
+	 */
+	for (i = 0; i < 5; i++)
+		if (iso7816.reserved[i])
+			return -EINVAL;
+
+	spin_lock_irqsave(&port->lock, flags);
+	ret = port->iso7816_config(port, &iso7816);
+	spin_unlock_irqrestore(&port->lock, flags);
+	if (ret)
+		return ret;
+
+	if (copy_to_user(iso7816_user, &port->iso7816, sizeof(port->iso7816)))
+		return -EFAULT;
+
+	return 0;
+}
+
 /*
  * Called via sys_ioctl.  We can use spin_lock_irq() here.
  */
@@ -1385,6 +1437,14 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 	case TIOCSRS485:
 		ret = uart_set_rs485_config(uport, uarg);
 		break;
+
+	case TIOCSISO7816:
+		ret = uart_set_iso7816_config(state->uart_port, uarg);
+		break;
+
+	case TIOCGISO7816:
+		ret = uart_get_iso7816_config(state->uart_port, uarg);
+		break;
 	default:
 		if (uport->ops->ioctl)
 			ret = uport->ops->ioctl(uport, cmd, arg);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 06ea4eeb09ab..d6e7747ffd46 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -137,6 +137,8 @@ struct uart_port {
 	void			(*handle_break)(struct uart_port *);
 	int			(*rs485_config)(struct uart_port *,
 						struct serial_rs485 *rs485);
+	int			(*iso7816_config)(struct uart_port *,
+						  struct serial_iso7816 *iso7816);
 	unsigned int		irq;			/* irq number */
 	unsigned long		irqflags;		/* irq flags  */
 	unsigned int		uartclk;		/* base uart clock */
@@ -253,6 +255,7 @@ struct uart_port {
 	struct attribute_group	*attr_group;		/* port specific attributes */
 	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
 	struct serial_rs485     rs485;
+	struct serial_iso7816   iso7816;
 	void			*private_data;		/* generic platform data pointer */
 };
 
diff --git a/include/uapi/asm-generic/ioctls.h b/include/uapi/asm-generic/ioctls.h
index 040651735662..cdc9f4ca8c27 100644
--- a/include/uapi/asm-generic/ioctls.h
+++ b/include/uapi/asm-generic/ioctls.h
@@ -79,6 +79,8 @@
 #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
 #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
 #define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
+#define TIOCGISO7816	_IOR('T', 0x42, struct serial_iso7816)
+#define TIOCSISO7816	_IOWR('T', 0x43, struct serial_iso7816)
 
 #define FIONCLEX	0x5450
 #define FIOCLEX		0x5451
diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
index 3fdd0dee8b41..93eb3c496ff1 100644
--- a/include/uapi/linux/serial.h
+++ b/include/uapi/linux/serial.h
@@ -132,4 +132,21 @@ struct serial_rs485 {
 					   are a royal PITA .. */
 };
 
+/*
+ * Serial interface for controlling ISO7816 settings on chips with suitable
+ * support. Set with TIOCSISO7816 and get with TIOCGISO7816 if supported by
+ * your platform.
+ */
+struct serial_iso7816 {
+	__u32	flags;			/* ISO7816 feature flags */
+#define SER_ISO7816_ENABLED		(1 << 0)
+#define SER_ISO7816_T_PARAM		(0x0f << 4)
+#define SER_ISO7816_T(t)		(((t) & 0x0f) << 4)
+	__u32	tg;
+	__u32	sc_fi;
+	__u32	sc_di;
+	__u32	clk;
+	__u32	reserved[5];
+};
+
 #endif /* _UAPI_LINUX_SERIAL_H */
-- 
2.12.2

