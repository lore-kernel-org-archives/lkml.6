Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753037AbeBIVNr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 16:13:47 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49570 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752905AbeBIVNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 16:13:02 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com
Subject: [PATCH v10 0/7] Early boot time stamps for x86
Date: Fri,  9 Feb 2018 16:11:36 -0500
Message-Id: <20180209211143.16215-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8800 signatures=668666
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802090267
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changelog
---------
v10 - v9
	- Added another patch to this series that removes dependency
	  between KVM clock, and memblock allocator. The benefit is that
	  all clocks can now be initialized even earlier.
v9 - v8
	- Addressed more comments from Dou Liyang

v8 - v7
	- Addressed comments from Dou Liyang:
	- Moved tsc_early_init() and tsc_early_fini() to be all inside
	  tsc.c, and changed them to be static.
	- Removed warning when notsc parameter is used.
	- Merged with:
	  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

v7 - v6
	- Removed tsc_disabled flag, now notsc is equivalent of
	  tsc=unstable
	- Simplified changes to sched/clock.c, by removing the
	  sched_clock_early() and friends as requested by Peter Zijlstra.
	  We know always use sched_clock()
	- Modified x86 sched_clock() to return either early boot time or
	  regular.
	- Added another example why ealry boot time is important

v5 - v6
	- Added a new patch:
		time: sync read_boot_clock64() with persistent clock
	  Which fixes missing __init macro, and enabled time discrepancy
	  fix that was noted by Thomas Gleixner
	- Split "x86/time: read_boot_clock64() implementation" into a
	  separate patch

v4 - v5
	- Fix compiler warnings on systems with stable clocks.

v3 - v4
	- Fixed tsc_early_fini() call to be in the 2nd patch as reported
	  by Dou Liyang
	- Improved comment before __use_sched_clock_early to explain why
	  we need both booleans.
	- Simplified valid_clock logic in read_boot_clock64().

v2 - v3
	- Addressed comment from Thomas Gleixner
	- Timestamps are available a little later in boot but still much
	  earlier than in mainline. This significantly simplified this
	  work.

v1 - v2
	In patch "x86/tsc: tsc early":
	- added tsc_adjusted_early()
	- fixed 32-bit compile error use do_div()

Adding early boot time stamps support for x86 machines.
SPARC patches for early boot time stamps are already integrated into
mainline linux.

Sample output
-------------
Before:
https://paste.ubuntu.com/26133428/

After:
https://paste.ubuntu.com/26133523/

For exaples how early time stamps are used, see this work:
Example 1:
https://lwn.net/Articles/734374/
- Without early boot time stamps we would not know about the extra time
  that is spent zeroing struct pages early in boot even when deferred
  page initialization.

Example 2:
https://patchwork.kernel.org/patch/10021247/
- If early boot timestamps were available, the engineer who introduced
  this bug would have noticed the extra time that is spent early in boot.

Pavel Tatashin (7):
  x86/tsc: remove tsc_disabled flag
  time: sync read_boot_clock64() with persistent clock
  x86/time: read_boot_clock64() implementation
  sched: early boot clock
  x86/paravirt: add active_sched_clock to pv_time_ops
  x86/tsc: use tsc early
  kvm/x86: remove kvm memblock dependency

 arch/arm/kernel/time.c                |   2 +-
 arch/s390/kernel/time.c               |   2 +-
 arch/x86/include/asm/paravirt.h       |   2 +-
 arch/x86/include/asm/paravirt_types.h |   1 +
 arch/x86/kernel/kvm.c                 |   1 +
 arch/x86/kernel/kvmclock.c            |  64 +++----------------
 arch/x86/kernel/paravirt.c            |   1 +
 arch/x86/kernel/setup.c               |   7 +-
 arch/x86/kernel/time.c                |  30 +++++++++
 arch/x86/kernel/tsc.c                 | 117 ++++++++++++++++++++++++++++------
 arch/x86/xen/time.c                   |   7 +-
 include/linux/timekeeping.h           |   3 +-
 kernel/sched/clock.c                  |  10 ++-
 kernel/time/timekeeping.c             |   8 ++-
 14 files changed, 164 insertions(+), 91 deletions(-)

-- 
2.16.1
