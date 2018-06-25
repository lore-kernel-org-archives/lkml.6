Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B97C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B1825AB4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOSo7g8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B1825AB4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934244AbeFYNnA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:43:00 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41814 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934034AbeFYNm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:42:57 -0400
Received: by mail-lf0-f66.google.com with SMTP id d24-v6so14492220lfa.8;
        Mon, 25 Jun 2018 06:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=z2ajmEiGZC7KCjvG5fyNO1lM3nIidAhkT1T6KgfzJik=;
        b=eOSo7g8A0ZXXZf4EROc9LQ1sr3wcxa22sIC9Zy4P30QwzC/YYucY4zgeSaB1qPYhht
         dsUj6WhL87S/xNngpCy73KZycy9ku0eFNUWCJimdNAWm9CBiDxPmoLzmWxbV9LkLye0f
         H+F0CHuv508SbDt6ieJx49yvEPsIXLywC7uwAI21bTuOXEFXu/dl/Xg1/Q4/vARsD05c
         UCg2Voi+/bOu4mKaIXLdkO5cYriBtpG9sysECDNVQcn7yLKbAUYHco6kXia/VCok+/J3
         LiwElpkTBpQAS8zKin/2UYwAB7zcSdjD7NIqBB/aTgimAYNgBMQCxgclGOhywyNOqLf6
         zVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=z2ajmEiGZC7KCjvG5fyNO1lM3nIidAhkT1T6KgfzJik=;
        b=TSFHJd03UFl8SlQtVMLzADO7Ae88v6zPE7gMWGy6QQKe0tCDIxTF+4KXmKPqCdG/DU
         EeEyNJLmjc7mt4x1NnxTkGM96BJsx+V+7N/Btdpyn67tmXC4t4oFnLREBNnrnP82yuH3
         ABbXxbIrSxZwg0lYJHF25AGF8s1wGoa4RwrC/DZVHMz+18W2UfQ3rd0ldc7+4DDRGCWq
         ifftwLDkUL1KIzD9BU+zxUcDCbUYiej4vRAUIecBuTdRLFI5E1nk3U4euzBqsvcFT+rl
         4BiSCpgevfBjEJL3/0rJtl7tvht9uXxAoG1OPydm2Rej94hcO62iK0jGCiXPj4dkWyat
         1u8w==
X-Gm-Message-State: APt69E1QNP1ozR15KK6OXTd9GFkYWo4LhzmtnxB8zFg9V1xz1NQ8Z7dJ
        hFhoEEAP/i3AR4ViSBgSLywp4G4PMKibWsH843c=
X-Google-Smtp-Source: ADUXVKKNbYh150QJhu7ezcqkqAqn2WFFB7ItFwA6H4EGvO0rUppwMEi5iGUtLQcvwxS+zpXaKUC0eWFBMydVQ4i8CK0=
X-Received: by 2002:a19:141f:: with SMTP id k31-v6mr6400629lfi.23.1529934175336;
 Mon, 25 Jun 2018 06:42:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41cf:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 06:42:54
 -0700 (PDT)
In-Reply-To: <CAK8P3a1Lr2y1SZonodsyUETkc3d_NBOzyOGGv0OFSW=Xo_RVsA@mail.gmail.com>
References: <20180620150138.49380-1-arnd@arndb.de> <87r2l1sby0.fsf@linux.intel.com>
 <CAK8P3a1J9j7pz-d+otbJweWgOZZePdaMJEb_sU2GJKi3oYq7Xg@mail.gmail.com>
 <87muvpsa61.fsf@linux.intel.com> <CAK8P3a1Lr2y1SZonodsyUETkc3d_NBOzyOGGv0OFSW=Xo_RVsA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Jun 2018 15:42:54 +0200
X-Google-Sender-Auth: WpwlM56nUbaM0pdSeg0Vl3S08h8
Message-ID: <CAK8P3a2YuoMJ654sJtzE4mJN7wdd4o5JtY8W7c9QocZX8JP6cw@mail.gmail.com>
Subject: Re: [PATCH] vfs: replace current_kernel_time64 with ktime equivalent
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Brian Foster <bfoster@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andi Kleen <andi.kleen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 9:35 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Jun 20, 2018 at 6:19 PM, Andi Kleen <ak@linux.intel.com> wrote:
>> Arnd Bergmann <arnd@arndb.de> writes:
>>>
>>> To clarify: current_kernel_time() uses at most millisecond resolution rather
>>> than microsecond, as tkr_mono.xtime_nsec only gets updated during the
>>> timer tick.
>>
>> Ah you're right. I remember now: the motivation was to make sure there
>> is basically no overhead. In some setups the full gtod can be rather
>> slow, particularly if it falls back to some crappy timer.
>
> This means, we're probably fine with a compile-time option that
> distros can choose to enable depending on what classes of hardware
> they are targetting, like
>
> struct timespec64 current_time(struct inode *inode)
> {
>         struct timespec64 now;
>         u64 gran = inode->i_sb->s_time_gran;
>
>         if (IS_ENABLED(CONFIG_HIRES_INODE_TIMES) &&
>             gran <= NSEC_PER_JIFFY)
>                   ktime_get_real_ts64(&now);
>         else
>                   ktime_get_coarse_real_ts64(&now);
>
>         return timespec64_trunc(now, gran);
> }
>
> With that implementation, we could still let file systems choose
> to get coarse timestamps by tuning the granularity in the
> superblock s_time_gran, which would result in nice round
> tv_nsec values that represent the actual accuracy.

I've done some simple tests and found that on a variety of
x86, arm32 and arm64 CPUs, it takes between 70 and 100
CPU cycles to read the TSC and add it to the coarse
clock, e.g. on a 3.1GHz Ryzen, using the little test program
below:

vdso hires:   37.18ns
vdso coarse:    6.44ns
sysc hires: 161.62ns
sysc coarse: 133.87ns

On the same machine, it takes around 400ns (1240 cycles)
to write one byte into a tmpfs file with pwrite(). Adding 5% to
10% overhead for accurate timestamps would definitely be
noticed, so I guess we wouldn't enable that unconditionally,
but could do it as an opt-in mount option if someone had a
use case.

       Arnd

---
/* measure times for high-resolution clocksource access from userspace */
#include <stdio.h>
#include <time.h>
#include <unistd.h>
#include <stdbool.h>
#include <sys/syscall.h>

static int do_clock_gettime(clockid_t clkid, struct timespec *tp, bool vdso)
{
        if (vdso)
                return clock_gettime(clkid, tp);

        return syscall(__NR_clock_gettime, clkid, tp);
}

static int loop1sec(int clkid, bool vdso)
{
        int i;
        struct timespec t, start;

        do_clock_gettime(clkid, &start, vdso);
        i = 0;
        do {
                do_clock_gettime(clkid, &t, vdso);
                i++;
        } while (t.tv_sec == start.tv_sec || t.tv_nsec < start.tv_nsec);

        return i;
}

int main(void)
{
        printf("vdso hires:     %7.2fns\n", 1000000000.0 /
loop1sec(CLOCK_REALTIME, true));
        printf("vdso coarse:    %7.2fns\n", 1000000000.0 /
loop1sec(CLOCK_REALTIME_COARSE, true));
        printf("sysc hires:     %7.2fns\n", 1000000000.0 /
loop1sec(CLOCK_REALTIME, false));
        printf("sysc coarse:    %7.2fns\n", 1000000000.0 /
loop1sec(CLOCK_REALTIME_COARSE, false));

        return 0;
}
