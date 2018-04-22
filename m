Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753395AbeDVCT6 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 22:19:58 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:42241 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753025AbeDVCT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 22:19:56 -0400
X-Google-Smtp-Source: AIpwx49lAUghhrZCeaCGVQS9aJwfAjWKftgv4W7xlQ/2nF41A0fwmBUP8n33gMlCKlWzCURHG78HjhwpPcasKLD/Tvg=
MIME-Version: 1.0
From: Diego Viola <diego.viola@gmail.com>
Date: Sat, 21 Apr 2018 23:19:55 -0300
Message-ID: <CA+ToGPE59B0EKYkRbMcoddEtWwe50nXNu-91UMdjamz+s8nKfg@mail.gmail.com>
Subject: Experiencing freezes with kernel 4.16.3 on a desktop with E5500 CPU
 (bisect included)
To: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
        len.brown@intel.com, rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently experiencing freezes after resuming from suspend when
using various applications on my desktop.

For example, when using Firefox and switching between tabs the screen
would freeze, allowing me to only move the mouse pointer but focusing
the mouse pointer on a application won't have any effect.

The keyboard would still work and the only way to make the issue go
away would be to switch to a virtual desktop and then switch back,
then I'd be able to use the mouse again until the same problem
re-occurs.

This never happened before upgrading to 4.16.3 and 4.15.18 is unaffected.

The problem only happens *after* resuming from suspend, in normal S0
state it never happens.

My machine is a desktop and has a dual core E5500 CPU with 2GB of RAM,
I run Arch Linux and I use the i3wm.

I don't think it's a problem with user space because I run exactly the
same Arch Linux setup on my T450 and the issue can't be reproduced on
that machine.

I did a bisect and the cause of the bug seems to be this commit:

aa83c45762a242acce9b35020363225a7b59d7c9 is the first bad commit

Here is the bisect log:

git bisect start
# bad: [0adb32858b0bddf4ada5f364a84ed60b196dbcda] Linux 4.16
git bisect bad 0adb32858b0bddf4ada5f364a84ed60b196dbcda
# good: [d8a5b80568a9cb66810e75b182018e9edb68e8ff] Linux 4.15
git bisect good d8a5b80568a9cb66810e75b182018e9edb68e8ff
# bad: [c14376de3a1befa70d9811ca2872d47367b48767] printk: Wake klogd
when passing console_lock owner
git bisect bad c14376de3a1befa70d9811ca2872d47367b48767
# bad: [a103950e0dd2058df5e8a8d4a915707bdcf205f0] Merge branch 'linus'
of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect bad a103950e0dd2058df5e8a8d4a915707bdcf205f0
# bad: [d8b91dde38f4c43bd0bbbf17a90f735b16aaff2c] Merge branch
'perf-core-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad d8b91dde38f4c43bd0bbbf17a90f735b16aaff2c
# good: [9697e9da84299d0d715d515dd2cc48f1eceb277d] Merge tag
'edac_for_4.16' of git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp
git bisect good 9697e9da84299d0d715d515dd2cc48f1eceb277d
# good: [d0bd31dc5c0b46b9c778112900cf8f910ac26e1b] Merge tag
'xtensa-20180129' of git://github.com/jcmvbkbc/linux-xtensa
git bisect good d0bd31dc5c0b46b9c778112900cf8f910ac26e1b
# good: [0337cf74ccf2a43437bff2e23b278e4f2dc4c6e2] perf util:
Introduce architecture specific errno/name mapping
git bisect good 0337cf74ccf2a43437bff2e23b278e4f2dc4c6e2
# bad: [6304672b7f0a5c010002e63a075160856dc4f88d] Merge branch
'x86-pti-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 6304672b7f0a5c010002e63a075160856dc4f88d
# good: [a46d3f9b1c9888a244ed1ce8da0eca98c3f378e2] Merge branch
'timers-core-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good a46d3f9b1c9888a244ed1ce8da0eca98c3f378e2
# good: [669c0f762ed19bd9ec128ebc97ae8641b6e1a4a3] Merge branch
'x86-platform-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 669c0f762ed19bd9ec128ebc97ae8641b6e1a4a3
# good: [7a32fc51ca938e67974cbb9db31e1a43f98345a9] x86/nospec: Fix
header guards names
git bisect good 7a32fc51ca938e67974cbb9db31e1a43f98345a9
# bad: [942633523cde99c5bfa0329996dd839ca66a87aa] Merge branch
'x86-mm-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 942633523cde99c5bfa0329996dd839ca66a87aa
# bad: [aa83c45762a242acce9b35020363225a7b59d7c9] x86/tsc: Introduce
early tsc clocksource
git bisect bad aa83c45762a242acce9b35020363225a7b59d7c9
# good: [6d671e1b85c63e7a337ba76c1a154c091545cff8] x86/time:
Unconditionally register legacy timer interrupt
git bisect good 6d671e1b85c63e7a337ba76c1a154c091545cff8
# first bad commit: [aa83c45762a242acce9b35020363225a7b59d7c9]
x86/tsc: Introduce early tsc clocksource

Current git HEAD is also affected.

I already tried HEAD with that commit reverted and the problem can't
be reproduced anymore.

Please let me know if I can include more info, thanks in advance.

Diego
