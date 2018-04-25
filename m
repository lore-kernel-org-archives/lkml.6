Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/mRTpaAI6jU+2tZ7XEWKYz00LfD4qlB4oixEHy3x8eOOwqZd/fa6RLYrG4NCKkdjRBTeYs
ARC-Seal: i=1; a=rsa-sha256; t=1524652739; cv=none;
        d=google.com; s=arc-20160816;
        b=ukqD42Q5t9rW0cEU8eTTN6EzS59BADp3Ey6evfAgWo6N20hfT7J1j4L17TaATBgww1
         A+60tiF4pFeNyOXxcgZb/SB8i07NM1CJuhpob/fEhB/bMp5N3W8+wRsryIvUv+/7zYEB
         S1LEWKutq16aghim3KOOV+Uye/tDQEnUAewUzNiea4HH1GjQAmxM95ZPIGoLDdBVAXRb
         +KAvb4F6iw0+JZJOIMGQo4QsWJr1uEY6glVdDfMsBK64D/4jC0vXvImgaQC9tVvS6Om1
         y9Y7UD30sKiosJdWMH9GT4lxKgA27sYNLAqXiEIGB3vjxARQ4CnL1k1qqs6MT+U9PWMV
         LwBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0jSepBs1ytdym1JVrNo8DDcc3gciIBBEp+V1o+6C0uI=;
        b=laGkUbqlrBVq+PtiwuQIo/HP9PrAWRK2vc9civY4/QUDzCHeK2q5SwgfPRnBReGmpf
         2N66B1auijt1IivchjY07MIulMY3LKnnDn9GK338N9fBxMXknfQSxmHt5wcaaeJOpPsO
         KbXcR4ih0BaycvXTwuG2JeGftKgpccE5bcdS4HRiNfz7v2ZWm2+D6qeIFbsQ8+BuHqHE
         mG4r2eC42t44qAl8dDFG2zF063hEItJR3k+pKU1+VVTCABSqDmbOOdoqH8VTKSla0GiV
         sOSBarSLcci94oSdU68qhe2F7QtWQ10+m73MWgPUhJXoeXId28fnckI9mo0Lwu0CW1P6
         1+4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 051/183] net: stmmac: dwmac-meson8b: propagate rate changes to the parent clock
Date: Wed, 25 Apr 2018 12:34:31 +0200
Message-Id: <20180425103244.609727329@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714270973663596?=
X-GMAIL-MSGID: =?utf-8?q?1598714270973663596?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


[ Upstream commit fb7d38a70e1d8ffd54f7a7464dcc4889d7e490ad ]

On Meson8b the only valid input clock is MPLL2. The bootloader
configures that to run at 500002394Hz which cannot be divided evenly
down to 125MHz using the m250_div clock. Currently the common clock
framework chooses a m250_div of 2 - with the internal fixed
"divide by 10" this results in a RGMII TX clock of 125001197Hz (120Hz
above the requested 125MHz).

Letting the common clock framework propagate the rate changes up to the
parent of m250_mux allows us to get the best possible clock rate. With
this patch the common clock framework calculates a rate of
very-close-to-250MHz (249999701Hz to be exact) for the MPLL2 clock
(which is the mux input). Dividing that by 2 (which is an internal,
fixed divider for the RGMII TX clock) gives us an RGMII TX clock of
124999850Hz (which is only 150Hz off the requested 125MHz, compared to
1197Hz based on the MPLL2 rate set by u-boot and the Amlogic GPL kernel
sources).

SoCs from the Meson GX series are not affected by this change because
the input clock is FCLK_DIV2 whose rate cannot be changed (which is fine
since it's running at 1GHz, so it's already a multiple of 250MHz and
125MHz).

Fixes: 566e8251625304 ("net: stmmac: add a glue driver for the Amlogic Meson 8b / GXBB DWMAC")
Suggested-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Tested-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -116,7 +116,7 @@ static int meson8b_init_clk(struct meson
 	snprintf(clk_name, sizeof(clk_name), "%s#m250_sel", dev_name(dev));
 	init.name = clk_name;
 	init.ops = &clk_mux_ops;
-	init.flags = 0;
+	init.flags = CLK_SET_RATE_PARENT;
 	init.parent_names = mux_parent_names;
 	init.num_parents = MUX_CLK_NUM_PARENTS;
 
