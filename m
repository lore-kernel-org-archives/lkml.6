Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E22CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593F620665
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbfAJUAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:00:41 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38763 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfAJUAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:00:40 -0500
Received: by mail-lf1-f68.google.com with SMTP id a8so9191532lfk.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 12:00:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPmQEHAt+sKPcUs7anxfhO25G59A/UNlRVD68a8kfAU=;
        b=tyS471DoV+WXoV7whUXo8mHdDbtZmKYP4ER8UZs3gx4EPznZlMVLp5JdEX67raMbYa
         vUXcWKe4j1nMvD6rh0JipX0/7RuM5pXC7sSPUc42HPv4gzdnL/eiW0u/saHFbl7RTuU6
         Am56bjIvfp2aw6KmLSYufeWpUoKWwgCo3gDuG08CyGdUIWhpg95xNeKPVFPFmh66cbcn
         q1+TISaYTQr7UoYylC9+1vuU4eiVgw5TXhZcAMjkgc+RrcBu4PPyhf4CKHAxi/pr62f3
         tMhygcmeY40sj39m+wKazgSX422QhpjtmnVZgxHD2cZQ3JXdMbA57mrktdUnfO68hz4T
         kxXw==
X-Gm-Message-State: AJcUuke0qLNoAsH512K41IDXWzSaeIb/F7q73pVOZ360L7Yq0LI/4mXc
        sMHlABLn/KYK9PVHd2w7ncqKPu0JzuLOc3+sAvNM2Q==
X-Google-Smtp-Source: ALg8bN6ZZ98td/Ac0ilRUDMoyEEhipPbBkGBBdNt1QINSZGIn/P70IOTrFhlCWqs3NMkNjVlvt5606j5IHAT+ci/Uik=
X-Received: by 2002:ac2:51af:: with SMTP id f15mr6312409lfk.44.1547150438890;
 Thu, 10 Jan 2019 12:00:38 -0800 (PST)
MIME-Version: 1.0
References: <20181213052259.56352-1-cai@lca.pw> <20181214040819.58625-1-cai@lca.pw>
 <CAKv+Gu80cxx6L3KYyYnsyjbrWN6iTp76jcdBio27b_h+dAzaHw@mail.gmail.com> <bea04814-25d2-7bb2-0f74-0530fcd54210@lca.pw>
In-Reply-To: <bea04814-25d2-7bb2-0f74-0530fcd54210@lca.pw>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Fri, 11 Jan 2019 01:30:26 +0530
Message-ID: <CACi5LpPDzcgW9Yjx1MkdwbmVPFAToQ5hMAw7cAgEvsrB5KwKDQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: invalidate TLB just before turning MMU on
To:     Qian Cai <cai@lca.pw>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

On Sat, Dec 15, 2018 at 7:24 AM Qian Cai <cai@lca.pw> wrote:
>
> On 12/14/18 2:23 AM, Ard Biesheuvel wrote:
> > On Fri, 14 Dec 2018 at 05:08, Qian Cai <cai@lca.pw> wrote:
> >> Also tried to move the local TLB flush part around a bit inside
> >> __cpu_setup(), although it did complete kdump some times, it did trigger
> >> "Synchronous Exception" in EFI after a cold-reboot fairly often that
> >> seems no way to recover remotely without reinstalling the OS.
> >
> > This doesn't make any sense to me. If the system gets into a weird
> > state out of cold reboot, how could this code be the culprit? Please
> > check your firmware, and try to reproduce the issue on a system that
> > doesn't have such defects.
> >
>
> I'll continue investigating those "Synchronous Exception" although it is kind of
> hard due to I don't have any source code of the firmware to confirm it is buggy
> or not.
>
> I did manage to reproduce this kdump issue on around 5 of those server running a
> fairly recent version of the firmware (07/01/2018). I don't have access to other
> large CPU machines.

Sorry I got busy with some other stuff, but as I reported earlier, I
am not able to reproduce this on my HPE apollo with the latest linus
tree as well.
Here are some details on my setup:

1. # uname -r
5.0.0-rc1+

with the following commit as the HEAD:
commit a88cc8da0279f8e481b0d90e51a0a1cffac55906 (HEAD -> master,
origin/master, origin/HEAD)
Merge: 9cb2feb4d21d 73444bc4d8f9
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Jan 8 18:58:29 2019 -0800

    Merge branch 'akpm' (patches from Andrew)

2. I use the following kdump commandline:
Kernel command line: BOOT_IMAGE=(hd9,gpt2)/vmlinuz-5.0.0-rc1+ ro
irqpoll nr_cpus=1 swiotlb=noforce reset_devices
earlycon=pl011,mmio,0x402020000

3. I am able to run kdump successfully on the machine and also collect
the crash core properly:

.. snip..
kdump: saving to /sysroot//var/crash/127.0.0.1-2019-01-10-10:52:25/
kdump: saving vmcore-dmesg.txt
kdump: saving vmcore-dmesg.txt complete
kdump: saving vmcore
Copying data                                      : [100.0 %] \
   eta: 0s
kdump: saving vmcore complete
.. snip ..

4. I use the same firmware version on the board as you shared earlier:
# dmidecode | grep -A 20 -i "BIOS Information"
BIOS Information
    Vendor: American Megatrends Inc.
    Version: L50_5.13_1.0.6
    Release Date: 07/10/2018
    Address: 0xF0000
    Runtime Size: 64 kB
    ROM Size: 64 MB
    Characteristics:
        PCI is supported
        BIOS is upgradeable
        BIOS shadowing is allowed
        Boot from CD is supported
        Selectable boot is supported
        BIOS ROM is socketed
        ACPI is supported
        BIOS boot specification is supported
        Targeted content distribution is supported
        UEFI is supported
    BIOS Revision: 6.3

So, I am guessing that it might be a kdump command line issue at your end.

Thanks,
Bhupesh
