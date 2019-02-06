Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C9EC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF09E2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfBFJ7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 04:59:03 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:47694 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726804AbfBFJ7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 04:59:03 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x169n1lk018182;
        Wed, 6 Feb 2019 03:58:26 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2qfp5p8pj2-1;
        Wed, 06 Feb 2019 03:58:25 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 2BFC8650F639;
        Wed,  6 Feb 2019 03:58:49 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Wed, 6 Feb 2019
 09:58:24 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id x169wMLJ001675; Wed,
 6 Feb 2019 09:58:22 GMT
Date:   Wed, 6 Feb 2019 09:58:22 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [BUG BISECT] NULL pointer after commit "ASoC: dapm: Only power
 up active channels from a DAI"
Message-ID: <20190206095822.GN3837@imbe.wolfsonmicro.main>
References: <20190205211622.GA5891@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190205211622.GA5891@kozik-lap>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=797 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902060078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 10:16:22PM +0100, Krzysztof Kozlowski wrote:
> Bisect pointed to commit:
>     commit 078a85f2806f0ffd11289009462a6a390f9adb5c
>     Author: Charles Keepax <ckeepax@opensource.cirrus.com>
>     Date:   Thu Jan 31 13:30:18 2019 +0000
>         ASoC: dapm: Only power up active channels from a DAI
> 
> as a bad commit for NULL pointer on my Odroid XU3 and Odroid U3 board when
> doing "aplay /usr/share/sounds/alsa/Front_Right.wav".
> 
> 1. Arch ARM Linux
> 2. exynos_defconfig
> 3. Odroid U3, XU3, Exynos SoC, ARMv7
> 
> Last address is in calltrace:
> c079552c
> dapm_update_dai_unlocked
> sound/soc/soc-dapm.c:2586
> 

Apologies for this one, is a little strange. I am assuming either
we end up with a NULL widget or more likely given the line
number a NULL path/widget on the path. Having some difficulty seeing
how we get into that state though.

Could you confirm what machine driver/DT is being used here? I am
assuming this is arch/arm/boot/dts/exynos4412-odroidu3.dts and
sound/soc/samsung/odroid.c. So will investigate those see if I
can find anything.

And could you try this diff and send through the output:

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 482ddb825fb59..9ee44b0192874 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2570,16 +2570,37 @@ static int dapm_update_dai_unlocked(struct snd_pcm_substream *substream,
        else
                w = dai->capture_widget;

+ if (!w) {
+         pr_err("CK -- NULL widget on %s\n", dai->name);
+         return 0;
+ }
+
        dev_dbg(dai->dev, "Update DAI routes for %s %s\n", dai->name,
                dir == SNDRV_PCM_STREAM_PLAYBACK ? "playback" : "capture");

        snd_soc_dapm_widget_for_each_sink_path(w, p) {
+         if (!p) {
+                 pr_err("DEBUG -- NULL sink path on %s\n", w->name);
+                 continue;
+         }
+         if (!p->sink) {
+                 pr_err("DEBUG -- NULL wink widget on %s\n", w->name);
+                 continue;
+         }
                ret = dapm_update_dai_chan(p, p->sink, channels);
                if (ret < 0)
                        return ret;
        }

        snd_soc_dapm_widget_for_each_source_path(w, p) {
+         if (!p) {
+                 pr_err("DEBUG -- NULL source path on %s\n", w->name);
+                 continue;
+         }
+         if (!p->source) {
+                 pr_err("DEBUG -- NULL source widget on %s\n", w->name);
+                 continue;
+         }
                ret = dapm_update_dai_chan(p, p->source, channels);
                if (ret < 0)
                        return ret;

Thanks,
Charles
