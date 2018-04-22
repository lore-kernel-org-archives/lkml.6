Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+Nkce5jrHMVhNbsFAs3m1csBcGskkYPSLleUW5wbDSgz9/zp0kVvyIqMsbbNYqvKlkw/8F
ARC-Seal: i=1; a=rsa-sha256; t=1524405304; cv=none;
        d=google.com; s=arc-20160816;
        b=iE9ENpy51pwsSiDXQSRrx/wi57aquMV0OKYmpu0D4eIWi1Wsri35zYSXuZG6hE8ZiW
         lmCiRTIvtOjfpEUhtO/muYW1XakA1gbQarv3v9Tw1MTFfIJD90QoPpjeQGqTqfIdIx/k
         BJRCeuwGfSvk9WXtg+q8KdFO0LJj96n6N+TPOu0P4euInggMp/3fdwWc2CdbKBRVCiV6
         oVrqA7gMPrYvd54f1QUgM322tbSmGP7Rzmz3CjcOCMmDxdbM5lwDp5vO4YGSaZzcewIo
         Ps3vAf+LcGXthRCp8BKeKRDGNpJ2FmFnmLjnMCF99RqCC9aHrZoeuEvkJByBbFhhqiB8
         EQfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6ctqpjEm3KkhLDUdfOg6nfsIzRErv6ljpf08M8d+OXo=;
        b=NvYkVvo+7Bz7lKVk5qfGmzN8F9hC2GZbbByBCdsDxGpAe32ndGg7x8hiPoOricDE4x
         O8b/ZGbjv6KZyPwUpTmlgbH8mWDz9zlEvMlrk5pRBb7BBoOe6iYWOQ27x5F9sISC/k5C
         +ZQsq+M+/AmchCiHWxkYHn9MmP7Ez5g/ltga25qkbL/1Q6pKLZXZ439Nm6CGlWe61fZ2
         8W8G99sN5DFBqCxduhpNftW9WascOKJjbqq4Y/f9HbsgMgvu9eXRfMp0amTRjfAJTOz+
         sben7QPx8bxoXrEWIoC7xTs2f58Qypldmn9n5t8a+GRg/IbP1XJvTxb0PnLYzYc0XMO8
         AQAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chen-Yu Tsai <wens@csie.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 4.16 018/196] phy: allwinner: sun4i-usb: poll vbus changes on A23/A33 when driving VBUS
Date: Sun, 22 Apr 2018 15:50:38 +0200
Message-Id: <20180422135105.065588730@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454816491806607?=
X-GMAIL-MSGID: =?utf-8?q?1598454816491806607?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen-Yu Tsai <wens@csie.org>

commit d7119224bfe6e8efbf821a52db7da9530d790f07 upstream.

The AXP223 PMIC, like the AXP221, does not generate VBUS change
interrupts when N_VBUSEN is used to drive VBUS for the OTG port
on the board.

This was not noticed until recently, as most A23/A33 boards use
a GPIO pin that does not support interrupts for OTG ID detection.
This forces the driver to use polling. However the A33-OlinuXino
uses a pin that does support interrupts, so the driver uses them.
However the VBUS interrupt never fires, and the driver never gets
to update the VBUS status. This results in musb timing out waiting
for VBUS to rise.

This was worked around for the AXP221 by resorting to polling
changes in commit 91d96f06a760 ("phy-sun4i-usb: Add workaround for
missing Vbus det interrupts on A31"). This patch adds the A23 and
A33 to the list of SoCs that need the workaround.

Fixes: fc1f45ed3043 ("phy-sun4i-usb: Add support for the usb-phys on the
		      sun8i-a33 SoC")
Fixes: 123dfdbcfaf5 ("phy-sun4i-usb: Add support for the usb-phys on the
		      sun8i-a23 SoC")
Cc: <stable@vger.kernel.org> # 4.3.x: 68dbc2ce77bb phy-sun4i-usb:
		Use of_match_node to get model specific config data
Cc: <stable@vger.kernel.org> # 4.3.x: 5cf700ac9d50 phy: phy-sun4i-usb:
		Fix optional gpios failing probe
Cc: <stable@vger.kernel.org> # 4.3.x: 04e59a0211ff phy-sun4i-usb:
		Fix irq free conditions to match request conditions
Cc: <stable@vger.kernel.org> # 4.3.x: 91d96f06a760 phy-sun4i-usb:
		Add workaround for missing Vbus det interrupts on A31
Cc: <stable@vger.kernel.org> # 4.3.x
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

---
 drivers/phy/allwinner/phy-sun4i-usb.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -410,11 +410,13 @@ static bool sun4i_usb_phy0_poll(struct s
 		return true;
 
 	/*
-	 * The A31 companion pmic (axp221) does not generate vbus change
-	 * interrupts when the board is driving vbus, so we must poll
+	 * The A31/A23/A33 companion pmics (AXP221/AXP223) do not
+	 * generate vbus change interrupts when the board is driving
+	 * vbus using the N_VBUSEN pin on the pmic, so we must poll
 	 * when using the pmic for vbus-det _and_ we're driving vbus.
 	 */
-	if (data->cfg->type == sun6i_a31_phy &&
+	if ((data->cfg->type == sun6i_a31_phy ||
+	     data->cfg->type == sun8i_a33_phy) &&
 	    data->vbus_power_supply && data->phys[0].regulator_on)
 		return true;
 
@@ -885,7 +887,7 @@ static const struct sun4i_usb_phy_cfg su
 
 static const struct sun4i_usb_phy_cfg sun8i_a23_cfg = {
 	.num_phys = 2,
-	.type = sun4i_a10_phy,
+	.type = sun6i_a31_phy,
 	.disc_thresh = 3,
 	.phyctl_offset = REG_PHYCTL_A10,
 	.dedicated_clocks = true,
