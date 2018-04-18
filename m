Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeDRRs6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 13:48:58 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43031 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752116AbeDRRs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 13:48:56 -0400
X-Google-Smtp-Source: AIpwx4+qTISSMi6NyHd8fA7+xQ9N41Pyl7RjwbVYXwBahALpZGHPp2MOq+lWmxi5If2SDnEJ8UYWkQ==
From: srinivas.kandagatla@linaro.org
To: broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: msm8916-wcd-analog: use threaded context for mbhc events
Date: Wed, 18 Apr 2018 18:46:37 +0100
Message-Id: <20180418174637.24041-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

As snd_soc_jack_report() can sleep, move handling of mbhc events to a
thread context rather than in interrupt context.

Fixes: de66b3455023 ('ASoC: codecs: msm8916-wcd-analog: add MBHC support')
Reported-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 12ee83d52405..b7cf7cce95fe 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -1187,7 +1187,8 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 		return irq;
 	}
 
-	ret = devm_request_irq(dev, irq, pm8916_mbhc_switch_irq_handler,
+	ret = devm_request_threaded_irq(dev, irq, NULL,
+			       pm8916_mbhc_switch_irq_handler,
 			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
 			       IRQF_ONESHOT,
 			       "mbhc switch irq", priv);
@@ -1201,7 +1202,8 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 			return irq;
 		}
 
-		ret = devm_request_irq(dev, irq, mbhc_btn_press_irq_handler,
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+				       mbhc_btn_press_irq_handler,
 				       IRQF_TRIGGER_RISING |
 				       IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				       "mbhc btn press irq", priv);
@@ -1214,7 +1216,8 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 			return irq;
 		}
 
-		ret = devm_request_irq(dev, irq, mbhc_btn_release_irq_handler,
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+				       mbhc_btn_release_irq_handler,
 				       IRQF_TRIGGER_RISING |
 				       IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				       "mbhc btn release irq", priv);
-- 
2.16.2
