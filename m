Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDE3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B1420989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZHuUacui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B1420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbeK3DoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:44:25 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39698 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729218AbeK3DoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:44:25 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so1295515pld.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 08:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s4KAWB8thmpYH1WwjCgumPIS1PyiX7+UJj97tYgIK5o=;
        b=ZHuUacuiSSYMQEtgRUiXKlj3vykdcFrM2GcB2KYfq7rKkw8B3kfMoDOPlUyuekZ1BL
         10x4k4jwYAZhq9LHCN1sh0lhH7vuZcXVjqXot5mt9c8q3y7TsMJtxDTdBlexFrFPUfGy
         P+/orrYrGhSDcz/uIykP7tGUzT8p+hyRF5qS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s4KAWB8thmpYH1WwjCgumPIS1PyiX7+UJj97tYgIK5o=;
        b=mkr7U1Zuwtm8TpQEUC258D2cBvaTASOq2NiSzMrMAF+BoxFBUIXJN1UmD2JpDyfnGV
         yWNvtM/VS/0zepNP4pxcO3LhFhHgI5OkjPJZGfs/ojQPnWd8gkAVYA/Uja1vmMAT3qAa
         jl4ad3JDxQJDDcRUChPqOMW/Mp2KXZy//3nVF9MKzROpZUD8YzkzalYhstGez2KVTzyP
         gAV46vJ24xrS4TgQOhsjJWhNhzC63VTAqCV/PXwwW/rE0inLq961W6aFRH2IdhDXdZiV
         djimCd5bNn6IoCOOFa3mfqxVzwAIzkdiN6hwNU6YmfgMaFYdOV/LUSPIy2Lf9OeiSO1y
         Jo0Q==
X-Gm-Message-State: AA+aEWa2ymLFEqLm+/BdoVYmZ0mKJSQWpaEGxLqDB06gUn7RW+eTDMzF
        TZKLNRFT7HeXdYFmKSrbdgwItA==
X-Google-Smtp-Source: AFSGD/Wsg40NT0WJBkAv5b8UhC82zU0+NQCzi6mFuMdjDjr6DS35UublCovKp/d0QS/0dJgUMQ2Djg==
X-Received: by 2002:a17:902:5a4d:: with SMTP id f13mr2219688plm.49.1543509508040;
        Thu, 29 Nov 2018 08:38:28 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id s37sm3033836pgm.19.2018.11.29.08.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 08:38:27 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kbuild test robot <lkp@intel.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Clark <robdclark@gmail.com>
Subject: [PATCH] drm: msm: Check cmd_db_read_aux_data() for failure
Date:   Thu, 29 Nov 2018 08:38:26 -0800
Message-Id: <20181129163826.178670-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to check the call to cmd_db_read_aux_data() for the error case,
so that we don't continue and use potentially uninitialized values for
'pri_count' and 'sec_count'. Otherwise, we get the following compiler
warnings:

   drivers/gpu/drm/msm/adreno/a6xx_gmu.c: In function 'a6xx_gmu_rpmh_arc_votes_init.isra.12':
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:943:12: warning: 'pri_count' is used uninitialized in this function [-Wuninitialized]
     pri_count >>= 1;
               ^~~
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:948:12: warning: 'sec_count' may be used uninitialized in this function
[-Wmaybe-uninitialized]
     sec_count >>= 1;
               ^~~

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Jordan Crouse <jcrouse@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Jordan Crouse <jcrouse@codeaurora.org>
Cc: Rob Clark <robdclark@gmail.com>
Fixes: ed3cafa79ea7 ("soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 8cd294e2846d..b450f7ea0422 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -936,6 +936,8 @@ static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
 	size_t pri_count, sec_count;
 
 	pri = cmd_db_read_aux_data(id, &pri_count);
+	if (IS_ERR(pri))
+		return PTR_ERR(pri);
 	/*
 	 * The data comes back as an array of unsigned shorts so adjust the
 	 * count accordingly
@@ -945,6 +947,9 @@ static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
 		return -EINVAL;
 
 	sec = cmd_db_read_aux_data("mx.lvl", &sec_count);
+	if (IS_ERR(sec))
+		return PTR_ERR(sec);
+
 	sec_count >>= 1;
 	if (!sec_count)
 		return -EINVAL;
-- 
Sent by a computer through tubes

