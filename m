Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D91AC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D9B20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HasY6LQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D9B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbeLAFx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:53:26 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32891 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbeLAFxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:53:25 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so3239063pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 10:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c70yC8nTUX49YKlETWoE+QkSk9SIJlmG5ulj2mcAOIQ=;
        b=HasY6LQt1kbAfq6HXFV0B4/cxttvkZ5qDQxWLYxJwURXGtGt+IFNl6b7i/Le9BSliE
         N1hXLFUfFfhxNcZVFV/YhkWv6metAzkUiggaHlRr5tl8WUxqLnDFSJTOeQter7MuF0/+
         p/asvmqul8e5yGAsEwGJmPoIW6ni/dnP0qpZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c70yC8nTUX49YKlETWoE+QkSk9SIJlmG5ulj2mcAOIQ=;
        b=EKUpSmIUQQjaOCWmVNyTVXi4z53EYMaPgC82Wq6o0bPAxQbV+VSXRtqg2QLQFsOW2v
         UdBqrFJlzwxQyjqrh3E+bt4oo1Y61HiSW63886I7gI7YO6yfiiDIn4QJNHI3ox7uYSUo
         FJU3evrVQANFFlwr2l/ntAePX2BvUfpWOJHuPmkEMI07YdhvLMDzf1IJI9c7F31ShF35
         TerwC+rJJjxSIyPg+Myvfs4Kdo89yDrX9c2BtmlHFdXP3GvS8CI9r1QJFDlk3EAzV0gR
         b0wsR1xT2ukwFbDM69I5i0zHjOgPTTFfkb/4X1h14Pvv0638q4OzFJN91psvFQ8F7cCr
         wPQg==
X-Gm-Message-State: AA+aEWY14YYDSL5un1HQwaQXaSCZ7nR/7Y1qpoVSQToJqkC5+RNnKUV5
        EZ1y38WN0uLluwlfSaJzFqDpXQ==
X-Google-Smtp-Source: AFSGD/XzNHY9kWDpwaeQcBGsnouBEkdj5n/q2gSqwQ/Jg+tVRFFP23O62II+IEaE8Low4nMRLrIzbA==
X-Received: by 2002:a63:4f5e:: with SMTP id p30mr5734462pgl.71.1543603393874;
        Fri, 30 Nov 2018 10:43:13 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id l184sm12743147pfc.112.2018.11.30.10.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 10:43:13 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] coresight: etm3x: Release CLAIM tag when operated from perf
Date:   Fri, 30 Nov 2018 11:43:06 -0700
Message-Id: <1543603387-32645-6-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543603387-32645-1-git-send-email-mathieu.poirier@linaro.org>
References: <1543603387-32645-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch deals with the release of the CLAIM tag when the ETM is
operated from perf.  Otherwise the tag is left asserted and subsequent
requests to use the device fail.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 6f30d52da9e4..9a63e87ea5f3 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -601,6 +601,7 @@ static void etm_disable_perf(struct coresight_device *csdev)
 	 * power down the tracer.
 	 */
 	etm_set_pwrdwn(drvdata);
+	coresight_disclaim_device_unlocked(drvdata->base);
 
 	CS_LOCK(drvdata->base);
 }
-- 
2.7.4

