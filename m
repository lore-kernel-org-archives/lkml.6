Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48voyqtDWlcO2bYmdjKQ+kAiYY2rsQHTl25ozxfwANyCqEqKcr9m35jtr91EiYQDvgP/s/0
ARC-Seal: i=1; a=rsa-sha256; t=1523399387; cv=none;
        d=google.com; s=arc-20160816;
        b=f3uKkE4hykbP7B5Uzt/nqX49lhx1jSpIDIgx/KMIvwj88D7kRzIp4cmvTxkFKLBIO6
         ggltypOrbGC+ShPCnGiSTox6NKtNjoPLDp0Wqqca7vLaG1i+WQK627+o1M13JYvEUgUT
         Ilc+0g9EdnfEiXISJi/7jchMfJk2SyAgg2rWsYhQRvN2Zp1xLWap0ZFJKNC3EUgx78LA
         5HOUXbZib0FuqlDWilwgML29RrCUJYpalRACfYJ7LBApuKBstxB/QHxRfdqvEXVEZgbY
         5f+yVcPgHJW989ampUAbNf96j0M2cdpBCLRtx9wxh+T7Pu8/6lONbTZZEtb9MwBBsOYH
         IS+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YpRmibwjH0mT8G77tgp2F45z8xCETfvwjVgyPS8byiA=;
        b=SqX8/v5ku4FsmP2R14AHmDwHUrXFImBj//OVZxg8H7FxfZjUYDLm+4mSA2RXyn9BRx
         t3Yti709uaim9euXHHAZRodUR0lC3kLxWEgaVaEcMhffZ2lC+fH2GfiKUX9/Xto+VjYA
         fVooQRf0noMEwbpu9OJ1QU+A257YjYPy/vsxDr8tHel57vIw/tRli8BtIiJ9kzjydTRm
         PqDbyn0asz2ZsFVhT5eXyvdp3M3Y2VPAwWesuJof6Z/9avbJMm9zLz2f+POI+O7sOXLX
         2MefpaEmI5Nseg0gr6+cpG11q9yEcPkQNGnWUMTS6B+qqAt54idFTM0+x1lWETkTz6lA
         Jevw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Lukas Wunner <lukas@wunner.de>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.15 089/168] Bluetooth: hci_bcm: Make shutdown and device wake GPIO optional
Date: Wed, 11 Apr 2018 00:23:51 +0200
Message-Id: <20180410212804.054618580@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400036426027296?=
X-GMAIL-MSGID: =?utf-8?q?1597400036426027296?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Wahren <stefan.wahren@i2se.com>

commit ab2f336cb7e629de74d8af06bcaf6b15e4230e19 upstream.

According to the devicetree binding the shutdown and device wake
GPIOs are optional. Since commit 3e81a4ca51a1 ("Bluetooth: hci_bcm:
Mandate presence of shutdown and device wake GPIO") this driver
won't probe anymore on Raspberry Pi 3 and Zero W (no device wake GPIO
connected). So fix this regression by reverting this commit partially.

Fixes: 3e81a4ca51a1 ("Bluetooth: hci_bcm: Mandate presence of shutdown and device wake GPIO")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/hci_bcm.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -775,12 +775,13 @@ static int bcm_get_resources(struct bcm_
 
 	dev->clk = devm_clk_get(dev->dev, NULL);
 
-	dev->device_wakeup = devm_gpiod_get(dev->dev, "device-wakeup",
-					    GPIOD_OUT_LOW);
+	dev->device_wakeup = devm_gpiod_get_optional(dev->dev, "device-wakeup",
+						     GPIOD_OUT_LOW);
 	if (IS_ERR(dev->device_wakeup))
 		return PTR_ERR(dev->device_wakeup);
 
-	dev->shutdown = devm_gpiod_get(dev->dev, "shutdown", GPIOD_OUT_LOW);
+	dev->shutdown = devm_gpiod_get_optional(dev->dev, "shutdown",
+						GPIOD_OUT_LOW);
 	if (IS_ERR(dev->shutdown))
 		return PTR_ERR(dev->shutdown);
 
