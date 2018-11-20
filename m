Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA6AC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409E4208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CwHrhZW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409E4208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732463AbeKTKxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:53:31 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42488 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732443AbeKTKxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:53:30 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so77742pfr.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 16:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YbFow0eL7TWD3snxY9K5hrco6FNslijMI7AoCHOBSq4=;
        b=CwHrhZW5ffJnJNdKeyu9Wqax+fBbQFZhMagY2kenE8PcAkvLThSJBFV8DSd8UPYcdn
         mXxiITU+MdZS79EGxxgM7LliezKNkUMEaxQPIH0h0hYuvXqoTeRt81+YzbHYs/kkMHU5
         vaAh+I6ZLM6C7xlDx3qvSXMijcCk/GA4wxnO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YbFow0eL7TWD3snxY9K5hrco6FNslijMI7AoCHOBSq4=;
        b=XxI8BzV24tmMyIFjOn0woRkPy19qwGD08acC7ifRs6F8F4V/KVTsUdcyCd2nf/Mhrn
         GJeL/M08zCIAHzsXWM27hRBQXOze0KZJRWdK+344VfAjNgCPE4CKgB9CpJR3CDKjRbfO
         1nuoKE4lFx5dFjbGu0BHJcjzcGwe8BpBgb/Ptz7m2rnFqIBGuv1TeaT4BxyNEQQ7993v
         ep1aVVYVgEF0U8G2AAzewTuReWyfP2inXYEoSGd0SY4maCbMN0Yi8mpL+XUSeQ+TG0/v
         dek1qORuPNy45fucfEbv0mB/WrnSyAWIUP4DH+AkdPBAJcId7hzSnLeJ3E/uhSS/f+cN
         3rPQ==
X-Gm-Message-State: AGRZ1gJRaDbuccsk5VEEp8DpbMQLVDpedK/uHqYFD1K0a9X321wyfp4e
        OI+XcvfN/MpiT/N6RcH3JHH/vg==
X-Google-Smtp-Source: AJdET5cCOderM4UPGx6ViswFe+IA4YMQrjbSwFX8H7e1XVzbwhR04pYgUjAyQGvKErvu51NwsNjMAw==
X-Received: by 2002:a63:1444:: with SMTP id 4mr22409418pgu.430.1542673632797;
        Mon, 19 Nov 2018 16:27:12 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id z83-v6sm55240218pfi.4.2018.11.19.16.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 16:27:12 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, evgreen@chromium.org,
        swboyd@chromium.org, Dmitry Osipenko <digetx@gmail.com>,
        ryandcase@chromium.org, David Collins <collinsd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] regulator: core: Avoid propagating to supplies when possible
Date:   Mon, 19 Nov 2018 16:26:53 -0800
Message-Id: <20181120002654.1891-6-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <20181120002654.1891-1-dianders@chromium.org>
References: <20181120002654.1891-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we called regulator_enable() on a regulator we'd end up
propagating that call all the way up the chain every time.  This is a
bit of a waste of time.  A child regulator already refcounts its own
enables so it should avoid passing on to its parent unless the
refcount transitioned between 0 and 1.

Historically this hasn't been a huge problem since we skipped dealing
with enable for always-on regulators.  In a previous patch, however,
we removed the always-on optimization.  On one system, the debugfs
regulator_summary was now showing a "use_count" of 33 for a top-level
regulator.

Let's implement this optimization.  This turns out to be fairly
trivial with the recent reorganization of the regulator core.

NOTE: as part of this patch I'll make "always-on" regulators start
with a use count of 1.  This keeps the counts clean when recursively
resolving regulators.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/regulator/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 23e852d38b88..2eda87520832 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1822,6 +1822,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 			rdev->supply = NULL;
 			return ret;
 		}
+		rdev->use_count = 1;
 	}
 
 	return 0;
@@ -2491,7 +2492,7 @@ static int _regulator_enable(struct regulator *regulator)
 
 	lockdep_assert_held_once(&rdev->mutex.base);
 
-	if (rdev->supply) {
+	if (rdev->use_count == 0 && rdev->supply) {
 		ret = _regulator_enable(rdev->supply);
 		if (ret < 0)
 			return ret;
@@ -2539,7 +2540,7 @@ static int _regulator_enable(struct regulator *regulator)
 	_regulator_handle_consumer_disable(regulator);
 
 err_disable_supply:
-	if (rdev->supply)
+	if (rdev->use_count == 0 && rdev->supply)
 		_regulator_disable(rdev->supply);
 
 	return ret;
@@ -2648,7 +2649,7 @@ static int _regulator_disable(struct regulator *regulator)
 	if (ret == 0 && rdev->coupling_desc.n_coupled > 1)
 		ret = regulator_balance_voltage(rdev, PM_SUSPEND_ON);
 
-	if (ret == 0 && rdev->supply)
+	if (ret == 0 && rdev->use_count == 0 && rdev->supply)
 		ret = _regulator_disable(rdev->supply);
 
 	return ret;
-- 
2.19.1.1215.g8438c0b245-goog

