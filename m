Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16695C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A772080C
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JwcHictg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A772080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732363AbeKTKxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:53:24 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37007 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbeKTKxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:53:24 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so81679plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 16:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AZnBqhOMiV0x8Nts3mmKhJTa0g/gCMAi6Irs/PqEMVY=;
        b=JwcHictgaQkYNO5P54osc7Htns94V1a2fCcS3nVYhHh39UlFaXOyv9ocOdpZm7wRR2
         wNe5/2lv+d5d6Mttw+U0apMUuL1+YrCvm5hj38UpSDjfSo/rA6ppVgXlIxnjz1NIgDL2
         tiXkA9V6txndjxlGKMTbIszBPmvsSltELHCw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AZnBqhOMiV0x8Nts3mmKhJTa0g/gCMAi6Irs/PqEMVY=;
        b=gTlI/tUT/SxS2Qlh9knhrnd+3pRyh8TLqV7Dr1SF4WQlgGtSmnRXWeSFBo2e1CK1iM
         1Mw6K8BqzdDCo+4W9ePCXrHveYosg2bEXQEgrvlHRiOCgQ6NmI+qvIH5oVOPrBAuwDFZ
         utEjquS/lcaRlaoL+XoDnXvOA5Tr3H3lS6nuMiWGDkMPzlmHedPOc70Y9BHOfYjXrmOD
         RRLpmR4cC+5iqrDd0N3eJowMsSbfUmuBMJ1InxchOn2SYZ9EUSAGEvytPl3D5Xh5rpiA
         /QjjIs0KSQYDrGN8v3Ip+de1yHp+WtCoOetxJdbuRTuEjXaSbBFBMzEXRLhPeQsyYGh6
         6LGg==
X-Gm-Message-State: AA+aEWaPqzlhw7c3nYl8hm++gRM9AAZGmrwrGyzA2KxQHVldDAw1BeTa
        ELnZXQXuC4t/TUmDB0tjxrfRPA==
X-Google-Smtp-Source: AFSGD/U3rgSlM3Pcb0dVyysF2XF6NSyf7C0QgZ/k5D+l8/OP9yrKCBCZ+MTT1x83HpaLo+dMJruIHQ==
X-Received: by 2002:a17:902:be0e:: with SMTP id r14-v6mr14343114pls.23.1542673626775;
        Mon, 19 Nov 2018 16:27:06 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id z83-v6sm55240218pfi.4.2018.11.19.16.27.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 16:27:05 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, evgreen@chromium.org,
        swboyd@chromium.org, Dmitry Osipenko <digetx@gmail.com>,
        ryandcase@chromium.org, David Collins <collinsd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] regulator: core: Properly expose requested_microamps in sysfs
Date:   Mon, 19 Nov 2018 16:26:48 -0800
Message-Id: <20181120002654.1891-1-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "requested_microamps" sysfs attribute was only being exposed for
"current" regulators.  This didn't make sense.  Allow it to be exposed
always.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/regulator/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d7ffd7b12472..ff5ca185bb8f 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4565,10 +4565,6 @@ static umode_t regulator_attr_is_visible(struct kobject *kobj,
 	if (attr == &dev_attr_bypass.attr)
 		return ops->get_bypass ? mode : 0;
 
-	/* some attributes are type-specific */
-	if (attr == &dev_attr_requested_microamps.attr)
-		return rdev->desc->type == REGULATOR_CURRENT ? mode : 0;
-
 	/* constraints need specific supporting methods */
 	if (attr == &dev_attr_min_microvolts.attr ||
 	    attr == &dev_attr_max_microvolts.attr)
-- 
2.19.1.1215.g8438c0b245-goog

