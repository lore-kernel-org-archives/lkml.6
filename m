Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F88C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82DE20879
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jq/y8nsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82DE20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeI2OAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 10:00:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38336 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbeI2OAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 10:00:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id r77-v6so6018686pgr.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 00:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=J+ymQzV0hrr4au/jEMcE99duAlPeokBN3DOzWbC7rno=;
        b=jq/y8nsA8g0TBBDyXmm3NiHXUmmzRZpNgh9aeP8mhxRkF1PV8rntwnZp1lv+WOetkU
         UzQlSFmn+AT9dh+LED+XnEEYEVvBjy6Ln4GxoLEECZQAYdrFX6zmQKWWx1Z0NRqAo+Hn
         PgwsY8WsurWbcTnzz0565XEXqwBpIkT+c3/JY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J+ymQzV0hrr4au/jEMcE99duAlPeokBN3DOzWbC7rno=;
        b=mewzQmZp0opgeLXrPQ6smpM9Llogr26svDUQWsPqJjYmhkVE62Zz5wUoWNeP+h7h4p
         RnqRJY20Wm0WQiG3Q//jPh0rwmgh7l9yTN9m/o+yg16oU7E1eMTqxAJ7UyJofpyV2cOz
         EnZ9VIoifGvsVPmi0Q//VhytQv38hIrm66PRdNcGFf2mJnuD5pXswfVuXgvCFzXIMttB
         N6VJRtHodgbWCbuAiuWWu76C+lR2MWcqdLIH12ISgcZup7Ro6agIZupsl1OlC/p3ME32
         W80hLD+IyUi5E3GREXH1Aa0Zgwfqq2UfRhQGsu9x8Y7BOmkT2ocgvy8cD6ln5aevErcN
         T7fg==
X-Gm-Message-State: ABuFfojzNRNF6tQt46zc8RkTxLQH5ZolS1NK67Bqi7+hvGEwnFAEDRC5
        cjQZqTQVBX/eaJHUq1u66HZO
X-Google-Smtp-Source: ACcGV621vksiYeJo4aIaH1u9Z54eKorP+hRV3T6M+pFqU/DtFCn/3g4lng68OX8VBM91sf++vvP3ag==
X-Received: by 2002:a63:a40a:: with SMTP id c10-v6mr1902901pgf.140.1538206377156;
        Sat, 29 Sep 2018 00:32:57 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:717:b0f2:f0af:8cc:da39:e2c3])
        by smtp.gmail.com with ESMTPSA id c28-v6sm15993154pfk.48.2018.09.29.00.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 00:32:56 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     afaerber@suse.de, joe@perches.com
Cc:     linux-arm-kernel@lists.infradead.org, pn@denx.de,
        sravanhome@gmail.com, robh@kernel.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] MAINTAINERS: Update clock binding entry for Actions Semi Owl SoCs
Date:   Sat, 29 Sep 2018 13:02:44 +0530
Message-Id: <20180929073244.7091-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit d0e45d686a3e ("dt-bindings: clock: Add S700 support for Actions
Semi Soc's")'

renamed the clock binding for Actions Semi Owl SoCs from
actions,s900-cmu.txt to actions,owl-cmu.txt inorder to accommodate all
members of Owl family SoCs. Hence, update the relevant entry in
MAINTAINERS file.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fff353db7536..e9d6ce3243ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1191,7 +1191,7 @@ F:	drivers/soc/actions/
 F:	include/dt-bindings/power/owl-*
 F:	include/linux/soc/actions/
 F:	Documentation/devicetree/bindings/arm/actions.txt
-F:	Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
+F:	Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
 F:	Documentation/devicetree/bindings/dma/owl-dma.txt
 F:	Documentation/devicetree/bindings/i2c/i2c-owl.txt
 F:	Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
-- 
2.17.1

