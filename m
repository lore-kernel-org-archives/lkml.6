Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D33C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221212184E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfBFLBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:01:06 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:34182 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726159AbfBFLBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:01:05 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x16AsbCn005654;
        Wed, 6 Feb 2019 04:59:57 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0b-001ae601.pphosted.com with ESMTP id 2qfp68rmxg-1;
        Wed, 06 Feb 2019 04:59:57 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id ED6D8611C8B3;
        Wed,  6 Feb 2019 05:00:20 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Wed, 6 Feb 2019
 10:59:56 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id x16AxtVa016379; Wed,
 6 Feb 2019 10:59:55 GMT
Date:   Wed, 6 Feb 2019 10:59:55 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] ASoC: dapm: Check for NULL widget in
 dapm_update_dai_unlocked
Message-ID: <20190206105955.GP3837@imbe.wolfsonmicro.main>
References: <CGME20190205211638epcas3p409823d4acac8073473153d745151ea5f@epcas3p4.samsung.com>
 <20190205211622.GA5891@kozik-lap>
 <844c3f34-f7db-6b26-169a-994922367c78@samsung.com>
 <20190206100549.GO3837@imbe.wolfsonmicro.main>
 <CAJKOXPejBO_9iBHg1R8M2=tcuTck72DjxTYEUyQOp8cPV-0xTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJKOXPejBO_9iBHg1R8M2=tcuTck72DjxTYEUyQOp8cPV-0xTg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=890 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902060087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 11:22:33AM +0100, Krzysztof Kozlowski wrote:
> On Wed, 6 Feb 2019 at 11:05, Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> >
> > DAIs linked to the dummy will not have an associated playback/capture
> > widget, so we need to skip the update in that case.
> >
> > Fixes: 078a85f2806f ("ASoC: dapm: Only power up active channels from a DAI")
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> >
> > Ok so that all makes sense, this patch is probably the best fix?
> >
> > Thanks,
> > Charles
> 
> For this particular issue (NULL-pointer):
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> However now I see bug sleeping in atomic context:
> 
> [   64.000828] BUG: sleeping function called from invalid context at
> ../kernel/locking/mutex.c:908

Does this probably definitely get fixed by reverting my patch?
It's just a bit odd as this seems to be complaining about a clock
operation in i2s_trigger and I don't think my patch should have
any affect on the trigger callback. It should get run from either
the dai_link DAPM event or hw_params, neither of which should
happen in an atomic context.

> [   64.307534] the existing dependency chain (in reverse order) is:
> [   64.314985]
> [   64.314985] -> #1 (&(&pri_dai->spinlock)->rlock){....}:
> [   64.321667]        clk_mux_set_parent+0x34/0xb8
> [   64.326162]        clk_core_set_parent_nolock+0x21c/0x54c
> [   64.331535]        clk_set_parent+0x38/0x6c
> [   64.335696]        of_clk_set_defaults+0x11c/0x384
> [   64.340460]        of_clk_add_provider+0x8c/0xc8
> [   64.345054]        samsung_i2s_probe+0x484/0x64c
> [   64.349651]        platform_drv_probe+0x6c/0xa4
> [   64.354153]        really_probe+0x280/0x414
> [   64.358311]        driver_probe_device+0x78/0x1c4
> [   64.362991]        bus_for_each_drv+0x74/0xb8
> [   64.367323]        __device_attach+0xd4/0x16c
> [   64.371655]        bus_probe_device+0x88/0x90
> [   64.375988]        deferred_probe_work_func+0x4c/0xd0
> [   64.381017]        process_one_work+0x228/0x810
> [   64.385520]        worker_thread+0x30/0x570
> [   64.389681]        kthread+0x134/0x164
> [   64.393405]        ret_from_fork+0x14/0x20
> [   64.397477]          (null)
> [   64.400249]
> [   64.400249] -> #0 (prepare_lock){+.+.}:
> [   64.405539]        __mutex_lock+0x7c/0xa98
> [   64.409610]        mutex_lock_nested+0x1c/0x24
> [   64.414029]        clk_prepare_lock+0x50/0xf8
> [   64.418362]        clk_core_get_rate+0xc/0x60
> [   64.422695]        i2s_trigger+0x444/0x6c8
> [   64.426768]        soc_pcm_trigger+0x100/0x140
> [   64.431188]        snd_pcm_action_single+0x38/0x80
> [   64.435953]        snd_pcm_action+0x54/0x5c
> [   64.440112]        snd_pcm_action_lock_irq+0x28/0x3c
> [   64.445052]        snd_pcm_ioctl+0x920/0x123c
> [   64.449386]        do_vfs_ioctl+0xb0/0x9f8
> [   64.453457]        ksys_ioctl+0x34/0x5c
> [   64.457269]        ret_fast_syscall+0x0/0x28
> [   64.461516]        0xbe8db8ec

Thanks,
Charles
