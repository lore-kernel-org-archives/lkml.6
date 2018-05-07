Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbeEGBb6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 21:31:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7228 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751444AbeEGBb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 21:31:57 -0400
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Kai Chieh Chuang <kaichieh.chuang@mediatek.com>
CC: Wei Yongjun <weiyongjun1@huawei.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ASoC: fix return value check in mt6351_codec_driver_probe()
Date: Mon, 7 May 2018 01:39:45 +0000
Message-ID: <1525657185-73163-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error, the function dev_get_regmap() returns NULL pointer not
ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/codecs/mt6351.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/mt6351.c b/sound/soc/codecs/mt6351.c
index e739f07..f73dcd7 100644
--- a/sound/soc/codecs/mt6351.c
+++ b/sound/soc/codecs/mt6351.c
@@ -1472,8 +1472,8 @@ static int mt6351_codec_driver_probe(struct platform_device *pdev)
 	priv->dev = &pdev->dev;
 
 	priv->regmap = dev_get_regmap(pdev->dev.parent, NULL);
-	if (IS_ERR(priv->regmap))
-		return PTR_ERR(priv->regmap);
+	if (!priv->regmap)
+		return -ENODEV;
 
 	dev_dbg(priv->dev, "%s(), dev name %s\n",
 		__func__, dev_name(&pdev->dev));
