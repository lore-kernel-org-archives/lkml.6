Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEC6C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A85F20823
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549401390;
	bh=bNJWF30YBDX/UvrlQMSCZ0p8DkLYviaviFNRV1G/vyU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=rgAoTQXlJFSYCI4pqdYHs/9jXgXyvGQp+1lRi7kbnNUT0+lH30J3fvrNLDle7lXHW
	 7VvU2Wtn5Bzt+MDjMAxRkD9HZZ/NiM0K08qtwjjrBvzWYRn534xbiAH1ya9b/dSbEf
	 sQ5Gnbem7lzurbzL7AZTv6G0uL7SMXojXnTQMu/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfBEVQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 16:16:28 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34563 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfBEVQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 16:16:28 -0500
Received: by mail-ed1-f67.google.com with SMTP id b3so4185691ede.1;
        Tue, 05 Feb 2019 13:16:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=u6/QppOMYn7WSchKOle0UyJwhZPdpOmwOaOcw+7EyUk=;
        b=flsY0F4HjB8qYl1M/C5ja/e2hnbx09PZMiDJB06pI+gJ3qv/cturiExEiG03rE0/kR
         UgpnuH2mWOey92dUjLBvBz6IjrMzCYa1bcpkpBovvKuWpAzb4hjJAFhHPzCF+VxHObiA
         lILM6XeltpZ13vvKif1+BXHsKRMWNFBPpf2xLbNHDz6roNmq2WiOByWYWmBK0QA2QtaX
         oHEUyI2ofAGrYauDmG5hoozRA6kqF5tcCsH+yj079Y5oaULxdxBxurGuopWaZ8GNQVFM
         emNl+DkSk0Ubbbt69i8bk/mK0S8tb8QvlrWN/C7o8MjOf95K988NSoQ9Sgu7oH/0myy3
         0sSA==
X-Gm-Message-State: AHQUAuaybYq3FSUwMjr5d/GVvukbfl5989L/QJKuch/jgNF6EvH9OICQ
        nLJ4EfJyPjF9p2DdRsrjddI=
X-Google-Smtp-Source: AHgI3IbUheeLALwe9UotXLhsdHPBzGxzbz0a4jllsJkEitmDZ9pYcynRb7mQHtcXn83HpGa0j6S6YA==
X-Received: by 2002:a17:906:4ac2:: with SMTP id u2mr5017308ejt.94.1549401385420;
        Tue, 05 Feb 2019 13:16:25 -0800 (PST)
Received: from kozik-lap ([194.230.155.153])
        by smtp.googlemail.com with ESMTPSA id b45sm5169374eda.34.2019.02.05.13.16.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 13:16:24 -0800 (PST)
Date:   Tue, 5 Feb 2019 22:16:22 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [BUG BISECT] NULL pointer after commit "ASoC: dapm: Only power up
 active channels from a DAI"
Message-ID: <20190205211622.GA5891@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Bisect pointed to commit:
    commit 078a85f2806f0ffd11289009462a6a390f9adb5c
    Author: Charles Keepax <ckeepax@opensource.cirrus.com>
    Date:   Thu Jan 31 13:30:18 2019 +0000
        ASoC: dapm: Only power up active channels from a DAI

as a bad commit for NULL pointer on my Odroid XU3 and Odroid U3 board when
doing "aplay /usr/share/sounds/alsa/Front_Right.wav".

1. Arch ARM Linux
2. exynos_defconfig
3. Odroid U3, XU3, Exynos SoC, ARMv7

Last address is in calltrace:
c079552c
dapm_update_dai_unlocked
sound/soc/soc-dapm.c:2586

Full log:

