Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49IjwBMyPwJNkptDZRIIFG9YdIPKYjfDKpYsbjGbfel4OAsZN67QCaqqSNi8Uxckjcit44O
ARC-Seal: i=1; a=rsa-sha256; t=1523399382; cv=none;
        d=google.com; s=arc-20160816;
        b=gfV5MREToREbwYRuy6hepEgMCimHYIajWzfOh/mrxwgwoS5NewgPLgzOD94dJRmjyR
         WKgGiRqUum/K+xhyn07XI6MYxhpBw4Fb+ml0iWdcLie7Sz93VIiE2NqpNGczpsIwvARg
         OW9z1BiderDQn9m8rzkqfpLEqf/POwS0k3f266n4PURadnvtRDjnrtPyL3DptWl1orzL
         /oAXMvsSzXbTVedzQjzACb0SMys8P/ooC+UELE+vUgWz0VKYoqq6uB21ghCm5pT+sNQx
         W5WKXa2jgfIwaDr9g/Kkt8vFYdxNX4wWg306gJFqRc8EdpbfHJudBZR/f57RkePwmIlG
         h69Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=A/gFKt+cFW/C1dQhnA0FyehIBbDqxLTV8IDQVquv1HQ=;
        b=alsPr08o4TSXLnfyN80Hv45KiS3A/0A+5hN2Dsj77rc1LinU4DBtONwnOho8OslfFA
         Q/wRbjHO0axGAcmaLXtxnmgsxArykK3/ERl57FUedq3ShmmZS6504Tj3weKZBbaoZuXt
         vkdFd+WcD9VsMoch5fi+cgsQ6QZqkpgjNcqtzleRK7oaYh607QcXANl562DxNkNfc3o3
         fGBsAvolCq7qHmiWE0fy6gUiwdfzyHB1J7qgf7hgUWfXNJVOwvEN74BbaMHFg+QtHWyy
         jasakVbsE9eHxD7M6JZ7GJvUS8nXKYUXKXyohCtaczhca4pCRTjpjxo1+lGQ8y4V6tlG
         LFOw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss@gmail.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Marcel Holtmann <marcel@holtmann.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 087/168] Bluetooth: hci_bcm: Mandate presence of shutdown and device wake GPIO
Date: Wed, 11 Apr 2018 00:23:49 +0200
Message-Id: <20180410212803.972318886@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400030546077791?=
X-GMAIL-MSGID: =?utf-8?q?1597400030546077791?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>


[ Upstream commit 3e81a4ca51a1172253078ca7abd6a91040b8fcf4 ]

Commit 0395ffc1ee05 ("Bluetooth: hci_bcm: Add PM for BCM devices")
amended this driver to request a shutdown and device wake GPIO on probe,
but mandated that only one of them need to be present:

	/* Make sure at-least one of the GPIO is defined and that
	 * a name is specified for this instance
	 */
	if ((!dev->device_wakeup && !dev->shutdown) || !dev->name) {
		dev_err(&pdev->dev, "invalid platform data\n");
		return -EINVAL;
	}

However the same commit added a call to bcm_gpio_set_power() to the
->probe hook, which unconditionally accesses *both* GPIOs.  Luckily,
the resulting NULL pointer deref was never reported, suggesting there's
no machine where either GPIO is missing.

Commit 8a92056837fd ("Bluetooth: hci_bcm: Add (runtime)pm support to the
serdev driver") removed the check whether at least one of the GPIOs is
present without specifying a reason.

Because commit 62aaefa7d038 ("Bluetooth: hci_bcm: improve use of gpios
API") refactored the driver to use devm_gpiod_get_optional() instead of
devm_gpiod_get(), one is now tempted to believe that the driver doesn't
require *any* of the two GPIOs.

Which is wrong, the driver still requires both GPIOs to avoid a NULL
pointer deref.  To this end, establish the status quo ante and request
the GPIOs with devm_gpiod_get() again.  Bail out of ->probe if either
of them is missing.

Oddly enough, whereas bcm_gpio_set_power() accesses the device wake pin
unconditionally, bcm_suspend_device() and bcm_resume_device() do check
for its presence before accessing it.  Those checks are superfluous,
so remove them.

Cc: Frédéric Danis <frederic.danis.oss@gmail.com>
Cc: Loic Poulain <loic.poulain@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/hci_bcm.c |   24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -577,11 +577,9 @@ static int bcm_suspend_device(struct dev
 	}
 
 	/* Suspend the device */
-	if (bdev->device_wakeup) {
-		gpiod_set_value(bdev->device_wakeup, false);
-		bt_dev_dbg(bdev, "suspend, delaying 15 ms");
-		mdelay(15);
-	}
+	gpiod_set_value(bdev->device_wakeup, false);
+	bt_dev_dbg(bdev, "suspend, delaying 15 ms");
+	mdelay(15);
 
 	return 0;
 }
@@ -592,11 +590,9 @@ static int bcm_resume_device(struct devi
 
 	bt_dev_dbg(bdev, "");
 
-	if (bdev->device_wakeup) {
-		gpiod_set_value(bdev->device_wakeup, true);
-		bt_dev_dbg(bdev, "resume, delaying 15 ms");
-		mdelay(15);
-	}
+	gpiod_set_value(bdev->device_wakeup, true);
+	bt_dev_dbg(bdev, "resume, delaying 15 ms");
+	mdelay(15);
 
 	/* When this executes, the device has woken up already */
 	if (bdev->is_suspended && bdev->hu) {
@@ -779,14 +775,12 @@ static int bcm_get_resources(struct bcm_
 
 	dev->clk = devm_clk_get(dev->dev, NULL);
 
-	dev->device_wakeup = devm_gpiod_get_optional(dev->dev,
-						     "device-wakeup",
-						     GPIOD_OUT_LOW);
+	dev->device_wakeup = devm_gpiod_get(dev->dev, "device-wakeup",
+					    GPIOD_OUT_LOW);
 	if (IS_ERR(dev->device_wakeup))
 		return PTR_ERR(dev->device_wakeup);
 
-	dev->shutdown = devm_gpiod_get_optional(dev->dev, "shutdown",
-						GPIOD_OUT_LOW);
+	dev->shutdown = devm_gpiod_get(dev->dev, "shutdown", GPIOD_OUT_LOW);
 	if (IS_ERR(dev->shutdown))
 		return PTR_ERR(dev->shutdown);
 
