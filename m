Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB68C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39812146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GuprEAWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39812146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeK3XG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:06:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39179 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbeK3XGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:06:53 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so5030233wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 03:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0iW9xOBt9WpVvAp1NOuB+sx1cxkSYq28KOi7fspXZu8=;
        b=GuprEAWu2Lv0u/c6lV9YTtHmcoUUXE4c5dQqqX+ySrUfOzQRadwXe5ZW0bQmFqDO89
         2rxnHCpuVYb+aQOPEnrtDpMRD0bWVf1v0RIyhP51olij9PmjEZwV/DwmgwFfk5PjyTJ6
         eHDNnDCdTt+AifZAzAX0zioTqfPqcxlhdjmPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0iW9xOBt9WpVvAp1NOuB+sx1cxkSYq28KOi7fspXZu8=;
        b=acGviZgNjbbecYVJQbKUTrp60JhOUSdBrwBCKy2ipxfkr7o44DHJcyNE0BxEcKtvQq
         g3SJIwDTNLIKMpW68AFEHXH7ULXps5J+ZW0n1BF4jmircN+fErK0k25tVl28ghI4oQX+
         EON1KDOVn00sVokVzmcfUjtwXDHcNrNCbaRcyVSKVnIm1CgGntHJ7/7dDV4ernf4iCX4
         Qjk9ajJC3u/o2X0TAdyqc8Tut4f9CgZDg/BcSbUe5noe887fdl5Qwy7b0jIUL1PtEo+U
         8ipIyjz+nGpY6Ub6zFzPR5PsxQlkH/Oaji5YaX1m/baiZ654DoNICWNmg/Vg55W4gteC
         KlVw==
X-Gm-Message-State: AA+aEWYSBgp8WzbqrwHIyqBNCwMqlchTEiU3cZIuvwYUbySN6hN8wltP
        p9B44ifqtuFEUmb+tWwg/5hP4A==
X-Google-Smtp-Source: AFSGD/V/7ChjUH63JcyS6B6SgTsLCv915BTgzr1QWyGk5gTz2VHFOEyO5OPbL7bIMOJghEXlYa501w==
X-Received: by 2002:a5d:5089:: with SMTP id a9mr4837909wrt.327.1543579069416;
        Fri, 30 Nov 2018 03:57:49 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id c12sm3861303wrs.82.2018.11.30.03.57.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 03:57:48 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] slimbus: ngd: fix spelling mistake "exeeds" -> "exceeds"
Date:   Fri, 30 Nov 2018 11:57:42 +0000
Message-Id: <20181130115742.16813-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130115742.16813-1-srinivas.kandagatla@linaro.org>
References: <20181130115742.16813-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err message, fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index ccf33217236c..71f094c9ec68 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -787,7 +787,7 @@ static int qcom_slim_ngd_xfer_msg(struct slim_controller *sctrl,
 
 	if (txn->msg->num_bytes > SLIM_MSGQ_BUF_LEN ||
 			txn->rl > SLIM_MSGQ_BUF_LEN) {
-		dev_err(ctrl->dev, "msg exeeds HW limit\n");
+		dev_err(ctrl->dev, "msg exceeds HW limit\n");
 		return -EINVAL;
 	}
 
-- 
2.19.2

