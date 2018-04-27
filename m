Return-Path: <john.garry@huawei.com>
X-Google-Smtp-Source: AB8JxZrLAMEK+inMG/IBjg6wesaDhu5bSGp2QPa45qHUBjPK7ClC7vP5JPNejjNrdNAGNuCQ3JXE
ARC-Seal: i=1; a=rsa-sha256; t=1524825478; cv=none;
        d=google.com; s=arc-20160816;
        b=kIxtkkGbuWGAH7THWrj2u/6i9vQ4smdk+o1KuDH1QyNTW7737OrCLXV17bIQH42suu
         Fo6x2sEZeqy+MBRdwhMzkwvs76aL0P1TN/h6Hu862M6fI94IFdoxroSfaUmCo0xwWqdS
         hCIiPWmBdoJ/AVtSZNj7dAZBszGiHecFVeMSwyuBrEJLsCAW2hg7IRTV0DuHWtY/ZPBX
         XqintlKfJC5AUp3q2O6OqcKhfrbD+5UAKW/FNSvqV/aLziL8pB/JMsgekjnsCoi68eb1
         M/4ttss5nhMXuzhuUfyLeqfT5fQZgt5DP6qqv3/t9/QgXetAdXZHh0yTlcPuXM6b360i
         ic/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=SMeunp6nFEzuw3NPbYPiW2e4/IkSwrRqwhi8SIBuRi8=;
        b=Gteth2UhnvRyestD1uqXqEoaW/WSiaMhWnmIHFDqj/wU6tUbuCpCt48VYmOEXIXzaX
         LKbxo+GH2uED/A9gvJeRulrJxnEMMP+MoPVMYjhd5ZPbxuzYe5JdOjr4UOXRarBPPjep
         M1ccUtSk9PA/imVnO88VUi44dNU6ZwQuy2jGswro59VZ4VXkzXtZLoBEKEmjKcBtjISp
         kXd4m1rra4M5ncfsZJsvuc78bcLxAFUDhaipcDGGLO6h1Nbr8BL+tr5RXW11XCMaXeig
         hwJoINZpASPL/FwphuNq0O0Fh6bvEkMXUx+fR/de7Bl/wqzT0/cNipXoASApIdA+UfDB
         wiAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=john.garry@huawei.com
From: John Garry <john.garry@huawei.com>
To: <gregkh@linuxfoundation.org>, <jslaby@suse.com>, <joel@jms.id.au>,
	<p.zabel@pengutronix.de>, <arnd@arndb.de>, <fcooper@ti.com>,
	<sergei.shtylyov@cogentembedded.com>, <yamada.masahiro@socionext.com>,
	<khoroshilov@ispras.ru>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<andriy.shevchenko@linux.intel.com>, <linuxarm@huawei.com>, John Garry
	<john.garry@huawei.com>
Subject: [PATCH v2] serial: 8250_of: Add IO space support
Date: Fri, 27 Apr 2018 18:36:06 +0800
Message-ID: <1524825366-155559-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598895400558722453?=
X-GMAIL-MSGID: =?utf-8?q?1598895400558722453?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently the 8250_of driver only supports MEM IO type
accesses.

Some development boards (Huawei D03, specifically) require
IO space access for 8250-compatible OF driver support, so
add it.

The modification is quite simple: just set the port iotype
and associated flags depending on the device address
resource type.

Signed-off-by: John Garry <john.garry@huawei.com>
---

Changes v1->v2:
- rebase to Greg's tty-testing branch
- use resource_type() helper

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 3de8d6a..bfb37f0 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -92,13 +92,43 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		goto err_unprepare;
 	}
 
+	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_FIXED_PORT |
+				  UPF_FIXED_TYPE;
 	spin_lock_init(&port->lock);
-	port->mapbase = resource.start;
-	port->mapsize = resource_size(&resource);
 
-	/* Check for shifted address mapping */
-	if (of_property_read_u32(np, "reg-offset", &prop) == 0)
-		port->mapbase += prop;
+	if (resource_type(&resource) == IORESOURCE_IO) {
+		port->iotype = UPIO_PORT;
+		port->iobase = resource.start;
+	} else {
+		port->mapbase = resource.start;
+		port->mapsize = resource_size(&resource);
+
+		/* Check for shifted address mapping */
+		if (of_property_read_u32(np, "reg-offset", &prop) == 0)
+			port->mapbase += prop;
+
+		port->iotype = UPIO_MEM;
+		if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
+			switch (prop) {
+			case 1:
+				port->iotype = UPIO_MEM;
+				break;
+			case 2:
+				port->iotype = UPIO_MEM16;
+				break;
+			case 4:
+				port->iotype = of_device_is_big_endian(np) ?
+					       UPIO_MEM32BE : UPIO_MEM32;
+				break;
+			default:
+				dev_warn(&ofdev->dev, "unsupported reg-io-width (%d)\n",
+					 prop);
+				ret = -EINVAL;
+				goto err_dispose;
+			}
+		}
+		port->flags |= UPF_IOREMAP;
+	}
 
 	/* Check for registers offset within the devices address range */
 	if (of_property_read_u32(np, "reg-shift", &prop) == 0)
@@ -114,26 +144,6 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		port->line = ret;
 
 	port->irq = irq_of_parse_and_map(np, 0);
-	port->iotype = UPIO_MEM;
-	if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
-		switch (prop) {
-		case 1:
-			port->iotype = UPIO_MEM;
-			break;
-		case 2:
-			port->iotype = UPIO_MEM16;
-			break;
-		case 4:
-			port->iotype = of_device_is_big_endian(np) ?
-				       UPIO_MEM32BE : UPIO_MEM32;
-			break;
-		default:
-			dev_warn(&ofdev->dev, "unsupported reg-io-width (%d)\n",
-				 prop);
-			ret = -EINVAL;
-			goto err_dispose;
-		}
-	}
 
 	info->rst = devm_reset_control_get_optional_shared(&ofdev->dev, NULL);
 	if (IS_ERR(info->rst)) {
@@ -147,8 +157,6 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 
 	port->type = type;
 	port->uartclk = clk;
-	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
-		| UPF_FIXED_PORT | UPF_FIXED_TYPE;
 	port->irqflags |= IRQF_SHARED;
 
 	if (of_property_read_bool(np, "no-loopback-test"))
-- 
1.9.1
