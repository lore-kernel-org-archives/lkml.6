Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751107AbeCZJ2b (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 05:28:31 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:42428 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbeCZJ2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 05:28:30 -0400
X-Google-Smtp-Source: AG47ELtYqzlZXni/GNa/j/Geqnk8deo54JTkHrVjoPIPKX2Re46GjpSGOGaquZdgw9cJn7tagXP/DSdYEqciY9wgG8E=
MIME-Version: 1.0
In-Reply-To: <20180326085214.GB5991@hc>
References: <20180302143737.10788-1-jglauber@cavium.com> <20180302143737.10788-2-jglauber@cavium.com>
 <CAK8P3a2ORBU-_7=JeCHSuM8YtC7zeO1VPxQzny_8BrpyVGCKKw@mail.gmail.com>
 <20180306140201.GB7428@hc> <20180326085214.GB5991@hc>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 26 Mar 2018 11:28:28 +0200
X-Google-Sender-Auth: 53ibTPquF0Oh-7pv0TKoacuO2Nw
Message-ID: <CAK8P3a03GvQKC58GXLWJaKwSWRq5LY7Jx3ftfFfpVbq1jAz3Pg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: defconfig: Raise NR_CPUS to 256
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 10:52 AM, Jan Glauber
<jan.glauber@caviumnetworks.com> wrote:
> On Tue, Mar 06, 2018 at 03:02:01PM +0100, Jan Glauber wrote:
>> On Tue, Mar 06, 2018 at 02:12:29PM +0100, Arnd Bergmann wrote:
>> > On Fri, Mar 2, 2018 at 3:37 PM, Jan Glauber <jglauber@cavium.com> wrote:
>> > > ThunderX1 dual socket has 96 CPUs and ThunderX2 has 224 CPUs.
>> >
>> > Are you sure about those numbers? From my counting, I would have expected
>> > twice that number in both cases: 48 cores, 2 chips and 2x SMT for ThunderX
>> > vs 52 Cores, 2 chips and 4x SMT for ThunderX2.
>>
>> That's what I have on those machines. I counted SMT as normal CPUs as it
>> doesn't make a difference for the config. I've not seen SMT on ThunderX.
>>
>> The ThunderX2 number of 224 is already with 4x SMT (and 2 chips) but
>> there may be other versions planned that I'm not aware of.
>>
>> > > Therefore raise the default number of CPUs from 64 to 256
>> > > by adding an arm64 specific option to override the generic default.
>> >
>> > Regardless of what the correct numbers for your chips are, I'd like
>> > to hear some other opinions on how high we should raise that default
>> > limit, both in arch/arm64/Kconfig and in the defconfig file.
>> >
>> > As I remember it, there is a noticeable cost for taking the limit beyond
>> > BITS_PER_LONG, both in terms of memory consumption and also
>> > runtime performance (copying and comparing CPU masks).
>>
>> OK, that explains the default. My unverified assumption is that
>> increasing the CPU masks wont be a noticable performance hit.
>>
>> Also, I don't think that anyone who wants performance will use
>> defconfig. All server distributions would bump up the NR_CPUS anyway
>> and really small systems will probably need to tune the config
>> anyway.
>>
>> For me defconfig should produce a usable system, not with every last
>> driver configured but with all the basics like CPUs, networking, etc.
>> fully present.
>>
>> > I'm sure someone will keep coming up with even larger configurations
>> > in the future, so we should try to decide how far we can take the
>> > defaults for the moment without impacting users of the smallest
>> > systems. Alternatively, you could add some measurements that
>> > show how much memory and CPU time is used up on a typical
>> > configuration for a small system (4 cores, no SMT, 512 MB RAM).
>> > If that's low enough, we could just do it anyway.
>>
>> OK, I'll take a look.
>
> I've made some measurements on a 4 core board (Cavium 81xx) with
> NR_CPUS set to 64 or 256:
>
> - vmlinux grows by 0.04 % with 256 CPUs

Ok. Is this both with CONFIG_CPUMASK_OFFSTACK=n?

> - Kernel compile time was a bit faster with 256 CPUS (which does
>   not make sense, but at least is seems to not suffer from the change).

Do you mean compiling the same kernel configuration while running
on a system with less than 64 CPUs on either a CONFIG_NR_CPUS=64
or CONFIG_NR_PCUS=256 kernel, or do you mean the time to compile
a kernel with either CONFIG_NR_CPUS=64 or CONFIG_NR_CPUS=256,
while running on the same host?

I assume the former, which is a very interesting result, possibly
pointing to us doing something wrong in the NR_CPUS=64 case
that could be optimized.

If you ran with CONFIG_CPUMASK_OFFSTACK, that may have made
a significant difference, but I would expect it to be faster without it.

To get more insight to what is happening, you could rerun the same
test with 'perf record' and then compare the profiles. How significant
is the runtime difference compared to the jitter you get between normal
runs on the same configuration?

>   Is there a benchmark that will be better suited? Maybe even a
>   microbenchmark that will suffer from the longer cpumasks?

Good question.

> - Available memory decreased by 0.13% (restricted memory to 512 MB),
>   BSS increased 5.3 %

0.13% of a few hundred megabytes is still several hundred kb, right? I'd
like to hear some other opinions on that, but it seems to be in the
range of enabling many additional device drivers, which is something
we don't do lightly.

      Arnd
