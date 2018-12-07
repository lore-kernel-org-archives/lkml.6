Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8DBC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404322064D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xmck1bS0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404322064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbeLGSkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:40:46 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:37381 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeLGSkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:40:42 -0500
Received: by mail-ua1-f67.google.com with SMTP id u19so1748879uae.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 10:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SRCkAV/rwwCb6G1s504cXx97lfWxm12ZTF5AciiY020=;
        b=Xmck1bS0DtZaa+WeJixKR5fKXvJ0b/KkgVumJ+cB+BRhf2dA1IB3yHuUry37zHpQs6
         zaxAXd4KG8ZJT1/0HnMFp9V5QWu3sIojUVz3n8BmfxYYfJvsAIizcUxSgPQrz5Rov1t2
         CbtwE330HXlFJIaGEy1i92cSc9oRewduTt9lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SRCkAV/rwwCb6G1s504cXx97lfWxm12ZTF5AciiY020=;
        b=UgxKgpaNv02MsHXZXOG15Djihjlx95+PZA+u/sOsrlmfkByAaTWfYtw4ZdPiehcncS
         w23p9vdkhfWG/VQ4j2cAcxkeUMfKqrpC300Chnj4nH6nC6ovveX0ORz6pahYPTTU6d8L
         9OP9W+RPu0gMTeSeThf8prt/lqnxqcl9+vFk1yAgZuADFbvbKfHfx4ZVpQ9qZmAOaFb1
         pTgH/YZSh6CD6ttN/QplFb+wDFtxYTtb4Xk0zLFAELCQx9u11zUMWtRHMLyf6oD2+YA8
         cpCWtFj9bKTFsIFcg5nc+QF90UoIKt2beLgc/Gc3FNLXP5uT+E3Fxz2cn7vjgpSPuBJr
         qZcA==
X-Gm-Message-State: AA+aEWZcTli4M0jodhq2xTXfz18YPGosDEcO2fjf0pcHsPAd/z0D1hiS
        cclZsvEGhaeMnaIhv8g0IwsrEmvBa+I=
X-Google-Smtp-Source: AFSGD/Ws7SSgCy6KVeOpx0jUYtiOwsZxXvBOjyRT+dDQLneH5v3I+MkiCBFVrOm6mxE/sZ4VBg+lAw==
X-Received: by 2002:ab0:6198:: with SMTP id h24mr1454539uan.97.1544208040595;
        Fri, 07 Dec 2018 10:40:40 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id y195sm1746685vkd.0.2018.12.07.10.40.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 10:40:38 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id h78so3022150vsi.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 10:40:38 -0800 (PST)
X-Received: by 2002:a67:dd11:: with SMTP id y17mr1406802vsj.111.1544208038051;
 Fri, 07 Dec 2018 10:40:38 -0800 (PST)
MIME-Version: 1.0
References: <20181205033828.6156-1-dianders@chromium.org> <20181207174231.GD11961@arrakis.emea.arm.com>
In-Reply-To: <20181207174231.GD11961@arrakis.emea.arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 7 Dec 2018 10:40:24 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WO2xMojkEqKCMkufwihUvnow3yEH4GZPh7hh8noNZ+=A@mail.gmail.com>
Message-ID: <CAD=FV=WO2xMojkEqKCMkufwihUvnow3yEH4GZPh7hh8noNZ+=A@mail.gmail.com>
Subject: Re: [REPOST PATCH v6 0/4] kgdb: Fix kgdb_roundup_cpus()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>, mhocko@suse.com,
        linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>, dalias@libc.org,
        paulus@samba.org, "H. Peter Anvin" <hpa@zytor.com>,
        sparclinux@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-hexagon@vger.kernel.org, x86@kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>, jhogan@kernel.org,
        linux-snps-arc@lists.infradead.org, ying.huang@intel.com,
        linux-mips@vger.kernel.org, rppt@linux.vnet.ibm.com, bp@alien8.de,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        christophe.leroy@c-s.fr, Vineet Gupta <vgupta@synopsys.com>,
        Ralf Baechle <ralf@linux-mips.org>, rkuo@codeaurora.org,
        paul.burton@mips.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        mpe@ellerman.id.au, Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 7, 2018 at 9:42 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Dec 04, 2018 at 07:38:24PM -0800, Douglas Anderson wrote:
> > Douglas Anderson (4):
> >   kgdb: Remove irq flags from roundup
> >   kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
> >   kgdb: Don't round up a CPU that failed rounding up before
> >   kdb: Don't back trace on a cpu that didn't round up
>
> FWIW, trying these on arm64 (ThunderX2) with CONFIG_KGDB_TESTS_ON_BOOT=y
> on top of 4.20-rc5 doesn't boot. It looks like they leave interrupts
> disabled when they shouldn't and it trips over the BUG at
> mm/vmalloc.c:1380 (called via do_fork -> copy_process).
>
> Now, I don't think these patches make things worse on arm64 since prior
> to them the kgdb boot tests on arm64 were stuck in a loop (RUN
> singlestep).

Thanks for the report!  ...actually, I'd never tried CONFIG_KGDB_TESTS
before.  ...so I tried them now:

A) chromeos-4.19 tree on qcom-sdm845 without this series: booted up OK
B) chromeos-4.19 tree on qcom-sdm845 with this series: booted up OK
C) v4.20-rc5-90-g30002dd008ed on rockchip-rk3399 (kevin) with this
series: booted up OK

Example output from B) above:

localhost ~ # dmesg | grep kgdbts
[    2.139814] KGDB: Registered I/O driver kgdbts
[    2.144582] kgdbts:RUN plant and detach test
[    2.165333] kgdbts:RUN sw breakpoint test
[    2.172990] kgdbts:RUN bad memory access test
[    2.178640] kgdbts:RUN singlestep test 1000 iterations
[    2.187765] kgdbts:RUN singlestep [0/1000]
[    2.559596] kgdbts:RUN singlestep [100/1000]
[    2.931419] kgdbts:RUN singlestep [200/1000]
[    3.303474] kgdbts:RUN singlestep [300/1000]
[    3.675121] kgdbts:RUN singlestep [400/1000]
[    4.046867] kgdbts:RUN singlestep [500/1000]
[    4.418920] kgdbts:RUN singlestep [600/1000]
[    4.790824] kgdbts:RUN singlestep [700/1000]
[    5.162479] kgdbts:RUN singlestep [800/1000]
[    5.534103] kgdbts:RUN singlestep [900/1000]
[    5.902299] kgdbts:RUN do_fork for 100 breakpoints
[    8.463900] KGDB: Unregistered I/O driver kgdbts, debugger disabled

...so I guess I'm a little confused.  Either I have a different config
than you do or something is special about your machine?


NOTE: In general I've never considered "single step" as reliable in
kgdb.  I mostly use kgdb as "after the fact" crash debugging to
analyze local variables / memory / other tasks.  If it worked that'd
actually be kinda great, but at least when I started using kgdb years
ago I learned that it didn't work and stopped trying...


-Doug
