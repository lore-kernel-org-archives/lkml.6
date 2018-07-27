Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ECCC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CB62089B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34CB62089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbeG0NJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:09:52 -0400
Received: from bran.ispras.ru ([83.149.199.196]:16167 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729541AbeG0NJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:09:51 -0400
Received: from myklebust.intra.ispras.ru (unknown [10.10.2.207])
        by smtp.ispras.ru (Postfix) with ESMTP id 996FC203B2;
        Fri, 27 Jul 2018 14:48:16 +0300 (MSK)
From:   Anton Vasilyev <vasilyev@ispras.ru>
To:     Helen Koike <helen.koike@collabora.com>
Cc:     Anton Vasilyev <vasilyev@ispras.ru>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] media: vimc: Remove redundant free
Date:   Fri, 27 Jul 2018 14:47:59 +0300
Message-Id: <20180727114759.10601-1-vasilyev@ispras.ru>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4a29b7090749 ("[media] vimc: Subdevices as modules") removes
vimc allocation from vimc_probe(), so corresponding deallocation
on the error path tries to free static memory.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
 drivers/media/platform/vimc/vimc-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/vimc/vimc-core.c b/drivers/media/platform/vimc/vimc-core.c
index fe088a953860..9246f265de31 100644
--- a/drivers/media/platform/vimc/vimc-core.c
+++ b/drivers/media/platform/vimc/vimc-core.c
@@ -328,7 +328,6 @@ static int vimc_probe(struct platform_device *pdev)
 	if (ret) {
 		media_device_cleanup(&vimc->mdev);
 		vimc_rm_subdevs(vimc);
-		kfree(vimc);
 		return ret;
 	}
 
-- 
2.18.0

