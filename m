Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41E4C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76CA208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76CA208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbeH1FoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:44:20 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45090 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbeH1FoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:44:20 -0400
Received: by mail-oi0-f65.google.com with SMTP id t68-v6so1698785oie.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 18:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rh6W76aERtj34AivYjBtIfo6EjHUyukF1dZUI0dMekc=;
        b=iTTqaBD5eigvoyZNA9fUrOP7hwR5uhodGpiscidA4hJVIswyG2KrmW08nU4YVusCpW
         bB+UnN3r+h/QEiX/HzdEFOWxNSlb+p1XO3SMEJEj0ETMoMvth2XQuMdSxwKVw1JxI9GC
         7PoYRxFNbtgOm2X0YNxuZERwA4WKr5UFQZvCrNsmHe6oiSPQN85pXpRF4z3VCnXQi5fp
         zxPtoyexUkcEE5mJCjHGC450ert06j3ePQEEUimwxhbnHGe8mMQrkxICl8NJnbSwCKwp
         WSD4FtXJBmtFu2wA+aMgHxlNcDTbbnwlZh9SjmoAN782IrLeFHNm6Npq31NZjKPRsLFt
         WHIA==
X-Gm-Message-State: APzg51D+VO5uf/fS8E/j5Rh2PxevRmq/WdG+N1z0aXxnSFbWH5RDetcH
        UEt5B4hweoqPvmRoDZdASCL34T0=
X-Google-Smtp-Source: ANB0VdZgBveS9TQaXFx/QA5m9UZ2to2yhYaAENfn5aLp91ENj4E2vRSt4/tGGFVpaGIl/8rj7J4yzA==
X-Received: by 2002:aca:56d1:: with SMTP id k200-v6mr1140894oib.319.1535421303954;
        Mon, 27 Aug 2018 18:55:03 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:55:03 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] nvmem: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:38 -0500
Message-Id: <20180828015252.28511-37-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/nvmem/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index aa1657831b70..6988ee9f11ba 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -304,6 +304,7 @@ static void nvmem_cell_drop(struct nvmem_cell *cell)
 	mutex_lock(&nvmem_cells_mutex);
 	list_del(&cell->node);
 	mutex_unlock(&nvmem_cells_mutex);
+	kfree(cell->name);
 	kfree(cell);
 }
 
@@ -879,7 +880,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 	cell->nvmem = nvmem;
 	cell->offset = be32_to_cpup(addr++);
 	cell->bytes = be32_to_cpup(addr);
-	cell->name = cell_np->name;
+	cell->name = kasprintf(GFP_KERNEL, "%pOFn", cell_np);
 
 	addr = of_get_property(cell_np, "bits", &len);
 	if (addr && len == (2 * sizeof(u32))) {
@@ -904,6 +905,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 	return cell;
 
 err_sanity:
+	kfree(cell->name);
 	kfree(cell);
 
 err_mem:
-- 
2.17.1

