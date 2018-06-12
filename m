Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 03800C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F4F208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JqbR2v11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F4F208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935005AbeFLXGJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 19:06:09 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37368 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934598AbeFLXGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 19:06:07 -0400
Received: by mail-pg0-f68.google.com with SMTP id r21-v6so287202pgv.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 16:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pvItt6oAFBkADy3l+CzHSJ7RBcRJ9eSggzIXENWZdLY=;
        b=JqbR2v11vk90IJctqnepj/VQlMooGMhdSyJQRgtliOPwfNc7Ia4UvvZkXeBvKSHjil
         m6kN4bfHKtViKEo4OaJG4YZ0OrLcmmaJF6dxHE2x5Q/DMx9ChvijIs9aGIrWtNLWP3Tc
         tTJi4cQWaPRm9WKPzZxrpgSpZtqXinKNEMl14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pvItt6oAFBkADy3l+CzHSJ7RBcRJ9eSggzIXENWZdLY=;
        b=FYabGNVMB0KsX/F3pJmM/iWcAZwseMX969RIm72mCmRoTc6IWZLE/GRdv0JMHqwf0r
         9uHDoKgMR6Z9zGCiKBiKWh2kPqVtGvsnuGNHXAmAcKtksKhQeG99TD4iyvqfCDail4A0
         hAGFeI8efA0GsheRqTyREN1fTZUv4ABOz5QoKF0VQT/Air/EOLQ2+WqQstAHSS40LvxU
         BQbUbs0J+mSMR3j0d4gPSoyRG4ERvbVjXeG3q5lWtxZCdfraC1Ubs2DvvevuF3WTD8SV
         ILSctigSZC6wi5PanJXCyqfHH9RFFNz0dPZDPqkrESacDUTLr6w58Mh2ZvavlfTQpD4S
         ekhA==
X-Gm-Message-State: APt69E0AM6TCMTVKnFP39ZUb/1QTTKFNmPnkXIlf4HjLekGG06x47mN5
        n/rq6utq731+j9sBGRl2DZXBPg==
X-Google-Smtp-Source: ADUXVKIyO92W5ARjUY+dReZPu647Lr+F/jWFwodTnxtiaWQ6MPySTBok7jcckBbjEohsdIS40IxiGw==
X-Received: by 2002:a63:715d:: with SMTP id b29-v6mr1960858pgn.325.1528844767175;
        Tue, 12 Jun 2018 16:06:07 -0700 (PDT)
Received: from swboyd.mtv.corp.google.com ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id b22-v6sm1365358pfi.144.2018.06.12.16.06.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 16:06:06 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        devicetree@vger.kernel.org
Subject: [PATCH] pinctrl: qcom: spmi-gpio: Add pm8998 and pm8005 to binding
Date:   Tue, 12 Jun 2018 16:06:04 -0700
Message-Id: <20180612230604.137880-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the binding for two more PMICs supported by the same driver.
While we're here, remove the duplicate pmi8994 lines because that
support got merged twice.

Cc: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../devicetree/bindings/pinctrl/qcom,pmic-gpio.txt          | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
index 5c25fcb29fb5..ffd4345415f3 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
@@ -7,6 +7,7 @@ PMIC's from Qualcomm.
 	Usage: required
 	Value type: <string>
 	Definition: must be one of:
+		    "qcom,pm8005-gpio"
 		    "qcom,pm8018-gpio"
 		    "qcom,pm8038-gpio"
 		    "qcom,pm8058-gpio"
@@ -15,7 +16,7 @@ PMIC's from Qualcomm.
 		    "qcom,pm8921-gpio"
 		    "qcom,pm8941-gpio"
 		    "qcom,pm8994-gpio"
-		    "qcom,pmi8994-gpio"
+		    "qcom,pm8998-gpio"
 		    "qcom,pma8084-gpio"
 		    "qcom,pmi8994-gpio"
 
@@ -78,6 +79,7 @@ to specify in a pin configuration subnode:
 	Value type: <string-array>
 	Definition: List of gpio pins affected by the properties specified in
 		    this subnode.  Valid pins are:
+		    gpio1-gpio4 for pm8005
 		    gpio1-gpio6 for pm8018
 		    gpio1-gpio12 for pm8038
 		    gpio1-gpio40 for pm8058
@@ -86,7 +88,7 @@ to specify in a pin configuration subnode:
 		    gpio1-gpio44 for pm8921
 		    gpio1-gpio36 for pm8941
 		    gpio1-gpio22 for pm8994
-		    gpio1-gpio10 for pmi8994
+		    gpio1-gpio26 for pm8998
 		    gpio1-gpio22 for pma8084
 		    gpio1-gpio10 for pmi8994
 
-- 
Sent by a computer through tubes

