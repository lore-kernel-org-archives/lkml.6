Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752305AbeC0Wse (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 18:48:34 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:37761 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752001AbeC0Wsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 18:48:32 -0400
X-Google-Smtp-Source: AIpwx48aVUxpHcVpFX5uOnoRFAEWEvL+FKVznd/PP7DMyTsHsPLxLcjvSH+YbHaihhWxAQK9+oYdrYJ+K8oui0S0suA=
MIME-Version: 1.0
References: <5abac4eb.VlEjF4GlZAlHJzXX%fengguang.wu@intel.com>
In-Reply-To: <5abac4eb.VlEjF4GlZAlHJzXX%fengguang.wu@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 27 Mar 2018 22:48:19 +0000
Message-ID: <CANn89iJyiouNoExFE5E0TzVtvwjSGR_5NqLkK3CBSphsQYGshg@mail.gmail.com>
Subject: Re: 07cde313b2 ("x86/msr: Allow rdmsr_safe_on_cpu() to schedule"):
 BUG: kernel hang in boot stage
To: kbuild test robot <fengguang.wu@intel.com>
Cc: LKP <lkp@01.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 3:26 PM kernel test robot <fengguang.wu@intel.com>
wrote:

> Greetings,

> 0day kernel testing robot got the below dmesg and the first bad commit is

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups

> commit 07cde313b2d21f728cec2836db7cdb55476f7a26
> Author:     Eric Dumazet <edumazet@google.com>
> AuthorDate: Fri Mar 23 14:58:17 2018 -0700
> Commit:     Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Tue Mar 27 12:01:47 2018 +0200

>      x86/msr: Allow rdmsr_safe_on_cpu() to schedule

>      High latencies can be observed caused by a daemon periodically reading
>      various MSR on all cpus. On KASAN enabled kernels ~10ms latencies can
be
>      observed simply reading one MSR. Even without KASAN, sending an IPI
to a
>      CPU, which is in a deep sleep state or in a long hard IRQ disabled
section,
>      waiting for the answer can consume hundreds of microseconds.

>      All usage sites are in preemptible context, convert
rdmsr_safe_on_cpu() to
>      use a completion instead of busy polling.

>      Overall daemon cpu usage was reduced by 35 %, and latencies caused by
>      msr_read() disappeared.

>      Signed-off-by: Eric Dumazet <edumazet@google.com>
>      Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>      Acked-by: Ingo Molnar <mingo@kernel.org>
>      Cc: Hugh Dickins <hughd@google.com>
>      Cc: Borislav Petkov <bp@alien8.de>
>      Cc: Eric Dumazet <eric.dumazet@gmail.com>
>      Link:
https://lkml.kernel.org/r/20180323215818.127774-1-edumazet@google.com

> 13cc36d76b  x86/rtc: Stop using deprecated functions
> 07cde313b2  x86/msr: Allow rdmsr_safe_on_cpu() to schedule
> 67bbd7a8d6  x86/cpuid: Allow cpuid_read() to schedule
> 990d052537  Merge branch 'x86/mm'

+-------------------------------+------------+------------+------------+------------+
> |                               | 13cc36d76b | 07cde313b2 | 67bbd7a8d6 |
990d052537 |

+-------------------------------+------------+------------+------------+------------+
> | boot_successes                | 33         | 4          | 2          |
4          |
> | boot_failures                 | 0          | 11         | 15         |
11         |
> | BUG:kernel_hang_in_boot_stage | 0          | 11         | 13         |
11         |
> | BUG:kernel_in_stage           | 0          | 0          | 2          |
            |

+-------------------------------+------------+------------+------------+------------+

> [   14.950320] fmc_trivial: probe of fake-design-for-testing-f001 failed
with error -95
> [   14.953048] fmc fake-design-for-testing-f001: Driver has no ID:
matches all
> [   14.955084] fmc_write_eeprom fake-design-for-testing-f001:
fmc_write_eeprom: no busid passed, refusing all cards
> [   14.958301] fmc fake-design-for-testing-f001: Driver has no ID:
matches all
> [   14.960428] fmc_chardev fake-design-for-testing-f001: Created misc
device "fake-design-for-testing-f001"
> BUG: kernel hang in boot stage


>                                                            # HH:MM RESULT
GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
> git bisect start c98e6b78ee92a4c5662febce64591980d77bd6c6
3eb2ce825ea1ad89d20f7a3b5780df850e4be274 --
> git bisect  bad 110c6c42e12d406bf2e5c15e71023ed2e91cb17d  # 01:31  B
  0    11   24   0  Merge
'linux-review/Alex-Williamson/MAINTAINERS-vfio-platform-Update-sub-maintainer/20180327-143800'
into devel-spot-201803272204
> git bisect good ec45958cf484f5c9310df39d9f85dd43c22ae799  # 01:47  G
11     0    2   2  Merge 'slave-dma/next' into devel-spot-201803272204
> git bisect good 7103b9adcdc2a848c54f3afa4ab7730f420f3fe0  # 02:18  G
11     0    1   1  Merge
'linux-review/Emmanuel-Grumbach/mac80211-don-t-WARN-on-bad-WMM-parameters-from-buggy-APs/20180327-180036'
into devel-spot-201803272204
> git bisect  bad ccf31c36bad5be0c7fbd4ce6e82b4410a7478da9  # 02:41  B
  0    11   25   0  Merge 'wireless-drivers-next/master' into
devel-spot-201803272204
> git bisect  bad 2105e74ef7120fa7b12d5c571763c0f6d06a75e9  # 03:02  B
  0     9   22   0  Merge 'pza/reset/next' into devel-spot-201803272204
> git bisect  bad 9a76dd69d30110dcecf0716dc961c93349da942b  # 03:22  B
  0     4   19   1  Merge
'linux-review/Vijendar-Mukunda/ASoC-dwc-I2S-Controller-instance-param-added/20180327-175125'
into devel-spot-201803272204
> git bisect  bad ed6c6d580da3d088d4c3cb449e1bf3fbb4a6d66a  # 03:44  B
  0     5   19   0  Merge 'tip/x86/cleanups' into devel-spot-201803272204
> git bisect good 16d1cb0bc43642a4d934631a73c5210ad2499e2f  # 04:08  G
11     0    0   0  x86/dumpstack: Unify show_regs()
> git bisect  bad 07cde313b2d21f728cec2836db7cdb55476f7a26  # 04:26  B
  0     5   19   0  x86/msr: Allow rdmsr_safe_on_cpu() to schedule
> git bisect good 13cc36d76bc4f5a9801ae32630bc8240ba0cc522  # 04:46  G
11     0    0   0  x86/rtc: Stop using deprecated functions
> # first bad commit: [07cde313b2d21f728cec2836db7cdb55476f7a26] x86/msr:
Allow rdmsr_safe_on_cpu() to schedule
> git bisect good 13cc36d76bc4f5a9801ae32630bc8240ba0cc522  # 04:51  G
31     0    2   2  x86/rtc: Stop using deprecated functions
> # extra tests with debug options
> git bisect  bad 07cde313b2d21f728cec2836db7cdb55476f7a26  # 05:14  B
  0     1   16   2  x86/msr: Allow rdmsr_safe_on_cpu() to schedule
> # extra tests on HEAD of linux-devel/devel-spot-201803272204
> git bisect  bad c98e6b78ee92a4c5662febce64591980d77bd6c6  # 05:19  B
  0    27   50   4  0day head guard for 'devel-spot-201803272204'
> # extra tests on tree/branch tip/x86/cleanups
> git bisect  bad 67bbd7a8d6bcdc44cc27105ae8c374e9176ceaf1  # 05:47  B
  0     7   23   2  x86/cpuid: Allow cpuid_read() to schedule
> # extra tests with first bad commit reverted
> git bisect good c885db74ec7feacddf4cce667615504892b756c8  # 06:05  G
11     0    1   1  Revert "x86/msr: Allow rdmsr_safe_on_cpu() to schedule"
> # extra tests on tree/branch tip/master
> git bisect  bad 990d0525372f3f3bb5abcc527c8bb56a030c2b29  # 06:25  B
  0    11   25   0  Merge branch 'x86/mm'

> ---
> 0-DAY kernel test infrastructure                Open Source Technology
Center
> https://lists.01.org/pipermail/lkp                          Intel
Corporation

Thanks for the report.

Presumably the issue is that __rdmsr_safe_on_cpu() is also called from
rdmsrl_safe_on_cpu()

So we need to initialize the completion properly from this call site.
