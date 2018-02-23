Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvOKEqLeLs3pCSEEK3eVtUB/uoyVP60oiQnlT123G8PYMUOZsJFz7Xy/MnuJC21bspg4QYf
ARC-Seal: i=1; a=rsa-sha256; t=1519410967; cv=none;
        d=google.com; s=arc-20160816;
        b=KP+/wOE2Qdm3OZf6n9od9hAuGxwcVS+Z1g9D/eeDv6eGiiYZQLjgNQxh2xO4R0RnoJ
         eO7PYxStqjoaiiPiapoUljcj3qdB1Wdn3cwAGMg5l5POacoGMdLUKQhJ8wuiCyjiTofP
         lwyW6Ylr8p5L4sY4QrnyVl2XSAJT14WIJ2BhZrHLEanK4kFUUNMYmAQ4qofKyrAtgVP9
         qQXHFNi90ok5uBgImdf9/EVm8LIFcdi8MkfEduepzjSVEGMMqubbf4EfR6fNwNeVzNI6
         HupcJ5Jd027s40CvShjgRlXi4vhaLQik2GoPwijS4di4W6CIu8raeDo4oICeFwbf0P1e
         xCeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=M4KhJe7M7bLTZMkNIVBgrX/d6Ba/v4dGPGIjBZfCM8A=;
        b=qlrEP8vNauraMNje+naB/ki/Nrb6J0eYnJ30iztl5sqvAEgEy9d81931Omiqvbtk4F
         Jd+C809Xzv/r2IDoOkpZrVOGG3PCgc9LBcUWCL3WMQrJAc5vCUy3zO2iP55dWq8G5EG3
         bQIwDYDBCBYWj3kDWhUPkaDRp4g0Vwqi5QTYH5BizrYbIsvE4kShUTbFH77lPF93JCgD
         OglVB+6p5TNXMhuG1lVAjmxIh+a+MTzYh1tw7mRN8Y5ksICs8skVWYxF0YBFtmBW03po
         +jiSb7nMLpoRGS14gBYQNhSPFQIkdCdDqx5gtlobvq+eYzDDHOQCQw+OEenXyveFwDB1
         ZC5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 038/193] pinctrl: sunxi: Fix A80 interrupt pin bank
Date: Fri, 23 Feb 2018 19:24:31 +0100
Message-Id: <20180223170332.034247568@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217875013730737?=
X-GMAIL-MSGID: =?utf-8?q?1593217875013730737?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andre Przywara <andre.przywara@arm.com>


[ Upstream commit 6ad4cc8d1ac483e0fd33f605fb2788b0ecf51ed4 ]

On the A80 the pins on port B can trigger interrupts, and those are
assigned to the second interrupt bank.
Having two pins assigned to the same interrupt bank/pin combination does
not look healthy (instead more like a copy&paste bug from pins PA14-PA16),
so fix the interrupt bank for pins PB14-PB16, which is actually 1.

I don't have any A80 board, so could not test this.

Fixes: d5e9fb31baa2 ("pinctrl: sunxi: Add A80 pinctrl muxing options")
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c
@@ -145,19 +145,19 @@ static const struct sunxi_desc_pin sun9i
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x3, "mcsi"),		/* MCLK */
-		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 14)),	/* PB_EINT14 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 14)),	/* PB_EINT14 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 15),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x3, "mcsi"),		/* SCK */
 		  SUNXI_FUNCTION(0x4, "i2c4"),		/* SCK */
-		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 15)),	/* PB_EINT15 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 15)),	/* PB_EINT15 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 16),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x3, "mcsi"),		/* SDA */
 		  SUNXI_FUNCTION(0x4, "i2c4"),		/* SDA */
-		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 16)),	/* PB_EINT16 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 16)),	/* PB_EINT16 */
 
 	/* Hole */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 0),
