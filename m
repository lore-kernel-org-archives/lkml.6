Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C531CECDFBD
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9792084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UG7lX5/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9792084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbeGSVl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 17:41:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44936 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbeGSVl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 17:41:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6JKt1Uu192531;
        Thu, 19 Jul 2018 20:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2018-07-02;
 bh=tYkoPPEQ0tFBVr+zQQ44VHl8S9FVuNGCP9azNzn3Fjo=;
 b=UG7lX5/OuDEdT9N1l+eONiiTNtxY1KfZ03bA5SAgFSbeJw0uO7f2ARX/6bj1/75pzMj/
 ktDqaHTKJgUE9pp4dvqhHbe4xOoqXTuxlwXkfeFi2wIH6jzXSmRy7Mn6n5qaO/dH2TfZ
 Q8IbqkVHUKrlYSriC7cUnQe7krZ0aG1m0U8iwR9TxTCkJvdlGK1DMQa/CbptbpRUUMYq
 PQKnZAjIYVnVY41rwuSxV3pIDH1ZKCHH1N2/pNs1SBMGG9vhkK38z38+q/W0t6UrOmNf
 cqF3EJy9xhBJEADXjgAJjSdbP+CehOxkbrR3mfmxSkZh9Xv9yLexzst7zGY4pvOeFmoq CA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2k9yjgruem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 20:56:13 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6JKuCWg032624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 20:56:12 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6JKuAVo026616;
        Thu, 19 Jul 2018 20:56:10 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Jul 2018 20:56:09 +0000
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, pasha.tatashin@oracle.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
Subject: [PATCH v15 00/26] Early boot time stamps
Date:   Thu, 19 Jul 2018 16:55:19 -0400
Message-Id: <20180719205545.16512-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8959 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807190218
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changelog
---------
v15 - v14
	Repo: https://github.com/soleen/time_15.git
	- dropped "x86/kvmclock: Avoid TSC recalibration" as Paolo Bonzini
	  suggested
	- Fixed in "sched: early boot clock" whenched_clock_running is set,
	   and moved __sched_clock_gtod_offset inside IRQ as Peter noticed.
	- Addressed comments from Dou Liyang: added missing __inits, and
	  X86_FEATURE_TSC_DEADLINE_TIMER, spelling.
	- Fixed xen_sched_clock_offset on xen hvm (noticed by Boris
	  Ostrovsky).
	- Added two patches to address Peter Zijlstra's request to split
	  native cpu calibration into early and late parts. The patches
	  are:
	  x86/tsc:  split native_calibrate_cpu() into early and late parts
	  x86/tsc:  use tsc_calibrate_cpu_early and
	    pit_hpet_ptimer_calibrate_cpu

v14 - v13
	- Included Thomas' KVM clock series, addressed comments from
	  reviewers.
	http://lkml.kernel.org/r/20180706161307.733337643@linutronix.de
	- Fixed xen hvm panic reported by Boris
	- Fixed build issue on microblaze

v13 - v12
	- Addressed comments from Thomas Gleixner.
	- Addressed comments from Peter Zijlstra.
	- Added a patch from Borislav Petkov
	- Added a new patch: sched: use static key for sched_clock_running
	- Added xen pv fixes, so clock is initialized when other
	  hypervisors initialize their clocks.
	Note: I am including kvm/x86: remove kvm memblock dependency, which
	is part of this series:
	http://lkml.kernel.org/r/20180706161307.733337643@linutronix.de
	Because without this patch it is not possible to test this series on
	KVM.

v12 - v11
	- split time: replace read_boot_clock64() with
	  read_persistent_wall_and_boot_offset() into four patches
	- Added two patches one fixes an existing bug with text_poke()
	  another one enables static branches early. Note, because I found
	  and fixed the text_poke() bug, enabling static branching became
	  super easy, as no changes to jump_label* is needed.
	- Modified x86/tsc: use tsc early to use static branches early, and
	  thus native_sched_clock() is not changed at all.
v11 - v10
	- Addressed all the comments from Thomas Gleixner.
	- I added one more patch:
	  "x86/tsc: prepare for early sched_clock" which fixes a problem
	  that I discovered while testing. I am not particularly happy with
	  the fix, as it adds a new argument that is used only in one
	  place, but if you have a suggestion for a different approach on
	  how to address this problem please let me know.

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

The early boot time stamps were discussed recently in these threads:
http://lkml.kernel.org/r/1527672059-6225-1-git-send-email-feng.tang@intel.com
http://lkml.kernel.org/r/1527672059-6225-2-git-send-email-feng.tang@intel.com

