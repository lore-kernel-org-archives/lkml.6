Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752973AbeEVMI3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 08:08:29 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:24301 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbeEVMIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 08:08:22 -0400
X-IronPort-AV: E=Sophos;i="5.49,430,1520924400";
   d="scan'208";a="11781815"
From: Claudiu Beznea <claudiu.beznea@microchip.com>
To: <thierry.reding@gmail.com>, <shc_work@mail.ru>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <corbet@lwn.net>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@free-electrons.com>
CC: <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 2/9] pwm: clps711x: populate PWM mode in of_xlate function
Date: Tue, 22 May 2018 15:07:06 +0300
Message-ID: <1526990833-30707-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526990833-30707-1-git-send-email-claudiu.beznea@microchip.com>
References: <1526990833-30707-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Populate PWM mode in of_xlate function to avoid pwm_apply_state() failure.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-clps711x.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index 26ec24e457b1..d742e8e375c7 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -109,10 +109,18 @@ static const struct pwm_ops clps711x_pwm_ops = {
 static struct pwm_device *clps711x_pwm_xlate(struct pwm_chip *chip,
 					     const struct of_phandle_args *args)
 {
+	struct pwm_device *pwm;
+
 	if (args->args[0] >= chip->npwm)
 		return ERR_PTR(-EINVAL);
 
-	return pwm_request_from_chip(chip, args->args[0], NULL);
+	pwm = pwm_request_from_chip(chip, args->args[0], NULL);
+	if (IS_ERR(pwm))
+		return pwm;
+
+	pwm->args.mode = pwm_mode_get_valid(chip, pwm);
+
+	return pwm;
 }
 
 static int clps711x_pwm_probe(struct platform_device *pdev)
-- 
2.7.4
