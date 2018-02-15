Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227hgTE0mxn2iVOGsZrW+0MoTB57LbyXZAwB3nTzOJ9XkJPzK06bsyx66RxUcRnT1weUHi1k
ARC-Seal: i=1; a=rsa-sha256; t=1518709042; cv=none;
        d=google.com; s=arc-20160816;
        b=MqLb0MlV1yu6+pju0Ub1ymmUsthM4XJ2AzcUVxhBCbVKRa29AMcIGji3SgVODJyWZr
         /ZGcy8DKNzUXeR1M4uJHnYwLhJkDT/gfxKZXpxG+OROglEup97Q70WQinNDLYngoMoOW
         cHEeKyjlPabzCCV4Sqaic4J6gXhTJoYHjC3CjDDbIstMfzMYZsgKr0wmwisBfe8MrRo+
         /jPFAwpX2QDhcoOymxyPYxx10MAgduX8eJnheKWD4DGMjmqUeRawmFD+FyECUEJLY9aG
         teUp4YPMHeUDrV4jeuTFobQaICVastLXMdi0dbbZ218dPPOJ6aQnxCplShiu+Y099unh
         cz8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pvQkkWCzCXcrFjdcxq947znp9n9+4zxZ+7327LtJQLk=;
        b=jVrKNk/wQBsbNEUQMIN6z/c411N6fEEWT3zc8eEEfrVSWzMXNyO575eEuAxqWyzpFc
         yd6bbxct9nRc/GzDIPUzFMmZ3yeqAWI3e1tHiazgNPfNSB+cMZp2VIn9Scw0eeHIkgtg
         Zq+W2rkXKKPItgaqX6QVJioqRBDV7Vy+G+MyIwelCtjzj1Yq8zhRPuPCYMBHfiB4vut9
         C3fUnUs5lxctbG6/x1aQ0keHlNqEk7FD1QWCKkvAXo0INRTrvGDupWWmPvtwZVP5mzn+
         BXPI4h8V2FzCUPSWNcLnzm/Mvg95BWnm7D+4KfP1mAudrTNYY6PoWREJDzRXZ94HDG0Q
         yQvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Daniel Drake <drake@endlessm.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.14 171/195] pinctrl: intel: Initialize GPIO properly when used through irqchip
Date: Thu, 15 Feb 2018 16:17:42 +0100
Message-Id: <20180215151714.605266810@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481323206045109?=
X-GMAIL-MSGID: =?utf-8?q?1592481853194005169?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit f5a26acf0162477af6ee4c11b4fb9cffe5d3e257 upstream.

When a GPIO is requested using gpiod_get_* APIs the intel pinctrl driver
switches the pin to GPIO mode and makes sure interrupts are routed to
the GPIO hardware instead of IOAPIC. However, if the GPIO is used
directly through irqchip, as is the case with many I2C-HID devices where
I2C core automatically configures interrupt for the device, the pin is
not initialized as GPIO. Instead we rely that the BIOS configures the
pin accordingly which seems not to be the case at least in Asus X540NA
SKU3 with Focaltech touchpad.

When the pin is not properly configured it might result weird behaviour
like interrupts suddenly stop firing completely and the touchpad stops
responding to user input.

Fix this by properly initializing the pin to GPIO mode also when it is
used directly through irqchip.

Fixes: 7981c0015af2 ("pinctrl: intel: Add Intel Sunrisepoint pin controller and GPIO support")
Reported-by: Daniel Drake <drake@endlessm.com>
Reported-and-tested-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/intel/pinctrl-intel.c |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -427,6 +427,18 @@ static void __intel_gpio_set_direction(v
 	writel(value, padcfg0);
 }
 
+static void intel_gpio_set_gpio_mode(void __iomem *padcfg0)
+{
+	u32 value;
+
+	/* Put the pad into GPIO mode */
+	value = readl(padcfg0) & ~PADCFG0_PMODE_MASK;
+	/* Disable SCI/SMI/NMI generation */
+	value &= ~(PADCFG0_GPIROUTIOXAPIC | PADCFG0_GPIROUTSCI);
+	value &= ~(PADCFG0_GPIROUTSMI | PADCFG0_GPIROUTNMI);
+	writel(value, padcfg0);
+}
+
 static int intel_gpio_request_enable(struct pinctrl_dev *pctldev,
 				     struct pinctrl_gpio_range *range,
 				     unsigned pin)
@@ -434,7 +446,6 @@ static int intel_gpio_request_enable(str
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	void __iomem *padcfg0;
 	unsigned long flags;
-	u32 value;
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
@@ -444,13 +455,7 @@ static int intel_gpio_request_enable(str
 	}
 
 	padcfg0 = intel_get_padcfg(pctrl, pin, PADCFG0);
-	/* Put the pad into GPIO mode */
-	value = readl(padcfg0) & ~PADCFG0_PMODE_MASK;
-	/* Disable SCI/SMI/NMI generation */
-	value &= ~(PADCFG0_GPIROUTIOXAPIC | PADCFG0_GPIROUTSCI);
-	value &= ~(PADCFG0_GPIROUTSMI | PADCFG0_GPIROUTNMI);
-	writel(value, padcfg0);
-
+	intel_gpio_set_gpio_mode(padcfg0);
 	/* Disable TX buffer and enable RX (this will be input) */
 	__intel_gpio_set_direction(padcfg0, true);
 
@@ -935,6 +940,8 @@ static int intel_gpio_irq_type(struct ir
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
+	intel_gpio_set_gpio_mode(reg);
+
 	value = readl(reg);
 
 	value &= ~(PADCFG0_RXEVCFG_MASK | PADCFG0_RXINV);
