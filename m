Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DC3C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BB821580
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jVNUuhuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BB821580
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387667AbeHNTy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:54:57 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40689 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387621AbeHNTy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:54:56 -0400
Received: by mail-pl0-f68.google.com with SMTP id s17-v6so8561330plp.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 10:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sGksIB8cizHaKApnUuX97vs90VO3iPXhSR8JaN7x2IY=;
        b=jVNUuhuLaWAUk3mi7QZkJiZY6h5l7ESWMHbmr57casDI1YZPMFj/AhbQ9IUXs4rAfF
         z5txz22DhcqC3J/D+h566gKxXRo+kgsz58HycewKR1jwrBWWUEVvyuZm8l7KwHno/75P
         5n76nx20yMVukneKSO2SeJAVkXU5f1W9E4M9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sGksIB8cizHaKApnUuX97vs90VO3iPXhSR8JaN7x2IY=;
        b=tmEkEBjE+EbI00TDvnbjEEcT5F1uKclP3RCk3EwS0/OTFtp43Yzna6V5r6mr5mHRa9
         f555MY86+SHSrfRvnYy2QB7ZDzsrB1rNAHaUk9U+feT3sZMQ3qycYOriv6RZ7b602egP
         TqRe6jWRmFdI7ixWN5sjcHUZhZiGRdbX2HCS1u25yB/Ml07Ihk85m3eRwnCb/FGEHQAe
         qtcV7PWgeX0Ks03Ciy2UsJXVBmodm3ieVgNzeBYomYQnqgb1QZTnlf1oDcjTFbAj2L7s
         rrfWmEjHexmc5FxiOZvbDqj5SdaEpCkj6/8wvw9wQH2d4qjWRZoH58ReZiQIediuZSNT
         6e8Q==
X-Gm-Message-State: AOUpUlGuMF+g5d+cE4deWJFf/1DDYfQLMY+ix2Bw9tyttn1thNOBhn8Z
        oqaeqbgiVrk3nB0t1drGVuilig==
X-Google-Smtp-Source: AA+uWPxYNurYc+HnkMKAZMixu8wqvH0Cc03EYWd/cEzk5rSegr6Ch+ARZQ9ph7GiX/qz8SkIpEdo1A==
X-Received: by 2002:a17:902:8f8c:: with SMTP id z12-v6mr20890675plo.4.1534266416567;
        Tue, 14 Aug 2018 10:06:56 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id d19-v6sm67940763pfe.42.2018.08.14.10.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 10:06:55 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     broonie@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        collinsd@codeaurora.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] regulator: core: Add consumer-requested load in regulator_summary
Date:   Tue, 14 Aug 2018 10:06:16 -0700
Message-Id: <20180814170617.100087-4-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
In-Reply-To: <20180814170617.100087-1-dianders@chromium.org>
References: <20180814170617.100087-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's handy to see the load requested by a regulator consumer in the
regulator_summary.  Add it.  Since this patch comes after the patch
("regulator: core: If consumers don't call regulator_set_load() assume
max") we'll also differentiate between the case where a consumer
hasn't called regulator_set_load() and the case where a consumer
called it but the load is currently 0 mA.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/regulator/core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index b8b8048efbdd..23f64faa6961 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4709,9 +4709,16 @@ static void regulator_summary_show_subtree(struct seq_file *s,
 
 		switch (rdev->desc->type) {
 		case REGULATOR_VOLTAGE:
-			seq_printf(s, "%45dmV %5dmV",
-				   consumer->voltage[PM_SUSPEND_ON].min_uV / 1000,
-				   consumer->voltage[PM_SUSPEND_ON].max_uV / 1000);
+			if (consumer->uA_load_set) {
+				seq_printf(s, "%37dmA %5dmV %5dmV",
+					   consumer->uA_load / 1000,
+					   consumer->voltage[PM_SUSPEND_ON].min_uV / 1000,
+					   consumer->voltage[PM_SUSPEND_ON].max_uV / 1000);
+			} else {
+				seq_printf(s, "%45dmV %5dmV",
+					   consumer->voltage[PM_SUSPEND_ON].min_uV / 1000,
+					   consumer->voltage[PM_SUSPEND_ON].max_uV / 1000);
+			}
 			break;
 		case REGULATOR_CURRENT:
 			break;
-- 
2.18.0.865.gffc8e1a3cd6-goog

