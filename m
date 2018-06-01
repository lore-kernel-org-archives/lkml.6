Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbeFAM6S (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 08:58:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:53355 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751769AbeFAM6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 08:58:14 -0400
Message-ID: <1527857873.4674.11.camel@gmx.de>
Subject: 4.13..4.14 scheduling overhead regression (bisected  -
 b956575bed91)
From: Mike Galbraith <efault@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Date: Fri, 01 Jun 2018 14:57:53 +0200
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:CmEd7hiqSMttT9g4c2/skHR8ETbOmNOGEvjZhVQPwrs9wswL678
 QqsCeN6PAp+euYhH6rxXjgL8cromM8dhXQiYiByDkyqSeBbGMZwIIvO670MRKkr1rELvfos
 aaPsEgnC8VuB0unYiLpvqdBtcROfTWbedjaT9G/gmNqThR+muevW22GhsCL9gV69txJNnXT
 r3w4HeGl4XimLn5T66MMw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mVY4zRNzHJI=:G5iucbFKQ5SFs7ouv3WXe7
 SV5nudJkV2sU+9CAszAEYLg2vw17v+BNMSG1x5ixTcP0RGQlOB7PXD/o7IAnWXqHZqth+TGcq
 l4qMGEwj83wXVlXES7Mwt513nzNyE2y9VdQAC6Neb0MZEWJt6RJYDViVXiScRDRw47DK69ScY
 rCAirNOgrC1eTt3pIbTJ6fvR32ptxsL+Mpo7QrPLTlzMpd5FEFR5Afc6Y6mVnzg8O9OzfIe5I
 +qdstlB4pluwEi/p7xFNF9TThrE10F65kcbHNqVLjsZD6yOlUEbfQJFcTi9JwViZzq1I1o9mR
 SE0b6Jm4QVRMIMjJM5F+CDihKdNFyu6PzbcxGVWYoJLsJIVC2LujVlLWScJ9xLxxqhlPsBoDQ
 ARIJ+9oHPr/PhzYlWaCVDW0Vi/utDREcBswxQTHUcdqUdEtfJoSfdse5b4p6vrqGY3JqFJgdQ
 aIRxFRHpcS8q+ZHjflMQioSr/fn3Ht2qkQkti7am93d/XrtSj3fXg6JG+K4YPsroKWUSk9jv8
 lZ/vdNn0KdK42b/R+xvgnunQvwfVYncSVqYAqVM2Xw2rzhjeLZFunT1NeqYFX5lwKksZK2YK5
 dEcwDIgNK/SbGWE+hhn/RQklB8EQPLEGwfLsFEl20ik2HHLTAAMUVUTL99CSUrw3HnzF4qSSy
 6W80m1WYElG1UBlyX3DJS9fXEL0oulZ4/z8K4gNNlSG5JNqU9NsapZmb8dA7MBigJw1p5KqKW
 Z7v1hehdz4Oegi9MpBoJ+TsbbN1Utvs5to1FWPc+DH/ZCSubOApsgx5So+6MLM/I8fvZSouN2
 5EiuINk
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

While dusting off regression testing trees, I noticed a substantial
pipe-test dent at 4.14, and bisected it to b956575bed91.  Log below.

skew_tick=1 audit=0 nodelayacct cgroup_disable=memory nopti nospectre_v2 nospec_store_bypass_disable
gov performance
taskset 0xc pipe-test 1

4.4.134         2.125751 usecs/loop -- avg 2.138286 935.3 KHz
4.5.7           2.111431 usecs/loop -- avg 2.141415 934.0 KHz
4.6.7           2.060672 usecs/loop -- avg 2.059993 970.9 KHz
4.7.10          2.086366 usecs/loop -- avg 2.090943 956.5 KHz
4.8.17          2.008318 usecs/loop -- avg 2.005780 997.1 KHz + ~2.00-ish   1.000
4.9.104         1.989143 usecs/loop -- avg 2.010945 994.6 KHz
4.10.17         2.010789 usecs/loop -- avg 2.006868 996.6 KHz
4.11.12         2.032123 usecs/loop -- avg 2.037766 981.5 KHz - ~2.04-ish   1.015   1.000
4.12.14         2.055745 usecs/loop -- avg 2.065894 968.1 KHz
4.13.16         2.024978 usecs/loop -- avg 2.045250 977.9 KHz
4.14.47         2.234518 usecs/loop -- avg 2.227716 897.8 KHz -- >2.22      1.110   1.093   1.000
4.15.18         2.287815 usecs/loop -- avg 2.295858 871.1 KHz --- >2.28     1.144   1.126   1.030
4.16.13         2.286036 usecs/loop -- avg 2.279057 877.6 KHz
4.17.0.g88a8676 2.288231 usecs/loop -- avg 2.288917 873.8 KHz

b956575bed91ecfb136a8300742ecbbf451471ab is the first bad commit
commit b956575bed91ecfb136a8300742ecbbf451471ab
Author: Andy Lutomirski <luto@kernel.org>
Date:   Mon Oct 9 09:50:49 2017 -0700

    x86/mm: Flush more aggressively in lazy TLB mode
    
git bisect start
# good: [569dbb88e80deb68974ef6fdd6a13edb9d686261] Linux 4.13
git bisect good 569dbb88e80deb68974ef6fdd6a13edb9d686261
# bad: [57a3ca7835962109d94533465a75e8c716b26845] Linux 4.14.47
git bisect bad 57a3ca7835962109d94533465a75e8c716b26845
# good: [fbf4432ff71b7a25bef993a5312906946d27f446] Merge branch 'akpm' (patches from Andrew)
git bisect good fbf4432ff71b7a25bef993a5312906946d27f446
# bad: [3fefc31843cfe2b5f072efe11ed9ccaf6a7a5092] Merge tag 'pm-final-4.14' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect bad 3fefc31843cfe2b5f072efe11ed9ccaf6a7a5092
# good: [8d93c7a4315711ea0f7a95ca353a89c4ed0763fb] Merge tag 'pci-v4.14-fixes-1' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci
git bisect good 8d93c7a4315711ea0f7a95ca353a89c4ed0763fb
# good: [0f380715e51f5ff418cfccb4cd0d4fe4c48c3241] Merge tag 'sound-4.14-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect good 0f380715e51f5ff418cfccb4cd0d4fe4c48c3241
# bad: [e5f468b3f23313994c5e6c356135f9b0d76bcb94] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
git bisect bad e5f468b3f23313994c5e6c356135f9b0d76bcb94
# good: [3d7882769b5dc929690f96e0c318c29b97f51018] Merge tag 'devprop-4.14-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect good 3d7882769b5dc929690f96e0c318c29b97f51018
# bad: [ae7df8f985f1b0445366ae6f6324cd08a218526e] Merge tag 'char-misc-4.14-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
git bisect bad ae7df8f985f1b0445366ae6f6324cd08a218526e
# good: [be1f16ba35d97aff4d85c0daba0a02da51b7c83c] Merge branch '4.14-fixes' of git://git.linux-mips.org/pub/scm/ralf/upstream-linus
git bisect good be1f16ba35d97aff4d85c0daba0a02da51b7c83c
# good: [a339b351304d5e6b02c7cf8eed895d181e64bce0] Merge branch 'sched-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good a339b351304d5e6b02c7cf8eed895d181e64bce0
# bad: [7a23c5abb930cefcef85df6dc0c8fb3e8961980c] Merge tag 'dmaengine-fix-4.14-rc5' of git://git.infradead.org/users/vkoul/slave-dma
git bisect bad 7a23c5abb930cefcef85df6dc0c8fb3e8961980c
# good: [ab7ff471aa5db670197070760f022622793da7e5] x86/hyperv: Fix hypercalls with extended CPU ranges for TLB flushing
git bisect good ab7ff471aa5db670197070760f022622793da7e5
# bad: [1f161f67a272cc4f29f27934dd3f74cb657eb5c4] x86/microcode: Do the family check first
git bisect bad 1f161f67a272cc4f29f27934dd3f74cb657eb5c4
# good: [cc6afe2240298049585e86b1ade85efc8a7f225d] x86/apic: Silence "FW_BUG TSC_DEADLINE disabled due to Errata" on hypervisors
git bisect good cc6afe2240298049585e86b1ade85efc8a7f225d
# bad: [b956575bed91ecfb136a8300742ecbbf451471ab] x86/mm: Flush more aggressively in lazy TLB mode
git bisect bad b956575bed91ecfb136a8300742ecbbf451471ab
# good: [616dd5872e52493863b0202632703eebd51243dc] x86/apic: Update TSC_DEADLINE quirk with additional SKX stepping
git bisect good 616dd5872e52493863b0202632703eebd51243dc
# first bad commit: [b956575bed91ecfb136a8300742ecbbf451471ab] x86/mm: Flush more aggressively in lazy TLB mode
