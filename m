Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09017C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D098521850
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbfB0Pww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 10:52:52 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:50710 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfB0Pww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 10:52:52 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gz1Vo-0002r6-87; Wed, 27 Feb 2019 16:52:48 +0100
Date:   Wed, 27 Feb 2019 16:52:47 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Yao HongBo <yaohongbo@huawei.com>
cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxarm@huawei.com
Subject: Re: [PATCH] time64: Avoid undefined behaviour in timespec64_add()
In-Reply-To: <6a50f6ed-aa5f-cf3b-71c5-ebd9cbfc29f6@huawei.com>
Message-ID: <alpine.DEB.2.21.1902271651330.26197@nanos.tec.linutronix.de>
References: <20190225032619.17070-1-yaohongbo@huawei.com> <CABeXuvqOEqN7fRa1pkLKNhNckoUpCoyxKRdieD+UE8DFt+yQ+g@mail.gmail.com> <6a50f6ed-aa5f-cf3b-71c5-ebd9cbfc29f6@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2019, Yao HongBo wrote:
> On 2/25/2019 12:53 PM, Deepa Dinamani wrote:
> > On Sun, Feb 24, 2019 at 7:13 PM Hongbo Yao <yaohongbo@huawei.com> wrote:
> >> I ran into this:

> >>         UBSAN: Undefined behaviour in ./include/linux/time64.h:70:2
> >>         signed integer overflow:
> >>         1551059291 + 9223372036854775807 cannot be represented in type 'long
> >>         long int'
> >>         CPU: 5 PID: 20064 Comm: syz-executor.2 Not tainted 4.19.24 #4
> >>         Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> >>         1.10.2-1ubuntu1 04/01/2014
> >>         Call Trace:
> >>          __dump_stack lib/dump_stack.c:77 [inline]
> >>          dump_stack+0xca/0x13e lib/dump_stack.c:113
> >>          ubsan_epilogue+0xe/0x81 lib/ubsan.c:159
> >>          handle_overflow+0x193/0x1e2 lib/ubsan.c:190
> >>          timespec64_add include/linux/time64.h:70 [inline]
> >>          timekeeping_inject_offset+0x3ed/0x4e0 kernel/time/timekeeping.c:1301
> >>          do_adjtimex+0x1e5/0x6c0 kernel/time/timekeeping.c:2360
> >>          __do_sys_clock_adjtime+0x122/0x200 kernel/time/posix-timers.c:1086
> 
> > You seem to be adding INT64_MAX here. Maybe the right thing to do is
> > to add a check at the syscall interface rather than here.
> 
> Thanks for this suggestion. Looks like that is a better way.
> I will try it.

Yes, the input to sys_clock_adjtime() needs to be sanity checked.

Thanks,

	tglx
