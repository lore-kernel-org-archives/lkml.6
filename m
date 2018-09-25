Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44E9C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710812145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FFPJDP+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710812145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbeIYGJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:09:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41220 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbeIYGJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:09:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id z3-v6so5120894pgv.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 17:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=NkrXbnTUrMX6ge8VLAmm0aNyJUV9M1f05zfh8t/GqFs=;
        b=FFPJDP+Tn+7QKQmJVY3j0GnK3wCymkABYbXdyUE9uoBzbQc+o5JHwWSBWH6j7q+VtL
         bbI7t2SajhZrTO1T+otCrIviUKb387YnPPZ0rrJb+D+7G4yaREf6M7OVu9ctzNSs+8LB
         PD3doXMvd1/oT7viQG3l1YBwq7RbvDmXwKT+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NkrXbnTUrMX6ge8VLAmm0aNyJUV9M1f05zfh8t/GqFs=;
        b=t3ajKufqKddFD98sE8LhJYVoc0LmtKTGvQ6GW83RYc3QO5rh5/+BU9a9zgWxVayQRZ
         jcpmjp0ZjSSapIqf/u82vH5GgWqACPPl2YcNFKqUchU2v4lLiwqZD3hWUdzTWU8jC0Pq
         t/FMCtNULlZ+wpPW5qdyPplbR8bBk4RC1udQZCAHiNJbgGKuuH0yTEVFtWzGNsRrVhjS
         3VAr9yIy6ILRnFP0x8H/1S8KT0KGQVnBVFv4S3W0y7W0bkGC+J/RT5J27I9ZTb9GUMky
         iZ4/kALVg/fxsTDlkMnf55Y6rNhB4onsFExoIz3XrBvEf1y0UZTemgVbjadakzrGnf3t
         u2HQ==
X-Gm-Message-State: ABuFfoiTqN9CNDoSqnIWm+F8Qz/n4EOEIw9FQDv69V4hXA85bDtbyPad
        JLRgJIM8xXbcFM7qSUt87nsTxQ==
X-Google-Smtp-Source: ACcGV63zDqNuKEgH578JDLKSDpDllNLd4PY+ffldRK28/ODz3QflNPsLvLw/mDK/Va93eSnLAv5ZcA==
X-Received: by 2002:a63:6781:: with SMTP id b123-v6mr858939pgc.151.1537833871184;
        Mon, 24 Sep 2018 17:04:31 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c2-v6sm500056pfo.107.2018.09.24.17.04.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 17:04:30 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v2] dt-bindings: pinctrl: qcom-pmic-gpio: Add pms405 support
Date:   Mon, 24 Sep 2018 17:06:56 -0700
Message-Id: <20180925000656.23869-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

Add support for the PMS405 GPIO support to the Qualcomm PMIC GPIO
binding.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Dropped unnecessary driver update
- Updated subject

 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
index ffd4345415f3..ab4000eab07d 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
@@ -19,6 +19,7 @@ PMIC's from Qualcomm.
 		    "qcom,pm8998-gpio"
 		    "qcom,pma8084-gpio"
 		    "qcom,pmi8994-gpio"
+		    "qcom,pms405-gpio"
 
 		    And must contain either "qcom,spmi-gpio" or "qcom,ssbi-gpio"
 		    if the device is on an spmi bus or an ssbi bus respectively
@@ -91,6 +92,7 @@ to specify in a pin configuration subnode:
 		    gpio1-gpio26 for pm8998
 		    gpio1-gpio22 for pma8084
 		    gpio1-gpio10 for pmi8994
+		    gpio1-gpio11 for pms405
 
 - function:
 	Usage: required
-- 
2.18.0