Unable to handle kernel NULL pointer dereference at virtual address 0000007c
pgd = d5b32ef7
[0000007c] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT SMP ARM
Modules linked in: s5p_mfc s5p_jpeg exynos_gsc v4l2_mem2mem v4l2_common videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 videobuf2_common videodev media s5p_cec
CPU: 7 PID: 359 Comm: aplay Not tainted 5.0.0-rc4-00177-g078a85f2806f #32
Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
PC is at dapm_update_dai_unlocked+0x38/0x138
LR is at snd_soc_dapm_update_dai+0x34/0x4c
pc : [<c079552c>]    lr : [<c0795660>]    psr: 60010013
sp : eb9d9be8  ip : eabc8b64  fp : ecce0e10
r10: c100b448  r9 : ecce0e0c  r8 : 00000000
r7 : 00000000  r6 : 00000000  r5 : 00000002  r4 : ecce0800
r3 : 00000000  r2 : eccaa080  r1 : ecdab000  r0 : 00000000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 6c09806a  DAC: 00000051
Process aplay (pid: 359, stack limit = 0x4ae0a814)
Stack: (0xeb9d9be8 to 0xeb9da000)
9be0:                   ecce0e0c c100b448 ecce0e10 ecce0800 ecd64400 ecdab000
9c00: eccaa080 c0795660 ee3c480c ecd64400 ecce0800 ecdab000 00000000 c079d760
9c20: eccaa080 ecce080c 00000000 00000001 00000000 00000000 00000000 00000000
9c40: 00000000 00000000 00000000 00000004 00000000 00000000 00000000 00000000
9c60: 00000000 00000000 00000000 00000001 00000000 00000000 00000000 00000000
9c80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9ca0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9cc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9ce0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9d00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9d20: 00000000 00000000 00000000 00000010 00000010 00000004 00000020 00000020
9d40: 00000004 00000002 00000002 00000004 0000bb80 0000bb80 00000004 0001e848
9d60: 0001e848 00000004 00001770 00001770 00000004 00005dc0 00005dc0 00000004
9d80: 00000004 00000004 00000004 0007a120 0007a120 00000004 00005dc0 00005dc0
9da0: 00000004 00017700 00017700 00000004 00000000 00000000 00000004 00000000
9dc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9de0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9e00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9e20: 00000000 00000000 00000000 000fff07 00200103 00000010 0000bb80 00000001
9e40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9e60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9e80: 00000000 8c6972bb ecdab000 ecd64400 ecdab000 00000000 c0b97b1c ebfe8000
9ea0: 00000000 bea4eea0 b6effb88 c07825e4 c100b448 ecdab000 ecd64400 00000000
9ec0: ecfdd180 ec1bde40 bea4eea0 c07836e0 eb9d9f78 00000000 00000000 00000001
9ee0: 61746164 c0294d70 00000001 8c6972bb c100b448 bea4eea0 ecfdd180 c02a9bac
9f00: bea4eea0 eb9d8000 ed4aafa8 c02a9244 eb9cbb80 c100b448 00000000 00000000
9f20: 00000000 00000000 00000000 8c6972bb eb9d9fb0 ec6f11c0 eb9cbb80 00000002
9f40: eb9cbb88 00000001 b6e85b6f 00000001 61746164 c0295028 00000000 00000000
9f60: c100b448 8c6972bb 00000000 ecfdd180 ecfdd180 00000004 c25c4111 bea4eea0
9f80: eb9d8000 00000036 b6effb88 c02a9bac 004cf1b8 bea4eea0 004cf208 00000036
9fa0: c01011c4 c0101000 004cf1b8 bea4eea0 00000004 c25c4111 bea4eea0 00020001
9fc0: 004cf1b8 bea4eea0 004cf208 00000036 bea4ee10 00000000 b6fb5900 b6effb88
9fe0: b6f6c82c bea4edf4 b6efbfc4 b6e0bbdc 200d0010 00000004 00000000 00000000
[<c079552c>] (dapm_update_dai_unlocked) from [<c0795660>] (snd_soc_dapm_update_dai+0x34/0x4c)
[<c0795660>] (snd_soc_dapm_update_dai) from [<c079d760>] (soc_pcm_hw_params+0x22c/0x624)
[<c079d760>] (soc_pcm_hw_params) from [<c07825e4>] (snd_pcm_hw_params+0x128/0x378)
[<c07825e4>] (snd_pcm_hw_params) from [<c07836e0>] (snd_pcm_ioctl+0x26c/0x1258)
[<c07836e0>] (snd_pcm_ioctl) from [<c02a9244>] (do_vfs_ioctl+0xb0/0x9e4)
[<c02a9244>] (do_vfs_ioctl) from [<c02a9bac>] (ksys_ioctl+0x34/0x58)
[<c02a9bac>] (ksys_ioctl) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
Exception stack(0xeb9d9fa8 to 0xeb9d9ff0)
9fa0:                   004cf1b8 bea4eea0 00000004 c25c4111 bea4eea0 00020001
9fc0: 004cf1b8 bea4eea0 004cf208 00000036 bea4ee10 00000000 b6fb5900 b6effb88
9fe0: b6f6c82c bea4edf4 b6efbfc4 b6e0bbdc
Code: e3530000 e5926020 1a00003a e1a07006 (e5b7407c) 
---[ end trace 8561600efcd2b2f1 ]---

Let me know if you need any other data.


Best regards,
Krzysztof

