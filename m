Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqjcG8HpNH5CgY/hEZ79+9gZYoMyIaxJke9Rc8I7vRVhdpigCyZ1SH4vAgAd4MPRV0a3kMG
ARC-Seal: i=1; a=rsa-sha256; t=1527156286; cv=none;
        d=google.com; s=arc-20160816;
        b=xkTvtagpr52jYezu8ANLZJgVGPl2vdsmSfwWWxtOKgYIpZ/f/1yutLkO5H3+UKLvnH
         +6R27YMugDizXJT0ryj3pjqCM1C0A1M2Y/bAoiz96vNyZ6regRFMOoD9tzNcgXNAfZsz
         /VOXrKifPW1UK2xV1KPmcbRNA3cHYnXmru89eVc/S9WLWxc435A1GD3OBKAX0oHcEmjo
         vulHSzpaCvmsKZnSFjDA9zyS0n9w5RKaFtsLD8gTcxdM2YW0GgDwfdrUY1ump3N67bEh
         Na55B7psdOauC1p/2oPHeygVpL4qNoHSaylU3wmYL1im+wSdbD25QeKlFKcTRR3ySF5k
         fZtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=1PCTTqaHZ6GFHA/ndgQRKcmDA+tbQB7iaNVp0cdp8Q4=;
        b=cUPavpPDsU9DULkjCvW3oCukHycqIkNTbIx3GSXAsa2DQojjAuvFxlnI1gkDl9uAli
         qg0DG8mab8pSCFTihCEun/iEo6moC19vwpsMHbDWgQGpCycQU+ZpyZtxCkSG9nEeqBaV
         Laj6UAMfuQxQbqtlDWOyx3/aax9OrPGs94bYgIAm1CHg7zk34Mq7GQxDHWzKaoCm9KUO
         U233YB9JPps1Jfkikwnfa9j6mUB6A4n646ZmI9eEUUvIjuZkL2+X7QEE9fE/DvrAa+GC
         LKys71OmpZ+sddn1eNWd58hF3Uwwtlf7WW+Oi04QlRFAJrtfbHPcCECTjAg1Cxdr5q8H
         4vEA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=FlH/Bi7Y;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=FlH/Bi7Y;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrzej Hajda <a.hajda@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 130/161] clk: samsung: exynos5250: Fix PLL rates
Date: Thu, 24 May 2018 11:39:15 +0200
Message-Id: <20180524093033.908526856@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338523015919946?=
X-GMAIL-MSGID: =?utf-8?q?1601339430309404609?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrzej Hajda <a.hajda@samsung.com>

[ Upstream commit 2ac051eeabaa411ef89ae7cd5bb8e60cb41ad780 ]

Rates declared in PLL rate tables should match exactly rates calculated
from PLL coefficients. If that is not the case, rate of the PLL's child clock
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
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/samsung/clk-exynos5250.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -711,13 +711,13 @@ static const struct samsung_pll_rate_tab
 	/* sorted in descending order */
 	/* PLL_36XX_RATE(rate, m, p, s, k) */
 	PLL_36XX_RATE(192000000, 64, 2, 2, 0),
-	PLL_36XX_RATE(180633600, 90, 3, 2, 20762),
+	PLL_36XX_RATE(180633605, 90, 3, 2, 20762),
 	PLL_36XX_RATE(180000000, 90, 3, 2, 0),
 	PLL_36XX_RATE(73728000, 98, 2, 4, 19923),
-	PLL_36XX_RATE(67737600, 90, 2, 4, 20762),
+	PLL_36XX_RATE(67737602, 90, 2, 4, 20762),
 	PLL_36XX_RATE(49152000, 98, 3, 4, 19923),
-	PLL_36XX_RATE(45158400, 90, 3, 4, 20762),
-	PLL_36XX_RATE(32768000, 131, 3, 5, 4719),
+	PLL_36XX_RATE(45158401, 90, 3, 4, 20762),
+	PLL_36XX_RATE(32768001, 131, 3, 5, 4719),
 	{ },
 };
 
