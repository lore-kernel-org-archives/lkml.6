Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AED7C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533D32175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfBFKGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:06:38 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:58218 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726598AbfBFKGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:06:37 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x16A3tfV003010;
        Wed, 6 Feb 2019 04:05:51 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0b-001ae601.pphosted.com with ESMTP id 2qfp68rkf2-1;
        Wed, 06 Feb 2019 04:05:51 -0600
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id E0EA3611C8BB;
        Wed,  6 Feb 2019 04:05:58 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Wed, 6 Feb 2019
 10:05:50 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id x16A5nik007087; Wed,
 6 Feb 2019 10:05:49 GMT
Date:   Wed, 6 Feb 2019 10:05:49 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] ASoC: dapm: Check for NULL widget in dapm_update_dai_unlocked
Message-ID: <20190206100549.GO3837@imbe.wolfsonmicro.main>
References: <CGME20190205211638epcas3p409823d4acac8073473153d745151ea5f@epcas3p4.samsung.com>
 <20190205211622.GA5891@kozik-lap>
 <844c3f34-f7db-6b26-169a-994922367c78@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <844c3f34-f7db-6b26-169a-994922367c78@samsung.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=781 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902060080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAIs linked to the dummy will not have an associated playback/capture
widget, so we need to skip the update in that case.

Fixes: 078a85f2806f ("ASoC: dapm: Only power up active channels from a DAI")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Ok so that all makes sense, this patch is probably the best fix?

Thanks,
Charles

 sound/soc/soc-dapm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 482ddb825fb59..5235d8828758a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2570,6 +2570,9 @@ static int dapm_update_dai_unlocked(struct snd_pcm_substream *substream,
 	else
 		w = dai->capture_widget;
 
+	if (!w)
+		return 0;
+
 	dev_dbg(dai->dev, "Update DAI routes for %s %s\n", dai->name,
 		dir == SNDRV_PCM_STREAM_PLAYBACK ? "playback" : "capture");
 
-- 
2.11.0

