Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680CCC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F4320852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F4320852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936887AbeFRJKU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:10:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33690 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966946AbeFRIa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:30:26 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C9370C7A;
        Mon, 18 Jun 2018 08:30:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 035/189] ASoC: msm8916-wcd-analog: use threaded context for mbhc events
Date:   Mon, 18 Jun 2018 10:12:11 +0200
Message-Id: <20180618081210.688431124@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit a8419a0cd98ddf628a9e38a92110af7cc650dde7 ]

As snd_soc_jack_report() can sleep, move handling of mbhc events to a
thread context rather than in interrupt context.

Fixes: de66b3455023 ('ASoC: codecs: msm8916-wcd-analog: add MBHC support')
Reported-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -1184,7 +1184,8 @@ static int pm8916_wcd_analog_spmi_probe(
 		return irq;
 	}
 
-	ret = devm_request_irq(dev, irq, pm8916_mbhc_switch_irq_handler,
+	ret = devm_request_threaded_irq(dev, irq, NULL,
+			       pm8916_mbhc_switch_irq_handler,
 			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
 			       IRQF_ONESHOT,
 			       "mbhc switch irq", priv);
@@ -1198,7 +1199,8 @@ static int pm8916_wcd_analog_spmi_probe(
 			return irq;
 		}
 
-		ret = devm_request_irq(dev, irq, mbhc_btn_press_irq_handler,
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+				       mbhc_btn_press_irq_handler,
 				       IRQF_TRIGGER_RISING |
 				       IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				       "mbhc btn press irq", priv);
@@ -1211,7 +1213,8 @@ static int pm8916_wcd_analog_spmi_probe(
 			return irq;
 		}
 
-		ret = devm_request_irq(dev, irq, mbhc_btn_release_irq_handler,
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+				       mbhc_btn_release_irq_handler,
 				       IRQF_TRIGGER_RISING |
 				       IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				       "mbhc btn release irq", priv);


