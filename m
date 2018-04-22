Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48EvNKTONkH9DjHyw06757S/XO5z8N4qISeMVusOzcXfTgF1LE9xRBNgnsEMSplNaseZGku
ARC-Seal: i=1; a=rsa-sha256; t=1524406028; cv=none;
        d=google.com; s=arc-20160816;
        b=Y81hKAVeHnZd0GrrS5ny7kVj4KjI7W97LrUFhyi1SqHMIeZHkwUJaEhrAUsYbuFAAn
         +lGXoZ+lL2nq+tbFiCPPbcGdmrRoNXwsI1UlmtIuQ+b5OEz19AO4sJSA9MKkSFZfSouv
         PkHWWmA1BHMhXZqX2GlI7x1HnMQd1ovjkM3l3hFon4wmuuihObz1AVrYYy7LpB4uoOIk
         x+isMJxDIo92tieOsSDObBsw5N1tYQ+kHhObFjAt8OnHMZPyEPqjfcW59/qR3Lqcf/Gx
         dU50Xt+tHZaiw/vHISEzYadcrM3Rr9sVwDtCuUFifqwvTy9vMW2dWxKnZEOjaHWpfK5p
         FwFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3dCXhoxU1zKSyfksWYvgss5d5T+RvKVX+7olRCpttOQ=;
        b=wjvFkQ4VjulRw0Dl5utQbgxEFgPVy0i/A9XV4mdj7jnlaFG/uMrPyKAN1HNjOh7525
         EkOE7zlTBQAwtO86kNr5aDad9xveAf5AE1omp0G0LjXs+qQGeryIdHrFKF02dOz9EFj/
         4z/eKa4eMVX7J58g0AsTIM1KBlDr6AhFw75Nx2+kZib1XErEftNWPcCDCSgVgl0ZYp1P
         FGNcm5EnNAcedDuztwdfWo+9O00B4khp0n21xR3odUgL9kx45GPFRoveXihn/2ERbc1M
         6YaHZsMmWSgSrNXFmwfZSh7q33oO6a1L+34p/PuP2poDlQ5sfundUMFxaZR9LBKDtNPC
         2sKg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 4.14 069/164] extcon: intel-cht-wc: Set direction and drv flags for V5 boost GPIO
Date: Sun, 22 Apr 2018 15:52:16 +0200
Message-Id: <20180422135138.290580577@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455021610998810?=
X-GMAIL-MSGID: =?utf-8?q?1598455576324938683?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit ad49aee401dd1997ec71360df6e51a91ad3cf516 upstream.

Sometimes (firmware bug?) the V5 boost GPIO is not configured as output
by the BIOS, leading to the 5V boost convertor being permanently on,

Explicitly set the direction and drv flags rather then inheriting them
from the firmware to fix this.

Fixes: 585cb239f4de ("extcon: intel-cht-wc: Disable external 5v boost ...")
Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/extcon/extcon-intel-cht-wc.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -66,6 +66,8 @@
 
 #define CHT_WC_VBUS_GPIO_CTLO		0x6e2d
 #define CHT_WC_VBUS_GPIO_CTLO_OUTPUT	BIT(0)
+#define CHT_WC_VBUS_GPIO_CTLO_DRV_OD	BIT(4)
+#define CHT_WC_VBUS_GPIO_CTLO_DIR_OUT	BIT(5)
 
 enum cht_wc_usb_id {
 	USB_ID_OTG,
@@ -183,14 +185,15 @@ static void cht_wc_extcon_set_5v_boost(s
 {
 	int ret, val;
 
-	val = enable ? CHT_WC_VBUS_GPIO_CTLO_OUTPUT : 0;
-
 	/*
 	 * The 5V boost converter is enabled through a gpio on the PMIC, since
 	 * there currently is no gpio driver we access the gpio reg directly.
 	 */
-	ret = regmap_update_bits(ext->regmap, CHT_WC_VBUS_GPIO_CTLO,
-				 CHT_WC_VBUS_GPIO_CTLO_OUTPUT, val);
+	val = CHT_WC_VBUS_GPIO_CTLO_DRV_OD | CHT_WC_VBUS_GPIO_CTLO_DIR_OUT;
+	if (enable)
+		val |= CHT_WC_VBUS_GPIO_CTLO_OUTPUT;
+
+	ret = regmap_write(ext->regmap, CHT_WC_VBUS_GPIO_CTLO, val);
 	if (ret)
 		dev_err(ext->dev, "Error writing Vbus GPIO CTLO: %d\n", ret);
 }
