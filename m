Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816DDC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3475E21730
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dAcdROHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3475E21730
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387683AbeHNTy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:54:58 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41433 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387669AbeHNTy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:54:58 -0400
Received: by mail-pl0-f66.google.com with SMTP id w19-v6so8560253ply.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 10:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sxQDdG2Di+2iO3ayrNjTUf45BVaOyDbXM7D3wCE/SSA=;
        b=dAcdROHgkaV2icsrCS6q3rz3ETVNxvPEhT8B2BXyEXqwXWHqgF+HxzsBkY4VrFdnKK
         YyzJPiLM3sikpfnj1HQ3xIu5030ZZyKAleUvhrRh/bmuLddzO/2/GbpLGHRCEniw/zWx
         KDbUIpOJTUHcuC5+8jB3ByHS3jwf6j9R5peNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sxQDdG2Di+2iO3ayrNjTUf45BVaOyDbXM7D3wCE/SSA=;
        b=oUmBhDGfnI9ycXLY7QzbeZbeczuEB4k7cJGITOIQKrDlXGPUyzIH6vpZc35LXZ+3EV
         pALQ36xB5VsaGTzrtzqJ8278RPBmkBSsPi+uRyGu5OS8sYo7LllJ53LuUF+Uff7ZjKqd
         ba3jYTUo9KXlaHOmelC48WHk0uliezayyAImOCcuBZQCX94FCNi/FsZl4FocjC9vmdFJ
         +/EUn1GMt+/4a55XE5Y+KAkBzsEIDckg4Y0PfKsYrKuLIj9uP64MAmb0iHoBJsqKSVoV
         ejUYyjyAr4cFiEgnHCUGAcTudi9qVwDuulfeoQp/IfxMwXSpIGKPMhVVqJBzEu0IM+2l
         qoEw==
X-Gm-Message-State: AOUpUlHAp0Y9xgDcCM4HJ80NjPa8Wg2YlBqAtIXSm3rMGnbFJxZsEWwi
        e8jrSlAsTrInXv/24Dgr3T/64g==
X-Google-Smtp-Source: AA+uWPybS1fQbbjpDp1vc+1JzkIB4Dv6hz1nHBVfT/+NWjrSR3Mk10v1OkytMzxz5njJ0/xLIfGttw==
X-Received: by 2002:a17:902:8e86:: with SMTP id bg6-v6mr21097403plb.108.1534266417906;
        Tue, 14 Aug 2018 10:06:57 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id d19-v6sm67940763pfe.42.2018.08.14.10.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 10:06:57 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     broonie@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        collinsd@codeaurora.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] regulator: core: Add locking to debugfs regulator_summary
Date:   Tue, 14 Aug 2018 10:06:17 -0700
Message-Id: <20180814170617.100087-5-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
In-Reply-To: <20180814170617.100087-1-dianders@chromium.org>
References: <20180814170617.100087-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most functions that access the rdev lock the rdev mutex before looking
at data.  ...but not the code that implements the debugfs
regulator_summary.  It probably should though, so let's do it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/regulator/core.c | 51 ++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 23f64faa6961..5950b44c10d5 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3468,21 +3468,23 @@ int regulator_set_current_limit(struct regulator *regulator,
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
 
@@ -3547,21 +3549,23 @@ int regulator_set_mode(struct regulator *regulator, unsigned int mode)
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
 
@@ -4669,18 +4673,23 @@ static void regulator_summary_show_subtree(struct seq_file *s,
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
@@ -4733,6 +4742,8 @@ static void regulator_summary_show_subtree(struct seq_file *s,
 
 	class_for_each_device(&regulator_class, NULL, &summary_data,
 			      regulator_summary_show_children);
+
+	regulator_unlock(rdev);
 }
 
 static int regulator_summary_show_roots(struct device *dev, void *data)
-- 
2.18.0.865.gffc8e1a3cd6-goog

