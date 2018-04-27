Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo+0CnDV805E/6MFxZyZ1k6YHMCePT+k1iM44JADv7LgaeIzAsdXYhC+pPc3ld2wpUB+0di
ARC-Seal: i=1; a=rsa-sha256; t=1524837809; cv=none;
        d=google.com; s=arc-20160816;
        b=lOQPt44Zq3MTWPNP7p0QsA6ninNEXeJsxbSEgFVTGZpQUsCiSp4C/ynK7/+kaE7TzZ
         oJc3dKIf72UOuKk2uqXp9OkNGbeu+Rz/RXEMxVzlITgOotyMxvTYqErje3Xt0FUxiP7h
         nldkr44i95odDkEPODZCygmWAZTm5ms0HjbWuB/k/0hifyiqbSm9aQLHyi7PszcWmDqx
         iOFpYuOnBTFSOdwOzfCmYCfYKVrs6ExObHJNa5CYfWZuXYdvAtf8TLYI0iZaaWG+8uAC
         0i/UPRxdtd+0n5JajMXMC46IhvpNIOQY48hY9Dvf+VlB3QOBTEfRXgvAgyYGTTSEREt8
         5yPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=SXZkosgqIJw2evUzMErYWVIFy1ai+mL6igO9twgX/oY=;
        b=pyU1KgrnP3HyR1S3eNivoWqkaEOn8XoyAPk1F3ZZUUQYL3JlaK+wxOmZHvHdRck2ID
         zV8tFhUuQrxOJsZxSa8+TqNICCoAjP438CvXEx2fjeSNHH2I9vhFSqWPWeayUo3trn1+
         5joohlKlCts6XEZz+0IMS1dv5poUuRncFY+GCKl230E4uaVhr2hoyvutRXmzCzN6ltNC
         Yrr04DrkUSUDcRioku5iTcMxUngr8HBozmtmVP3bSxwXjZujwgX2ZhDk6q5xNpMq0S+z
         JEgN/ghbSwTt/IIbUcwBbdvfUHJulILi6i+juTdo4dgBq6IKwB5NC8ufA3LwHtrmjNRj
         YqEg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582982189F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Daniel Drake <drake@endlessm.com>,
	Chris Chiu <chiu@endlessm.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.9 25/74] Revert "pinctrl: intel: Initialize GPIO properly when used through irqchip"
Date: Fri, 27 Apr 2018 15:58:15 +0200
Message-Id: <20180427135710.947021572@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908331040967874?=
X-GMAIL-MSGID: =?utf-8?q?1598908331040967874?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit f5a26acf0162477af6ee4c11b4fb9cffe5d3e257

Mike writes:
	It seems that commit f5a26acf0162 ("pinctrl: intel: Initialize GPIO
	properly when used through irqchip") can cause problems on some Skylake
	systems with Sunrisepoint PCH-H. Namely on certain systems it may turn
	the backlight PWM pin from native mode to GPIO which makes the screen
	blank during boot.

	There is more information here:

	  https://bugzilla.redhat.com/show_bug.cgi?id=1543769

	The actual reason is that GPIO numbering used in BIOS is using "Windows"
	numbers meaning that they don't match the hardware 1:1 and because of
	this a wrong pin (backlight PWM) is picked and switched to GPIO mode.

	There is a proper fix for this but since it has quite many dependencies
	on commits that cannot be considered stable material, I suggest we
	revert commit f5a26acf0162 from stable trees 4.9, 4.14 and 4.15 to
	prevent the backlight issue.

Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Fixes: f5a26acf0162 ("pinctrl: intel: Initialize GPIO properly when used through irqchip")
Cc: Daniel Drake <drake@endlessm.com>
Cc: Chris Chiu <chiu@endlessm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/intel/pinctrl-intel.c |   23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -368,18 +368,6 @@ static void __intel_gpio_set_direction(v
 	writel(value, padcfg0);
 }
 
-static void intel_gpio_set_gpio_mode(void __iomem *padcfg0)
-{
-	u32 value;
-
-	/* Put the pad into GPIO mode */
-	value = readl(padcfg0) & ~PADCFG0_PMODE_MASK;
-	/* Disable SCI/SMI/NMI generation */
-	value &= ~(PADCFG0_GPIROUTIOXAPIC | PADCFG0_GPIROUTSCI);
-	value &= ~(PADCFG0_GPIROUTSMI | PADCFG0_GPIROUTNMI);
-	writel(value, padcfg0);
-}
-
 static int intel_gpio_request_enable(struct pinctrl_dev *pctldev,
 				     struct pinctrl_gpio_range *range,
 				     unsigned pin)
@@ -387,6 +375,7 @@ static int intel_gpio_request_enable(str
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	void __iomem *padcfg0;
 	unsigned long flags;
+	u32 value;
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
@@ -396,7 +385,13 @@ static int intel_gpio_request_enable(str
 	}
 
 	padcfg0 = intel_get_padcfg(pctrl, pin, PADCFG0);
-	intel_gpio_set_gpio_mode(padcfg0);
+	/* Put the pad into GPIO mode */
+	value = readl(padcfg0) & ~PADCFG0_PMODE_MASK;
+	/* Disable SCI/SMI/NMI generation */
+	value &= ~(PADCFG0_GPIROUTIOXAPIC | PADCFG0_GPIROUTSCI);
+	value &= ~(PADCFG0_GPIROUTSMI | PADCFG0_GPIROUTNMI);
+	writel(value, padcfg0);
+
 	/* Disable TX buffer and enable RX (this will be input) */
 	__intel_gpio_set_direction(padcfg0, true);
 
@@ -775,8 +770,6 @@ static int intel_gpio_irq_type(struct ir
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
-	intel_gpio_set_gpio_mode(reg);
-
 	value = readl(reg);
 
 	value &= ~(PADCFG0_RXEVCFG_MASK | PADCFG0_RXINV);
