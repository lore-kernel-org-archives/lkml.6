Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226ADC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE62720859
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfAFT2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 14:28:44 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:31371 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfAFT2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 14:28:44 -0500
Received: from localhost.localdomain (unknown [IPv6:2a02:8108:4840:8f74:143e:fcd5:beb7:2140])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id 64D7B13F838;
        Sun,  6 Jan 2019 20:28:36 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>
Subject: [PATCH 2/8] nvmem: core: Fix of_nvmem_cell_get() for optional cells
Date:   Sun,  6 Jan 2019 20:28:14 +0100
Message-Id: <20190106192820.12558-3-albeu@free.fr>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190106192820.12558-1-albeu@free.fr>
References: <20190106192820.12558-1-albeu@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_nvmem_cell_get() should return -ENOENT when a cell isn't defined,
otherwise callers can't distinguish between a missing cell and other
errors.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index cf2e1091fe89..f8c43da6f2ca 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1031,7 +1031,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
 
 	cell_np = of_parse_phandle(np, "nvmem-cells", index);
 	if (!cell_np)
-		return ERR_PTR(-EINVAL);
+		return ERR_PTR(-ENOENT);
 
 	nvmem_np = of_get_next_parent(cell_np);
 	if (!nvmem_np)
-- 
2.19.1

