Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87319C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501112082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501112082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeH3XJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:09:03 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39816 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbeH3XJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:09:02 -0400
Received: by mail-oi0-f66.google.com with SMTP id c190-v6so17378691oig.6;
        Thu, 30 Aug 2018 12:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fBMJ862XEEIahgbuSdVZDN7DTE3GVasP4unDCjvFxdc=;
        b=KuPp9/ijSlclldTTh2zLqZwViGGXIkLzmMbqpj2hZywx7801NocSlNB7IaZhlMvy5R
         GV9y7u6t5dHU+u+/mq6kujDU4MtjtO89jDLM/+dSRuBFx70WWkQJmwYfSuubvZYPdBXC
         W0ilOhV8ZsJOutgZCKlbLWAZFGwlS5mrOvKZvyASnBK993KTpwjp/zCRWxpk8FTOyRbz
         MAfaYhKgyXFQ02yitTAuaOw6pf7p9s/u7+HQPd3kRxKGN1v9HuofJ519cis3Tvi5nGQV
         9IXH6R++vA00vtCZkJeU4JoyMF1Uew/W1kRCOPOsrZQeCrPrJPhDuTyTDXuwfrAXZ+Xf
         JpfQ==
X-Gm-Message-State: APzg51ChGGFSxnX7hAc+1CXO/tJlDV1FjzXYyf0s/+Td0BoNKfPfb55P
        ZzPANGRIy+9FnRdaYpw02LporK4=
X-Google-Smtp-Source: ANB0VdbEYg1iS0DI53pRY/ExndBGIi+b8KoKq+zO4BY1Fyew9HHOK4/+2Gp84qhcbL+WmE0ZsNl93A==
X-Received: by 2002:aca:c141:: with SMTP id r62-v6mr4048910oif.179.1535655925249;
        Thu, 30 Aug 2018 12:05:25 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id 22-v6sm4200423oix.58.2018.08.30.12.05.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:05:24 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] of/fdt: Scan the root node properties earlier
Date:   Thu, 30 Aug 2018 14:05:21 -0500
Message-Id: <20180830190523.31474-2-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830190523.31474-1-robh@kernel.org>
References: <20180830190523.31474-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scan the root node properties (#{size,address}-cells) earlier, so that
the dt_root_addr_cells and dt_root_size_cells variables are initialized
and can be used.

Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/fdt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 800ad252cf9c..49abe18f1bde 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1215,6 +1215,10 @@ bool __init early_init_dt_verify(void *params)
 	initial_boot_params = params;
 	of_fdt_crc32 = crc32_be(~0, initial_boot_params,
 				fdt_totalsize(initial_boot_params));
+
+	/* Initialize {size,address}-cells info */
+	of_scan_flat_dt(early_init_dt_scan_root, NULL);
+
 	return true;
 }
 
@@ -1224,9 +1228,6 @@ void __init early_init_dt_scan_nodes(void)
 	/* Retrieve various information from the /chosen node */
 	of_scan_flat_dt(early_init_dt_scan_chosen, boot_command_line);
 
-	/* Initialize {size,address}-cells info */
-	of_scan_flat_dt(early_init_dt_scan_root, NULL);
-
 	/* Setup memory, calling early_init_dt_add_memory_arch */
 	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
 }
-- 
2.17.1

