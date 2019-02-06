Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F63C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3AB2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfBFLEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:04:10 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:34512 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726997AbfBFLEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:04:10 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x16AsbDB005654;
        Wed, 6 Feb 2019 05:03:12 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0b-001ae601.pphosted.com with ESMTP id 2qfp68rn2g-1;
        Wed, 06 Feb 2019 05:03:11 -0600
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id BC53D611C8BB;
        Wed,  6 Feb 2019 05:03:19 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Wed, 6 Feb 2019
 11:03:10 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id x16B3AWb016565; Wed,
 6 Feb 2019 11:03:10 GMT
Date:   Wed, 6 Feb 2019 11:03:10 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-samsung-soc@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [BUG BISECT] NULL pointer after commit "ASoC: dapm: Only power
 up active channels from a DAI"
Message-ID: <20190206110310.GQ3837@imbe.wolfsonmicro.main>
References: <CGME20190205211638epcas3p409823d4acac8073473153d745151ea5f@epcas3p4.samsung.com>
 <20190205211622.GA5891@kozik-lap>
 <844c3f34-f7db-6b26-169a-994922367c78@samsung.com>
 <5f4f2221-f11f-98c8-fadc-e713f4623246@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5f4f2221-f11f-98c8-fadc-e713f4623246@samsung.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=489 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902060087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 11:11:03AM +0100, Sylwester Nawrocki wrote:
> On 2/6/19 10:46, Sylwester Nawrocki wrote:
> > On 2/5/19 22:16, Krzysztof Kozlowski wrote:
> >> Bisect pointed to commit:
> >>     commit 078a85f2806f0ffd11289009462a6a390f9adb5c
> >>     Author: Charles Keepax <ckeepax@opensource.cirrus.com>
> >>     Date:   Thu Jan 31 13:30:18 2019 +0000
> >>         ASoC: dapm: Only power up active channels from a DAI
> >>
> >> as a bad commit for NULL pointer on my Odroid XU3 and Odroid U3 board when
> >> doing "aplay /usr/share/sounds/alsa/Front_Right.wav".
> >>
> >> 1. Arch ARM Linux
> >> 2. exynos_defconfig
> >> 3. Odroid U3, XU3, Exynos SoC, ARMv7
> >>
> >> Last address is in calltrace:
> >> c079552c
> >> dapm_update_dai_unlocked
> >> sound/soc/soc-dapm.c:2586
> > 
> > Thanks for bisecting this, I ran into same issue last night and I'm starting
> > to debug this now. I have added some debug prints and it looks like it oopses
> > on NULL playback_widget of the dummy DAI.
> > 
> > [   30.701182] hdmi-audio-codec hdmi-audio-codec.0.auto: Update DAI routes for i2s-hifi playback
> > [   30.709630] dapm_update_dai_unlocked:2586 w=8bd27d28
> > [   30.714403] dapm_update_dai_unlocked:2594 w=8bd27d28
> > [   30.724688] max98090 5-0010: Update DAI routes for HiFi playback
> > [   30.730163] dapm_update_dai_unlocked:2586 w=3fc942af
> > [   30.735154] dapm_update_dai_unlocked:2594 w=3fc942af
> > [   30.745051] snd-soc-dummy snd-soc-dummy: Update DAI routes for snd-soc-dummy-dai playback
> > [   30.753128] dapm_update_dai_unlocked:2586 w=  (null)
> > [   30.758114] Unable to handle kernel NULL pointer dereference at virtual address 0000007c
> 
> With a change as below there is no oops and everything works again,
> but I'm not sure this is a proper fix.
> 

I think this is the proper fix, if we have DAIs which don't have
capture/playback widgets then there should be no parts of the
DAPM graph that need updated in relation to the number of
channels, so skipping the processing seems fine.

Thanks,
Charles

> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index 5b74dffc9c11..111a23a9708a 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -2580,6 +2580,9 @@ static int dapm_update_dai_unlocked(struct snd_pcm_substream *substream,
>         else
>                 w = dai->capture_widget;
>  
> +       if (!w)
> +               return 0;
> +
>         dev_dbg(dai->dev, "Update DAI routes for %s %s\n", dai->name,
>                 dir == SNDRV_PCM_STREAM_PLAYBACK ? "playback" : "capture");
> 
> -- 
> Thanks,
> Sylwester
