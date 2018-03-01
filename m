Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162571AbeCAWYC convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 17:24:02 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:55233 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1162460AbeCAWYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 17:24:01 -0500
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To: kuninori.morimoto.gx@renesas.com
Cc: broonie@kernel.org, maxime.ripard@free-electrons.com, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [BUG] Kernel crash on Allwinner H3 due to sound core changes
Date: Thu, 01 Mar 2018 23:23:57 +0100
Message-ID: <63331816.68OamKINx1@jernej-laptop>
In-Reply-To: <2424862.oPtAVTfrB9@jernej-laptop>
References: <2424862.oPtAVTfrB9@jernej-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kuninori,

I'm responding to my own mail, since I didn't received yours for some reason 
but I still saw your response in mailing list archive.

Dne sreda, 28. februar 2018 ob 22:02:09 CET je Jernej Škrabec napisal(a):
> Hi all,
> 
> with todays linux-next (next-20180228), kernel on Allwinner H3 SoC crashes
> with dmesg like that: https://pastebin.com/raw/0D5JeaJ8
> 
> I bisected the kernel and first offending commit is:
> be7ee5f32a9a ("ASoC: soc-generic-dmaengine-pcm: replace platform to
> component")
> 
> I know that crash message is completely unrelated to sound subsystem, but it
> turns out that if I disable CONFIG_SND_SUN4I_CODEC kernel works ok, but
> this way I lose analog audio output.
> 
> Any suggestions what can be the issue?

I did a bit of research and I can tell you that different kernel options (some 
drivers added or removed) change how or where kernel crashes. That would 
suggest some kind of memory corruption.

I removed parts of the code from the sun4i codec driver and interestingly it 
doesn't crash if I remove following lines:

ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
if (ret) {
	dev_err(&pdev->dev, "Failed to register against DMAEngine\n");
	goto err_assert_reset;
}

Is it possible that NULL pointer causes troubles somewhere down the line?

I tested this on linux-next, next-20180228 tag.

Best regards,
Jernej
