Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqKyJ6Y46JzwEbpitfyNc3EpfGCz0VS2w/0kXIpvONSE9WV6WvJv57B3NBlK1ZDIhiLiE1c
ARC-Seal: i=1; a=rsa-sha256; t=1527156281; cv=none;
        d=google.com; s=arc-20160816;
        b=EQR6AR157Vq7z/ynpSiU45hVy77OnxwTC1etYKcacfzPC09ZtqWduZf1nWOeXCVUg6
         LYPB8s3FOvUFT84KlQpwE4XMQWfXF0saZ35ymho06Fd3+6txZi/J8Ly4eHzTbYmyUAFI
         Mu3mC7TZ2TnxoKkhTvZNgAdYfKV9D5pPNRMeZEhl9he6DQXVXwzqydqAtb8lVrNdFQuT
         FbRYFjUYGVKXvN1ztjDgPyfC9/xfsUrOVd5o+u2tsH1w5XlJW51WZdePyhma1mB6xW/r
         J2z5aOqFRy4yvaEkcNMEqR+BROf/WiJbT8/644IV6oBkPBgEf+WiVjCYn5tLlkP6edSr
         7QHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=7KPjDocPo/YDap4eH/qDVGO76VnLql/xj7SNLqlwW+0=;
        b=eRBf861Z1yFhShK4iv93NDN09qlCOpkXwCu3on8v2j5fy5Ev1LmDVvsbSdEHm8WJBY
         rb6I8gvkCy8Jwe6Uqi0QbTToTWwtbc2m1mdT/yeMPaEm7PF2VS89Rga688KfLdc47mM3
         fTP4JHOES6eB+bDvL71O9Crb6G51F73wj0IAPC/nTPD4+flvhrYGrK7sN7SV2avM0I62
         jRCInd0JquYXQAP7qHFX9pcfYkMiBBxU/1eD+xUdokn1xco6Yy1f58bCqGZUdy8xb3A+
         venj/xCG7ZFu4ZvnicMwx2ZYmpgzcy3clAbUHRef6pc1dNN9OhDW0isItIhjONdSkwZZ
         /L7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=hHKZl4sJ;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=hHKZl4sJ;
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
Subject: [PATCH 4.16 128/161] clk: samsung: exynos5260: Fix PLL rates
Date: Thu, 24 May 2018 11:39:13 +0200
Message-Id: <20180524093033.660803435@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338515019995107?=
X-GMAIL-MSGID: =?utf-8?q?1601339424748478716?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrzej Hajda <a.hajda@samsung.com>

[ Upstream commit cdb68fbd4e7962be742c4f29475220c5bf28d8a5 ]

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
 drivers/clk/samsung/clk-exynos5260.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/samsung/clk-exynos5260.c
+++ b/drivers/clk/samsung/clk-exynos5260.c
@@ -65,7 +65,7 @@ static const struct samsung_pll_rate_tab
 	PLL_36XX_RATE(480000000, 160, 2, 2, 0),
 	PLL_36XX_RATE(432000000, 144, 2, 2, 0),
 	PLL_36XX_RATE(400000000, 200, 3, 2, 0),
-	PLL_36XX_RATE(394073130, 459, 7, 2, 49282),
+	PLL_36XX_RATE(394073128, 459, 7, 2, 49282),
 	PLL_36XX_RATE(333000000, 111, 2, 2, 0),
 	PLL_36XX_RATE(300000000, 100, 2, 2, 0),
 	PLL_36XX_RATE(266000000, 266, 3, 3, 0),
