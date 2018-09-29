Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EACC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 05:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C19A2087D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 05:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hpBvakUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C19A2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeI2MR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 08:17:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37019 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbeI2MR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 08:17:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id x26-v6so5674947pfn.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 22:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=5xZvV9ure0B+Th/au/ie3rB7XqPr/svxvChRm0xoFwg=;
        b=hpBvakUNb4T8ainOmd6UaRX9Am+kZP71yKwiZMqtFvyofcJRewL5Tq/DS46xAwOkqE
         KIVb1IDSSZS7F/6yiOc+8UD/ML/nTLTal5LYqk+oKHEe5rz2+2tdXsTBcFoo5d06CpRs
         6N8OgTQGHPvv4qS8tIraFX/k4k+/kVHKs1Dp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=5xZvV9ure0B+Th/au/ie3rB7XqPr/svxvChRm0xoFwg=;
        b=HiSeWYa9aK3Qj4kcRIZuk0MMRfRPICjT3Ley1rUXWEJWJrU1TYHVArJ2FxQIBx0HGC
         Q/mSdsopq5ZtYDT4DL+KdVEY3oK0I8LwJGLCtpitKxmdCVfyqdUof3fCFCKmpFLMx/6F
         sHnaGkoKzUK5A96Qv/HUDugMvPyRVxoDQ3Yk6Urvjyno9BiqeoFrwPhHagc1zRDPsCO7
         +/u8jUEnO5i79b2zjgUPIrTPoaBOJrQDqHjCXjwATFDw0cSxUnXERISUzsdkMeFNzO1w
         JtqOpx47t2zb3jWQtU991xh/nc1RgUsj2Aqn8qp0gpOuyPNEVTeA5Se1DgrWMcjpcypb
         p9+w==
X-Gm-Message-State: ABuFfohH0GvECtItrYeesCyav1aRLOYhlMJZgCJskHWcBWtmNZpBsU5O
        n1bqolY26w2HayNJggV69+o1fdIZZqI/Iw==
X-Google-Smtp-Source: ACcGV6102u+MUI5IZUapI4Hd253UUKINrrKH7Ruy795W3nNou7IRSd+vkhFVmcT29bH8uiUzlflU2w==
X-Received: by 2002:a17:902:8b8c:: with SMTP id ay12-v6mr1701882plb.163.1538200222836;
        Fri, 28 Sep 2018 22:50:22 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i80-v6sm11118049pfi.87.2018.09.28.22.50.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Sep 2018 22:50:21 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org,
        eric.long@spreadtrum.com
Cc:     broonie@kernel.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] dmaengine: sprd: Add me as one of the module authors
Date:   Sat, 29 Sep 2018 13:49:05 +0800
Message-Id: <c6a70c1245092d1c2c2c195f82423798457fb3c6.1538199697.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1538199697.git.baolin.wang@linaro.org>
References: <cover.1538199697.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1538199697.git.baolin.wang@linaro.org>
References: <cover.1538199697.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Long <eric.long@spreadtrum.com>

Add me as one of the module authors.

Signed-off-by: Eric Long <eric.long@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 50d6569..e2f0167 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -1226,4 +1226,5 @@ static int __maybe_unused sprd_dma_runtime_resume(struct device *dev)
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("DMA driver for Spreadtrum");
 MODULE_AUTHOR("Baolin Wang <baolin.wang@spreadtrum.com>");
+MODULE_AUTHOR("Eric Long <eric.long@spreadtrum.com>");
 MODULE_ALIAS("platform:sprd-dma");
-- 
1.7.9.5

