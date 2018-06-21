Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F002C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB9521A82
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kx4y7D33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB9521A82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933729AbeFUV2d (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:28:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49138 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933047AbeFUV2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:28:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5LLO0cu099114;
        Thu, 21 Jun 2018 21:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2017-10-26;
 bh=5wDAxJI6BT6/pz5GS3fR1rsmAF17yD5TXQBw/64Me5U=;
 b=kx4y7D33vOiiswbWTLqtL4BoLxC36eBC/eP7xUCT97pvBBdEqsP9DJ3SPpCC/1StDpye
 uNhxs5Bx/l3F2euLGBJYlssoWjQYqi9BhzRl7hxqPaQ2r+MCGT0xQ5QRJoRP2Vvw65yd
 A8avaGdvp9MHr+f3mRtTgraBDgJa0VpoKpBG9LCpB0x/5zn+L4SYN3OuFsGQbSr3mYHs
 pgv7A1OYux4iC6b3H0lkNu04vJF4URp+8k3uwnHOwBTqdJmoVjdzJSIystLv9VerInSv
 MDgw1nEab38NwmzwPscDzQQcktteXd0onGkwTXn85SL56EFj0FN8o83IyHOpawh4WLFM yw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2jmu6y3nxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jun 2018 21:25:30 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5LLPToj028153
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jun 2018 21:25:29 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5LLPPDp015150;
        Thu, 21 Jun 2018 21:25:26 GMT
Received: from xakep.us.oracle.com (/10.39.228.116)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Jun 2018 14:25:25 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org
Subject: [PATCH v12 00/11] Early boot time stamps for x86
Date:   Thu, 21 Jun 2018 17:25:07 -0400
Message-Id: <20180621212518.19914-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8931 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806210230
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changelog
---------
v12 - v11
	- splitted time: replace read_boot_clock64() with
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

Pavel Tatashin (11):
  x86: text_poke() may access uninitialized struct pages
  x86: initialize static branching early
  x86/tsc: redefine notsc to behave as tsc=unstable
  kvm/x86: remove kvm memblock dependency
  s390/time: add read_persistent_wall_and_boot_offset()
  time: replace read_boot_clock64() with
    read_persistent_wall_and_boot_offset()
  s390/time: remove read_boot_clock64()
  ARM/time: remove read_boot_clock64()
  x86/tsc: prepare for early sched_clock
  sched: early boot clock
  x86/tsc: use tsc early

 .../admin-guide/kernel-parameters.txt         |  2 -
 Documentation/x86/x86_64/boot-options.txt     |  4 +-
 arch/arm/kernel/time.c                        | 12 +---
 arch/s390/kernel/time.c                       | 15 +++--
 arch/x86/include/asm/text-patching.h          |  1 +
 arch/x86/kernel/alternative.c                 | 10 ++-
 arch/x86/kernel/cpu/amd.c                     | 13 ++--
 arch/x86/kernel/cpu/common.c                  | 38 ++++++-----
 arch/x86/kernel/kvm.c                         |  1 +
 arch/x86/kernel/kvmclock.c                    | 64 +++---------------
 arch/x86/kernel/setup.c                       | 11 ++--
 arch/x86/kernel/tsc.c                         | 65 ++++++++++---------
 include/linux/timekeeping.h                   |  3 +-
 kernel/sched/clock.c                          | 10 ++-
 kernel/time/timekeeping.c                     | 61 ++++++++---------
 15 files changed, 140 insertions(+), 170 deletions(-)

-- 
2.17.1

