Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEDBC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 08:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A1420844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 08:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A1420844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbeIHNdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 09:33:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11652 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726346AbeIHNdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 09:33:36 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A3D3D8685A737;
        Sat,  8 Sep 2018 16:48:33 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.399.0; Sat, 8 Sep 2018 16:48:32 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <tiwai@suse.com>, <perex@perex.cz>, <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <bgoswami@codeaurora.org>,
        <plai@codeaurora.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] sound: skl-topology: Use kmemdup to replace kzalloc + memcpy
Date:   Sat, 8 Sep 2018 16:36:20 +0800
Message-ID: <1536395780-18725-3-git-send-email-zhongjiang@huawei.com>
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
do. and we prefer to kmemdup rather than the open coded implementation.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 sound/soc/intel/skylake/skl-topology.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 2620d77..52a9915 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -898,11 +898,10 @@ static int skl_tplg_set_module_bind_params(struct snd_soc_dapm_widget *w,
 			bc = (struct skl_algo_data *)sb->dobj.private;
 
 			if (bc->set_params == SKL_PARAM_BIND) {
-				params = kzalloc(bc->max, GFP_KERNEL);
+				params = kmemdup(bc->params, bc->max, GFP_KERNEL);
 				if (!params)
 					return -ENOMEM;
 
-				memcpy(params, bc->params, bc->max);
 				skl_fill_sink_instance_id(ctx, params, bc->max,
 								mconfig);
 
-- 
1.7.12.4

