Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24931C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C342075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KMUjwRZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C342075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935814AbeFRShG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:37:06 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42117 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935648AbeFRShE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:37:04 -0400
Received: by mail-pl0-f68.google.com with SMTP id w17-v6so9491439pll.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 11:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OMFMi5fcJ7dj1rJGD2+w2YYPlVEf5YMSNf4ukEvDuS4=;
        b=KMUjwRZUbliUTHx+l+B4k0FfgTGgydXX7kdBfR0NtcQSbrR2bOPTq2depYYzak4eLP
         csaccm77BtaYgnPzVL9hmwajG5RNyCk9oOBy6j/xwHPKe8W4ABnD1fPtZFQA13PBwiiR
         GJQ3TTDibOR4HptkqL7nj8OsDFx1cQKYdCX2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OMFMi5fcJ7dj1rJGD2+w2YYPlVEf5YMSNf4ukEvDuS4=;
        b=t2iOfaLIM6Ae7A9NQSLBDpIznhhJ7AMkQBSh85dRYBs5CXup5qWgcocrTnuEjmM+N4
         ZBDLR/NKuEKjxfJXkvGOo0BEslv9qv8MDAkFTsQNH4PCZi1Xk4Q2JpP0WIsmp7KTThZ7
         9KpZ3X45gXpUkWGAwSeE8NJXR77sCWtzCYoAI06EjwOJQJwOhKf5GG4wV/ZkL4fONr5N
         +b6zDV5JIyP8MOIgQ26c/2m1aoTisg/oGvtMIVGQ88I6qTOFHtcIellFA9DRRYNTSon8
         th7rYQ9V5wJpuSDNSIgOziWU5NFEQxP8tsSw+ivySi+JK3ENxFYnH3emBYTZkr547vw9
         pDgg==
X-Gm-Message-State: APt69E0VwkGdVc74ajZlPRhLwhQZWvDAOdVnnjIy3XTM00/SgrWlm7ig
        KhHh9/W+bENeimPySHyk9Cd2Xw==
X-Google-Smtp-Source: ADUXVKL+bwkP/HD8I1A9IEJBgdsCIhSmdSMG001CD1DSQcPIuNWzigfXB2dfIU3G8XLRYaNV6i74XQ==
X-Received: by 2002:a17:902:59ce:: with SMTP id d14-v6mr15320379plj.253.1529347024352;
        Mon, 18 Jun 2018 11:37:04 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id a23-v6sm18568986pgd.85.2018.06.18.11.37.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 11:37:03 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     andy.gross@linaro.org
Cc:     tdas@codeaurora.org, collinsd@codeaurora.org, sboyd@kernel.org,
        ilina@codeaurora.org, broonie@kernel.org, rplsssn@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drivers: qcom: rpmh-rsc: Check cmd_db_ready() to help children
Date:   Mon, 18 Jun 2018 11:36:52 -0700
Message-Id: <20180618183652.62249-1-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Children of RPMh will need access to cmd_db.  Rather than having each
child have code to check if cmd_db is ready let's add the check to
RPMh.

With this we'll be able to remove this boilerplate code from
clk-rpmh.c and qcom-rpmh-regulator.c.  Neither of these files has
landed upstream yet but patches are pretty far along.

===
This code is based upon v11 of Lina and Raju's RPMh series.

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Lina Iyer <ilina@codeaurora.org>
---

Changes in v2:
- 1 space after a period as per Lina

 drivers/soc/qcom/rpmh-rsc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 144a058407c0..c0f9cec92b13 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
+#include <soc/qcom/cmd-db.h>
 #include <soc/qcom/tcs.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
@@ -621,6 +622,18 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	struct rsc_drv *drv;
 	int ret, irq;
 
+	/*
+	 * Even though RPMh doesn't directly use cmd-db, all of its children
+	 * do. To avoid adding this check to our children we'll do it now.
+	 */
+	ret = cmd_db_ready();
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Command DB not available (%d)\n",
+									ret);
+		return ret;
+	}
+
 	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
 	if (!drv)
 		return -ENOMEM;
-- 
2.18.0.rc1.244.gcf134e6275-goog

