Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsJrYULL4ejFGLvmzXGQlFGJoOovkw1Jew4+h1ByBYmkAPZIvV69cySuv3z8icG82eXXQJt
ARC-Seal: i=1; a=rsa-sha256; t=1521483960; cv=none;
        d=google.com; s=arc-20160816;
        b=NP9Mi2Fz26Xwa0lg0Oc/j79qG3gCDw/cCQZJDlW8SWrnaw1syMSqax67EUq1WrzL+W
         nO+nhyMGDurG3KccP06p8YFJoaueeO0if38gVcrvCx9vGW427UjUS2utl8zp47AgeDVe
         tZpnWRMS1WZXVhq8tpEJpHtshCvPEATL2NlSlspjfb8W+fnQj9oQZ9xJAmPkR2n034Zv
         dVNsD0Shq45ZztspZrEWkdWMT14oo3HF20GifPJjqf4VhLE7TtBiiJEP+By+ZqSm6mdT
         2Nj6wIXxBAG5ydXEm9d0kv+2av0G8z+UfKdmuyqjKtdcHtMcIKEdH6gi8LaPzp5bc7tE
         PS8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uswYoHDQZvVyNb6VvLutqc6PyFyXzp2Ro01730/QVf0=;
        b=LwxtOChPFTmpOsxSmvNiUiG9414ZAAa96rv1UAJhKKKNs9FGwqdwjX3jrWShLj6MaT
         2oRFBt1Di5ZphBrPYaIzj+TmvfEBxvOP5++LpyxyaW0fGYMo8jzz70I2ffQZJGWu/t/K
         KgDjgDkZBTJzCTCR+/WGePKDGaaC+EywXHfULPiWavj6Dgen6KRqDSs5LdzUgxrp2jS0
         ZRbgNxySXpVusuHh7VDKjTsZiGvWYT1kuztXOVpRtyOw3Of8NP0KYk4Y0Pvd8AnrRTOB
         9Im5gXYEAixeJYoMWQBOtgjEe7PrK4t1efuB62n9Ffnzj6UDkWzVEE0yX+OvupnP8RsQ
         /zZw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Fugang Duan <B38611@freescale.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 145/241] net: fec: add phy-reset-gpios PROBE_DEFER check
Date: Mon, 19 Mar 2018 19:06:50 +0100
Message-Id: <20180319180757.191602215@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391565217059227?=
X-GMAIL-MSGID: =?utf-8?q?1595391565217059227?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fugang Duan <fugang.duan@nxp.com>


[ Upstream commit 9269e5560b261eb9ee157497890dc0948db76cf8 ]

Many boards use i2c/spi expander gpio as phy-reset-gpios and these
gpios maybe registered after fec port, driver should check the return
value of .of_get_named_gpio().

Signed-off-by: Fugang Duan <B38611@freescale.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/fec_main.c |   26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3209,7 +3209,7 @@ static int fec_enet_init(struct net_devi
 }
 
 #ifdef CONFIG_OF
-static void fec_reset_phy(struct platform_device *pdev)
+static int fec_reset_phy(struct platform_device *pdev)
 {
 	int err, phy_reset;
 	bool active_high = false;
@@ -3217,7 +3217,7 @@ static void fec_reset_phy(struct platfor
 	struct device_node *np = pdev->dev.of_node;
 
 	if (!np)
-		return;
+		return 0;
 
 	of_property_read_u32(np, "phy-reset-duration", &msec);
 	/* A sane reset duration should not be longer than 1s */
@@ -3225,8 +3225,10 @@ static void fec_reset_phy(struct platfor
 		msec = 1;
 
 	phy_reset = of_get_named_gpio(np, "phy-reset-gpios", 0);
-	if (!gpio_is_valid(phy_reset))
-		return;
+	if (phy_reset == -EPROBE_DEFER)
+		return phy_reset;
+	else if (!gpio_is_valid(phy_reset))
+		return 0;
 
 	active_high = of_property_read_bool(np, "phy-reset-active-high");
 
@@ -3235,7 +3237,7 @@ static void fec_reset_phy(struct platfor
 			"phy-reset");
 	if (err) {
 		dev_err(&pdev->dev, "failed to get phy-reset-gpios: %d\n", err);
-		return;
+		return err;
 	}
 
 	if (msec > 20)
@@ -3244,14 +3246,17 @@ static void fec_reset_phy(struct platfor
 		usleep_range(msec * 1000, msec * 1000 + 1000);
 
 	gpio_set_value_cansleep(phy_reset, !active_high);
+
+	return 0;
 }
 #else /* CONFIG_OF */
-static void fec_reset_phy(struct platform_device *pdev)
+static int fec_reset_phy(struct platform_device *pdev)
 {
 	/*
 	 * In case of platform probe, the reset has been done
 	 * by machine code.
 	 */
+	return 0;
 }
 #endif /* CONFIG_OF */
 
@@ -3422,6 +3427,7 @@ fec_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev,
 				"Failed to enable phy regulator: %d\n", ret);
+			clk_disable_unprepare(fep->clk_ipg);
 			goto failed_regulator;
 		}
 	} else {
@@ -3434,7 +3440,9 @@ fec_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	fec_reset_phy(pdev);
+	ret = fec_reset_phy(pdev);
+	if (ret)
+		goto failed_reset;
 
 	if (fep->bufdesc_ex)
 		fec_ptp_init(pdev);
@@ -3495,8 +3503,10 @@ failed_init:
 	fec_ptp_stop(pdev);
 	if (fep->reg_phy)
 		regulator_disable(fep->reg_phy);
+failed_reset:
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 failed_regulator:
-	clk_disable_unprepare(fep->clk_ipg);
 failed_clk_ipg:
 	fec_enet_clk_enable(ndev, false);
 failed_clk:
