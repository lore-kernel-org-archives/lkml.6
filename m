Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166581AbeBOSc2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 13:32:28 -0500
Received: from mail-ot0-f175.google.com ([74.125.82.175]:45751 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1166435AbeBOScZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 13:32:25 -0500
X-Google-Smtp-Source: AH8x224mxw/aCO2qcHsNEN1PB0ZNaMLh88wdZfK4VgQzMP+2J5CC/oAgIxK3kDY7XiDkTQiELwdpzw==
Subject: Re: collecting simple benchmark scripts?
To: Kees Cook <keescook@google.com>, Shuah Khan <shuah@kernel.org>,
        Fengguang Wu <fengguang.wu@intel.com>, Tycho Andersen <tycho@tycho.ws>,
        Steven Rostedt <srostedt@redhat.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <CAGXu5j+LVvfdeD4rhTKAQ0PP5s5ysAjNtrfkpcp2sLzwKqbVHw@mail.gmail.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <7723ae8d-8333-ba17-6983-a45ec8b11c54@redhat.com>
Date: Thu, 15 Feb 2018 10:32:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+LVvfdeD4rhTKAQ0PP5s5ysAjNtrfkpcp2sLzwKqbVHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/14/2018 02:50 PM, Kees Cook wrote:
> Hi,
> 
> In a separate thread, some folks were looking for some simple
> benchmarks for evaluating various changes to kernel internals (as
> opposed to the much more focused things like xfstests). For me, this
> has been an area of lore and passed-around scripts, and it seems like
> maybe we should have a subdirectory of tools/testing/benchmarks/ or
> something to collect these?
> 
> (Or maybe this already exists and I've totally missed it?)
> 
> I've got at least one micro-benchmark in
> tools/testing/selftests/seccomp/seccomp_benchmark.c, and searches show
> tools/testing/selftests/vm/gup_benchmark.c too, but I was thinking of
> either more generali things more like the famous "kernel build
> benchmark" or a wrapper for running hackbench to get some statistics
> out of it, etc.
> 
> Or, I guess, at least collecting all the micro-benchmarks in some
> single place, as they're a bit scattered.
> 
> I'm sure I'm not remotely the first person to bring this up, but my
> attempts at searches for this have failed.
> 
> Thoughts?
> 
> -Kees
> 

This is the script I've been using for hackbench since it can
be noisy. I expect someone to tell me the math is wrong but
I'd be happy to throw this in a repo if others are interested

#!/bin/sh

CNT=100
mean=0.0
M2=0.0
for i in $(seq 1 $CNT); do
	echo $i
	r=`hackbench -g 20 -l 1000 | grep Time | cut -d ' ' -f 2`
	d_calc="$r-$mean"
         d=`echo $d_calc | bc -l`
	mean_calc="$mean+($d/$i)"
	mean=`echo $mean_calc | bc -l`
	M2_calc="$M2+($d*($r-$mean))"
	M2=`echo  $M2_calc| bc -l`
done

echo "mean $mean"
V_calc="$M2/$(($CNT-1))"
V=`echo $V_calc | bc -l`
DEV_calc="sqrt($V)"
DEV=`echo $DEV_calc | bc -l`
echo "variance $V"
echo "stdev $DEV"
