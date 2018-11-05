Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE99C32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 00:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2112082E
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 00:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AcQFtBzf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2112082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387437AbeKEJ35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 04:29:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43590 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387412AbeKEJ35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 04:29:57 -0500
Received: by mail-lj1-f195.google.com with SMTP id g26-v6so6385084lja.10
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 16:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MxtTo3ks2mCIOYOq9qVrQFTTKEG5WqZ6km3hGzyBWo4=;
        b=AcQFtBzfzfK61crX2IyPY7t8+wrEhXsU+4OPzWAVkJWQtYbAdPdum7fNk/9O00MIEk
         tDz51tNuU5igCAXGB6DQA1lfj1HvHh84oCTr/QEO138wrfxdPznFALYSk6PtPDmeYfLg
         di3D8ZMh6yFdAGCwmz0lot6e+v7SsQmklUraA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MxtTo3ks2mCIOYOq9qVrQFTTKEG5WqZ6km3hGzyBWo4=;
        b=sazTrbtQcmFq7wvu1ZAVMr9uuGZ6QjHFtNTTWjxSNz0UV4ntXaCpT8GX4pGxls8DuN
         tN7GciWgaIKPyAfEFcfsF8PZ5+1QUi+jgsdUxcSegKpnFTcmX2RqoHCG0veirpkXYdLn
         0umk5BhgBik2yQ2PutQY6Q5v/7CTFOKdP8yOEpLJi8iZU7BZYrPSoPR609Kzu71/O0rX
         mH81LVDNU06n09cTvEqXpjf6jwsnx6YbdzSIr+NpFB159MSpm1YPV7Wg8cUeoAYPQLM/
         OlPU556n47j1dZh9LnU3aTGb/3Evz+6ONWR/DwnD3rjBv6LmlE9zkQLe71mjp1YKYvUi
         iT4g==
X-Gm-Message-State: AGRZ1gLd/ukNNy8b094L2VR8gItzvb4c5+psTUvhfg+70U539kVJcARh
        1feQwfX/nijP8CCZd/4B8YfJRZrJCDs=
X-Google-Smtp-Source: AJdET5fqtdS7F6tVb0Dfz+sRAEIWrofUnU0/CINnkk1vloTkrdhWmMQ96rB8K+XuG5zFy6U87Tn96A==
X-Received: by 2002:a2e:9c59:: with SMTP id t25-v6mr14001785ljj.107.1541376784207;
        Sun, 04 Nov 2018 16:13:04 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id h13-v6sm3499631ljg.80.2018.11.04.16.13.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 16:13:03 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id n3-v6so4867250lfe.7
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 16:13:02 -0800 (PST)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr10942890lfa.106.1541376782308;
 Sun, 04 Nov 2018 16:13:02 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Nov 2018 16:12:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=whDiwASMgw8Q7TNA2MJhf3s=ouK4+_3ioqmobs-yagnkQ@mail.gmail.com>
Message-ID: <CAHk-=whDiwASMgw8Q7TNA2MJhf3s=ouK4+_3ioqmobs-yagnkQ@mail.gmail.com>
Subject: Linux 4.20-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So I did debate calling it 5.0, but if we all help each other, I'm
sure we can count to 20. It's a nice round number, and I didn't want
to make a pattern of it. I think 5.0 happens next year, because then I
*really* run out of fingers and toes.

Anyway, 4.20-rc1 is tagged and pushed out, and the merge window is
over. This was a fairly big merge window, but it didn't break any
records, just solid. And things look pretty regular, with about 70% of
the patch is driver updates (gpu drivers are looming large as usual,
but there's changes all over). The rest is arch updates (x86, arm64,
arm, powerpc and the new C-SKY architecture), header files,
networking, core mm and kernel, and tooling.

In fact, tooling is quite noticeable. A fair amount of selftest
changes, but also various perf tooling updates.

There's a vfs pull request I declined and it might still go in later
in a slightly reduced form, but apart from that I think everything got
merged. We had one pull request that almost missed the merge windows
due to a silly change in my email setup, but I verified that nothing
else had happened to hit that special case.

