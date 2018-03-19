Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELueEPv2hQzO2TMv2BZXMNpha06jgAkvD7nO1uC9jd22lgFcFdcsO3HPS3R8qmFd/yoVBkFh
ARC-Seal: i=1; a=rsa-sha256; t=1521483404; cv=none;
        d=google.com; s=arc-20160816;
        b=CP/RI4yxl/qHdeHLBBf14szO7EVU/MeKaqVAgeFEusVElJqw47EAQCXqmhCbr4yfIo
         gi3cz/BoH7LOrwO4W41fRWd8S/5ZikSnpsq3kaq+3lm0okh3dqh/9IWxcoNWiLzDaCup
         vIsza1Lr2M+D7UMJRulsPRuMthVbPr19Edxql1Ait+JDAUuzq57J+gKYmohWD0Mofg2w
         r1jgzNfCQZC5ecIf7Rq7kGO6X/yboGBKG3PBCJWYJZsbPpQuYCMml0bigqr4Q/KpUa2R
         S15JARV/1NBLEnAzjPnbWXsf0NHUTjidywD/Fb6X6Ru63zgadK3/foljkRwE0ts0lvIB
         zSTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xg34jKoDp/tDSzp3DNhYLA2hTuse+yZTvYGBOGNpW1c=;
        b=L42PQ8R3Hxf0S7mxR8fHpop4/WOgcCRwX3zLG3yd2WcIXrb3b6LaCgvxGQUkhrRN8Y
         LUZ5+xCl/eIbuOVHDwOXjK+aejI5W9BDaHolvNTkw12KAcZLBMi0t/A8ctdsnVl63pXr
         5mv93zGfxzJ+p9rMYOzFx7/WDjC563RAyywNIXxLhulhGD43KvHCnHOYNBnlhkbbmmps
         wjZqaZNn9ytiTkCcZC5H/tD3tdoREEu+I9AdlUClnHHMMqzmxBvJEz136mfJi4Q8G6Yx
         lBnIvC59ZoZNF3/Hd9xv2+yvevRhxQpdNLmQUF37NoFX+s8FRvH1mCrSYuxdQf1u4/Lj
         wFVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 077/134] pwm: tegra: Increase precision in PWM rate calculation
Date: Mon, 19 Mar 2018 19:06:00 +0100
Message-Id: <20180319171900.407368935@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390982053089635?=
X-GMAIL-MSGID: =?utf-8?q?1595390982053089635?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Laxman Dewangan <ldewangan@nvidia.com>


[ Upstream commit 250b76f43f57d578ebff5e7211eb2c73aa5cd6ca ]

The rate of the PWM calculated as follows:

	hz = NSEC_PER_SEC / period_ns;
 	rate = (rate + (hz / 2)) / hz;

This has the precision loss in lower PWM rate.

Change this to have more precision as:

	hz = DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC * 100, period_ns);
	rate = DIV_ROUND_CLOSEST(rate * 100, hz)

Example:

1. period_ns = 16672000, PWM clock rate is 200 KHz.

	Based on old formula
		hz = NSEC_PER_SEC / period_ns
		   = 1000000000ul/16672000
		   = 59 (59.98)
		rate = (200K + 59/2)/59 = 3390

	Based on new method:
		hz = 5998
		rate = DIV_ROUND_CLOSE(200000*100, 5998) = 3334

	If we measure the PWM signal rate, we will get more accurate
	period with rate value of 3334 instead of 3390.

2.  period_ns = 16803898, PWM clock rate is 200 KHz.

	Based on old formula:
		hz = 59, rate = 3390

	Based on new formula:
		hz = 5951, rate = 3360

	The PWM signal rate of 3360 is more near to requested period
	than 3333.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pwm/pwm-tegra.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -69,6 +69,7 @@ static int tegra_pwm_config(struct pwm_c
 	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	unsigned long long c;
 	unsigned long rate, hz;
+	unsigned long long ns100 = NSEC_PER_SEC;
 	u32 val = 0;
 	int err;
 
@@ -87,9 +88,11 @@ static int tegra_pwm_config(struct pwm_c
 	 * cycles at the PWM clock rate will take period_ns nanoseconds.
 	 */
 	rate = clk_get_rate(pc->clk) >> PWM_DUTY_WIDTH;
-	hz = NSEC_PER_SEC / period_ns;
 
-	rate = (rate + (hz / 2)) / hz;
+	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
+	ns100 *= 100;
+	hz = DIV_ROUND_CLOSEST_ULL(ns100, period_ns);
+	rate = DIV_ROUND_CLOSEST(rate * 100, hz);
 
 	/*
 	 * Since the actual PWM divider is the register's frequency divider
