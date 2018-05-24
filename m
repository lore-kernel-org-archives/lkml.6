Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqOGiFJfex62AX0saEonjVVZCGAIBohYwTnTlCiKXdikJYv17Cpgf1Ocyj5yML+kYBYVKQT
ARC-Seal: i=1; a=rsa-sha256; t=1527156283; cv=none;
        d=google.com; s=arc-20160816;
        b=k+VwWrV39SwD1a5ilsCeMVIJDq4Wae5+JdostbDWKuFU7Q5l2y+7KX4qOFLPe2RgA7
         aRCHW2BPBV3kz7Z7ubqtnkhVQ+qqnRjIpt3KEZwe2TL7+UnAlMQOcpAr2QLTI18wB6GT
         GatHikSZs4Oqas5sTX7K1BXhPgjWon0hrGnTTv8cQQ6agDeWgH59j9eTaB//XXL8dZK8
         4h56FudhKHpLQt4RFrkB/RmafrBEdpNz6LWnNGstef+VW+LEkDhITDAD6dvdiiXy2o5/
         M/1Q4wQHKLZkWW8j05QgaZQjk9PUdMHORPHPU7ifbJTm950dwoeiUWlBkd6e1Vo9ybnX
         7KWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ZzaUMyD15xsrfUiwQbNSbefdAxP+727Vs15OEJ6DNyU=;
        b=SbVPEviHQb0UMv/v9Vt/EQf2JBSfMuhj8Kt4ZXVy0DaK6IdfNU7bNpm+qa99jbquze
         hDOz3eiOTIPRFOoDz0Yu/TWlmgVoeckPO+ROZSGjXrKiCgvCBhn+gizACnsTVekhHoqm
         2qWmkJNZ74Zo1dKkbhNpRhlYHDWPjETR1EkWzvoFE+JkHW1fDEc3CUaQ3cV58T39ogMs
         O9a+QfZNqPMjMAIbbGx7V/KLXOkQPNNkD5VkKMDv0eVeGPxjEugQHFEPgqc6Vu5jpMUB
         Ky9t4luXUIS3L9xRZmPWZZ7aHvyyIi6S3kHvMZqZQUADOv2ME+zn3dByyw3NIYU+vO/d
         MPjA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Hk1XOgU5;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Hk1XOgU5;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrzej Hajda <a.hajda@samsung.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 129/161] clk: samsung: exynos5433: Fix PLL rates
Date: Thu, 24 May 2018 11:39:14 +0200
Message-Id: <20180524093033.808546894@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338518076958484?=
X-GMAIL-MSGID: =?utf-8?q?1601339427840870245?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrzej Hajda <a.hajda@samsung.com>

[ Upstream commit ab0447845cffc0fd752df2ccd6b4e34006000ce4 ]

Rates declared in PLL rate tables should match exactly rates calculated from
the PLL coefficients. If that is not the case, rate of the PLL's child clock
might be set not as expected. For instance, if in the PLL rates table we have
a 393216000 Hz entry and the real value as returned by the PLL's recalc_rate
callback is 393216003, after setting PLL's clk rate to 393216000 clk_get_rate
will return 393216003. If we now attempt to set rate of a PLL's child divider
clock to 393216000/2 its rate will be 131072001, rather than 196608000.
That is, the divider will be set to 3 instead of 2, because 393216003/2 is
greater than 196608000.

To fix this issue declared rates are changed to exactly match rates generated
by the PLL, as calculated from the P, M, S, K coefficients.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/samsung/clk-exynos5433.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -729,7 +729,7 @@ static const struct samsung_pll_rate_tab
 	PLL_35XX_RATE(800000000U,  400, 6,  1),
 	PLL_35XX_RATE(733000000U,  733, 12, 1),
 	PLL_35XX_RATE(700000000U,  175, 3,  1),
-	PLL_35XX_RATE(667000000U,  222, 4,  1),
+	PLL_35XX_RATE(666000000U,  222, 4,  1),
 	PLL_35XX_RATE(633000000U,  211, 4,  1),
 	PLL_35XX_RATE(600000000U,  500, 5,  2),
 	PLL_35XX_RATE(552000000U,  460, 5,  2),
@@ -757,12 +757,12 @@ static const struct samsung_pll_rate_tab
 /* AUD_PLL */
 static const struct samsung_pll_rate_table exynos5433_aud_pll_rates[] __initconst = {
 	PLL_36XX_RATE(400000000U, 200, 3, 2,      0),
-	PLL_36XX_RATE(393216000U, 197, 3, 2, -25690),
+	PLL_36XX_RATE(393216003U, 197, 3, 2, -25690),
 	PLL_36XX_RATE(384000000U, 128, 2, 2,      0),
-	PLL_36XX_RATE(368640000U, 246, 4, 2, -15729),
-	PLL_36XX_RATE(361507200U, 181, 3, 2, -16148),
-	PLL_36XX_RATE(338688000U, 113, 2, 2,  -6816),
-	PLL_36XX_RATE(294912000U,  98, 1, 3,  19923),
+	PLL_36XX_RATE(368639991U, 246, 4, 2, -15729),
+	PLL_36XX_RATE(361507202U, 181, 3, 2, -16148),
+	PLL_36XX_RATE(338687988U, 113, 2, 2,  -6816),
+	PLL_36XX_RATE(294912002U,  98, 1, 3,  19923),
 	PLL_36XX_RATE(288000000U,  96, 1, 3,      0),
 	PLL_36XX_RATE(252000000U,  84, 1, 3,      0),
 	{ /* sentinel */ }
