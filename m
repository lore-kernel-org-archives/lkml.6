Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8513C5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B32A214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rrEc41ih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B32A214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbeJQJRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 05:17:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43076 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbeJQJRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 05:17:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id p24-v6so12319680pff.10;
        Tue, 16 Oct 2018 18:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cZrnXJgpaLW8wt9ct/fjPUh76p1CqfOkjQzMlSnZDKI=;
        b=rrEc41ih1H/0RdIOtR2MK0KuQuFiGiL6x97XOrhcVGKupcpN9gLBdNB2BmCL4egfs5
         8SRYfsMnOgB+VA2z5Y1xSKvaelYo9zNum83MeUjaLPaI9OwyBYIaP5R33EoOr/Tcy4U7
         Oc/ejs9vI4pEWE25D0yv/EvDWLVW19fVHCFZNJwMg0t2mVeL86ZRzhw75qi2gnWdzo+Q
         zkwGNdTky7dkJfxIaSee5MFzJKadDh9eQpqgRSLxWByYdV/g6bno8648eiu5/YL4I2ah
         IfvM/IT3KOUUfVeJKNhB4+rpP0ixRF39+pvysdECIq/GYLpAr9Og3KjOahUoIto0Ddoe
         UMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cZrnXJgpaLW8wt9ct/fjPUh76p1CqfOkjQzMlSnZDKI=;
        b=a6tZAQc0iws5+oJSie78hMZbwFNHkSmDWPSJZh9yLYYdb5kiTiMff97uAEtq7ArbE+
         uV45gNNmDEp4G5nkgCzEFEsR8epiG8wpx7roEtfrreS4PWkcDR0eJtyA4zwWBE876ED/
         ntuGp//1PG8dJbwB2PkeIWvPFPqCR+mJK0JzNMua9mJx+2ARhpAkJTjUDVKHhKYHPGlq
         d+0p/0KNp1KISU+QdxLMXblPW2u0G5rzDyr4gxFUS/RJJJkgQ8CumJ8a06nXcPNtPjfC
         SwDYBA7rvladgMjU9EOQhLanKs13JlIDArew60CKKTAaqPfRhEJHOy7CsE56esl117WT
         F61w==
X-Gm-Message-State: ABuFfoiAB+HMCvsth59OBldOtS9UYGPCsvB4VxTxD6Pqk3fuaICoMInz
        qhPw785ykVm0LR+d3q4bhq/3nr46
X-Google-Smtp-Source: ACcGV63HxtBWJckFAFod1epEucyG0sr5Hlv8m1PtRMdrwEpmI5lXf56Mf8ZwwOoaGsqCAz4c87ZPrg==
X-Received: by 2002:a62:583:: with SMTP id 125-v6mr12152154pff.186.1539739474592;
        Tue, 16 Oct 2018 18:24:34 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n64-v6sm22841851pfi.185.2018.10.16.18.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 18:24:34 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] hwmon: (ina3221) Return -ENODATA for two alarms attributes
Date:   Tue, 16 Oct 2018 18:24:23 -0700
Message-Id: <20181017012426.26958-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181017012426.26958-1-nicoleotsuka@gmail.com>
References: <20181017012426.26958-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing critically wrong to read these two attributes
without having a is_enabled() check at this point. But reading
the MASK_ENABLE register would clear the CVRF bit according to
the datasheet. So it'd be safer to fence for disabled channels
in order to add pm runtime feature.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/hwmon/ina3221.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index d61688f04594..3e98b59108ee 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -200,6 +200,8 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
 		return 0;
 	case hwmon_curr_crit_alarm:
 	case hwmon_curr_max_alarm:
+		if (!ina3221_is_enabled(ina, channel))
+			return -ENODATA;
 		ret = regmap_field_read(ina->fields[reg], &regval);
 		if (ret)
 			return ret;
-- 
2.17.1