One thing I _would_ like to point out as the merge window closes: I
tend to delay some pull requests that I want to take a closer look at
until the second week of the merge window when things are calming
down, and that _really_ means that I'd like to get all the normal pull
requests in the first week of the two-week merge window. And most
people really followed that, but by Wednesday this week I had gotten a
big frustrated that I kept getting new pull requests when I wanted to
really just spend most of the day looking through the ones that
deserved a bit of extra attention.

And yes, people generally kind of know about this and I really do get
*most* pull requests early. But I'm considering trying to make that a
more explicit rule that I will literally stop taking new pull requests
some time during the second week unless you have a good reason for why
it was delayed.

Because yes, the merge window is two weeks, but it's two weeks partly
exactly _because_ people (not just me) sometimes need extra time to
resolve any possible issues, not because regular everyday pull
requests should spread out over the whole two weeks. The development
for things meant for the next release should have been done by the
time the merge window opens.

Anyway, let's see. Maybe it won't be needed. It hasn't become a
problem, it just was starting to feel a bit tight there.

Oh, and I did try to do the reply emails. And I'm _entirely_ sure that
I must have missed acknowledging emails for a few pull requests. I'm
hoping that by the time the next merge window rolls around, we'll just
have new automation for it, so that everybody just automatically gets
notified when their pull request hit mainline. In the meantime, you
have a good chance - but not a guarantee - that I'll send a "Pulled"
ack email when I start processing a pull request.

And as usual for rc1, the log below is just the list of people I
pulled from with a one-liner "mergelog". Very much a high-level
summary of merges, for details you need to look into the git tree..

                    Linus

---
Al Viro (8):
    tty ioctl updates
    vfs fixes
    compat_ioctl fixes
    alpha syscall glue updates
    more ->lookup() cleanups
    AFS updates
    misc vfs updates
    9p fix

Alex Williamson (1):
    VFIO updates

Alexandre Belloni (1):
    RTC updates

Andrew Morton (3):
    updates
    more updates
    more updates

Arnd Bergmann (4):
    ARM SoC device tree updates
    ARM SoC defconfig updates
    ARM SoC driver updates
    ARM SoC platform updates

Bartlomiej Zolnierkiewicz (1):
    fbdev updates

Benson Leung (1):
    chrome-platform updates

Bjorn Andersson (2):
    remoteproc updates
    rpmsg updates

Bjorn Helgaas (1):
    PCI updates

Bob Peterson (1):
    gfs2 updates

Boris Brezillon (1):
    mtd updates

Borislav Petkov (2):
    EDAC updates
    more EDAC updates

Bruce Fields (1):
    nfsd updates

Catalin Marinas (2):
    arm64 updates
    more arm64 updates

Christoph Hellwig (3):
    dma mapping updates
    more dma-mapping updates
    dma-mapping fix

Corey Minyard (1):
    IPMI updates

Dan Williams (1):
    libnvdimm updates

Darren Hart (1):
    x86 platform driver updates

Dave Airlie (2):
    drm updates
    drm fixes

Dave Chinner (1):
    vfs dedup fixes

David Kleikamp (1):
    jfs updates

David Miller (8):
    sparc updates
    networking updates
    sparc fix
    sparc fixes
    networking fixes
    networking fixes
    sparc fixes
    networking fixes

David Sterba (2):
    btrfs updates
    more btrfs updates

Dennis Zhou (1):
    percpu fixes

Dmitry Torokhov (1):
    input updates

Dominik Brodowski (1):
    pcmcia fixes

Dominique Martinet (1):
    9p updates

Eduardo Valentin (1):
    thermal SoC updates

Eric Biederman (1):
    siginfo updates

Geert Uytterhoeven (1):
    m68k updates

Greg KH (5):
    USB/PHY updates
    driver core updates
    char/misc driver updates
    staging/IIO driver updates
    tty/serial updates

Greg Ungerer (1):
    m68k nommu fix

Guenter Roeck (1):
    hwmon updates

Guo Ren (2):
    C-SKY architecture port
    csky dtb fixups

Helge Deller (2):
    parisc updates
    parisc updates

Herbert Xu (1):
    crypto updates

Ilya Dryomov (1):
    ceph updates

