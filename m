Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11130C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC04520883
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dQ81GztV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC04520883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbeKHIlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:41:37 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40993 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbeKHIlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:41:36 -0500
Received: by mail-pg1-f195.google.com with SMTP id 70so2385439pgh.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 15:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KfFijGXJwU7EYqU+SdDNmXH5u5EZCG9E6Nv8N75Zm7o=;
        b=dQ81GztVCN/8T6I1e52qyjWwEl0/RCF9wQDvKZS2H3xNo/ItgsXkjnyzQmJTNVWFie
         TpxCp9atw7eIqjOSz6tUF0DDmPGeo8xseVtU30X9R7a8oAK8EDVkXS+cUxZurfJ2SouT
         qxxDw+TdYYvAsDgZRs/3xw2R6gUA+4quEl4Y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KfFijGXJwU7EYqU+SdDNmXH5u5EZCG9E6Nv8N75Zm7o=;
        b=EtWLS2vs7kWQGr88ijg1bsOBH2gVes4xrtK8SevcB4TfdlW/ksx0Q4DDN5J1dQThSV
         icxgnzwZS52gAWMWz13x4kT9w7T8GLwuCmMyjnu8OUfTbnXXYqKnbs4RWLRA2bNm0Rdd
         hdZfwot6gKEbLwTSMx2Jg0HkweeYeM3DBExlrxwsc1yyUUna2llxD2CultNRWKl/9HOv
         59XCzXnrj6X2S1OXavMAHjzNThPtxIkrjaaSPWkJ0rVYj2j7Xr6HNoaCrIIGDhutnm6i
         B5A+s+W2gUldF9UchiYOi8lqC1rns5FUcMWsIYDaBff6sHoYNSSAIlLdufTZ6eWV/nok
         rDdQ==
X-Gm-Message-State: AGRZ1gLzx+XhSwSCEq7UfoYaO8xIL2QLnzZv+98eW2sHjHZQS3/0zk0V
        TmRPhISoFpEtfufquAygP8pbXA==
X-Google-Smtp-Source: AJdET5ef8y8Nygxsop3YIKnTByh0+2J7UmD7KJ+Qb2G1w6hOXQxMbv62yKPd5McBvf7aEWwcmcLRtw==
X-Received: by 2002:a62:ae06:: with SMTP id q6-v6mr2242703pff.126.1541632140457;
        Wed, 07 Nov 2018 15:09:00 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id e70-v6sm1802034pfb.113.2018.11.07.15.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Nov 2018 15:08:59 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, leo.yan@linaro.org,
        suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] coresight: etm3x: Release CLAIM tag when operated from perf
Date:   Wed,  7 Nov 2018 16:08:52 -0700
Message-Id: <1541632132-1252-5-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541632132-1252-1-git-send-email-mathieu.poirier@linaro.org>
References: <1541632132-1252-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch deals with the release of the CLAIM tag when the ETM is
operated from perf.  Otherwise the tag is left asserted and subsequent
requests to use the device fail.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 4f638d81a66a..d7f452e62193 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -602,6 +602,7 @@ static void etm_disable_perf(struct coresight_device *csdev)
 	 * power down the tracer.
 	 */
 	etm_set_pwrdwn(drvdata);
+	coresight_disclaim_device_unlocked(drvdata->base);
 
 	CS_LOCK(drvdata->base);
 }
-- 
2.7.4

