Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695CAC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 20:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC392084C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 20:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="TyxuJG7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfALUvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 15:51:03 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49430 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfALUvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 15:51:02 -0500
Received: from zn.tnic (p200300EC2BD30C0094DD7F5E07197EF6.dip0.t-ipconnect.de [IPv6:2003:ec:2bd3:c00:94dd:7f5e:719:7ef6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 84B9C1EC0A74;
        Sat, 12 Jan 2019 21:51:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547326260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=WqHfWkjTe1Bun1m6sWoF7zQTXWUQllmgMsdkpGFSznM=;
        b=TyxuJG7byp/esjc8VSRXFy/rkH2NKlCinhcSs6S0tFS2TAJIrjATdL4sHCcOVTPEHiNkRI
        wtwUanx4rtyR24MFvCVKUNO5/ozXfjkuzOgnmOqqE9KUUSVpdmurY03F3QvWyzdnW21q34
        xjBLMUEh+AE13TGZLh3JOKx9VR1dcb4=
Date:   Sat, 12 Jan 2019 21:50:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     dri-devel@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf
 last fence id 0x00000000017a67a1 on ring 0)
Message-ID: <20190112205051.GA1908@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

my odyssey with the GPU continues. This time it didn't reset itself
but started spewing a single line about the hardware locking up.

The machine was responsive to sysrq so I was able to write out
/var/log/messages and reboot.

This is still with 4.20-rc7 but I'm building 5.0-rc1 to see if there's a
difference.

Any and all ideas what to do here are greatly appreciated.

Thx.

Jan 12 21:38:16 zn vmunix: [257393.853806] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a0 on ring 0)
Jan 12 21:38:16 zn vmunix: [257394.369780] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a0 on ring 0)
Jan 12 21:38:17 zn vmunix: [257394.877795] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:17 zn vmunix: [257395.389789] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:18 zn vmunix: [257395.901786] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:18 zn vmunix: [257396.413787] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:19 zn vmunix: [257396.925790] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:19 zn vmunix: [257397.437787] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:20 zn vmunix: [257397.949788] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:20 zn vmunix: [257398.461786] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:21 zn vmunix: [257398.973824] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:21 zn vmunix: [257399.485828] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:22 zn vmunix: [257399.997842] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:22 zn vmunix: [257400.509852] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:23 zn vmunix: [257401.021845] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:23 zn vmunix: [257401.533826] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:24 zn vmunix: [257402.045822] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:24 zn vmunix: [257402.557826] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:25 zn vmunix: [257403.069833] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:25 zn vmunix: [257403.581826] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:26 zn vmunix: [257404.093828] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:26 zn vmunix: [257404.605827] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:27 zn vmunix: [257405.117821] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:27 zn vmunix: [257405.629883] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:28 zn vmunix: [257406.141842] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:28 zn vmunix: [257406.653828] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:29 zn vmunix: [257407.165827] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:29 zn vmunix: [257407.677827] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:30 zn vmunix: [257408.189823] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:30 zn vmunix: [257408.701827] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:31 zn vmunix: [257409.213827] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:32 zn vmunix: [257409.725822] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:32 zn vmunix: [257410.237827] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:33 zn vmunix: [257410.749833] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:33 zn vmunix: [257411.261824] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:34 zn vmunix: [257411.773828] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:34 zn vmunix: [257412.285827] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
