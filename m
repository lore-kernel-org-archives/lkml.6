Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906823-1518710547-2-14777585169487474359
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710546; b=WzYto44KRdhdky2AE5nYT4lTWj2AQwweQHwmKktCg1+ozhF
    wbuv/rrX1vmEk0oP0t3P3+vgsH4F8rtBj07aythyViHCC0qg1i3/MyRDRoUFKRMA
    GkVZmDwP73v0RaEK6ZSepYEGnaqtLlBlfypXAmbNUxDTWdichbB/WQSMDuxLuoN5
    w8cMavUfMVhbNyXPbEAJBa5j1O6TcWr96z2lPj4rD/YGShepo7j6D6Vuf0Eztzkr
    R9yoDTf/T/3FKmmkWm2Etx3+8IO2MTNBIBQFBjyG56z1qXBkGZw2F/PFZ1Moz+vu
    Y/sVPCqfgxU6RtZ7N8LUVWN8kPNjJ7ZBUxpkz2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710546; bh=Fdws4QecFU4x8BsM4OIMk31zMY
    tiGoQojj7SlkbZCas=; b=QBTqaUfW6Qi/JcC1yGYcAfQlBjYk8LozsQVt+XlirB
    sG05Ka9aEauw4ANmiSEuMqxPOvLl/5NjUhrmUeZB9p4PnV6yGSKBEJp6U2bb455P
    sXjjzmlfyMUu0V8XupW2F5/1uDjJwRErgm+mnb5IZxvf6xrXWlkTFWh3y1kVSGo8
    hFtVSLFyP+LxOIOC5byOpfJKgvzqVWLiZz/wF9TIRk29e1EGaKjtjV1WbirxSbYq
    u1/OnQbQYMfS023lYidN93VPDJ4PQRTB7a6bkaq5LgsHNgrmljeJ8TlIQ4x7U9AI
    Vj6S82eOoxHmns5yR/3PqsZyzznX2fUvHFTyAf8CmYfA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424704AbeBOPqm (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:46:42 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35878 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424702AbeBOPqk (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:46:40 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.15 176/202] pinctrl: intel: Initialize GPIO properly when used through irqchip
Date: Thu, 15 Feb 2018 16:17:56 +0100
Message-Id: <20180215151722.080763452@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -425,6 +425,18 @@ static void __intel_gpio_set_direction(v
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
@@ -432,7 +444,6 @@ static int intel_gpio_request_enable(str
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	void __iomem *padcfg0;
 	unsigned long flags;
-	u32 value;
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
@@ -442,13 +453,7 @@ static int intel_gpio_request_enable(str
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
