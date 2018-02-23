Return-Path: <geert@linux-m68k.org>
X-Google-Smtp-Source: AH8x226JiR4xyDb60C2OinMi4l41//IasURIlBstFYVJExSj/Igz3gU/vffbuTsKvW1xPeCzSDhQ
ARC-Seal: i=1; a=rsa-sha256; t=1519393121; cv=none;
        d=google.com; s=arc-20160816;
        b=aLvb93xNu6aH6mSrFzZvYyyYFxBfiGZIlsgtsJJ8IJGQ6Ldu4XiUlzSkWbiVmhOiSd
         ffiCnNI82J+DsH9dVq2p72MUgAzCqlAkmhC4ymuVJDfHDXYFnf94Irq6odDpx2T2bBUT
         cUHJvHb4xEChfWFjo3Hb4OoJzOaWJLGJEPCpM+J+qTGPlSzQ3dNevetXUv3c7PiC57Kj
         iU7+BNmQqZInnAtcCW2X7MSWJ8dJHyi3pAyzX93/AhiDyA26FmoTC1jfDFdnBUk7YV4t
         krlZhRw4ZOqwX0x2lXue5p+d7q6SkzXppjRnpK+S0uNwL5ylHl/wysKOV2hCdOkEkNLm
         0uZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=rw5iJYj16LXV8lv9NC4QqrfCxBUMr4WQVVCd3SWxCZA=;
        b=Zunoh1tMk4jBsCVvF+U0gmFg7O/VTuTy4/v1aPfFvL2ZnB9JL/8r+uWtSlsRjXpiCQ
         mVuRB43z2Od4ph6OdR0UqpuCDbzkHhUWZhsg+dW+WQE3KpDx5iuMvcStSyk6eDTwNidU
         8gzMXUUu1g0XOL60MvQmNS2IFf/MI/nFa22PFNeu2qTAxIbSzPYB/Tod4ZPFSwLSoI55
         PU0kVYmzcGfDpj8AJidiG8o7Y31L/CbFp5M25xsT4qgWW6gX/Gl8A1UWZTUY4+FGtSdz
         s1DX5N6VbZMEWjGN/h9xGLKMyK7OQsIEP56yXh6SVVLqlxnmUbrUjvr4Idxkt0TqIEIO
         CrjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a02:1800:120:4::f00:13 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a02:1800:120:4::f00:13 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
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
Subject: [PATCH v2 2/9] serial: fsl_lpuart: Fix out-of-bounds access through DT alias
Date: Fri, 23 Feb 2018 14:38:30 +0100
Message-Id: <1519393117-31998-3-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
References: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593199162009963322?=
X-GMAIL-MSGID: =?utf-8?q?1593199162009963322?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The lpuart_ports[] array is indexed using a value derived from the
"serialN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Fixes: c9e2e946fb0ba5d2 ("tty: serial: add Freescale lpuart driver support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Fix Fixes reference,
  - Use ARRAY_SIZE().
---
 drivers/tty/serial/fsl_lpuart.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 8cf112f2efc30707..51e47a63d61accef 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2145,6 +2145,10 @@ static int lpuart_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
 		return ret;
 	}
+	if (ret >= ARRAY_SIZE(lpuart_ports)) {
+		dev_err(&pdev->dev, "serial%d out of range\n", ret);
+		return -EINVAL;
+	}
 	sport->port.line = ret;
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	sport->port.membase = devm_ioremap_resource(&pdev->dev, res);
-- 
2.7.4
