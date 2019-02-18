Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE73C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E36B21916
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388855AbfBROh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:37:58 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60328 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388228AbfBROgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:36:53 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EBB41BB4D30A6FB9883D;
        Mon, 18 Feb 2019 22:36:47 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Mon, 18 Feb 2019 22:36:39 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Olivier Moysan <olivier.moysan@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <alsa-devel@alsa-project.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH v2 -next] ASoC: stm32: sai: remove set but not used variables 'mask, cr1'
Date:   Mon, 18 Feb 2019 14:50:26 +0000
Message-ID: <20190218145026.142805-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218134836.107220-1-yuehaibing@huawei.com>
References: <20190218134836.107220-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

sound/soc/stm/stm32_sai_sub.c: In function 'stm32_sai_configure_clock':
sound/soc/stm/stm32_sai_sub.c:902:11: warning:
 variable 'mask' set but not used [-Wunused-but-set-variable]
sound/soc/stm/stm32_sai_sub.c:902:6: warning:
 variable 'cr1' set but not used [-Wunused-but-set-variable]

It's not used any more after 8307b2afd386 ("ASoC: stm32: sai: set sai as
mclk clock provider")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: remove unnessesary if branch.
---
 sound/soc/stm/stm32_sai_sub.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index d4825700b63f..f9297228c41c 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -898,7 +898,7 @@ static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
 				     struct snd_pcm_hw_params *params)
 {
 	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
-	int cr1, mask, div = 0;
+	int div = 0;
 	int sai_clk_rate, mclk_ratio, den;
 	unsigned int rate = params_rate(params);
 
@@ -943,10 +943,8 @@ static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
 		} else {
 			if (sai->mclk_rate) {
 				mclk_ratio = sai->mclk_rate / rate;
-				if (mclk_ratio == 512) {
-					mask = SAI_XCR1_OSR;
-					cr1 = SAI_XCR1_OSR;
-				} else if (mclk_ratio != 256) {
+				if ((mclk_ratio != 512) &&
+				    (mclk_ratio != 256)) {
 					dev_err(cpu_dai->dev,
 						"Wrong mclk ratio %d\n",
 						mclk_ratio);



