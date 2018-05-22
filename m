Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753069AbeEVTkJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:40:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54488 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752724AbeEVTkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:40:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Tue, 22 May 2018 12:40:05 -0700
From: Sodagudi Prasad <psodagud@codeaurora.org>
To: keescook@chromium.org, luto@amacapital.net, wad@chromium.org,
        akpm@linux-foundation.org, riel@redhat.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, ebiggers@google.com,
        fweisbec@gmail.com, sherryy@android.com, vegard.nossum@oracle.com,
        cl@linux.com, aarcange@redhat.com, alexander.levin@verizon.com,
        vegard.nossum@oracle.com, sherryy@android.com, fweisbec@gmail.com,
        ebiggers@google.com, peterz@infradead.org
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: write_lock_irq(&tasklist_lock)
Message-ID: <0879f797135033e05e8e9166a3c85628@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

When following test is executed on 4.14.41 stable kernel, observed that 
one of the core is waiting for tasklist_lock for long time with IRQs 
disabled.
./stress-ng-64 --get 8 -t 3h --times --metrics-brief

Every time when device is crashed, I observed that one the task stuck at 
fork system call and waiting for tasklist_lock as writer with irq 
disabled.
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/kernel/fork.c?h=linux-4.14.y#n1843

Some other tasks are making getrlimit, prlimit system calls, so that 
these readers are continuously taking tasklist_list read lock.

Writer has disabled local IRQs for long time and waiting to readers to 
finish but readers are keeping tasklist_lock busy
for quite long time.

I think, −−get N option creates N thread and they make following system 
calls.
========================================================================
start N workers that call system calls that fetch data from the kernel, 
currently these are: getpid,
getppid, getcwd, getgid, getegid, getuid, getgroups, getpgrp, getpgid, 
getpriority, getresgid, getresuid,
getrlimit, prlimit, getrusage, getsid, gettid, getcpu, gettimeofday, 
uname, adjtimex, sysfs.
Some of these system calls are OS specific.
========================================================================

Have you observed this type of issues with tasklist_lock ?
Do we need write_lock_irq(&tasklist_lock) in below portion of code ? Can 
I use write_unlock instead of write_lock_irq in portion of code?
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/kernel/fork.c?h=linux-4.14.y#n1843

-Thanks, Prasad

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
