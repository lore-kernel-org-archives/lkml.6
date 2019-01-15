Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87FCC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A829720656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Z8HyUZR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbfAOKWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:22:08 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40366 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727703AbfAOKWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:22:07 -0500
Received: from zn.tnic (p200300EC2BCBB4000C4BA7EB962C71EB.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:b400:c4b:a7eb:962c:71eb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3457E1EC0B69;
        Tue, 15 Jan 2019 11:22:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547547726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aQAd3dcGSAHvWdq9RE1c/3tRXshLB8B+72EMBokzE7k=;
        b=Z8HyUZR5PHsr/GGJ7Gc2mqs1n7eA/PeHwifOF5G2oHTETjzwb80gT0XoCduzp/ULycANAl
        IAz07ix7OoqRGqzroDfu32zut/FsFmiR8viIR+bsD6jMn7OVXHRxTaS7LNBl84U2Mlw6gp
        5vSBjAKAhrCQL0aOHAGIkfAsrFjuFjo=
Date:   Tue, 15 Jan 2019 11:21:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     dri-devel@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: radeon 0000:1d:00.0: GPU lockup (current fence id
 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Message-ID: <20190115102155.GC6596@zn.tnic>
References: <20190112205051.GA1908@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190112205051.GA1908@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 09:50:51PM +0100, Borislav Petkov wrote:
> Hi guys,
> 
> my odyssey with the GPU continues. This time it didn't reset itself
> but started spewing a single line about the hardware locking up.
> 
> The machine was responsive to sysrq so I was able to write out
> /var/log/messages and reboot.
> 
> This is still with 4.20-rc7 but I'm building 5.0-rc1 to see if there's a
> difference.

Well, not really. This time the reset succeeded and the machine is still
alive:

[111333.620619] radeon 0000:1d:00.0: ring 0 stalled for more than 10360msec
[111333.620626] radeon 0000:1d:00.0: GPU lockup (current fence id 0x000000000080f31d last fence id 0x000000000080f416 on ring 0)
[111334.132277] radeon 0000:1d:00.0: ring 0 stalled for more than 10872msec
[111334.132283] radeon 0000:1d:00.0: GPU lockup (current fence id 0x000000000080f31d last fence id 0x000000000080f418 on ring 0)
[111334.199083] radeon 0000:1d:00.0: failed to get a new IB (-35)
[111334.199107] [drm:radeon_cs_ioctl [radeon]] *ERROR* Failed to get ib !
[111334.206116] radeon 0000:1d:00.0: Saved 8121 dwords of commands on ring 0.
[111334.206127] radeon 0000:1d:00.0: GPU softreset: 0x00000008
[111334.206130] radeon 0000:1d:00.0:   R_008010_GRBM_STATUS      = 0xA0001030
[111334.206132] radeon 0000:1d:00.0:   R_008014_GRBM_STATUS2     = 0x00000003
[111334.206135] radeon 0000:1d:00.0:   R_000E50_SRBM_STATUS      = 0x200000C0
[111334.206137] radeon 0000:1d:00.0:   R_008674_CP_STALLED_STAT1 = 0x00000000
[111334.206139] radeon 0000:1d:00.0:   R_008678_CP_STALLED_STAT2 = 0x00000000
[111334.206141] radeon 0000:1d:00.0:   R_00867C_CP_BUSY_STAT     = 0x00020182
[111334.206144] radeon 0000:1d:00.0:   R_008680_CP_STAT          = 0x80028645
[111334.206146] radeon 0000:1d:00.0:   R_00D034_DMA_STATUS_REG   = 0x44C83D57
[111334.272194] radeon 0000:1d:00.0: R_008020_GRBM_SOFT_RESET=0x00004001
[111334.272247] radeon 0000:1d:00.0: SRBM_SOFT_RESET=0x00000100
[111334.274336] radeon 0000:1d:00.0:   R_008010_GRBM_STATUS      = 0xA0003030
[111334.274338] radeon 0000:1d:00.0:   R_008014_GRBM_STATUS2     = 0x00000003
[111334.274339] radeon 0000:1d:00.0:   R_000E50_SRBM_STATUS      = 0x200080C0
[111334.274341] radeon 0000:1d:00.0:   R_008674_CP_STALLED_STAT1 = 0x00000000
[111334.274342] radeon 0000:1d:00.0:   R_008678_CP_STALLED_STAT2 = 0x00000000
[111334.274344] radeon 0000:1d:00.0:   R_00867C_CP_BUSY_STAT     = 0x00000000
[111334.274345] radeon 0000:1d:00.0:   R_008680_CP_STAT          = 0x80100000
[111334.274347] radeon 0000:1d:00.0:   R_00D034_DMA_STATUS_REG   = 0x44C83D57
[111334.274354] radeon 0000:1d:00.0: GPU reset succeeded, trying to resume
[111334.290030] [drm] PCIE gen 2 link speeds already enabled
[111334.292121] [drm] PCIE GART of 512M enabled (table at 0x0000000000142000).
[111334.292135] radeon 0000:1d:00.0: WB enabled
[111334.292137] radeon 0000:1d:00.0: fence driver on ring 0 use gpu addr 0x0000000020000c00 and cpu addr 0x00000000fb2c042c
[111334.292325] radeon 0000:1d:00.0: fence driver on ring 5 use gpu addr 0x00000000000521d0 and cpu addr 0x0000000014f22c80
[111334.323193] [drm] ring test on 0 succeeded in 0 usecs
[111334.497890] [drm] ring test on 5 succeeded in 1 usecs
[111334.497896] [drm] UVD initialized successfully.
[111334.724316] [drm] ib test on ring 0 succeeded in 0 usecs
[111335.380416] [drm] ib test on ring 5 succeeded

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
