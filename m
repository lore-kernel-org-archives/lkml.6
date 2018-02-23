Return-Path: <geert@linux-m68k.org>
X-Google-Smtp-Source: AH8x226cumbjqbDqZ4MXy7LftJ0m9E6KY1NchFdFwHK88xM1p0C/dKiT6RBGLXOMlFPGvfC8wCog
ARC-Seal: i=1; a=rsa-sha256; t=1519393121; cv=none;
        d=google.com; s=arc-20160816;
        b=Yiu6YcPUfFkmoF/vIJgg88eAJ1Tz7kpZ4/5WKO6LjsxAtDiurt8+6bK/EBqShOT1S/
         SmK/cBkMbf02Vt6wywq0MnjG9dgMW8I1hgiwqOdi35HoO+h3JWmPxfiltuEy6eqhG292
         mQliUvPmpBijpYG6Uqz7pKiGPOhVNOGAFtzMLoeQ89guEMTJUJ2KWzV6y83hifG7gbAG
         mWQSWTzqfnHAtapyjn/ohtLJkDncaJeQY65m0ahOzc1MPE+Jj3P//QGeA8v0/s2RjL1B
         2LFOU51CTnpIZTHyFAdvAZRDF6AvgdphJDaCIcmVDLyiGo/ktX7uk/3cX+HukDOgn5Dj
         zzdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=p8WrIViTV6CEMH8dweY0Cvq9fsCGfWKkK1ojVz7ILi8=;
        b=eUhalMpPyQiPrG8+jxc/JneIAlqRGG1wJSqJ5CnrnK9jlidqJZ5DB3TNUy/nN+LzMf
         jp7QuHqOXMLerUD0m0qdh35MIElYfLr0T+BEaKYR4DeyXnkwFMYQzMI1gokWWCwPeZBD
         1+a+U3M5oYVwur2LLwmnnRDaOC1Er0Nh9GzKoHaFFkbuhHKhYBoeorpRy+x5TrzoK4Ky
         ACmplhF86HUkZDfTkGK10M7KAYgYHUgtvvmqysedU6seYpOko0NKXijE3ZDz6FG80/AN
         gVW5Z7b+8hiae8KoaIZd9vjirVIi3BlHT6Mu0LISVyH8Q2329Yem94n1COdP82772gkm
         +ooQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a02:1800:110:4::f00:19 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a02:1800:110:4::f00:19 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
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
Subject: [PATCH v2 3/9] serial: imx: Fix out-of-bounds access through serial port index
Date: Fri, 23 Feb 2018 14:38:31 +0100
Message-Id: <1519393117-31998-4-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
References: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593199161822059553?=
X-GMAIL-MSGID: =?utf-8?q?1593199161822059553?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The imx_ports[] array is indexed using a value derived from the
"serialN" alias in DT, or from platform data, which may lead to an
out-of-bounds access.

Fix this by adding a range check.

Fixes: ff05967a07225ab6 ("serial/imx: add of_alias_get_id() reference back")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
v2:
  - Fix Fixes reference,
  - Add blank line,
  - Use ARRAY_SIZE(),
  - Update patch description for platform data.
---
 drivers/tty/serial/imx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 1d7ca382bc12b238..7c9bdc8e34ac9109 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2042,6 +2042,12 @@ static int serial_imx_probe(struct platform_device *pdev)
 	else if (ret < 0)
 		return ret;
 
+	if (sport->port.line >= ARRAY_SIZE(imx_ports)) {
+		dev_err(&pdev->dev, "serial%d out of range\n",
+			sport->port.line);
+		return -EINVAL;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(base))
-- 
2.7.4
