Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC6AC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237D62415D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237D62415D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbeFVLmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:42:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751313AbeFVLmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:42:40 -0400
Received: from ziggy.de (unknown [37.223.136.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DAD52415B;
        Fri, 22 Jun 2018 11:42:38 +0000 (UTC)
From:   Matthias Brugger <matthias.bgg@gmail.com>
To:     dmitry.torokhov@gmail.com, chen.zhong@mediatek.com,
        lee.jones@linaro.org
Cc:     matthias.bgg@gmail.com, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH] input: mtk-pmic-keys: Fix probe when no DT node present
Date:   Fri, 22 Jun 2018 13:42:28 +0200
Message-Id: <20180622114228.8619-1-matthias.bgg@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drivers gets probed from a mfd devices. So the driver runs
probe although no DT node exists. This leads to a NULL pointer
dereference in the probe function. Check if a node exists and
error out in case none is present.

Fixes: 3e9f0b3e2b27 ("input: Add MediaTek PMIC keys support")
Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index 02c67a1749fc..388043e1939c 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -257,6 +257,9 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
 	const struct of_device_id *of_id =
 		of_match_device(of_mtk_pmic_keys_match_tbl, &pdev->dev);
 
+	if (of_id == NULL)
+		return -ENODEV;
+
 	keys = devm_kzalloc(&pdev->dev, sizeof(*keys), GFP_KERNEL);
 	if (!keys)
 		return -ENOMEM;
-- 
2.17.1

