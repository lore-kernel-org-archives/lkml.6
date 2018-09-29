Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E51AC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 05:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93A7206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 05:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gNEOE6eC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93A7206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeI2MRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 08:17:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46084 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbeI2MRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 08:17:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id b129-v6so5860585pga.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 22:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ESGwK71J9MVIx0LSTHlmPcydTEacdFoGT0gjQtbEMzs=;
        b=gNEOE6eCXEHf3IE6h9XVE5pgCYM1vzkbspyms3szdjJJ+l/Uq8cZB4tj/PaIUo4iEe
         Fy4S1kh/qfy9w+0/t5csp252mRMKvC8gIWadoxyMe3xLkyRXSNZjqphoThcbDOB2cPjl
         i1CULVEXrpsc66q3rF7biFV6/30cJ876Jo/CU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ESGwK71J9MVIx0LSTHlmPcydTEacdFoGT0gjQtbEMzs=;
        b=j/TC7CHcTxAuJ2P5VJ2gKIKhYfPpvJX2hUKsDEaGuZIPYmyA/WfJV8+kDZR5AzzXVu
         cpIGQ3Meoq7Xc4defEvNxRtR3gkgrRAynkv4iNjcGCkDIjHJW4+W4DHHawp/T/NfryPt
         UvV7FPJDtX6Jrcn284pQ3oqQhXuzr29KY5ShzeSu6dEC6hwM6fvhq34kahG+beQE5AUN
         aDoXp5jMCqzCoAXTXlDGc6Bhy/cHdmQdZl4d8vZG/XLKm7rqylUIeKcmt7hSxWcIc0hL
         c1S9nnVU041ZeSBKvi9R2T/uaZvtbS6u7zO4izAW2FTWiLGrLBu6LkvbSJahAyQwGS1i
         yIkQ==
X-Gm-Message-State: ABuFfoiWo4OxbFUUu9MjcEvFdBSyKHca4GTbYLxudHB7TpikM//MjMdv
        L3+hcRkjeqO3of49rVUiEBdAfYN7qyb/rg==
X-Google-Smtp-Source: ACcGV63QP6TcYjR8U7GOSTKKwZ7h+ABOrRt6RAhZd0q0YD6b3GOFtLVnMRgodR4d0rT4WStcM6SdZA==
X-Received: by 2002:a63:8442:: with SMTP id k63-v6mr1583392pgd.388.1538200201941;
        Fri, 28 Sep 2018 22:50:01 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i80-v6sm11118049pfi.87.2018.09.28.22.49.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Sep 2018 22:50:00 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org,
        eric.long@spreadtrum.com
Cc:     broonie@kernel.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] dmaengine: sprd: Remove direction usage from struct dma_slave_config
Date:   Sat, 29 Sep 2018 13:48:59 +0800
Message-Id: <ad83dabc0e2360e131bd820c7c3b69ba47d11f30.1538199697.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1538199697.git.baolin.wang@linaro.org>
References: <cover.1538199697.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1538199697.git.baolin.wang@linaro.org>
References: <cover.1538199697.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The direction field of struct dma_slave_config was marked deprecated,
thus remove the usage.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 38d4e4f..c226dc93 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -847,9 +847,6 @@ static int sprd_dma_slave_config(struct dma_chan *chan,
 	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
 	struct dma_slave_config *slave_cfg = &schan->slave_cfg;
 
-	if (!is_slave_direction(config->direction))
-		return -EINVAL;
-
 	memcpy(slave_cfg, config, sizeof(*config));
 	return 0;
 }
-- 
1.7.9.5

