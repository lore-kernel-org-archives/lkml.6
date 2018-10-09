Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9323C00449
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 02:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AED92086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 02:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fOddjQEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AED92086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeJIJWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 05:22:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37009 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbeJIJWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 05:22:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id c10-v6so17931pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 19:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q4Qgab7AmHkTyy8csV/4RxB3lFjUcgy6P9FGnJqaXYA=;
        b=fOddjQEuBpJT55aExzSpljO58wMsDoIvz+B1mmuPRSm9TNAWomDbWD+CemFOKNAD5V
         0p/ZDCuI+z2qSgBuOpno9PEChLyEZc12xxP57gCkbYYvHlUL1s3ORR2s5OYKddArxyOr
         1/oIdAsRSiQ2skddp5b085l+C0K56QC00hpbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q4Qgab7AmHkTyy8csV/4RxB3lFjUcgy6P9FGnJqaXYA=;
        b=j+nMLQTiXfLMNoNLCPJatvRFRLlV8sD53seGELFY6U8H04ahw4Wwf6P9netZE5i82Q
         NiTDljupshDt6vpSLF2E73muHqkerFnQxeccbmT5aRGQmnTGqhvada+isitTR+W3wXyk
         lgFwRW5DiL0KOO/Iakje+Hors9FGdlLIch2RAicau7gAIaxQTeoI1qcSbPmshj36jPA0
         m5RvI591d3VqW4GgQZi+YPTEsZMXV+LS8nhb6hsZAE4NMBTbAlh1DE/w6fudRYbGEtgh
         qVxblFPz4/cHByklWpOzX60OuB1EvqBvkq9mRMKdXhqsLGeGKRzqnj8PF+GIeX9aP364
         Ov8w==
X-Gm-Message-State: ABuFfogr34yrWlOx18JDmOPQsHoAJckgmtrqtY4CdTtc96zRbzJXMnAe
        AO/MaCo5kA/NVLVbttJfrAjxEw==
X-Google-Smtp-Source: ACcGV62ms6ZmYDM/7ErfbLCxh+GSY8BSzTKOZWPojz3L/YHfjUexzbw1LpBqmWTGc6TeuCn7gHjNZw==
X-Received: by 2002:a65:5188:: with SMTP id h8-v6mr23553812pgq.288.1539050894080;
        Mon, 08 Oct 2018 19:08:14 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id i29-v6sm33757230pfj.82.2018.10.08.19.08.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 19:08:12 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] remoteproc: qcom: q6v5-pil: add SCM probe dependency
Date:   Mon,  8 Oct 2018 19:08:05 -0700
Message-Id: <20181009020805.143982-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to qcom_q6v5_pas and qcom_wcnss drivers, probe will fail if SCM
is not up.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index a839b07a58b1..8836ca1bc0c1 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -1151,6 +1151,9 @@ static int q6v5_probe(struct platform_device *pdev)
 	if (!desc)
 		return -EINVAL;
 
+	if (!qcom_scm_is_available())
+		return -EPROBE_DEFER;
+
 	rproc = rproc_alloc(&pdev->dev, pdev->name, &q6v5_ops,
 			    desc->hexagon_mba_image, sizeof(*qproc));
 	if (!rproc) {
-- 
2.19.0.605.g01d371f741-goog

