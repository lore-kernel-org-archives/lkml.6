Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752D4C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D0220C03
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D0220C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbeHNK7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 06:59:45 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:35610 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726053AbeHNK7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 06:59:45 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7E89NTm001293;
        Tue, 14 Aug 2018 03:12:46 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2ksw6yk8p1-1;
        Tue, 14 Aug 2018 03:12:46 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id C8E8E611C8AC;
        Tue, 14 Aug 2018 03:14:33 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 14 Aug 2018
 09:12:45 +0100
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w7E8ChwS020612; Tue,
 14 Aug 2018 09:12:43 +0100
Date:   Tue, 14 Aug 2018 09:12:43 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
CC:     <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "Jaroslav Kysela" <perex@perex.cz>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Robert Jarzmik" <robert.jarzmik@free.fr>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v2] ASoC: wm9712: fix replace codec to component
Message-ID: <20180814081243.GM32322@imbe.wolfsonmicro.main>
References: <20180813223556.16262-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180813223556.16262-1-marcel@ziswiler.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=660 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1808140084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 12:35:56AM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Since commit 143b44845d87 ("ASoC: wm9712: replace codec to component")
> "wm9712-codec" got renamed to "wm9712-component", however, this change
> never got propagated down to the actual board/platform drivers. E.g. on
> Colibri T20 this lead to the following spew upon boot with sound/touch
> being broken:
> 
> [    2.214121] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
> [    2.222137] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
> ...
> [    2.344384] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
> [    2.351885] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
> ...
> [    2.668339] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
> [    2.675811] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
> ...
> [    3.208408] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
> [    3.216312] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
> ...
> [    3.235397] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
> [    3.248938] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
> ...
> [   14.970443] ALSA device list:
> [   14.996628]   No soundcards found.
> 
> This commit finally fixes this again.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
