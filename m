Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA8DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8F121479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8F121479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeKUSOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:14:08 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:42240 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbeKUSOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 13:14:08 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 89D153EA44BEDCCA6676;
        Wed, 21 Nov 2018 15:40:39 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wAL7eQIG084734;
        Wed, 21 Nov 2018 15:40:26 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018112115404502-12071388 ;
          Wed, 21 Nov 2018 15:40:45 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     qiang.zhao@nxp.com
Cc:     leoyang.li@nxp.com, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, wang.yi59@zte.com.cn,
        wen.yang99@zte.com.cn, Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH 2/4] soc/fsl/qe: fix potential NULL pointer dereference in ucc_of_parse_tdm
Date:   Wed, 21 Nov 2018 15:41:51 +0800
Message-Id: <1542786111-18648-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-21 15:40:45,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-21 15:40:18,
        Serialize complete at 2018-11-21 15:40:18
X-MAIL: mse01.zte.com.cn wAL7eQIG084734
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a possible null pointer dereference in
ucc_of_parse_tdm, detected by the semantic patch
deref_null.cocci, with the following warning:

./drivers/soc/fsl/qe/qe_tdm.c:177:21-24: ERROR: pdev is NULL but dereferenced.

The following code has potential null pointer references:
        pdev = of_find_device_by_node(np2);
        if (!pdev) {
                ret = -EINVAL;
                pr_err("%pOFn: failed to lookup pdev\n", np2);
                of_node_put(np2);
                goto err_miss_siram_property;
        }
...
err_miss_siram_property:
        devm_iounmap(&pdev->dev, utdm->si_regs);

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Reviewed-by: Tan Hu <tan.hu@zte.com.cn>
CC: Julia Lawall <julia.lawall@lip6.fr>
---
 drivers/soc/fsl/qe/qe_tdm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/qe_tdm.c b/drivers/soc/fsl/qe/qe_tdm.c
index f78c346..166378b 100644
--- a/drivers/soc/fsl/qe/qe_tdm.c
+++ b/drivers/soc/fsl/qe/qe_tdm.c
@@ -174,7 +174,8 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 	return ret;
 
 err_miss_siram_property:
-	devm_iounmap(&pdev->dev, utdm->si_regs);
+	if (pdev)
+		devm_iounmap(&pdev->dev, utdm->si_regs);
 	return ret;
 }
 EXPORT_SYMBOL(ucc_of_parse_tdm);
-- 
2.9.5

