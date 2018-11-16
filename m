Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D77C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC4E208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EYSmG4fP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC4E208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389544AbeKPVN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:13:57 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41641 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389430AbeKPVN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:13:56 -0500
Received: by mail-pg1-f193.google.com with SMTP id 70so10464045pgh.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 03:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=1sCzjJpuyoWAr3SZdjEjaCQC9rkWcsgGFIVrSihaM1o=;
        b=EYSmG4fP+EBCLFpS0lesxnIuPLkCQaeDlr7V1pYlMXk9ZJBIW6Vkje/8uYps6+lbyX
         k/mvNHYnGrCviwD9IprEAwK3uYLY396LT9HIg/iEQbrgImLIfY+LZ0SODLR+dIkU7irv
         fmG0dV/IoMH3mgYZyk3Rwwn0PRWWShlCl8CkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=1sCzjJpuyoWAr3SZdjEjaCQC9rkWcsgGFIVrSihaM1o=;
        b=SXw5b8MtFCq5jSlzL5PXaTj/VDR21bsO6pD7YvRcJNr7tSU7/98nvyxkoM7lcIrSuJ
         opWzXvOZBtACLAeVj5AnPahh0P5EgjONN/gHUz/YKykCp215UOkmLmkBihuZ3t1dhbvv
         1v6DJu0wrQUPsz/4L8WEyE00j6qsrRsyavfvkJLxJmWNZWHksF1j+KuDqWGHD1PWmoBb
         p9GRAweb7OS1/gGjVfDqsZgOnRxg4bW5HZ1TR7GDAPoSvXGgD9ZBAv1yOYVesKRgUxy4
         9rBNG6eicUUC2nB0LMOT/CgaIR9zBrtuU2kaDrRPqhhPUz2ZzJowkfO+IJMVuneebb9A
         M8pA==
X-Gm-Message-State: AGRZ1gLhQarBvH92eBdwtYewBexQRtcApa1ACNkL7r617Wt9EEaLEsTu
        5Dtxk80mSrgF5PWZfEtN7EGUPw==
X-Google-Smtp-Source: AJdET5d9M+WFrHcPuCILaiINB7Uq4f1JDAtltUBrI+KqnwdRk33BFpgTjc5xh9Dtxw1yPwXuBjcbhA==
X-Received: by 2002:a63:3546:: with SMTP id c67mr9619376pga.284.1542366125739;
        Fri, 16 Nov 2018 03:02:05 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 202sm21268106pfy.87.2018.11.16.03.02.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Nov 2018 03:02:05 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org
Subject: [PATCH 3/6] power: supply: charger-manager: Fix incorrect return value
Date:   Fri, 16 Nov 2018 19:01:10 +0800
Message-Id: <edef76d756eeae2708f5a23f4d8f1f742fac76a7.1542362262.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
References: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
In-Reply-To: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
References: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix incorrect return value.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/charger-manager.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index bd6c450..a52bc77 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1212,7 +1212,6 @@ static int charger_extcon_init(struct charger_manager *cm,
 	if (ret < 0) {
 		pr_info("Cannot register extcon_dev for %s(cable: %s)\n",
 			cable->extcon_name, cable->name);
-		ret = -EINVAL;
 	}
 
 	return ret;
@@ -1633,7 +1632,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 
 	if (IS_ERR(desc)) {
 		dev_err(&pdev->dev, "No platform data (desc) found\n");
-		return -ENODEV;
+		return PTR_ERR(desc);
 	}
 
 	cm = devm_kzalloc(&pdev->dev, sizeof(*cm), GFP_KERNEL);
-- 
1.7.9.5

