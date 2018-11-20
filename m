Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AE8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15543205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uu4qaXPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15543205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732507AbeKTKxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:53:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40489 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732399AbeKTKx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:53:26 -0500
Received: by mail-pl1-f194.google.com with SMTP id b22-v6so75755pls.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 16:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=406s8WjJUgyqvQe6Qdp8vScrbKpe04X0EBrEV2mKch4=;
        b=Uu4qaXPxdI46ZCTzsOoAbpPR+sGGlr0TNamWOTWXzefCxDSiZNtBxvFO1FT5rq4ZYS
         dcBINpJU9fOh0gMCNl3KfQcEMDnOeKvLJAHIlSKtnQUt6PwbZaC3UvsmnTg6RMA4Hkc/
         B7y7V5cJk6bFyXEJg4AU/QNu6YD/uvvelsCOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=406s8WjJUgyqvQe6Qdp8vScrbKpe04X0EBrEV2mKch4=;
        b=mF2NlMBxzDrhbIowO5hv5453/8wUIawGPteJAx7hc3EaKX8v1HaB3W+4HL09ZGwOWi
         5pqAmebuHv7a4BRdZxYty6BvgfQ9WfaeRehTBSum9T36FiqrmCnp/MxOfKSlnfDQrm8f
         3lTmGgtvZuAP3K3n0kwz9ZiRJnhtzF0e1Mu0AOcikjwlIgOWvRvWKrPnhSkZ7PK5SVOI
         I/iKpjEly4RR1+6xFrZj7+7r2BXG08q5bF5OwBv4kov9djB3JODbMS+j4XT8fRpzloGl
         PNbMYon2ntMFOKaUrdXsRyA4rCRTsnjT9C9vgIGXxdem/BBrXWkNsNF1e/qKH3r5qkQ6
         FAWQ==
X-Gm-Message-State: AGRZ1gIYUNeWzX0O2ML1jmNApknEln1UHcRabnaO8AAkkz525d3yfE2O
        bzpwr6kbkynW05ek5InWpYxJAg==
X-Google-Smtp-Source: AJdET5dial7+SljRT99gVLGygDQQQyv0tG+BX3VsVVN+CIkrpLykmsa30U/WtH5DVSxxxLkzrgGAiw==
X-Received: by 2002:a17:902:110a:: with SMTP id d10-v6mr24892652pla.85.1542673629169;
        Mon, 19 Nov 2018 16:27:09 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id z83-v6sm55240218pfi.4.2018.11.19.16.27.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 16:27:08 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, evgreen@chromium.org,
        swboyd@chromium.org, Dmitry Osipenko <digetx@gmail.com>,
        ryandcase@chromium.org, David Collins <collinsd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] regulator: core: Don't double-disable supplies in regulator_disable_deferred()
Date:   Mon, 19 Nov 2018 16:26:50 -0800
Message-Id: <20181120002654.1891-3-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <20181120002654.1891-1-dianders@chromium.org>
References: <20181120002654.1891-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the commit f8702f9e4aa7 ("regulator: core: Use ww_mutex for
regulators locking") disabling of the supply was moved into
_regulator_disable().  That means regulator_disable_work() shouldn't
be disabling since that double-disables the supply.

Fixes: f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/regulator/core.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 0052bbc8c531..63a8af1e2256 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2703,16 +2703,6 @@ static void regulator_disable_work(struct work_struct *work)
 		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
 
 	regulator_unlock_dependent(rdev, &ww_ctx);
-
-	if (rdev->supply) {
-		for (i = 0; i < count; i++) {
-			ret = regulator_disable(rdev->supply);
-			if (ret != 0) {
-				rdev_err(rdev,
-					 "Supply disable failed: %d\n", ret);
-			}
-		}
-	}
 }
 
 /**
-- 
2.19.1.1215.g8438c0b245-goog

