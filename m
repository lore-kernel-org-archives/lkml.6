Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B707C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6B0208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MTky1X/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6B0208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966396AbeFORnl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:43:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58862 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966063AbeFORnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:43:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5FHcbXT071391;
        Fri, 15 Jun 2018 17:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2017-10-26;
 bh=ULErE7lfYhdPi3ybTPdIrf2lbzVUufBLpRlGwByu97A=;
 b=MTky1X/a1oOTzjHNLmDXOX9ENcuWGpyC8xIz8gCmhd0GSIa23rGAS2y7/PoPw6jGwFpm
 ZbHM2hLOKFOGUD1KfySoyVNCUusRJPlGnK/kZvM15NTyW31NQTYBGf7zMm74hx4wWBsa
 /7OpBTe1MjBEYoshChyTmX4RJUghdGSF7O5qPgTaHOQ3Ga6wcCGmBgq0qxu1WG4RolAC
 Ydu/GxW5gQWmvFOcwLAIwOAZ202PnVMINBvWFnz89xLNDJVbklIGXsxuNWaoh/Hk2Xm0
 ojAYyTkT7p6ZM9M2orbnP/yvwQnnL82/VoV7Pp/h0vnU+P/YnTMJeze1bp9QvPNxloHR lg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2jk0xrsvpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 17:42:15 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5FHgDmb009652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 17:42:14 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5FHgAnL022440;
        Fri, 15 Jun 2018 17:42:10 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Jun 2018 10:42:10 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk
Subject: [PATCH v10 0/7] Early boot time stamps for x86
Date:   Fri, 15 Jun 2018 13:41:57 -0400
Message-Id: <20180615174204.30581-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8925 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806150189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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

 arch/arm/kernel/time.c                |   2 +-
 arch/s390/kernel/time.c               |   2 +-
 arch/x86/include/asm/paravirt.h       |   2 +-
 arch/x86/include/asm/paravirt_types.h |   1 +
 arch/x86/kernel/kvm.c                 |   1 +
 arch/x86/kernel/kvmclock.c            |  64 ++------------
 arch/x86/kernel/paravirt.c            |   1 +
 arch/x86/kernel/setup.c               |   7 +-
 arch/x86/kernel/time.c                |  30 +++++++
 arch/x86/kernel/tsc.c                 | 116 ++++++++++++++++++++++----
 arch/x86/xen/time.c                   |   7 +-
 include/linux/timekeeping.h           |   2 +-
 kernel/sched/clock.c                  |  10 ++-
 kernel/time/timekeeping.c             |   8 +-
 14 files changed, 165 insertions(+), 88 deletions(-)

-- 
2.17.1

