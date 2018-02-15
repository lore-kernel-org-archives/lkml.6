Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2268+mN1XQll5+QIezKvjAOcVLyB0StTJyEes1ZYupe70BlScatL8Y53IeFaUy+A4C0/BV1K
ARC-Seal: i=1; a=rsa-sha256; t=1518708537; cv=none;
        d=google.com; s=arc-20160816;
        b=stkMlSJpZP772nueLwhNgE3tHC1N3w1tiYFeW/wBFMrTXMLt+PVrb6IEALK3zWf2wt
         SF96xd1H0msIUIOu0ZFx02HiDYDhV91MaaE8lQpo3bxzlQa/3yhWwNk3aSK3DySdDZGs
         XKmvnrkMUsou/zfYD28UXRnfl/HB8as8G5lUdfcViJuhXDF0Z2k7bKIqTYiZ3XrBIls3
         HnjOX6brxW2emn55AksM51f7uV/A9XEZHooH/B0pv4CMgRM5IEOMGA83i5pfN13Rni8f
         cBAdoUoGX3uPYMDs8JAbktNaOZWD/Rx28bROOL3XbLmN8pOO9L+I/OwCQUHRRUogb0O0
         NvaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9LbTazXK7tGdWO8CQKdFl9WeAXc8VNu2aQGxl9Cc3NY=;
        b=pwnRdmXRS1kysflbI8OU910TqNqR+mWjLIzSeS97ccj/rEcsUVf1YVfWRdGVZGpx7r
         yJ2ZV63AyHknN2TY5erP7fB0nw/VI25QlwuW1TcPBh/pEUHZPD5fibh+KNoyOLMOmJFt
         gNDbOeDKekrPyGpldDRCY6vWTRz+nTpLpx2pzQq+2D3509MlaAYe1poKfsLk4uN1xGnI
         q0sLs8pB1IR67g1MJiHLaEToPHMk7xZgoRTHngMgiI7T2BoEPKVX8Cgbyko8a/+cnclO
         b4Z9wwNEbbyhsjv1tuXOesXTH/nmQmEU6BNc25WohvrGT7eUNlMYmOKWJTRzDZGezLSk
         hflg==
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
Subject: [PATCH 4.9 77/88] pinctrl: intel: Initialize GPIO properly when used through irqchip
Date: Thu, 15 Feb 2018 16:17:44 +0100
Message-Id: <20180215151233.118734437@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481323206045109?=
X-GMAIL-MSGID: =?utf-8?q?1592481323206045109?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -368,6 +368,18 @@ static void __intel_gpio_set_direction(v
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
@@ -375,7 +387,6 @@ static int intel_gpio_request_enable(str
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	void __iomem *padcfg0;
 	unsigned long flags;
-	u32 value;
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
@@ -385,13 +396,7 @@ static int intel_gpio_request_enable(str
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
 
@@ -770,6 +775,8 @@ static int intel_gpio_irq_type(struct ir
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
+	intel_gpio_set_gpio_mode(reg);
+
 	value = readl(reg);
 
 	value &= ~(PADCFG0_RXEVCFG_MASK | PADCFG0_RXINV);
