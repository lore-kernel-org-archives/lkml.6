Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrzNDYvgm95YEnUzij2zqMS3tAmUzrmG/6NslYWKbZNjygq25xdyZU5XdNkivo1F11Up6re
ARC-Seal: i=1; a=rsa-sha256; t=1527156256; cv=none;
        d=google.com; s=arc-20160816;
        b=LtU36UhHxO/E5fjWMoLdSoh8libhaEVPNYNhLqbJeM0q1q3vNO9L7SZQUbpGFnmVvx
         dffAQTeMByggo15V7XMVSHkApN5R0ta1feYXIoOBM4arxZ3r26xfZy4LKxTRcTjurU/x
         YplY/Xecpl1Qo3gMpQlIV6B4LGV57TRV6/BRMVSd8FG4WDVqSrUWP6jvAbSWwtSwi7+5
         FCj/xHOdQaEimTg/BfHH4qDLCotIaWyJdsvp6ffupT2PU2V1ly3EjOmPha8E69kY0mpA
         ZTbEPf7gmSAR6x21jc61jhyKuCoMPCXqPhm2smFQkKRmXqfWZ2d+VDqhMeDJ4irbjhIx
         NxIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=d3mtSsfdcc+GnIsOaZcPs53/MRE2xg6DCipr9kuqQKY=;
        b=WOJNbWZ0d/O94ISo8/KH81Z56fxKqnnd/PztGwhrY5Dq4QWBdvUkeKcfrumSME/uVU
         /YW9moAiolyjKEUtmfpPPto4mHRiaD/VSTvjulR2UB6c6tZrWBlOa+8i3CLhsBvSX8Vs
         SVpwmedbZDPCwjbp+J8bl8XGLnGyYkj4LAezP2YAhuFTLSlZV/IXFftYKMTL0iQnVlSp
         rCTP3p4DFadOYbaV6UAvl9pSVmlx74sgEsdgbNtfLj9/rgoKltlblTIfJ6jHxCJQ2gMU
         8ba0vBiaPDYcF7FYWYPF6ZWMYSjbLUBPicgK4+OOdQ+4lZ/nSh5tS11ljf85LTgQOZ68
         su+A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=bvw18X50;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=bvw18X50;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 120/161] ASoC: samsung: i2s: Ensure the RCLK rate is properly determined
Date: Thu, 24 May 2018 11:39:05 +0200
Message-Id: <20180524093032.679486639@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338492038010883?=
X-GMAIL-MSGID: =?utf-8?q?1601339398374058608?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sylwester Nawrocki <s.nawrocki@samsung.com>

[ Upstream commit 647d04f8e07afc7c3b7a42b3ee01a8b28db29631 ]

If the RCLK mux clock configuration is specified in DT and no set_sysclk()
callback is used in the sound card driver the sclk_srcrate field will remain
set to 0, leading to an incorrect PSR divider setting.
To fix this the frequency value is retrieved from the CLK_I2S_RCLK_SRC clock,
so the actual RCLK mux selection is taken into account.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/samsung/i2s.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -656,8 +656,12 @@ static int i2s_set_fmt(struct snd_soc_da
 		tmp |= mod_slave;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
-		/* Set default source clock in Master mode */
-		if (i2s->rclk_srcrate == 0)
+		/*
+		 * Set default source clock in Master mode, only when the
+		 * CLK_I2S_RCLK_SRC clock is not exposed so we ensure any
+		 * clock configuration assigned in DT is not overwritten.
+		 */
+		if (i2s->rclk_srcrate == 0 && i2s->clk_data.clks == NULL)
 			i2s_set_sysclk(dai, SAMSUNG_I2S_RCLKSRC_0,
 							0, SND_SOC_CLOCK_IN);
 		break;
@@ -881,6 +885,11 @@ static int config_setup(struct i2s_dai *
 		return 0;
 
 	if (!(i2s->quirks & QUIRK_NO_MUXPSR)) {
+		struct clk *rclksrc = i2s->clk_table[CLK_I2S_RCLK_SRC];
+
+		if (i2s->rclk_srcrate == 0 && rclksrc && !IS_ERR(rclksrc))
+			i2s->rclk_srcrate = clk_get_rate(rclksrc);
+
 		psr = i2s->rclk_srcrate / i2s->frmclk / rfs;
 		writel(((psr - 1) << 8) | PSR_PSREN, i2s->addr + I2SPSR);
 		dev_dbg(&i2s->pdev->dev,
