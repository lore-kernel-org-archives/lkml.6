Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA65C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 08:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3506C20869
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 08:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3506C20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeIHNdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 09:33:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11651 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726346AbeIHNdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 09:33:37 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AE97EEB277A67;
        Sat,  8 Sep 2018 16:48:33 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.399.0; Sat, 8 Sep 2018 16:48:31 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <tiwai@suse.com>, <perex@perex.cz>, <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <bgoswami@codeaurora.org>,
        <plai@codeaurora.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] sound: q6core: Use kmemdup to replace kzalloc + memcpy
Date:   Sat, 8 Sep 2018 16:36:19 +0800
Message-ID: <1536395780-18725-2-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1536395780-18725-1-git-send-email-zhongjiang@huawei.com>
References: <1536395780-18725-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup has implemented the function that kzalloc() + memcpy() will
do. and we prefer to use the kmemdup rather than the open coded implementation.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 sound/soc/qcom/qdsp6/q6core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6core.c b/sound/soc/qcom/qdsp6/q6core.c
index 06f03a5..ca1be73 100644
--- a/sound/soc/qcom/qdsp6/q6core.c
+++ b/sound/soc/qcom/qdsp6/q6core.c
@@ -105,12 +105,10 @@ static int q6core_callback(struct apr_device *adev, struct apr_resp_pkt *data)
 		bytes = sizeof(*fwk) + fwk->num_services *
 				sizeof(fwk->svc_api_info[0]);
 
-		core->fwk_version = kzalloc(bytes, GFP_ATOMIC);
+		core->fwk_version = kmemdup(data->payload, bytes, GFP_ATOMIC);
 		if (!core->fwk_version)
 			return -ENOMEM;
 
-		memcpy(core->fwk_version, data->payload, bytes);
-
 		core->fwk_version_supported = true;
 		core->resp_received = true;
 
@@ -124,12 +122,10 @@ static int q6core_callback(struct apr_device *adev, struct apr_resp_pkt *data)
 
 		len = sizeof(*v) + v->num_services * sizeof(v->svc_api_info[0]);
 
-		core->svc_version = kzalloc(len, GFP_ATOMIC);
+		core->svc_version = kmemdup(data->payload, len, GFP_ATOMIC);
 		if (!core->svc_version)
 			return -ENOMEM;
 
-		memcpy(core->svc_version, data->payload, len);
-
 		core->get_version_supported = true;
 		core->resp_received = true;
 
-- 
1.7.12.4

