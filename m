Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D3BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35AE2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="h2t2PmnQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfANPZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:25:05 -0500
Received: from m12-17.163.com ([220.181.12.17]:41789 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbfANPZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=Og8BZeed9Dm7OHTIhV
        cdl99gGRcQqsfQVhxANsneef4=; b=h2t2PmnQMMF89plCub2vXZ4sm64dj20bRP
        uUIumUF5B5+KiEt+nGVdNbR4PLuvlzydNN0UkMlKsEW5RFxUsvQD5uC69Ncge0FR
        r13PeKW+KMubtA6+2zC6ROsbH7jPNeMdxmwq7YLj3ca1lLZ4yifQ95ipceCjwMEp
        93Qs3rUsI=
Received: from localhost.localdomain (unknown [171.213.47.169])
        by smtp13 (Coremail) with SMTP id EcCowAA3BtfGqTxcAi+3Aw--.62S2;
        Mon, 14 Jan 2019 23:24:56 +0800 (CST)
From:   wangbo <wdjjwb@163.com>
To:     linux-kernel@vger.kernel.org
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        wang.bo116@zte.com.cn, wangbo <wdjjwb@163.com>
Subject: [PATCH] scsi: wd719x Replace GFP_KERNEL with GFP_ATOMIC in wd719x_chip_init
Date:   Mon, 14 Jan 2019 23:24:49 +0800
Message-Id: <1547479489-11560-1-git-send-email-wdjjwb@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EcCowAA3BtfGqTxcAi+3Aw--.62S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw1fArWxZw48Jr47XFy7Wrg_yoWxKFb_WF
        Wjvrn2qr4qkF17Aw18ZFs3Aa40vw4fXw4Dur1Ygry7u3ySgFn8J34Uuw17u3yrCF47Xry3
        Jw4jq34YyFsxCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1wID7UUUUU==
X-Originating-IP: [171.213.47.169]
X-CM-SenderInfo: xzgmy4re6rljoofrz/1tbiEBA8GVWBjXOAoQAAsu
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wd719x_host_reset get spinlock first then call wd719x_chip_init,
so replace GFP_KERNEL with GFP_ATOMIC in wd719x_chip_init.

Signed-off-by: wangbo <wang.bo116@zte.com.cn>
---
 drivers/scsi/wd719x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/wd719x.c b/drivers/scsi/wd719x.c
index e3310e9..7b1b645 100644
--- a/drivers/scsi/wd719x.c
+++ b/drivers/scsi/wd719x.c
@@ -318,7 +318,7 @@ static int wd719x_chip_init(struct wd719x *wd)
 
 	if (!wd->fw_virt)
 		wd->fw_virt = dma_alloc_coherent(&wd->pdev->dev, wd->fw_size,
-						 &wd->fw_phys, GFP_KERNEL);
+						 &wd->fw_phys, GFP_ATOMIC);
 	if (!wd->fw_virt) {
 		ret = -ENOMEM;
 		goto wd719x_init_end;
-- 
2.7.4