Ingo Molnar (22):
    RCU updates
    EFI updates
    locking and misc x86 updates
    perf updates
    RAS updates
    scheduler updates
    x86 apic updates
    x86 asm updates
    x86 boot updates
    x86 build update
    x86 cpu updates
    x86 grub2 updates
    x86 hyperv updates
    x86 mm updates
    x86 paravirt updates
    x86 platform updates
    x86 pti updates
    x86 vdso updates
    irq fixes
    perf updates and fixes
    x86 fixes
    scheduler fixes

Jacek Anaszewski (2):
    LED updates
    LED fix

Jaegeuk Kim (1):
    f2fs updates

James Bottomley (2):
    SCSI updates
    more SCSI updates

James Morris (6):
    security subsystem updates
    integrity updates
    TPM updates
    smack updates
    LoadPin updates
    keys updates

Jan Kara (2):
    fsnotify updates
    ext2 and udf updates

Jason Gunthorpe (1):
    rdma updates

Jassi Brar (1):
    mailbox updates

Jens Axboe (4):
    block layer updates
    libata updates
    more block layer updates
    block layer fixes

Jiri Kosina (1):
    HID updates

Joerg Roedel (1):
    IOMMU updates

John Johansen (1):
    apparmor updates

Jon Mason (1):
    NTB updates

Jonathan Corbet (1):
    documentation updates

Juergen Gross (1):
    xen fixes

Kees Cook (3):
    pstore updates
    VLA removal
    stackleak gcc plugin

Konrad Rzeszutek Wilk (1):
    xen swiotlb fix

Lee Jones (2):
    MFD updates
    backlight updates

Linus Walleij (2):
    pin control updates
    GPIO updates

Mark Brown (3):
    regmap updates
    spi updates
    regulator updates

Mark Salter (1):
    c6x update

Martin Schwidefsky (1):
    s390 updates

Masahiro Yamada (2):
    Kbuild updates
    Kbuild updates

Matthew Wilcox (1):
    XArray conversion

Mauro Carvalho Chehab (2):
    media updates
    new experimental media request API

Max Filippov (1):
    Xtensa fixes and cleanups

Michael Ellerman (2):
    powerpc updates
    powerpc fixes

Michael Tsirkin (1):
    virtio/vhost updates

Miguel Ojeda (1):
    compiler attribute updates

Mike Marshall (1):
    orangefs updates

Mike Snitzer (1):
    device mapper updates

Miklos Szeredi (2):
    fuse updates
    overlayfs updates

Nicolas Pitre (1):
    cramfs fixes

Olof Johansson (1):
    ARM SoC fixes

Palmer Dabbelt (3):
    RISC-V updates
    more RISC-V updates
    RISC-V defconfig update

Paul Burton (2):
    MIPS fixes
    MIPS updates

Paul Moore (1):
    SELinux updates

Petr Mladek (1):
    printk updates

Radim Kr=C4=8Dm=C3=A1=C5=99 (1):
    KVM updates

Rafael Wysocki (4):
    power management updates
    ACPI updates
    more power management updates
    more ACPI updates

Richard Weinberger (2):
    UML updates
    UBIFS updates

Rob Herring (2):
    Devicetree updates
    Devicetree fixes

Russell King (1):
    ARM updates

Sebastian Reichel (1):
    power supply and reset updates

Shaohua Li (1):
    md updates

Shuah Khan (1):
    kselftest updates

Stephen Boyd (1):
    clk updates

Steve French (2):
    cifs updates
    cifs fixes and updates

Steven Rostedt (2):
    tracing fixes
    tracing updates

Takashi Iwai (2):
    sound updates
    sound fixes

Ted Ts'o (1):
    ext4 updates

Tejun Heo (1):
    cgroup updates

Thierry Reding (1):
    pwm updates

Thomas Gleixner (3):
    timekeeping updates
    irq updates
    more timer updates

Tony Luck (1):
    ia64 updates

Trond Myklebust (2):
    NFS client updates
    NFS client bugfixes

Ulf Hansson (1):
    MMC updates

Vinod Koul (1):
    dmaengine updates

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (2):
    i2c updates
    i2c fixes

Zhang Rui (1):
    thermal management updates
