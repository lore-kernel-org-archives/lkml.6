Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754352AbeCVBog (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 21:44:36 -0400
Received: from akagi.fsij.org ([217.70.189.144]:38138 "EHLO akagi.fsij.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752752AbeCVBoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 21:44:34 -0400
From: NIIBE Yutaka <gniibe@fsij.org>
To: linux-kernel@vger.kernel.org
Cc: NIIBE Yutaka <gniibe@fsij.org>
Subject: [PATCH v2 0/4] Fix no signal delivery at do_signal
Date: Thu, 22 Mar 2018 10:44:09 +0900
Message-Id: <20180322014413.24099-1-gniibe@fsij.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Background:
I tried to fix my own problem in suspend-to-ram with USB devices (some
device doesn't work well after suspend/resume).  I know it's common
problems.  Well, while I identified some problems of USB devices and
drivers, I did try my best.  I fixed a USB device implementation of
mine.  Then, I also located and fixed bugs in a USB user space driver
which I maintain.

Now, I think I found a kernel problem.  After suspend/resume, in my
USB user space driver, a task sends a signal to another task, then,
pselect is woken up by the signal.  In this situation, a signal
handler is called correctly, but it seems that the pselect is
restarted.  Expected behavior is woken pselect returning -EINTR.

Looking the code, my theory is:
It is a fake signal by suspend which wakes up pselect to be frozen,
and after resume, real signal is sent.  When both of signals are
handled in a single call of exit_to_usermode_loop, by two calls of
do_signal, firstly for fake signal and secondly for real signal, the
system call is restarted wrongly, where it should return -EINTR.

Here is a patch series of mine for x86.  I'd suggest architecture
maintainers to do similar if an architecture supports suspend/resume.

I found that, in arch/arm, it does differently.  When it finds no
signal delivery at do_signal, it restarts the system call soon,
breaking the loop.  This approach also works.

Changes from v1:
* Title change of cover leter
* Avoid User Mode Linux breakage
* Only call nosig_restart_syscall when really needed
* Add 'unlikely'.

NIIBE Yutaka (4):
  signal/x86: Factor out nosig handling.
  signal/x86: do_signal: syscall restart should be done only once.
  signal/x86: Move restore_saved_sigmask().
  signal/x86: Move nosig handling at the end of exit_to_usermode_loop.

 arch/x86/entry/common.c       |  6 +++++-
 arch/x86/include/asm/signal.h |  5 ++++-
 arch/x86/kernel/signal.c      | 22 ++++++++++++++--------
 3 files changed, 23 insertions(+), 10 deletions(-)

-- 
2.11.0
