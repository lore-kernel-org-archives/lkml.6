Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6E5C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4730024137
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y+tsa2Kg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4730024137
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754674AbeGENMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:12:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45771 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754342AbeGENFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:05:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id u7-v6so1137735wrn.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0MKE00JaWerRp2/nQ0l2U1l97a+GwZN1ggGadoc+uKY=;
        b=Y+tsa2Kgng9NIpvHg6lzwny2cePlCJmo68eKAkvZ/n6P7oGZ9uglsTSl3c6Psm09ao
         IaezgHVRYpSiEag/EIiewAtPSsBi1KxExBTPg+/0aQbeaMQH5nukXvWjUVlUHBOcHei7
         VCCggFIwfbBCRZcVuE3RTOxtgOPSvjypnkg0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0MKE00JaWerRp2/nQ0l2U1l97a+GwZN1ggGadoc+uKY=;
        b=EIC/2y1lfSl0uSlH2DlT+cVi2R68kC0zSy8LdsrwGcl9qwt6gh13JVusjeqdKax4rw
         F/alnzXkF6ZrQC23N71sDqtN9Tj+H2bFyTNLXxpBj1oEHVH5Ti8tZCxzvJ+ZTIO+m8qq
         ULY8KqUBqRpZyfWa6a9uuF8Z4D65a9j2aEGga++6rIi1N45CNJhrC4LacaTOVXrSHRFL
         7o83BQsiFNNcborA8OF7SBUg8VJvxfdBXr4r3lkI8pGCwZ8DPiynepc1n26tza341HDr
         d2BmAJPGF24uqtgUgmrg+VJkcAYGv2dXtnN3qfl8unsa/Xltu1FwNV1z86RVvDz4vcMB
         LHDw==
X-Gm-Message-State: APt69E0KMde9fYJDErsmpS0nmi0WvzHtO4RzktaKMg92PTgO7I5y97Du
        PSECRhZ9wYuFydFWnYaj7081cw==
X-Google-Smtp-Source: AAOMgpdvMGhvI4cd5Xirrv0/aOZFMvP9Rgd8ZFa1XDoc4o/h6Q6S889SpW4N3rWSKyD1aPdntytTrg==
X-Received: by 2002:adf:9f0f:: with SMTP id l15-v6mr4653674wrf.206.1530795917786;
        Thu, 05 Jul 2018 06:05:17 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id 11-v6sm2109102wrw.67.2018.07.05.06.05.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:05:17 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v5 10/27] venus: hfi_venus: add suspend functionality for Venus 4xx
Date:   Thu,  5 Jul 2018 16:03:44 +0300
Message-Id: <20180705130401.24315-11-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds suspend (power collapse) functionality by reusing
the suspend function for Venus 3xx and also enables idle indicator
property for Venus 4xx (where it is disabled by default).

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 7a83e967a8ea..124085556b94 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -879,6 +879,14 @@ static int venus_sys_set_default_properties(struct venus_hfi_device *hdev)
 	if (ret)
 		dev_warn(dev, "setting fw debug msg ON failed (%d)\n", ret);
 
+	/*
+	 * Idle indicator is disabled by default on some 4xx firmware versions,
+	 * enable it explicitly in order to make suspend functional by checking
+	 * WFI (wait-for-interrupt) bit.
+	 */
+	if (IS_V4(hdev->core))
+		venus_sys_idle_indicator = true;
+
 	ret = venus_sys_set_idle_message(hdev, venus_sys_idle_indicator);
 	if (ret)
 		dev_warn(dev, "setting idle response ON failed (%d)\n", ret);
@@ -1533,7 +1541,7 @@ static int venus_suspend_3xx(struct venus_core *core)
 
 static int venus_suspend(struct venus_core *core)
 {
-	if (core->res->hfi_version == HFI_VERSION_3XX)
+	if (IS_V3(core) || IS_V4(core))
 		return venus_suspend_3xx(core);
 
 	return venus_suspend_1xx(core);
-- 
2.14.1

