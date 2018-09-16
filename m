Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9600ECE563
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 23:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D242087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 23:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JhtiWx6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D242087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeIQFKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 01:10:45 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41907 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbeIQFKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 01:10:44 -0400
Received: by mail-io1-f66.google.com with SMTP id q4-v6so10045052iob.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 16:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PeH6Ipil7CJB8tr8f+7fACMPhexFa7TfJUCZcP2TPv4=;
        b=JhtiWx6z2EAkugIUVFF3mdBXCn47MKdK7pJ+zNcau76PFl/LzR0YlIKmSZmiDcAJTZ
         BegA6txQXHCF1UTovMDhfGyZ+tiFSeGRljIUKH9RrmORZjqHZsIcbxv0kjwF8MySqIwY
         vPD3xPTir7pagSO/M6yhSYdydYdK/XiWjaFSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PeH6Ipil7CJB8tr8f+7fACMPhexFa7TfJUCZcP2TPv4=;
        b=kobjAww7H6zko7VEeYCgtjkUzABwfEJHnLhpOTnHTX9p4tU61h20t0A7G3P8dhplSI
         TmhPL/DQq242aOXI2vuwrfwSH8wy2TNr54NC1I1zxnWROvW9UFoDn6QIB+NfG16OIvK9
         677npiqfo8XhEQGboATjzR73XD1kDs+GyeuqnZ8jdtbnP0r5YR20ZgnsIGkFGcaMwzR3
         /s3sRiqcuIQGbdjigFWwled08rBk/D78lH4q45pRzx1ztedIPnMzEPeE/yB8RJ9w01XQ
         /wCjI0nkXZbZF8hS7dLRdq+QUpYEEWDS6NHHp1JjVuU9EAPK2HZZl9JX2J4I9eio4tUx
         7m4g==
X-Gm-Message-State: APzg51AeaXmjGg+JkhCRJ0ZRtMk1kH8RUWw9FGqfU5sOItp/EsiN7EuZ
        30posBWLRBJai4d8eQk1s8+Jyw==
X-Google-Smtp-Source: ANB0VdaGxTTviRMAbXFeiq8yLxllNIcUn/MzVLJwC87rBav5or4sbxiP7LDZg8gv3seMP0f3/SCdFA==
X-Received: by 2002:a6b:1706:: with SMTP id 6-v6mr19948407iox.58.1537141563501;
        Sun, 16 Sep 2018 16:46:03 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id a11-v6sm4495177ioc.63.2018.09.16.16.46.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 16:46:03 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        vkoul@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6/7] slimbus: ngd: return proper error code instead of zero
Date:   Sun, 16 Sep 2018 16:45:45 -0700
Message-Id: <20180916234546.29661-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180916234546.29661-1-srinivas.kandagatla@linaro.org>
References: <20180916234546.29661-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

It looks like there is a typo in probe return. Fix it.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 0241373..f48a06e 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1396,7 +1396,7 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
 	if (ctrl->mwq)
 		destroy_workqueue(ctrl->mwq);
 
-	return 0;
+	return ret;
 }
 
 static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
-- 
2.9.3

