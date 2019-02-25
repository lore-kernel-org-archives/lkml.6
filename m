Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE807C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8112B2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fT+2jPCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfBYTWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:22:21 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41256 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfBYTWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:22:17 -0500
Received: by mail-pl1-f196.google.com with SMTP id y5so4937593plk.8;
        Mon, 25 Feb 2019 11:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IHBkJQMqZ5iq2XG0cYhogrcMCEHQBwxQeo0dWaLkQfk=;
        b=fT+2jPCLquZaatV7yjwBlrH9BaTieG+x/MEMD1/EuxWM16za4fYo2sTB5h78L8N3VU
         rGO2wMtU48egZc/+iMZeOM7uj73nv66t8nk455i6r3u21v+Mmifk7rZ1Al88AB0e3uUl
         zqF3jt6hjWa5VWzhUw2CsUWQCTyrmWG7kFazP0ChWOxANqOS5eZ4cKwqezhsfvbvhEeI
         vYyjlLUXDpg6/M9j616xwMkSnzfm08AOHgL0nGDBk2QcivtS40oBtdjnog/3jDWJ9hBm
         Fk28M1rVLMqUdppEyR8kwUIfpPoOa0HWxC8PUcz2q5DJWEBTVUumD6dJcn8uf47u4wYw
         5CJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IHBkJQMqZ5iq2XG0cYhogrcMCEHQBwxQeo0dWaLkQfk=;
        b=lBy0cqyAKMDjq37mhHlm/onBnXB53s2YeeXVv7mpeZvea59h7T01oKUMlpSn5XBMEu
         qsaRF0RRxcGAKaglwQiJMwAGx42hj/Z2z7TGfSQghGRVcmMzIuHXIT9mh/2tjqemg1m/
         rQ0XI3h+BkcbanUSlTTuP5HwJ3ACJe9CR+kaovgpjxqeloJ68EfV5cdqRep5lO2YCMBd
         yEYNVBqJZazIMTzKApW4HJruQ7FouxWRu/UurYsmYZFrjfo611DpuweJWMf3vgqVzQX+
         M/YA64P3Q84qb5jFAw83w1INRLacBq80nEcGJGStl0OB9G77yTa5oKi12pi3kRBSWP30
         7Cag==
X-Gm-Message-State: AHQUAubwyVL44v3eMDgMIf6SStPvU6bcXBNeUyM/AddEZa8DoG0WLlce
        tYmTMZ6IIB7gHHCXKLvtztg=
X-Google-Smtp-Source: AHgI3IZ7dTyrq3o9370mDT+gYO+qjCbvJXbXcnG9/EFmYKriNTa24bgDDmCxI2HvtSHtM+7tKlLcAA==
X-Received: by 2002:a17:902:161:: with SMTP id 88mr22366328plb.306.1551122536915;
        Mon, 25 Feb 2019 11:22:16 -0800 (PST)
Received: from localhost.localdomain ([216.13.234.27])
        by smtp.gmail.com with ESMTPSA id a19sm13054413pfo.52.2019.02.25.11.22.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 11:22:16 -0800 (PST)
From:   Alamy Liu <alamy.liu@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v2 2/2] mmc: cqhci: Fix a tiny potential memory leak on error condition
Date:   Mon, 25 Feb 2019 11:22:14 -0800
Message-Id: <20190225192214.3881-2-alamy.liu@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190225192214.3881-1-alamy.liu@gmail.com>
References: <20190225192214.3881-1-alamy.liu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free up the allocated memory in the case of error return

--- code study ---
The value of mmc_host->cqe_enabled stays 'false'.
Thus, cqhci_disable (mmc_cqe_ops->cqe_disable) won't be called to
free the memory.
Also, cqhci_disable() seems to be designed to disable and free
all resources, not suitable to handle this corner case.

Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
Signed-off-by: Alamy Liu <alamy.liu@gmail.com>
---
 drivers/mmc/host/cqhci.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index 974997b6cb..795893ba47 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -218,12 +218,21 @@ static int cqhci_host_alloc_tdl(struct cqhci_host *cq_host)
 						 cq_host->desc_size,
 						 &cq_host->desc_dma_base,
 						 GFP_KERNEL);
+	if (!cq_host->desc_base)
+		return -ENOMEM;
+
 	cq_host->trans_desc_base = dmam_alloc_coherent(mmc_dev(cq_host->mmc),
 					      cq_host->data_size,
 					      &cq_host->trans_desc_dma_base,
 					      GFP_KERNEL);
-	if (!cq_host->desc_base || !cq_host->trans_desc_base)
+	if (!cq_host->trans_desc_base) {
+		dmam_free_coherent(mmc_dev(cq_host->mmc), cq_host->desc_size,
+				   cq_host->desc_base,
+				   cq_host->desc_dma_base);
+		cq_host->desc_base = NULL;
+		cq_host->desc_dma_base = 0;
 		return -ENOMEM;
+	}
 
 	pr_debug("%s: cqhci: desc-base: 0x%p trans-base: 0x%p\n desc_dma 0x%llx trans_dma: 0x%llx\n",
 		 mmc_hostname(cq_host->mmc), cq_host->desc_base, cq_host->trans_desc_base,
-- 
2.17.1

