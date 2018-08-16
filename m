Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E10C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CEF2147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RM7d/JtB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CEF2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbeHPX3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:29:38 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44813 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeHPX3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:29:38 -0400
Received: by mail-pl0-f66.google.com with SMTP id ba4-v6so2613821plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 13:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w7Wphlzb9MyK0taAOg/N66aiORw+y2yAt3Sx+0/JxpQ=;
        b=RM7d/JtBTH9+ddsJPLpMHR9J08jjqf+7xgW9tb8w4d/Mn/HxpbDrEgjaNhwHjgGXUN
         qW76X0gRpvsYpE6lstrIhWv5e/OKxrcSt/UK1KT0TpplCuBU27FAxUeXFTXVr9aUMzIf
         Nn0ixMKJVTCZ2yHXCECr2FCeBx4BCBozBOM6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w7Wphlzb9MyK0taAOg/N66aiORw+y2yAt3Sx+0/JxpQ=;
        b=l9xdDNNq3WEQfuheGbGpXWlV6GRvKRDisJM1NPC707qZSwCKbgiv5cB1GJ7bJqXdaH
         gonX7UpNx3FBE9elcuGebNScY4qeOQTwukqK6gxLFZwhAzlvksQqje4zswF24MvXV54n
         RjByHEBw8SGRxpglT2FupH9bC3w741P55KW+sC4l3wO1chSiOXdxgIRvDQ2NgRzEAPtS
         5HnsJ7pmUO7DiBPs4TBeQ35h9EoduSLyC3qXU/Ur58LsuFRSzI9jVsoixgt8qHCDCGPx
         jtTvvFBrKEDJ+wEhHT9r8XPR3gdSulwzUdWpTAOMq7O3iUoj2iBeG4pdc97omaeEiKWt
         HHhA==
X-Gm-Message-State: AOUpUlGR/dFgdn3Z66gzLr69Knr3hK+4gJ4vo4QAnyPOhKsd66GRu4rf
        oHTOBsuFcezn+LZ8NHb7WjRb6A==
X-Google-Smtp-Source: AA+uWPyOT6veSG5LvTj0oG1K0MaDZ9fJw5DNV0uys4awJdeffBrb8jSnRbaOm5HPmYIuiWFqnCng+w==
X-Received: by 2002:a17:902:82c7:: with SMTP id u7-v6mr2509651plz.83.1534451337960;
        Thu, 16 Aug 2018 13:28:57 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id t76-v6sm209647pfe.109.2018.08.16.13.28.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 13:28:57 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     broonie@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        collinsd@codeaurora.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] regulator: core: Add locking to debugfs regulator_summary
Date:   Thu, 16 Aug 2018 13:28:03 -0700
Message-Id: <20180816202803.250079-4-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
In-Reply-To: <20180816202803.250079-1-dianders@chromium.org>
References: <20180816202803.250079-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most functions that access the rdev lock the rdev mutex before looking
at data.  ...but not the code that implements the debugfs
regulator_summary.  It probably should though, so let's do it.

Note: this fixes no known issues.  The problem was found only by code
inspection.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2: None

 drivers/regulator/core.c | 51 ++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 1e2dc8d09075..d350bcabdf20 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3461,21 +3461,23 @@ int regulator_set_current_limit(struct regulator *regulator,
 }
 EXPORT_SYMBOL_GPL(regulator_set_current_limit);
 
+static int _regulator_get_current_limit_unlocked(struct regulator_dev *rdev)
+{
+	/* sanity check */
+	if (!rdev->desc->ops->get_current_limit)
+		return -EINVAL;
+
+	return rdev->desc->ops->get_current_limit(rdev);
+}
+
 static int _regulator_get_current_limit(struct regulator_dev *rdev)
 {
 	int ret;
 
 	regulator_lock(rdev);
-
-	/* sanity check */
-	if (!rdev->desc->ops->get_current_limit) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	ret = rdev->desc->ops->get_current_limit(rdev);
-out:
+	ret = _regulator_get_current_limit_unlocked(rdev);
 	regulator_unlock(rdev);
+
 	return ret;
 }
 
@@ -3540,21 +3542,23 @@ int regulator_set_mode(struct regulator *regulator, unsigned int mode)
 }
 EXPORT_SYMBOL_GPL(regulator_set_mode);
 
+static unsigned int _regulator_get_mode_unlocked(struct regulator_dev *rdev)
+{
+	/* sanity check */
+	if (!rdev->desc->ops->get_mode)
+		return -EINVAL;
+
+	return rdev->desc->ops->get_mode(rdev);
+}
+
 static unsigned int _regulator_get_mode(struct regulator_dev *rdev)
 {
 	int ret;
 
 	regulator_lock(rdev);
-
-	/* sanity check */
-	if (!rdev->desc->ops->get_mode) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	ret = rdev->desc->ops->get_mode(rdev);
-out:
+	ret = _regulator_get_mode_unlocked(rdev);
 	regulator_unlock(rdev);
+
 	return ret;
 }
 
@@ -4661,18 +4665,23 @@ static void regulator_summary_show_subtree(struct seq_file *s,
 	struct regulation_constraints *c;
 	struct regulator *consumer;
 	struct summary_data summary_data;
+	unsigned int opmode;
 
 	if (!rdev)
 		return;
 
+	regulator_lock_nested(rdev, level);
+
+	opmode = _regulator_get_mode_unlocked(rdev);
 	seq_printf(s, "%*s%-*s %3d %4d %6d %7s ",
 		   level * 3 + 1, "",
 		   30 - level * 3, rdev_get_name(rdev),
 		   rdev->use_count, rdev->open_count, rdev->bypass_count,
-		   regulator_opmode_to_str(_regulator_get_mode(rdev)));
+		   regulator_opmode_to_str(opmode));
 
 	seq_printf(s, "%5dmV ", _regulator_get_voltage(rdev) / 1000);
-	seq_printf(s, "%5dmA ", _regulator_get_current_limit(rdev) / 1000);
+	seq_printf(s, "%5dmA ",
+		   _regulator_get_current_limit_unlocked(rdev) / 1000);
 
 	c = rdev->constraints;
 	if (c) {
@@ -4719,6 +4728,8 @@ static void regulator_summary_show_subtree(struct seq_file *s,
 
 	class_for_each_device(&regulator_class, NULL, &summary_data,
 			      regulator_summary_show_children);
+
+	regulator_unlock(rdev);
 }
 
 static int regulator_summary_show_roots(struct device *dev, void *data)
-- 
2.18.0.865.gffc8e1a3cd6-goog

