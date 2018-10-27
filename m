Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C04C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 14:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA7E2085B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 14:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA7E2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbeJ0X2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 19:28:48 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37183 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbeJ0X2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 19:28:47 -0400
Received: by mail-ua1-f66.google.com with SMTP id y5so1434751uap.4;
        Sat, 27 Oct 2018 07:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MxvITRTep+3IFO2+j+EOZCxGmdUigxuzqPa+CRR0G4g=;
        b=gqOJLEXDmY4M69CrKcVd9naZCijisdO1n0FaiBDBxiX21LcLHsZ7SNfNLrxB3ymwwS
         1r77OFDbvlPuPhgB0KMO6DlFRGDMDaijB/iMrE0zw5efyD3QV3hjfp01EHHMm0CnbdR4
         efP40GkU1QrCTAgzelLPD2Lioal+Tul7lNKQRKNOXJVoj+o/HLwVysoTJh2YXM6+KeL2
         OBhAAyuGmaAwqD52Jv2RdjJWwrS/GHRfRwkb00HG6YTet4Rwq4BkBQhA9gusKHOsawpd
         J17GLxSv1PktObFRMtFDrBrVYo1wdtGFl8X4nvk6uNwKPttvHeXPhKnyeMMAJNtbhvhQ
         RcQg==
X-Gm-Message-State: AGRZ1gIzkVzfZchPrYiBXCQs1GuHPVcAFYOXZCzplkyvknhOwuC7UCGW
        SywApuorq7SvK/HPfTJ5h1L9gm21rIPpEfeo7/8=
X-Google-Smtp-Source: AJdET5dOGMaZy7A5zewvPue15kqJIQZrb4TQTv89nH0QViwfYrvs7/LWUgeyTcsNa1DITsUDna9dSqOUcQHjGC2l840=
X-Received: by 2002:ab0:594e:: with SMTP id o14mr1775334uad.78.1540651653232;
 Sat, 27 Oct 2018 07:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <1540530377-3509-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1540530377-3509-1-git-send-email-firoz.khan@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 27 Oct 2018 16:47:20 +0200
Message-ID: <CAMuHMdXPR7WgPe5nPh3Lcc6FDxTNDYyOmV1oKU=BLcS2H7MPgA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] m68k: system call table generation support
To:     firoz.khan@linaro.org
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Firoz,

On Fri, Oct 26, 2018 at 7:06 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> The purpose of this patch series is, we can easily add/modify/delete
> system call table support by changing entry in syscall.tbl file
> instead of manually changing many files. The other goal is to unify
> the system call table generation support implementation across all
> the architectures.
>
> The system call tables are in different format in all architecture.
> It will be difficult to manually add, modify or delete the system
> calls in the respective files manually. To make it easy by keeping
> a script and which'll generate uapi header file and syscall table
> file.
>
> syscall.tbl contains the list of available system calls along with
> system call number and corresponding entry point. Add a new system
> call in this architecture will be possible by adding new entry in
> the syscall.tbl file.
>
> Adding a new table entry consisting of:
>         - System call number.
>         - ABI.
>         - System call name.
>         - Entry point name.
>
> ARM, s390 and x86 architecuture does exist the similar support. I
> leverage their implementation to come up with a generic solution.
>
> I have done the same support for work for alpha, ia64, microblaze,
> mips, parisc, powerpc, sh, sparc, and xtensa. Below mentioned git
> repository contains more details.
> Git repo:- https://github.com/frzkhn/system_call_table_generator/
>
> Finally, this is the ground work to solve the Y2038 issue. We need
> to add two dozen of system calls to solve Y2038 issue. So this patch
> series will help to add new system calls easily by adding new entry
> in the syscall.tbl.

Thanks for the update!

Can you please tell the audience what has been changed in v4?

When posting a new version of a patch or patch series, it is a good
idea to include a changelog in the cover letter and/or patches.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
