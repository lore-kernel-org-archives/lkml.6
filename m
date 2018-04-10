Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+JP5mj8qwIvuymjGnDV4oQBP67SxgCdVE1N8a2Z+3xA0p9R3x8ez6BoytVoqj65PaifGqy
ARC-Seal: i=1; a=rsa-sha256; t=1523399825; cv=none;
        d=google.com; s=arc-20160816;
        b=XDY/rt8RVp82bhlaoSIpWmksxr0zTH6uNa8UBUuUB58XsYLyr/l9OCeGCIqTIgYryY
         kKDZF90DzySv4M9+zOQOBOsJO/yS0U2A/MiM9gvW6rvLVEl3J9C72LuCW/GKsDVBUm/y
         olbG0lokp7/gWosjSS15jow37t0ShrBfu+WyZmW1EAgXaqvdKn0Z23jqf0mTAskE/Lz3
         3SiN9Zwziv2paIG54pLcvPSZ2qAh7jtJzOCcc91wPrr4K6ndK5KRQI2jsUVvH40kgnjW
         ZAOISDSn3TKVPoorTNT3m4MV3yPa3WpY4y/zKnGfZBhhtbnsiTYND+kZcFHcVx78PQxW
         OSqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VMP3YqSt44e1e8bigJw67npbb91AJrwWH0byfXDcggE=;
        b=u9MmNaOoiz4bPMaeXJCuwYJntfzTIcDDM2CydmDKIzLJR4gsRGuxLY5eY8ftPQvE9w
         sltitD56SiTH3jDJqAUC+coot3qA+V0lJnLGm3BUHYRiUuwrZno1ykhnZCKcPU75J7IP
         PFuBWeHNvt+YxGfKH/7mGx9PJyYzpxM9TTj9qwyDCbj/fOhaKtxjJHs+cNu2lzmU9Ypz
         mipZamEqKryltEU4/R2Df94qTxG5/ihT5H3Fsw2ctidKNAUEdeJDZX6n3ROolbJ2nQGu
         rIG/+rE8bascag0CxmVh2m70jPFct+hNd8Z11USpBkkmNOVqIAF41dOiUcxpzFhKhsNJ
         A2jw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Bastien Nocera <hadess@hadess.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 077/138] Input: goodix - disable IRQs while suspended
Date: Wed, 11 Apr 2018 00:24:27 +0200
Message-Id: <20180410212911.088525899@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400122613176921?=
X-GMAIL-MSGID: =?utf-8?q?1597400496011982083?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>


[ Upstream commit faec44b6838312484d63e82286087cf2d5ebb891 ]

We should not try to do any i2c transfers before the controller is
resumed (which happens before our resume method gets called).

So we need to disable our IRQ while suspended to enforce this. The
code paths for devices with GPIOs for the int and reset pins already
disable the IRQ the through goodix_free_irq().

This commit also disables the IRQ while suspended for devices without
GPIOs for the int and reset pins.

This fixes the i2c bus sometimes getting stuck after a suspend/resume
causing the touchscreen to sometimes not work after a suspend/resume.
This has been tested on a GPD pocked device.

BugLink: https://github.com/nexus511/gpd-ubuntu-packages/issues/10
BugLink: https://www.reddit.com/r/GPDPocket/comments/7niut2/fix_for_broken_touch_after_resume_all_linux/
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/touchscreen/goodix.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -808,8 +808,10 @@ static int __maybe_unused goodix_suspend
 	int error;
 
 	/* We need gpio pins to suspend/resume */
-	if (!ts->gpiod_int || !ts->gpiod_rst)
+	if (!ts->gpiod_int || !ts->gpiod_rst) {
+		disable_irq(client->irq);
 		return 0;
+	}
 
 	wait_for_completion(&ts->firmware_loading_complete);
 
@@ -849,8 +851,10 @@ static int __maybe_unused goodix_resume(
 	struct goodix_ts_data *ts = i2c_get_clientdata(client);
 	int error;
 
-	if (!ts->gpiod_int || !ts->gpiod_rst)
+	if (!ts->gpiod_int || !ts->gpiod_rst) {
+		enable_irq(client->irq);
 		return 0;
+	}
 
 	/*
 	 * Exit sleep mode by outputting HIGH level to INT pin
