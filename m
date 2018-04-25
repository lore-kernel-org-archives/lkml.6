Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49YNACeG5Y9neQoiNoiFPUsjhhHg/r30owyv8BY/XvUu+9D/1arg05P/aCRTNOK8Sj3QWoy
ARC-Seal: i=1; a=rsa-sha256; t=1524652736; cv=none;
        d=google.com; s=arc-20160816;
        b=NQjA7R/gKR0REbqsCI5z2n6CYOWFmLYUwOIg4Doiyvr+hjlGyoSZ8dV6uYDM+ZEmkO
         JV4CEZWKvgMMvTY4DN/ttQcK1pkEetfNL6WoJqICmBarHro1Wk3tFx7Zsf6sBWuesBHa
         SrseMhiCgl8buVeZ/ezwk3DU5TyB/Cf2bcTJlkHic+Uh2P8XQ4riNRb/k6xFmAoMOpnd
         nT8+lFcLvv4N/zyHo2XDJ2iLP+FUJMKft4rP2Q4qFE8Cl6bcX3QhWOCws8LClnfJp6cj
         hUHb5lB7dn6FSuUipUjPI82NIELsavvR2GP9i/A5Jw19aCZg2A8m1BRPtiTYav+X9iRm
         gXNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sm+WvDhuzgyNNIG8zTH596eCDRNFVDxq/4dh21F//tI=;
        b=nk7l6Q24CPinOqQn8MZzbFv3kB/qNb4YEKmL8WIykNYkD/J6L+ufeRe2l47mcnBT1a
         tmP8zIK9IKhysKLtSAlNlSeL1suBthh3GmAXx5FbZYZbya5XcsJEfP1bdsSrfUp/5Ljp
         wthMPK06T+OTn330pef4TQcxAg/8LpPp4vquOogfMf4HgojeNL9cWT+chk2esEf/wKpm
         okdH2ksysQOtYloCXQFQkvdDKPJe64z5I2XdijGwLjyxRmQDI9AIYmT5SbZevFRvf9SO
         xUdmb9yzZ8ZmuiOh+g1lNuJIJAY3sOklsJpzUMHI7mJoGudBaKrrfkTN3SOACpJi8jYX
         m7Xg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Emiliano Ingrassia <ingrassia@epigenesys.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 050/183] net: stmmac: dwmac-meson8b: fix setting the RGMII TX clock on Meson8b
Date: Wed, 25 Apr 2018 12:34:30 +0200
Message-Id: <20180425103244.567375102@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714267906161500?=
X-GMAIL-MSGID: =?utf-8?q?1598714267906161500?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


[ Upstream commit 433c6cab9d298687c097f6ee82e49157044dc7c6 ]

Meson8b only supports MPLL2 as clock input. The rate of the MPLL2 clock
set by Odroid-C1's u-boot is close to (but not exactly) 500MHz. The
exact rate is 500002394Hz, which is calculated in
drivers/clk/meson/clk-mpll.c using the following formula:
DIV_ROUND_UP_ULL((u64)parent_rate * SDM_DEN, (SDM_DEN * n2) + sdm)
Odroid-C1's u-boot configures MPLL2 with the following values:
- SDM_DEN = 16384
- SDM = 1638
- N2 = 5

The 250MHz clock (m250_div) inside dwmac-meson8b driver is derived from
the MPLL2 clock. Due to MPLL2 running slightly faster than 500MHz the
common clock framework chooses a divider which is too big to generate
the 250MHz clock (a divider of 2 would be needed, but this is rounded up
to a divider of 3). This breaks the RTL8211F RGMII PHY on Odroid-C1
because it requires a (close to) 125MHz RGMII TX clock (on Gbit speeds,
the IP block internally divides that down to 25MHz on 100Mbit/s
connections and 2.5MHz on 10Mbit/s connections - we don't need any
special configuration for that).

Round the divider to the closest value to prevent this issue on Meson8b.
This means we'll now end up with a clock rate for the RGMII TX clock of
125001197Hz (= 125MHz plus 1197Hz), which is close-enough to 125MHz.
This has no effect on the Meson GX SoCs since there fclk_div2 is used as
input clock, which has a rate of 1000MHz (and thus is divisible cleanly
to 250MHz and 125MHz).

Fixes: 566e8251625304 ("net: stmmac: add a glue driver for the Amlogic Meson 8b / GXBB DWMAC")
Reported-by: Emiliano Ingrassia <ingrassia@epigenesys.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Tested-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -144,7 +144,9 @@ static int meson8b_init_clk(struct meson
 	dwmac->m250_div.shift = PRG_ETH0_CLK_M250_DIV_SHIFT;
 	dwmac->m250_div.width = PRG_ETH0_CLK_M250_DIV_WIDTH;
 	dwmac->m250_div.hw.init = &init;
-	dwmac->m250_div.flags = CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO;
+	dwmac->m250_div.flags = CLK_DIVIDER_ONE_BASED |
+				CLK_DIVIDER_ALLOW_ZERO |
+				CLK_DIVIDER_ROUND_CLOSEST;
 
 	dwmac->m250_div_clk = devm_clk_register(dev, &dwmac->m250_div.hw);
 	if (WARN_ON(IS_ERR(dwmac->m250_div_clk)))
