Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0621AC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B952064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fAwBti8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B952064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeH3DMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 23:12:43 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44671 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbeH3DMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 23:12:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id ba4-v6so2946562plb.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 16:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UMxQLmkO8a9j8OOFLcsacU8qmnqmoLfX8+VaMPjiXCw=;
        b=fAwBti8OJkSoz9X+d2wPh9zaSqldM1Av91lq3O8owb7Qv9L63h3Mcjc5MW7fArtIC7
         w6NIj6nfQrfXCx5xqbW2rNPg5zqdDmdJ6MX1OJ3dIjD9cwhFCnOe2IOWSCrPAONkdDHm
         DM4afhKbZxHxkqrl29f+BLqimUv6zWA0SMNto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UMxQLmkO8a9j8OOFLcsacU8qmnqmoLfX8+VaMPjiXCw=;
        b=oVnj9jf7FOAwY/4pl58z6x1MbG8kdv2mFReyOMhKoa8dtNZLwK+yCw2eG05nRNasxO
         EtOkBnD82PqBdnqTptHcUCH9gdkSC9aiyHxHErq4aJHoSxViQqOzG+mmddfJOowUrf8v
         DY1jOqLkSJHiyo5pvFF9Qpw9tHdB/UzGDYnbyUSGjTM6/w1Q6+kn+gOTnMH4I7C2YD7h
         n3KfYkKQeiQkAW2tQ8SmBOeRszIFscFKwJ1ggd2wJ0eO9EZAbIEx824LPvJuXUUO4n5T
         487OtnbmLhAqUJeQKU1XnReLjqOEordbLg+b2G1r6tsyl121ipEixpezQLj7TyObVya9
         /TNw==
X-Gm-Message-State: APzg51DJOOpQX1b4pVpvQ1e0mKCRwv/CO84pRIeDZXRAORxWVhaejBkE
        ccTBLL8XnrAb3NhxBhl0qH/FTA==
X-Google-Smtp-Source: ANB0VdZkOVKV5x+p6sWZ0oQfkMpn/WWFzjo5bXoeKXrlAwjZWtGZhMIZeVsZJMx9UvgUWoM12M/I5w==
X-Received: by 2002:a17:902:c6b:: with SMTP id 98-v6mr7776455pls.233.1535584409442;
        Wed, 29 Aug 2018 16:13:29 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w69-v6sm14035404pgd.37.2018.08.29.16.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 16:13:28 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc:     Sricharan R <sricharan@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Craig Tatlor <ctatlor97@gmail.com>
Subject: [PATCH 3/3] dt-bindings: firmware: scm: Add MSM8998 and SDM845
Date:   Wed, 29 Aug 2018 16:15:05 -0700
Message-Id: <20180829231505.22660-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829231505.22660-1-bjorn.andersson@linaro.org>
References: <20180829231505.22660-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the compatible/clock handling is reworked add compatibles for
MSM8998 and SDM845 to the SCM binding.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
index 1c8e24530f7c..41f133a4e2fa 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
@@ -14,7 +14,9 @@ Required properties:
  * "qcom,scm-msm8960"
  * "qcom,scm-msm8974"
  * "qcom,scm-msm8996"
+ * "qcom,scm-msm8998"
  * "qcom,scm-ipq4019"
+ * "qcom,scm-sdm845"
  and:
  * "qcom,scm"
 - clocks: Specifies clocks needed by the SCM interface, if any:
-- 
2.18.0

