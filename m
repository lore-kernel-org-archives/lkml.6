Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C71C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC9421525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DD/v9ZdU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC9421525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388831AbeIUBDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:03:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37719 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388779AbeIUBDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:03:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id h69-v6so4826109pfd.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZRpxBhstQqFQwU6Y9NFTCaAtWvfL9rLmbEuk40AVBmc=;
        b=DD/v9ZdULDaaDFJrEGuLvI68iRFEFUWmC/BLFTAAE380yYlWPLZiET2S0pNTuznmQO
         6D5Jkm8lZd5Fp4bY6eR22twKi+VZ5DeDENB8ni0NZVm7wicx0AIa0OFxOoe0YLe0hhVd
         Sjd5nDHLwM65tvukeo8noORSddQdi7mUKZCxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZRpxBhstQqFQwU6Y9NFTCaAtWvfL9rLmbEuk40AVBmc=;
        b=JtxS3Bp8yI/i4xgoDcj8CwcdZ0uWLab7erBgGdneyly6MkGCk6bOpx4gzGMJpBm90w
         dyB/hQ7yYSjAaqZxLaZApwdG47S4Pq04N4uw1yYV6K/jzEdpNN6uQEdvmP5H/psA5fYS
         Tu0/X7R7i7eEysF6lpTO+bCOdUCkCK9oVUR/wMDdCdq/S5zQOa/mlxC9HUs0p/fLoLId
         dL4DWdhnsVCTFf58S2yfg4hAEdhb9H5czpvty9OytjBCRdhDgKhpM5gwcBVtMrM8+VtA
         FLEeQRhR3eL3yGdqKMiisClkWPP3Mr7rmmDe2Hb1Kl4mUGqQSmz/8tWOTYExy7kR/pnZ
         RVQA==
X-Gm-Message-State: APzg51D/xkEzfCbs25m5JRtgRpobrZcBubXQrcZpxAESZtptSw/qLVuB
        J+F8qGInLs/ChOUFLudvOZBhThS0iPc=
X-Google-Smtp-Source: ANB0VdZcIC31E9h3hEXMdoNeJ9e2x2dBUJ0dx4MH8YyhztCEpa68b7nYBchOQgq+RQyGEpZt3QE7Pw==
X-Received: by 2002:a62:6cc6:: with SMTP id h189-v6mr4937473pfc.23.1537471124485;
        Thu, 20 Sep 2018 12:18:44 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.18.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:18:43 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 15/44] coresight: perf: Disable trace path upon source error
Date:   Thu, 20 Sep 2018 13:17:50 -0600
Message-Id: <1537471099-19781-16-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

We enable the trace path, before activating the source.
If we fail to enable the source, we must disable the path
to make sure it is available for another session.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index afe7e7fc1a93..6db76ce6ba5f 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -317,11 +317,13 @@ static void etm_event_start(struct perf_event *event, int flags)
 
 	/* Finally enable the tracer */
 	if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF))
-		goto fail_end_stop;
+		goto fail_disable_path;
 
 out:
 	return;
 
+fail_disable_path:
+	coresight_disable_path(path);
 fail_end_stop:
 	perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
 	perf_aux_output_end(handle, 0);
-- 
2.7.4

