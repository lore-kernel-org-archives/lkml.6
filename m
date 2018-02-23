Return-Path: <geert@linux-m68k.org>
X-Google-Smtp-Source: AH8x226G+Nlm6IJFFMuKDIp1x8m0c8s554d5EswRUimh+aGtZPSkvXHhnkP46BrS28Nm9g/lbCPm
ARC-Seal: i=1; a=rsa-sha256; t=1519393121; cv=none;
        d=google.com; s=arc-20160816;
        b=sqs+BYv9I4vW+hNFDzDg1OBMe7lQTZpRIid2eOhNEVJGSblQPwHv42X+kzjOIR50qN
         SrXmRtfPgQ/Ht+nT1rxpDgfaF72ffiaeAqYSQB4U9m99L8Ou/1d2Hmoc+DGzQMQA54LF
         B1JOKPzcJaK/UI/i+5TO/rxpbgVQrUE19QU3Z9v8N81TilEFPtXaM9vxvUPRG3NhrIdm
         FP41oQmWyx03OaBAj3Gys/Rn7o7lw8e5+4FP1PhPQu//LArRLhiAnnzIdP6m15nFsGX0
         Z0Wcxqe0/NsAJ83M2OEZgJ92LvBx/SaL7Wg7KDeuo/2BLPZsGN2vHPX03ZxcJCQ8LOjf
         FR6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=a3/dFoW5wbBfMJG79edk6gEtiZuhpJUL3XiVms1XSh8=;
        b=u7M299Dhd4iAqsUZhp/MjZvdYiQBTm0JRx8P6FQXNAIq33aRc93mXuhluDvrAPr2zR
         1zek41KuNewVhyDAGcOwJjoB658DErDYKJ3Zta1z/tahUSumvEUAeVEzg+WD8/vazc+e
         c/JmYpW3O9gqeT1PBV/F1+H7djzlsArjWwX79KLQeaYWSxksvWWSRr1Q/MB1u7jUs5gg
         9DU1XmfvoCXD9sq5ODPcxz73LDQRP+QTpspi3NkEO5I1VXYa064Bo+I4PlKQToR8cSeQ
         5F39lsDqOJMSr28WZcRrv3vaXtS/stUMwyjBOjmAdRUNwd5K0M87jJAKm3yyj2lG/aEq
         Fsnw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a02:1800:110:4::f00:18 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a02:1800:110:4::f00:18 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Barry Song <baohua@kernel.org>,
	Vineet Gupta <vgupta@synopsys.com>,
	Jiri Slaby <jslaby@suse.com>,
	Michal Simek <michal.simek@xilinx.com>,
	linux-serial@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/9] serial: arc_uart: Fix out-of-bounds access through DT alias
Date: Fri, 23 Feb 2018 14:38:29 +0100
Message-Id: <1519393117-31998-2-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
References: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593199161933264257?=
X-GMAIL-MSGID: =?utf-8?q?1593199161933264257?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The arc_uart_ports[] array is indexed using a value derived from the
"serialN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Note that the array size is defined by a Kconfig symbol
(CONFIG_SERIAL_ARC_NR_PORTS), so this can even be triggered using a
legitimate DTB.

Fixes: ea28fd56fcde69af ("serial/arc-uart: switch to devicetree based probing")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Fix Fixes reference,
  - Use ARRAY_SIZE().
---
 drivers/tty/serial/arc_uart.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index 2599f9ecccfe7769..d904a3a345e74785 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -593,6 +593,11 @@ static int arc_serial_probe(struct platform_device *pdev)
 	if (dev_id < 0)
 		dev_id = 0;
 
+	if (dev_id >= ARRAY_SIZE(arc_uart_ports)) {
+		dev_err(&pdev->dev, "serial%d out of range\n", dev_id);
+		return -EINVAL;
+	}
+
 	uart = &arc_uart_ports[dev_id];
 	port = &uart->port;
 
-- 
2.7.4
