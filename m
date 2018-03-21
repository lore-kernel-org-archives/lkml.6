Return-Path: <rrajk@nvidia.com>
X-Google-Smtp-Source: AG47ELu/4R+QgcBgvFQhUryGowN0SLPBolnh+GYoOdYS0T8C1+LIh2o11pnRlaw1zWJcRoKZ7Nxe
ARC-Seal: i=1; a=rsa-sha256; t=1521607251; cv=none;
        d=google.com; s=arc-20160816;
        b=BO8qDY3CXXx52P0ifvwCw53qDkrmifL3xWmF1LqtuwNZUN6o7tiIw+ShBUO3vJYonb
         autWIzI0M1N7RVurYIiXAzgSVpthTiK7vMKVWTizg70pYVTweLmEwF2QlE0gM9MAu6Oi
         gV3je5b8LIZm5+aJLZaB/nOSTePV6iL1rbQ+0UkiG+O9VgogJG6incYnYyq5LP8BghXn
         yNd4jn90SH09QIkNo85VplIc9f45Q4fSShaiXY1v1WNnzkuy0oxa7axORB406yhIHx1b
         ZYltzIU76wRq9TfRmD0Rsb/budZuCYzDTJJ69yOxVuhnxf3gduetBdJ995p6//Ee450Y
         gWRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=ZJ9UkHPQWCh7rvQRwEwtiwH5JMOQuAQuSx32xVnaqsA=;
        b=s7I7ZBJG2p3SzR+t0pHCgyYJpiW1LVB1RoW1iNaZl+P+QCiS4KEhOrKVixhYAWC/6H
         4FWKSvi9CRAIzkkJvasR7fNGuAzp8MC59mpcvDzUkZx9xSm61SS4RaaNngnz6b4scmVi
         IKkJ9NqJjVEAyON2HWl8zZQ6TTPykbOZXg7gsy4QPqNHzEQkId18Hnr0GNDUj2EsiGlt
         v3uQuZjCZLsf/8VMXOmaL0mUeVJDik4bcWUvo8LvL5UYPgBpk6vMCu3BYJtkGY70Ubed
         iur9lwaZIF95RTAsgRzeSbIDSLskaxjr0vSUVkWxRKWeQY8V/rax5O4whjCfoL6C1kZa
         B6iw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.65 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.65 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate102.nvidia.com on Tue, 20 Mar 2018 21:40:46 -0700
From: Rajkumar Rampelli <rrajk@nvidia.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <jdelvare@suse.com>, <linux@roeck-us.net>,
	<corbet@lwn.net>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
	<kstewart@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
	<pombredanne@nexb.com>, <mmaddireddy@nvidia.com>, <mperttunen@nvidia.com>,
	<arnd@arndb.de>, <timur@codeaurora.org>, <andy.gross@linaro.org>,
	<xuwei5@hisilicon.com>, <elder@linaro.org>, <heiko@sntech.de>,
	<krzk@kernel.org>, <ard.biesheuvel@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <ldewangan@nvidia.com>,
	<rrajk@nvidia.com>
Subject: [PATCH V2 1/9] pwm: core: Add support for PWM HW driver with pwm capture only
Date: Wed, 21 Mar 2018 10:10:36 +0530
Message-ID: <1521607244-29734-2-git-send-email-rrajk@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595520845385709681?=
X-GMAIL-MSGID: =?utf-8?q?1595520845385709681?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add support for pwm HW driver which has only capture functionality.
This helps to implement the PWM based Tachometer driver which reads
the PWM output signals from electronic fans.

PWM Tachometer captures the period and duty cycle of the PWM signal

Add conditional checks for callabacks enable(), disable(), config()
to check if they are supported by the client driver or not. Skip these
callbacks if they are not supported.

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---

V2: Added if conditional checks for pwm callbacks since drivers may
    implements only pwm capture functionality.

 drivers/pwm/core.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 1581f6a..f70fe68 100644
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
 
@@ -495,7 +499,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
 			 * ->apply().
 			 */
 			if (pwm->state.enabled) {
-				pwm->chip->ops->disable(pwm->chip, pwm);
+				if (pwm->chip->ops->disable)
+					pwm->chip->ops->disable(pwm->chip, pwm);
 				pwm->state.enabled = false;
 			}
 
@@ -509,22 +514,26 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
 
 		if (state->period != pwm->state.period ||
 		    state->duty_cycle != pwm->state.duty_cycle) {
-			err = pwm->chip->ops->config(pwm->chip, pwm,
+			if (pwm->chip->ops->config) {
+				err = pwm->chip->ops->config(pwm->chip, pwm,
 						     state->duty_cycle,
 						     state->period);
-			if (err)
-				return err;
+				if (err)
+					return err;
+			}
 
 			pwm->state.duty_cycle = state->duty_cycle;
 			pwm->state.period = state->period;
 		}
 
 		if (state->enabled != pwm->state.enabled) {
-			if (state->enabled) {
+			if (state->enabled && pwm->chip->ops->enable) {
 				err = pwm->chip->ops->enable(pwm->chip, pwm);
 				if (err)
 					return err;
-			} else {
+			}
+
+			if (!state->enabled && pwm->chip->ops->disable) {
 				pwm->chip->ops->disable(pwm->chip, pwm);
 			}
 
-- 
2.1.4
