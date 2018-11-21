Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86977C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492F121479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WHrs5Fgo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492F121479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbeKUU2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:28:44 -0500
Received: from m12-11.163.com ([220.181.12.11]:60688 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbeKUU2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:28:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=PEt/7/vEcPWJBbY9lN
        VmnMzWQFEARF8oSnu621UdFhM=; b=WHrs5FgoT8Z28kMSz0MVRBlme5uesfIFOB
        dXzumylYgM5Pn2MLkZuc2pZc2Mu+PI7dnk+AzhOMPh/58DPVSUCalbHJkNvM1u5m
        CJzMiHVoqfmRd716Mj7yjZqBOcUg5Guzm9jQRevafifpcB6Oev/P+OVkwS60lIdE
        g/36FjFwM=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp7 (Coremail) with SMTP id C8CowACXpVAoK_Vb+kHtBA--.4484S3;
        Wed, 21 Nov 2018 17:54:18 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: use memunmap to free memremap
Date:   Wed, 21 Nov 2018 17:53:47 +0800
Message-Id: <1542794027-93141-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: C8CowACXpVAoK_Vb+kHtBA--.4484S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZry3CF4Dur43Wr15XrW3GFg_yoWxAFcEgF
        40vF4Iqr90vFWrZF1ayF9xZryqkw15uFZ3uFW8KFyayw4q9Fn7CFs5Zr4kXay3GrWUJF98
        tr4vyF4xAryxXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5znQUUUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBzwoGclaD0W5JawAAs5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memunmap() should be used to free the return of memremap(), not
iounmap().

Fixes: dfddb969edf0("iommu/vt-d: Switch from ioremap_cache to memremap")
Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/iommu/intel-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f3ccf02..41a4b88 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3075,7 +3075,7 @@ static int copy_context_table(struct intel_iommu *iommu,
 			}
 
 			if (old_ce)
-				iounmap(old_ce);
+				memunmap(old_ce);
 
 			ret = 0;
 			if (devfn < 0x80)
-- 
2.7.4


