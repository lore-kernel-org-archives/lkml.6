Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49Z4Qb31EMCGi9UnYKGEWt8TgOBAySvcj8kUbBCVp4nG0DKpZGh2kDU9MReXQTyei8bpw8b
ARC-Seal: i=1; a=rsa-sha256; t=1524405835; cv=none;
        d=google.com; s=arc-20160816;
        b=HDl+KrZEEegv28OZvw7ujSLiqwLkGGWbUrye92PSIqrD8p5gg3BDJw17S0ZUOOsO7n
         Q2tynUi5zO00j+4PbG1J1SqvgkjUjTl+UYHV9aGHPt4udSMNsNDqfjtBpKwNMuTT9amY
         ZMF3UD1YBYY36JbwyiGwUkFsvBVbhAKirtba9YHevKufcGavCwC3jDNyiR1yOck1d+TX
         H4pDBezG2j7g+/XO9z7at53NiEh6IyfNcddctH++CDNWq9iB2cBVr5wDqBMnVCBIqM0t
         c9Y1n67E4FPNIbA4cZ2O9BjjPa9VggnDrqz2dmVo4kIhOqySQBf3yOzO2YLbeowUyhdu
         w+rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IPuJMZoMu4LBnROlmJyu0ICnevrJhJv4LEGnfkjXxgk=;
        b=K4qXB9/XzQjbiVTQV4tvgzGUtIco4tx+27MTX+iyfAhPExpkg6yaM4MDFAg3hystP2
         9scSoZ9vp9y7TsGXqnHUGIqerNYZI8Kmy5rAUk+Nz0+Ou1NF6yBXZ6PC+sqosi8mPBDE
         gITIrwa9lY+e4yN8JaKq/qjG1dU8LB+vH5vdsO+KatMu6uQXXuHGVmKEuMFg9yj3T0Ut
         XRM4gX32Mlq/1LbVkjeugX5mRFivTQFXHWMEpDEHbwMtbcwKMOszUSlqj6mIc42vP8dm
         b2UUrPNxDAcPEh3ejHSjqUkj6rUshiE1eWMYBQynSYLeOaMV5bDKu5bsip51QW/pnDQh
         /6gA==
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
Subject: [PATCH 4.14 016/164] phy: allwinner: sun4i-usb: poll vbus changes on A23/A33 when driving VBUS
Date: Sun, 22 Apr 2018 15:51:23 +0200
Message-Id: <20180422135136.056538738@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454816491806607?=
X-GMAIL-MSGID: =?utf-8?q?1598455373554496553?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
