Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9869EC04EBA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2152089F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ikdts3Yp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2152089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732479AbeKTKxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:53:32 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35159 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732443AbeKTKxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:53:31 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so82217pgs.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 16:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sB1g0rvrHnjuVhO+N/+Cw73Z3iwSgrPMWcX2Cdrpd7A=;
        b=Ikdts3YpExY1ENnjB/km5U1sr+IeTxB5EvtXCh5J/XYFMEPWa/0yU3pHjZ3YPATSqX
         zJBmNac4mi81A4KK5ZPgc5euYrc2HpdeQ0sa64J9UE0zgTeV5mprtj2TX2pBmEj0FKXn
         t+cvuMOl4vo2m3glHgppxErfwJVbicMNmDyII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sB1g0rvrHnjuVhO+N/+Cw73Z3iwSgrPMWcX2Cdrpd7A=;
        b=n6QcW/XpXWRPyCOXAtj5gLXR6GjzMlgymvWcs1DTFP/55T8p62HqBFFK+6RTJ4/n3f
         rOGH2I6Mh/bY6mNULIzZQ1HyArZzxWp25mbZ9WqBmTeCGfGsbg+KRfQrXP7KF48mnc4u
         KMZBeCmcQTyZ7pYWGLeItLAddfrp2DB/WJiK9OAuyH+AXPiFh0UT2ConXlENCjPWXn/n
         ThPq1MKMLJXaFiRXh88GAQZVe4QcSRt4VoA877v62E5Y5jJm14IR3TZ1jPEIAk3j6ruj
         EADjk+DogpIvAKGv6Lb+j8xtz5aoHPRTj/9PptaPelg/ToT9UI231nZG1GM99Yu011Hl
         KHHw==
X-Gm-Message-State: AGRZ1gIPx+w1DpZbtITbS+slWHIh3QJmJ5vB855y/GOVFkwJWTKJyoj9
        roQP9uQuvYNj/wh+N+UGog0MYA==
X-Google-Smtp-Source: AJdET5cT1F9dLGLtBEoQgppreD6nV6MpVMcqJTysnPCJKYhMZHHjv5rTZ9hgNEuTUZUKiRE5s8iBiw==
X-Received: by 2002:a63:f547:: with SMTP id e7mr22509717pgk.182.1542673633990;
        Mon, 19 Nov 2018 16:27:13 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id z83-v6sm55240218pfi.4.2018.11.19.16.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 16:27:13 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, evgreen@chromium.org,
        swboyd@chromium.org, Dmitry Osipenko <digetx@gmail.com>,
        ryandcase@chromium.org, David Collins <collinsd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] regulator: core: Remove loop disabling supplies in regulator_force_disable()
Date:   Mon, 19 Nov 2018 16:26:54 -0800
Message-Id: <20181120002654.1891-7-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <20181120002654.1891-1-dianders@chromium.org>
References: <20181120002654.1891-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In regulator_force_disable() there was a strange loop that looked like:

  while (rdev->open_count--)
    regulator_disable(rdev->supply);

I'm not totally sure what the goal was for this loop, but it seems
wrong to me.  If anything I think maybe we should have been looping
over our use_count, but even that might be a little strange.  For now
let's just remove the code and we can add something back in if someone
can explain what's expected.

Fixes: f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/regulator/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 2eda87520832..963081aba17a 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2738,10 +2738,6 @@ int regulator_force_disable(struct regulator *regulator)
 
 	regulator_unlock_dependent(rdev, &ww_ctx);
 
-	if (rdev->supply)
-		while (rdev->open_count--)
-			regulator_disable(rdev->supply);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_force_disable);
-- 
2.19.1.1215.g8438c0b245-goog

