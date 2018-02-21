Return-Path: <rrajk@nvidia.com>
X-Google-Smtp-Source: AH8x226bxMr9plAq/pnm6GwVmeX5HS4Dp2VbIb53+dDqTyPfPbGb1QVvhonNLNk5lplLdBOYANVk
ARC-Seal: i=1; a=rsa-sha256; t=1519196370; cv=none;
        d=google.com; s=arc-20160816;
        b=Z0dTftShIX6wWmAOBsm88HtILzOW2xK6fV3CSe8a1Z8FUgwG4d7Zlg6xiTtaBAtg+3
         fZfWNv44fNiljUZJXU9kEd4cffY/iJG9o+iYXpSBuQokHer/1u2WcvmRDLWW6aDAXzNR
         2AuVSkYjX876xLl1hegRp7c4RltKOBGB2LA7L5Bueck6QYe9XmmIsYAjOHWI0WnATS0e
         hgj39tmrWxg55bUnK/bzrXEz/8OfSVflx177w3GMtpze8Cssa+Dg8MIpYT56G7LjYZiC
         dnQcA/feWyf6yx9mVJvayD+ehELWkXsWu9N18A+uVrYKRKVIAJbvlhPFwO/grfrXEhKm
         0Ocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=7ogMPazthmwllAp7FzUqgI2texCeT7/jhmaE71noClo=;
        b=h7pal9N/7U1L7DK9oMJHGl/Sxlbx3s96PqsMPf6S/sxKAI6ZKsEnhHPPrde2WeAEvF
         AcluiV+C52GX4Sw+Hhh6iurR+nzjwfIp8NOAWU8Vb6iXt1yVZOQnTAWT2DRrGz1WmqeH
         pBTlPNeUjWoxVqkSvzjvtypiG2t6/3KTsEu8gk7QDVp/jC2XgI/t80tVc5hXHWH8salQ
         R7AIrtJSYF9/b6Zu4/JtzKyxEVMDqSuTEdmARm/WP4OmK0YSBxouWefjty9Ej5dfuXnJ
         VarNHBrCf8nVsBEbzuHHBiZ3Ctx2SyWWt+jnt4orA4sC4C8a67hEzSa6Wnq+3c8x/R7D
         ud4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.143 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.143 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Tue, 20 Feb 2018 22:59:28 -0800
From: Rajkumar Rampelli <rrajk@nvidia.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <jdelvare@suse.com>, <linux@roeck-us.net>,
	<corbet@lwn.net>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
	<kstewart@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
	<pombredanne@nexb.com>, <mmaddireddy@nvidia.com>, <mperttunen@nvidia.com>,
	<arnd@arndb.de>, <gregory.clement@free-electrons.com>,
	<timur@codeaurora.org>, <andy.gross@linaro.org>, <xuwei5@hisilicon.com>,
	<elder@linaro.org>, <heiko@sntech.de>, <krzk@kernel.org>,
	<ard.biesheuvel@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <ldewangan@nvidia.com>,
	<rrajk@nvidia.com>
Subject: [PATCH 01/10] pwm: core: Add support for PWM HW driver with pwm capture only
Date: Wed, 21 Feb 2018 12:28:50 +0530
Message-ID: <1519196339-9377-2-git-send-email-rrajk@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
References: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592992853007888587?=
X-GMAIL-MSGID: =?utf-8?q?1592992853007888587?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add support for pwm HW driver which has only capture functionality.
This helps to implement the PWM based Tachometer driver which reads
the PWM output signals from electronic fans.

PWM Tachometer captures the period and duty cycle of the PWM signal

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---
 drivers/pwm/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 1581f6a..87d14c9 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -246,6 +246,10 @@ static bool pwm_ops_check(const struct pwm_ops *ops)
 	if (ops->apply)
 		return true;
 
+	/* driver supports capture operation */
+	if (ops->capture)
+		return true;
+
 	return false;
 }
 
-- 
2.1.4
