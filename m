Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F0AC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD292146E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xgEVJfMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD292146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390977AbeGLANN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 20:13:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35458 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390955AbeGLANK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 20:13:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6C04UP9185776;
        Thu, 12 Jul 2018 00:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2018-07-02;
 bh=g/Ml0WWStK6JuihHX4vAe1nukI0Qqe6zD+qez1JSnJY=;
 b=xgEVJfMcU3pPz7uhGZU7ilxzIcScqJ9kACdHRte54d6IYD68NOid2FXYAVBwJPSbZXFF
 K18RwLdCiZEusl9uJHrDDBD01tUssTFM+Xixj+hUvM1v4tisR3Sff+VDuNttKo5yDUm8
 k/+CxMjFORNanPemGLEDhZkobnrxUogdwIZGb2TAa+uMq7F4Q8BVdXQwKa+Mufc2mnnb
 b/rprF8/1tbEs+l79w0g65Zywa9X+ePjk5+V1ux+TeTrzH46FMO+9ULb10NfTaBq7ztY
 BYWRA6396qwgDImkeeMRn3cOZLibMljnmDlJYy2mt3bNHeV2sz2piF0hYAGHMY5SPind 5A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2k2p7e09g8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 00:04:30 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6C04Sfc028772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 00:04:28 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6C04Pcq011210;
        Thu, 12 Jul 2018 00:04:25 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Jul 2018 17:04:24 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, pasha.tatashin@oracle.com,
        boris.ostrovsky@oracle.com, jgross@suse.com
Subject: [PATCH v13 00/18] Early boot time stamps
Date:   Wed, 11 Jul 2018 20:04:01 -0400
Message-Id: <20180712000419.5165-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8951 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807110252
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changelog
---------
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
  x86: text_poke() may access uninitialized struct pages
  x86: initialize static branching early
  x86/tsc: redefine notsc to behave as tsc=unstable
  kvm/x86: remove kvm memblock dependency
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

 .../admin-guide/kernel-parameters.txt         |   2 -
 Documentation/x86/x86_64/boot-options.txt     |   4 +-
 arch/arm/include/asm/mach/time.h              |   3 +-
 arch/arm/kernel/time.c                        |  15 +-
 arch/arm/plat-omap/counter_32k.c              |   2 +-
 arch/s390/kernel/time.c                       |  15 +-
 arch/x86/include/asm/kvm_para.h               |   2 +-
 arch/x86/include/asm/text-patching.h          |   1 +
 arch/x86/include/asm/tsc.h                    |   2 +-
 arch/x86/kernel/alternative.c                 |   7 +
 arch/x86/kernel/cpu/amd.c                     |  13 +-
 arch/x86/kernel/cpu/common.c                  |  40 ++--
 arch/x86/kernel/jump_label.c                  |  11 +-
 arch/x86/kernel/kvm.c                         |   1 +
 arch/x86/kernel/kvmclock.c                    |  66 +------
 arch/x86/kernel/setup.c                       |  11 +-
 arch/x86/kernel/tsc.c                         | 187 +++++++++---------
 arch/x86/xen/enlighten_pv.c                   |  51 +++--
 arch/x86/xen/mmu_pv.c                         |   6 +-
 arch/x86/xen/suspend_pv.c                     |   5 +-
 arch/x86/xen/time.c                           |  24 +--
 arch/x86/xen/xen-ops.h                        |   6 +-
 drivers/clocksource/tegra20_timer.c           |   2 +-
 include/linux/sched_clock.h                   |   5 +-
 include/linux/timekeeping.h                   |   3 +-
 init/main.c                                   |   4 +-
 kernel/sched/clock.c                          |  48 +++--
 kernel/sched/core.c                           |   1 -
 kernel/sched/debug.c                          |   2 -
 kernel/time/sched_clock.c                     |   2 +-
 kernel/time/timekeeping.c                     |  62 +++---
 31 files changed, 288 insertions(+), 315 deletions(-)

-- 
2.18.0

