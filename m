Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbeBZVYF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:24:05 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50379 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbeBZVYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:24:03 -0500
X-Google-Smtp-Source: AG47ELv6pp2PkSVI2n4Ra6NF3OnDhc+SOPPOI46SsIBkJX0TsP1DBg13FSGY5FjorBX4/UG2LuQsJ8KdHExf2wI1VX8=
MIME-Version: 1.0
In-Reply-To: <20180226045645.GE3019@yexl-desktop>
References: <20180225144421.GB7144@yexl-desktop> <CALvZod7=kgWDMPbrDUGXznoJgv47fq-PUa97onVhS8x73TR+6g@mail.gmail.com>
 <20180226025728.GA8942@yexl-desktop> <20180226045645.GE3019@yexl-desktop>
From: Shakeel Butt <shakeelb@google.com>
Date: Mon, 26 Feb 2018 13:24:00 -0800
Message-ID: <CALvZod6nDEEBHfJGB53EQxpESxTVb7hxa9HU7fA1CA+qMMyJaQ@mail.gmail.com>
Subject: Re: [LKP] [lkp-robot] [mm, mlock, vmscan] 9c4e6b1a70:
 stress-ng.hdd.ops_per_sec -7.9% regression
To: Ye Xiaolong <xiaolong.ye@intel.com>
Cc: Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>, Michal Hocko <mhocko@kernel.org>,
        lkp@01.org, Minchan Kim <minchan@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Shaohua Li <shli@fb.com>,
        Greg Thelen <gthelen@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2018 at 8:56 PM, Ye Xiaolong <xiaolong.ye@intel.com> wrote:
> On 02/26, Ye Xiaolong wrote:
>>Hi, Shakeel
>>
>>On 02/25, Shakeel Butt wrote:
>>>On Sun, Feb 25, 2018 at 6:44 AM, kernel test robot
>>><xiaolong.ye@intel.com> wrote:
>>>>
>>>> Greeting,
>>>>
>>>> FYI, we noticed a -7.9% regression of stress-ng.hdd.ops_per_sec due to commit:
>>>>
>>>>
>>>> commit: 9c4e6b1a7027f102990c0395296015a812525f4d ("mm, mlock, vmscan: no more skipping pagevecs")
>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>>
>>>> in testcase: stress-ng
>>>> on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory
>>>> with following parameters:
>>>>
>>>
>>>Hi Xiaolong,
>>>
>>>Is there a way I can get the output of "perf record -a -g" running in
>>>parallel to the actual test on this machine. As I have mentioned
>>>before I am not able to reproduce this issue. However I am trying to
>>>repro on a VM with 4 vcpus and 4 GiB memory and I don't see any
>>>difference. I am suspecting that it may repro on a larger machine but
>>>I don't have access to one.
>>>
>>
>>perf.data attached. It was generated via `perf record -q -ag --realtime=1 -m 256`
>
> Attached perf-profile.gz is the result of `perf report` result.
>

Hi Xiaolong,

Can you please give me the actual full stress-ng command used in this
test? I have run following command on linux tree (with top commit
being 4c3579f6cadd5e) with and without my patch on a 72 thread
machine.

$ stress-ng --sequential 0 --class io -t 10s --times --verify --metrics-brief

Result without the patch:

stress-ng: info:  [16828] successful run completed in 97.90s (1 min, 37.90 secs)
stress-ng: info:  [16828] stressor       bogo ops real time  usr time
sys time   bogo ops/s   bogo ops/s
stress-ng: info:  [16828]                           (secs)    (secs)
 (secs)   (real time) (usr+sys time)
stress-ng: info:  [16828] aio               44928     10.00      0.00
    0.00      4492.79         0.00
stress-ng: info:  [16828] aiol                155     15.52      0.00
    0.00         9.98         0.00
stress-ng: info:  [16828] hdd               71136     14.25      0.00
    2.78      4991.33     25588.49
stress-ng: info:  [16828] rawdev            16681     10.07      0.00
    0.00      1656.10         0.00
stress-ng: info:  [16828] readahead     383446363     10.00    340.42
  327.13  38330308.93    574408.45
stress-ng: info:  [16828] revio          40008242     10.00     12.27
  704.03   4000263.49     55854.03
stress-ng: info:  [16828] seek            1807314     10.58      1.02
   22.24    170899.04     77700.52
stress-ng: info:  [16828] sync-file          1730     10.05      0.00
    0.67       172.20      2582.09
stress-ng: info:  [16828] for a 97.90s run time:
stress-ng: info:  [16828]    7048.63s available CPU time
stress-ng: info:  [16828]     355.18s user time   (  5.04%)
stress-ng: info:  [16828]    1059.33s system time ( 15.03%)
stress-ng: info:  [16828]    1414.51s total time  ( 20.07%)
stress-ng: info:  [16828] load average: 53.40 28.06 14.48


Result with the patch:

stress-ng: info:  [31637] successful run completed in 94.40s (1 min, 34.40 secs)
stress-ng: info:  [31637] stressor       bogo ops real time  usr time
sys time   bogo ops/s   bogo ops/s
stress-ng: info:  [31637]                           (secs)    (secs)
 (secs)   (real time) (usr+sys time)
stress-ng: info:  [31637] aio               44928     10.00      0.00
    0.00      4492.79         0.00
stress-ng: info:  [31637] aiol                138     14.26      0.00
    0.00         9.68         0.00
stress-ng: info:  [31637] hdd               75305     13.77      0.00
    2.82      5467.52     26703.90
stress-ng: info:  [31637] rawdev            13309     10.05      0.00
    1.29      1323.72     10317.05
stress-ng: info:  [31637] readahead     373902555     10.00    323.52
  316.95  37382265.90    583794.02
stress-ng: info:  [31637] revio          45142381     10.00     13.73
  702.51   4513648.49     63026.89
stress-ng: info:  [31637] seek            3046010     10.32      1.83
   23.92    295270.48    118291.65
stress-ng: info:  [31637] sync-file          1858     10.03      0.00
    0.65       185.17      2858.46
stress-ng: info:  [31637] for a 94.40s run time:
stress-ng: info:  [31637]    6796.83s available CPU time
stress-ng: info:  [31637]     340.50s user time   (  5.01%)
stress-ng: info:  [31637]    1050.70s system time ( 15.46%)
stress-ng: info:  [31637]    1391.20s total time  ( 20.47%)
stress-ng: info:  [31637] load average: 51.64 26.97 14.28


What should I be looking at in the results? Also please note that I
have to compile stress-ng statically to run on these machines and skip
the lkp framework.

thanks,
Shakeel
