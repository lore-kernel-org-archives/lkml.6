Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753787AbeCFOas (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:30:48 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:39338 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753760AbeCFOar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:30:47 -0500
X-Google-Smtp-Source: AG47ELumQvYpR++y/PgYMOmh4QScA6YZORGJmftOBk4D8NYhtBK8ZnkDB6eRDf73Wj/+3APmK5QILW0s8WgkjkS54Pw=
MIME-Version: 1.0
In-Reply-To: <20180306140201.GB7428@hc>
References: <20180302143737.10788-1-jglauber@cavium.com> <20180302143737.10788-2-jglauber@cavium.com>
 <CAK8P3a2ORBU-_7=JeCHSuM8YtC7zeO1VPxQzny_8BrpyVGCKKw@mail.gmail.com> <20180306140201.GB7428@hc>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Mar 2018 15:30:45 +0100
X-Google-Sender-Auth: 1DIB0zH2kWMjewLoRgk7qOh-SOw
Message-ID: <CAK8P3a1ByFF0xfUjtNx28BvMah6Om1ZCP6LhYUvz=-nT3-aFEg@mail.gmail.com>
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

On Tue, Mar 6, 2018 at 3:02 PM, Jan Glauber
<jan.glauber@caviumnetworks.com> wrote:
> On Tue, Mar 06, 2018 at 02:12:29PM +0100, Arnd Bergmann wrote:
>> On Fri, Mar 2, 2018 at 3:37 PM, Jan Glauber <jglauber@cavium.com> wrote:
>> > ThunderX1 dual socket has 96 CPUs and ThunderX2 has 224 CPUs.
>>
>> Are you sure about those numbers? From my counting, I would have expected
>> twice that number in both cases: 48 cores, 2 chips and 2x SMT for ThunderX
>> vs 52 Cores, 2 chips and 4x SMT for ThunderX2.
>
> That's what I have on those machines. I counted SMT as normal CPUs as it
> doesn't make a difference for the config. I've not seen SMT on ThunderX.
>
> The ThunderX2 number of 224 is already with 4x SMT (and 2 chips) but
> there may be other versions planned that I'm not aware of.

I've never used on, the numbers I have are probably the highest
announced core counts that are produced, but it's possible that
those with fewer cores that you have (24 and 26, respectively)
are much more affordable and/or common.

>> > Therefore raise the default number of CPUs from 64 to 256
>> > by adding an arm64 specific option to override the generic default.
>>
>> Regardless of what the correct numbers for your chips are, I'd like
>> to hear some other opinions on how high we should raise that default
>> limit, both in arch/arm64/Kconfig and in the defconfig file.
>>
>> As I remember it, there is a noticeable cost for taking the limit beyond
>> BITS_PER_LONG, both in terms of memory consumption and also
>> runtime performance (copying and comparing CPU masks).
>
> OK, that explains the default. My unverified assumption is that
> increasing the CPU masks wont be a noticable performance hit.

The cpumask macros are rather subtle and are written to be
as efficient as possible on configurations with 1, BITS_PER_LONG
as well as large numbers of CPUs. There is also the
CONFIG_CPUMASK_OFFSTACK option that trades (stack) memory
consumption for CPU cycles and is usually used on configurations
with more than 512 CPUs.

> Also, I don't think that anyone who wants performance will use
> defconfig. All server distributions would bump up the NR_CPUS anyway
> and really small systems will probably need to tune the config
> anyway.
>
> For me defconfig should produce a usable system, not with every last
> driver configured but with all the basics like CPUs, networking, etc.
> fully present.

Agreed. If we can sacrifice a little bit of kernel performance in
exchange for running on a wider range of machines, we should do
that, but if either the CPU or memory cost is excessive for small
machines, then I think it's better to sacrifice access to some of the
CPUs on the larger systems.

I would expect that the performance impact for running without
SMP on ThunderX2 (52 CPUs instead of 224) is significant but
also something we can live with as a non-optimized configuration.
On my 32-thread x86 build box, disabling SMT costs under 20%,
for larger configurations I would expect a smaller impact for
similar workloads (because of Amdahl's law), but your SMT
implementation may be better than AMD's.

      Arnd