I updated my series to the latest mainline and sending it again.

Peter mentioned he did not like patch 6,7, and we can discuss for a better
way to do that, but I think patches 1-5 can be accepted separetly, since
they already enable early timestamps on platforms where sched_clock() is
available early. Such as KVM.

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
  kvm/x86: remove kvm memblock dependency
  x86/paravirt: add active_sched_clock to pv_time_ops
  x86/tsc: use tsc early

Example 3:
http://lkml.kernel.org/r/20180615155733.1175-1-pasha.tatashin@oracle.com
- Needed early time stamps to show improvement
Borislav Petkov (1):
  x86/CPU: Call detect_nopl() only on the BSP

Pavel Tatashin (19):
  x86/kvmclock: Remove memblock dependency
  x86: text_poke() may access uninitialized struct pages
  x86: initialize static branching early
  x86/tsc: redefine notsc to behave as tsc=unstable
  x86/xen/time: initialize pv xen time in init_hypervisor_platform
  x86/xen/time: output xen sched_clock time from 0
  s390/time: add read_persistent_wall_and_boot_offset()
  time: replace read_boot_clock64() with
    read_persistent_wall_and_boot_offset()
  time: default boot time offset to local_clock()
  s390/time: remove read_boot_clock64()
  ARM/time: remove read_boot_clock64()
  x86/tsc: calibrate tsc only once
  x86/tsc: initialize cyc2ns when tsc freq. is determined
  x86/tsc: use tsc early
  sched: move sched clock initialization and merge with generic clock
  sched: early boot clock
  sched: use static key for sched_clock_running
  x86/tsc:  split native_calibrate_cpu() into early and late parts
  x86/tsc:  use tsc_calibrate_cpu_early and
    pit_hpet_ptimer_calibrate_cpu

Thomas Gleixner (6):
  x86/kvmclock: Remove page size requirement from wall_clock
  x86/kvmclock: Decrapify kvm_register_clock()
  x86/kvmclock: Cleanup the code
  x86/kvmclock: Mark variables __initdata and __ro_after_init
  x86/kvmclock: Move kvmclock vsyscall param and init to kvmclock
  x86/kvmclock: Switch kvmclock data to a PER_CPU variable

 .../admin-guide/kernel-parameters.txt         |   2 -
 Documentation/x86/x86_64/boot-options.txt     |   4 +-
 arch/arm/include/asm/mach/time.h              |   3 +-
 arch/arm/kernel/time.c                        |  15 +-
 arch/arm/plat-omap/counter_32k.c              |   2 +-
 arch/s390/kernel/time.c                       |  15 +-
 arch/x86/include/asm/kvm_guest.h              |   7 -
 arch/x86/include/asm/kvm_para.h               |   1 -
 arch/x86/include/asm/text-patching.h          |   1 +
 arch/x86/include/asm/tsc.h                    |   4 +-
 arch/x86/kernel/alternative.c                 |   7 +
 arch/x86/kernel/cpu/amd.c                     |  13 +-
 arch/x86/kernel/cpu/common.c                  |  40 +--
 arch/x86/kernel/jump_label.c                  |  11 +-
 arch/x86/kernel/kvm.c                         |  14 +-
 arch/x86/kernel/kvmclock.c                    | 256 +++++++-----------
 arch/x86/kernel/setup.c                       |  10 +-
 arch/x86/kernel/tsc.c                         | 253 +++++++++--------
 arch/x86/kernel/x86_init.c                    |   2 +-
 arch/x86/xen/enlighten_pv.c                   |  51 ++--
 arch/x86/xen/mmu_pv.c                         |   6 +-
 arch/x86/xen/suspend_pv.c                     |   5 +-
 arch/x86/xen/time.c                           |  18 +-
 arch/x86/xen/xen-ops.h                        |   6 +-
 drivers/clocksource/tegra20_timer.c           |   2 +-
 include/linux/sched_clock.h                   |   5 +-
 include/linux/timekeeping.h                   |   3 +-
 init/main.c                                   |   4 +-
 kernel/sched/clock.c                          |  59 ++--
 kernel/sched/core.c                           |   1 -
 kernel/sched/debug.c                          |   2 -
 kernel/time/sched_clock.c                     |   2 +-
 kernel/time/timekeeping.c                     |  62 +++--
 33 files changed, 439 insertions(+), 447 deletions(-)
 delete mode 100644 arch/x86/include/asm/kvm_guest.h

-- 
2.18.0

