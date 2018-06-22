Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C88C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022BC23C47
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022BC23C47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934171AbeFVCSA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 22:18:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53020 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932514AbeFVCR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 22:17:59 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CEABBCF73D395;
        Fri, 22 Jun 2018 10:17:55 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.382.0; Fri, 22 Jun 2018 10:17:50 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ASoC: rt1305: use devm_snd_soc_register_component()
Date:   Fri, 22 Jun 2018 02:23:34 +0000
Message-ID: <1529634214-105520-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using devm_snd_soc_register_component() and drop all of the code
related to .remove hook.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/codecs/rt1305.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt1305.c b/sound/soc/codecs/rt1305.c
index 421b8fb..c4452ef 100644
--- a/sound/soc/codecs/rt1305.c
+++ b/sound/soc/codecs/rt1305.c
@@ -1150,17 +1150,11 @@ static int rt1305_i2c_probe(struct i2c_client *i2c,
 	rt1305_reset(rt1305->regmap);
 	rt1305_calibrate(rt1305);
 
-	return snd_soc_register_component(&i2c->dev, &soc_component_dev_rt1305,
+	return devm_snd_soc_register_component(&i2c->dev,
+			&soc_component_dev_rt1305,
 			rt1305_dai, ARRAY_SIZE(rt1305_dai));
 }
 
-static int rt1305_i2c_remove(struct i2c_client *i2c)
-{
-	snd_soc_unregister_component(&i2c->dev);
-
-	return 0;
-}
-
 static void rt1305_i2c_shutdown(struct i2c_client *client)
 {
 	struct rt1305_priv *rt1305 = i2c_get_clientdata(client);
@@ -1180,7 +1174,6 @@ static void rt1305_i2c_shutdown(struct i2c_client *client)
 #endif
 	},
 	.probe = rt1305_i2c_probe,
-	.remove   = rt1305_i2c_remove,
 	.shutdown = rt1305_i2c_shutdown,
 	.id_table = rt1305_i2c_id,
 };

