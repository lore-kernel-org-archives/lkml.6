Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8133ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992A021525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fsBEayu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992A021525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388860AbeIUBDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:03:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40188 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388833AbeIUBDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:03:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id s17-v6so4791174plp.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ObPs8TBqb1FBhZucHBxXAUazksYFj4fmD4SKmUP8+rA=;
        b=fsBEayu8vtj+dBnKQsFWsbQLIRoK1CjTRzt94gokqPrNLPyADX1BXthDgarHA/Vf9x
         wGxJG6c3pgoO0Mk4Iuk14x55Q+m/3A4suWuP/C7b6pMRE3wG37jJgf9CKFbMv8W5B6T3
         hMu8cemFTIWPIT63RnAIs6oWVsZSDDta9jwyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ObPs8TBqb1FBhZucHBxXAUazksYFj4fmD4SKmUP8+rA=;
        b=oRsEik8yLRDUWlQPC0e61eKrPHSZtylxxN23vgGfA2atbb7SyOE0bbdBuQpSjUCMWH
         yQ0hiQa/nmYO1OnRbf3uOV/P+SszmNhck0lbrRiuLga/BEfiUX21qPX1KSUpfzjCzCSp
         iHE5ZnP8rxs616Z4FcMSWLvGe2mznnCHED+OPfhRyub9Bj+ltLTYkhTOKNww1yBEYUSY
         dQiB73r7jxuMZc/YCbf2vcGQfLLtc70Zd76TZpFttf+ISB1V5Y1UseVx1pADGLC1PQLN
         ZcdaYqj0pzryG6qbOzC7GjFS1gpNZl0th76lkCRiNQoKQLVNqENVTxSZtrlT/OSKl65c
         MMnA==
X-Gm-Message-State: APzg51B1RTpbiqvZq1Drobv17EcUoLwRbumVlYDzjXzUSjPUvR6pGSY7
        AhpCO87o0Mejmge9FdVjCsrOKiCD8FY=
X-Google-Smtp-Source: ANB0VdYaU76+6ssvmPEYbvw0dBwyrVrBEiNzbpAD8FSDvFmOm1LqYggyXROWzIXBa56qp6DwDN3jOg==
X-Received: by 2002:a17:902:6806:: with SMTP id h6-v6mr41442637plk.304.1537471127643;
        Thu, 20 Sep 2018 12:18:47 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:18:46 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 17/44] coresight: tmc-etr: Relax collection of trace from sysfs mode
Date:   Thu, 20 Sep 2018 13:17:52 -0600
Message-Id: <1537471099-19781-18-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Since the ETR now uses mode specific buffers, we can reliably
provide the trace data captured in sysfs mode, even when the ETR
is operating in PERF mode.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 2d6f428176ff..bafd73e71c4c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1168,19 +1168,17 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 		goto out;
 	}
 
-	/* Don't interfere if operated from Perf */
-	if (drvdata->mode == CS_MODE_PERF) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	/* If sysfs_buf is NULL the trace data has been read already */
+	/*
+	 * We can safely allow reads even if the ETR is operating in PERF mode,
+	 * since the sysfs session is captured in mode specific data.
+	 * If drvdata::sysfs_data is NULL the trace data has been read already.
+	 */
 	if (!drvdata->sysfs_buf) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	/* Disable the TMC if we are trying to read from a running session */
+	/* Disable the TMC if we are trying to read from a running session. */
 	if (drvdata->mode == CS_MODE_SYSFS)
 		tmc_etr_disable_hw(drvdata);
 
-- 
2.7.4

