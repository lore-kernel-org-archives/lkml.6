Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC9BC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FF920883
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FF920883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbeIXV6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:58:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:56468 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730347AbeIXV6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:58:07 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42Jpgm09tlz9ttRx;
        Mon, 24 Sep 2018 17:55:16 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id VEOlbjB9qRxB; Mon, 24 Sep 2018 17:55:15 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42Jpgl6nlPz9ttRs;
        Mon, 24 Sep 2018 17:55:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 742AA8B7C4;
        Mon, 24 Sep 2018 17:55:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id te0BDsoL9cNA; Mon, 24 Sep 2018 17:55:16 +0200 (CEST)
Received: from PO15451.localdomain (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A44228B7BA;
        Mon, 24 Sep 2018 17:55:15 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A7C2270AD4; Mon, 24 Sep 2018 15:52:21 +0000 (UTC)
Message-Id: <72d3e8c38f729dc22cb3235319b72f96190e01ee.1537802981.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1537802981.git.christophe.leroy@c-s.fr>
References: <cover.1537802981.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 1/9] timer: fix circular header dependency
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org
Date:   Mon, 24 Sep 2018 15:52:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When switching powerpc to CONFIG_THREAD_INFO_IN_TASK, include/sched.h
has to be included in asm/smp.h for the following change, in order
to avoid uncomplete definition of task_struct:

-#define raw_smp_processor_id() (current_thread_info()->cpu)
+#define raw_smp_processor_id() (current->cpu)

But this generates the following compilation error, due to circular
header dependency.

  CC      kernel/time/alarmtimer.o
In file included from ./arch/powerpc/include/asm/smp.h:31,
                 from ./include/linux/smp.h:64,
                 from ./include/linux/percpu.h:7,
                 from ./include/linux/hrtimer.h:22,
                 from kernel/time/alarmtimer.c:19:
./include/linux/sched.h:558:19: error: field 'dl_timer' has incomplete type
  struct hrtimer   dl_timer;
                   ^~~~~~~~
./include/linux/sched.h:567:17: error: field 'inactive_timer' has incomplete type
  struct hrtimer inactive_timer;
                 ^~~~~~~~~~~~~~
make[1]: *** [kernel/time/alarmtimer.o] Error 1
make: *** [kernel/time/alarmtimer.o] Error 2

  CC      fs/timerfd.o
In file included from ./arch/powerpc/include/asm/smp.h:31,
                 from ./include/linux/smp.h:64,
                 from ./include/linux/percpu.h:7,
                 from ./include/linux/hrtimer.h:22,
                 from ./include/linux/alarmtimer.h:6,
                 from fs/timerfd.c:12:
./include/linux/sched.h:558:19: error: field 'dl_timer' has incomplete type
  struct hrtimer   dl_timer;
                   ^~~~~~~~
./include/linux/sched.h:567:17: error: field 'inactive_timer' has incomplete type
  struct hrtimer inactive_timer;
                 ^~~~~~~~~~~~~~
make[1]: *** [fs/timerfd.o] Error 1
make: *** [fs/timerfd.o] Error 2

This patch fixes it by including linux/hrtimer.h after linux/sched.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 Should it be fixed in powerpc instead ? In that case, how ? Any idea ?

 fs/timerfd.c             | 2 +-
 kernel/time/alarmtimer.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index d69ad801eb80..0fc01b241382 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -9,12 +9,12 @@
  *
  */
 
-#include <linux/alarmtimer.h>
 #include <linux/file.h>
 #include <linux/poll.h>
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/sched.h>
+#include <linux/alarmtimer.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/list.h>
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index fa5de5e8de61..5fb75c9b3f06 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -16,11 +16,11 @@
  * published by the Free Software Foundation.
  */
 #include <linux/time.h>
-#include <linux/hrtimer.h>
 #include <linux/timerqueue.h>
 #include <linux/rtc.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/debug.h>
+#include <linux/hrtimer.h>
 #include <linux/alarmtimer.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
-- 
2.13.3

