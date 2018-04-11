Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48x1gpa3y/fkWSbWz/jDvfMLGhAVapcVjTI3fnhTxFidzrmkAyB21xfTUCJEeZQRVovNyfT
ARC-Seal: i=1; a=rsa-sha256; t=1523473349; cv=none;
        d=google.com; s=arc-20160816;
        b=OeR7JCBtymPrnCOUpkQC11YvB7cG+d6aBfvQ+6RB44VoY6Qz0sTesO6BHv0W5Xpow5
         Ch4j/itzdTy9nrQ4CesbzFVeaQzJIfvcOhKenA1c1aMsERikcBih1WW5tuphhKG2XmwN
         eisV3ZfJGoJFnnrw5o9nbNEtjyYb3eB+WORQryj+NS/mLIKzrHtBpxAIu6gh2aY7aDn7
         xzmwxRqoHlw9qqhUcVjkSzjpgyC5U8ms3Q8PlBSB502w4RYdfhMHBW/iGneroCK18qTj
         S7XZadQMWzY9Up1O/R3bUXHmLU1LHY4BBvhdoRaBndsJJF6zL27t/JHsdpli5P/BNz0i
         nSIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=psperO3aldDXEVPisCA2gm2xB2nZDFxTx8TWcz+i6ro=;
        b=T5vd53/cF+UHSFxzbDbn1nXYq7lzGLWptJQ/Pqz0PaL0/t6MkqtSVLqKcUvz3M9zD2
         IYE2+CcVwXCDRBqr/ulwKxXzEkHZvkwtHMoPLuErbRGn+Gka2O4i2kIkbaHw6qm611mj
         pzCOprozjAd0rdOvEwDYoSAao69Ql5JgROdAHo2EsNbbyCLCcjvRuG6EGWoPSZJotjKA
         icVDpC+gpd3UK0MncOKkASWe4LUNAimcz5nJ6hiUQ0x/XHPbHLj0pAqnV4/NVKT1Deat
         1MRvy/b56W9WwKw/FGmYvyVzbT5q8v36aVb8gJvB5H+0cD0XBOEcatzmbGkeQ5HCXt+m
         2S7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Leonard Crestez <leonard.crestez@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 181/310] net: phy: micrel: Restore led_mode and clk_sel on resume
Date: Wed, 11 Apr 2018 20:35:20 +0200
Message-Id: <20180411183630.390575424@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477590290826063?=
X-GMAIL-MSGID: =?utf-8?q?1597477590290826063?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leonard Crestez <leonard.crestez@nxp.com>


[ Upstream commit 79e498a9c7da0737829ff864aae44df434105676 ]

These bits seem to be lost after a suspend/resume cycle so just set them
again. Do this by splitting the handling of these bits into a function
that is also called on resume.

This patch fixes ethernet suspend/resume on imx6ul-14x14-evk boards.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/micrel.c |   42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -268,23 +268,12 @@ out:
 	return ret;
 }
 
-static int kszphy_config_init(struct phy_device *phydev)
+/* Some config bits need to be set again on resume, handle them here. */
+static int kszphy_config_reset(struct phy_device *phydev)
 {
 	struct kszphy_priv *priv = phydev->priv;
-	const struct kszphy_type *type;
 	int ret;
 
-	if (!priv)
-		return 0;
-
-	type = priv->type;
-
-	if (type->has_broadcast_disable)
-		kszphy_broadcast_disable(phydev);
-
-	if (type->has_nand_tree_disable)
-		kszphy_nand_tree_disable(phydev);
-
 	if (priv->rmii_ref_clk_sel) {
 		ret = kszphy_rmii_clk_sel(phydev, priv->rmii_ref_clk_sel_val);
 		if (ret) {
@@ -295,7 +284,7 @@ static int kszphy_config_init(struct phy
 	}
 
 	if (priv->led_mode >= 0)
-		kszphy_setup_led(phydev, type->led_mode_reg, priv->led_mode);
+		kszphy_setup_led(phydev, priv->type->led_mode_reg, priv->led_mode);
 
 	if (phy_interrupt_is_valid(phydev)) {
 		int ctl = phy_read(phydev, MII_BMCR);
@@ -311,6 +300,25 @@ static int kszphy_config_init(struct phy
 	return 0;
 }
 
+static int kszphy_config_init(struct phy_device *phydev)
+{
+	struct kszphy_priv *priv = phydev->priv;
+	const struct kszphy_type *type;
+
+	if (!priv)
+		return 0;
+
+	type = priv->type;
+
+	if (type->has_broadcast_disable)
+		kszphy_broadcast_disable(phydev);
+
+	if (type->has_nand_tree_disable)
+		kszphy_nand_tree_disable(phydev);
+
+	return kszphy_config_reset(phydev);
+}
+
 static int ksz8041_config_init(struct phy_device *phydev)
 {
 	struct device_node *of_node = phydev->mdio.dev.of_node;
@@ -715,8 +723,14 @@ static int kszphy_suspend(struct phy_dev
 
 static int kszphy_resume(struct phy_device *phydev)
 {
+	int ret;
+
 	genphy_resume(phydev);
 
+	ret = kszphy_config_reset(phydev);
+	if (ret)
+		return ret;
+
 	/* Enable PHY Interrupts */
 	if (phy_interrupt_is_valid(phydev)) {
 		phydev->interrupts = PHY_INTERRUPT_ENABLED;
