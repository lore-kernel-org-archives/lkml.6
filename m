Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31551ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60582077B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FF+W4Ci7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60582077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbeGRC6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:58:47 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44426 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731235AbeGRC6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:58:47 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6I2KT80001714;
        Wed, 18 Jul 2018 02:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2018-07-02;
 bh=dATugm/ULlGase9ZPnpYcpkqAPk9QoC9+YrDnnR1bbM=;
 b=FF+W4Ci7QCRP/jvidg0KB4NXVjD2juXigy1LvKbJ2OYIXQtMQXynwvN3ixHr+IxzV9yL
 USQ4IHwQAGwmdohMI++7BVk6oheAygK2FM9j+80UJIGj4W2CidkN5UYSJRfIxZ1cQ2LQ
 TdKaLAWDgaVdogT9qDCQe+v6fAisr/ZoHpXHzgtuSwg+nXcP2TL/4hNkgxHn3jb229K+
 JTgvBTY/TjbBAc8qW+p06Vc5yw0Yu+DtCldSg4VodE9/OBTp4ipgnX61abevJqPj/V51
 kkQI2E2DZbrQzWEHp2zCckD7UylF6dJdt4PV9zlPsSaG+nLMFB/MALDYcHVYWDK+4Wc8 3Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2k7a3t34cm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:22:22 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6I2MLRE027294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:22:21 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6I2MJ22013427;
        Wed, 18 Jul 2018 02:22:19 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 19:22:18 -0700
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
Subject: [PATCH v14 00/25] Early boot time stamps
Date:   Tue, 17 Jul 2018 22:21:46 -0400
Message-Id: <20180718022211.6259-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8957 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807180026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changelog
---------
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

Pavel Tatashin (17):
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

Peter Zijlstra (1):
  x86/kvmclock: Avoid TSC recalibration

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
 arch/x86/include/asm/tsc.h                    |   2 +-
 arch/x86/kernel/alternative.c                 |   7 +
 arch/x86/kernel/cpu/amd.c                     |  13 +-
 arch/x86/kernel/cpu/common.c                  |  40 +--
 arch/x86/kernel/jump_label.c                  |  11 +-
 arch/x86/kernel/kvm.c                         |  14 +-
 arch/x86/kernel/kvmclock.c                    | 266 ++++++++----------
 arch/x86/kernel/setup.c                       |  10 +-
 arch/x86/kernel/tsc.c                         | 187 ++++++------
 arch/x86/xen/enlighten_pv.c                   |  51 ++--
 arch/x86/xen/mmu_pv.c                         |   6 +-
 arch/x86/xen/suspend_pv.c                     |   5 +-
 arch/x86/xen/time.c                           |  17 +-
 arch/x86/xen/xen-ops.h                        |   6 +-
 drivers/clocksource/tegra20_timer.c           |   2 +-
 include/linux/sched_clock.h                   |   5 +-
 include/linux/timekeeping.h                   |   3 +-
 init/main.c                                   |   4 +-
 kernel/sched/clock.c                          |  49 ++--
 kernel/sched/core.c                           |   1 -
 kernel/sched/debug.c                          |   2 -
 kernel/time/sched_clock.c                     |   2 +-
 kernel/time/timekeeping.c                     |  62 ++--
 32 files changed, 386 insertions(+), 429 deletions(-)
 delete mode 100644 arch/x86/include/asm/kvm_guest.h

-- 
2.18.0

