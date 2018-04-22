Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/diTUokDMvubwr1KSKqe61cfJUsEGixo2xGVJEV4HFlKm9J/Rzc2QiD38JJwvhhb5KGeLE
ARC-Seal: i=1; a=rsa-sha256; t=1524405500; cv=none;
        d=google.com; s=arc-20160816;
        b=e7p9NathjuEW4TQe/oozsLiRvclctG5qovk+bIfWjx3Hti+QbuJwGSAHbTi1rW+Wfn
         xSEHKJxNkBUqlEneQ4pUrGogAGIcOPMY3g1lfjqk9g+Q9ooFE2u2q3KhD3Tjbflw13Hd
         1rxpjqtmjKNqj2ORVbuQtvySPLU+uXyrC9iKrdHvH7iIgNq64W8VKB2je6wDpikebTJK
         A9d98HDB9u/ca28sHs/3d5liZag5mW4csA0LkfoTpeCxpQxpXQgi5v8g6qh5xzdawTPm
         Kkl03QXh1ssg0OpcJPnC2iflsAmFR5ErfDypI2cP95lyTSvepne3fYTwVTFY5wHjYKDn
         +Agg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PDNC4RHLay3No1OguLdlcclWKFdwtNHz5KwKgLa1ESs=;
        b=KivTkOzi9p/pGYAGsnEP8DUNL/oJPTg7ACovmOStl+E0GHFP7fTQ8TAFDKGb368+zM
         X30K1dLe+gtyhszsGYdDRkm+gL/vYwaiqEHRqAW+2xHLwFX62whl0TNDvKCiKq3+cuKl
         iNIhDxUAUsGr8QlPlYgW5sfhNydb4+GS5mITllHkvZcZbKdg6xcskEXmFt49YPveaCYS
         Ow/oTUtxv62PWDZHkDEyLnITiEAiLG8aJOlWBxv71YPd004/CrWB6iEHwQZwDJ4z8J7b
         6X0r4HtlcyDt6BB8JQ6VU2xZh8LqcMHqRhazaFocYN3vsOyo6qkI+91ekzcRwEyryNXP
         uM2A==
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
Subject: [PATCH 4.16 082/196] extcon: intel-cht-wc: Set direction and drv flags for V5 boost GPIO
Date: Sun, 22 Apr 2018 15:51:42 +0200
Message-Id: <20180422135108.549449503@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455021610998810?=
X-GMAIL-MSGID: =?utf-8?q?1598455021610998810?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
