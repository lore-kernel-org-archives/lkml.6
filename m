Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B883BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E6C20820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CyeWGYtL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E6C20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392562AbeKVSHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:07:31 -0500
Received: from m12-14.163.com ([220.181.12.14]:44645 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728352AbeKVSHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:07:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=Z9V4SWJuxMzXS08SK2
        TY5KGlBC+wofk1r/EfrwgsdVE=; b=CyeWGYtLPdty4KwvXwe5wYenS6g2KJtD8x
        uOr3JKJHAISH8KJcEm92HFnk+rlJpu29HXNAy5LjeelYeMwzU+A/57SgG8FJrLxX
        Ajo7t21A0ONr04+E0+23Pn36soAagDosNvpk0dde3pLCFIZLEm+G2cBGhr3s+LAb
        0M5SrIEjo=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp10 (Coremail) with SMTP id DsCowAAXl87MWvZb_HgvBQ--.62410S3;
        Thu, 22 Nov 2018 15:29:18 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/memstick/host/jmb38x_ms: fixes incorrect error handling
Date:   Thu, 22 Nov 2018 15:29:20 +0800
Message-Id: <1542871760-48125-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DsCowAAXl87MWvZb_HgvBQ--.62410S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF17ZFyfXF1kZr4DCw4xtFb_yoW3Cwc_CF
        93Zr4fKrZ5ur1UGw15Zay3ur9rtw4vvrn2yw1rtws3X348ur1xGws2vry3urZxWFWUC3s8
        CrW7X3WS9ryjqjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeSD7DUUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiNg4HclWBcSPgbAAAsH
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree() is incorrectly used to free the memory chunk allocated by
memstick_alloc_host(). Instead, memstick_free_host() should be used.

Fixes: 60fdd931d577("memstick: add support for JMicron jmb38x ...")
Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/memstick/host/jmb38x_ms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
index bcdca9f..637409c 100644
--- a/drivers/memstick/host/jmb38x_ms.c
+++ b/drivers/memstick/host/jmb38x_ms.c
@@ -907,7 +907,7 @@ static struct memstick_host *jmb38x_ms_alloc_host(struct jmb38x_ms *jm, int cnt)
 
 	iounmap(host->addr);
 err_out_free:
-	kfree(msh);
+	memstick_free_host(msh);
 	return NULL;
 }
 
-- 
2.7.4


