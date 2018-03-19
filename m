Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtlKhTxQ8zDKGgABH4N1kv3VSS3WpHf78wPO7VsYDNiBpdAR7hqMSnJf586Cy1Ll8Ro2N3y
ARC-Seal: i=1; a=rsa-sha256; t=1521483886; cv=none;
        d=google.com; s=arc-20160816;
        b=bnNhmSiRmSZHh0h4EDzUSaieyvZio9lgijEtTc22Q822yrs6onKQyAfFQgZNbkg887
         RfDdZO8uTHmMWqDO9CMzJK8cdrnXgsioCL1+hifVnGgx59OdzSWW5UOMX/QiL73996iZ
         tbyTxlP6SiaMfHAsfaPIk+s1382vVNbLdhFVM6NF0psdb1xjr9X5NeAym7tJFKmxWPLr
         9TbsRGViglTdcTB21LvU0L7asSw6mbLT1q/qaZ8aBFFEuYHMCD9e8CwryLyNW90SJfM/
         8n6VzL4x6cjMckua9o8vn2Rj1ZTtb/IegeKLgdjuOKAn3a7V2CfVletU8Pk/3XfHDgMP
         L39g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jJcIzNGpqhTu4EcQkleIYW4XZH+7LZZMv9++QOVlE1M=;
        b=MfqzMahywZY03MjTQYau/YeUgUR4lRO9lKkzcUVt6E8b9BXjZCHVDvZcdcJ/DTMUJu
         lwLnZWxZ7QJ41IOgSPfOSknLS9B1NioSIt12eIFlqFJvfoTF9FK4ltJxPk/JlHaglTf9
         EoQYb+Ht7NH06/rzUJ9HjQ4T1exHII4YseBgnOGNtRx7gRQ3SryS2ZV1O46ySGuY2Dzu
         RHoss9o5obc1ZmGbugLQCO/4bRG0aBVyDpfps/ldKe4TeUVpLRi3NbHM+eXi8D3zqtL9
         scvWoJG1Voc/pLYZ8FIS91d6qDllsTY5CiA5h9B4c0SWBi4AQ+xo8kHWxeWMf+0xKgfm
         /2+g==
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
Subject: [PATCH 4.9 154/241] pwm: tegra: Increase precision in PWM rate calculation
Date: Mon, 19 Mar 2018 19:06:59 +0100
Message-Id: <20180319180757.557584913@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390982053089635?=
X-GMAIL-MSGID: =?utf-8?q?1595391488366735260?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -76,6 +76,7 @@ static int tegra_pwm_config(struct pwm_c
 	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	unsigned long long c = duty_ns;
 	unsigned long rate, hz;
+	unsigned long long ns100 = NSEC_PER_SEC;
 	u32 val = 0;
 	int err;
 
@@ -95,9 +96,11 @@ static int tegra_pwm_config(struct pwm_c
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
