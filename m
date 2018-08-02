Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5F1C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFC02146D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFFC02146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731812AbeHBKHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:07:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36647 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeHBKHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:07:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w728Gn0s3431771
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 01:16:49 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w728Gnpu3431768;
        Thu, 2 Aug 2018 01:16:49 -0700
Date:   Thu, 2 Aug 2018 01:16:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Christophe Leroy <tipbot@zytor.com>
Message-ID: <tip-21b8732eb4479b579bda9ee38e62b2c312c2a0e5@git.kernel.org>
Cc:     hpa@zytor.com, alexander.shishkin@linux.intel.com, acme@redhat.com,
        tglx@linutronix.de, christophe.leroy@c-s.fr, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, alexander.shishkin@linux.intel.com,
          acme@redhat.com, tglx@linutronix.de, christophe.leroy@c-s.fr,
          peterz@infradead.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20170922112043.8349468C57@po15668-vm-win7.idsi0.si.c-s.fr>
References: <20170922112043.8349468C57@po15668-vm-win7.idsi0.si.c-s.fr>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Allow overriding MAX_NR_CPUS at compile
 time
Git-Commit-ID: 21b8732eb4479b579bda9ee38e62b2c312c2a0e5
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  21b8732eb4479b579bda9ee38e62b2c312c2a0e5
Gitweb:     https://git.kernel.org/tip/21b8732eb4479b579bda9ee38e62b2c312c2a0e5
Author:     Christophe Leroy <christophe.leroy@c-s.fr>
AuthorDate: Fri, 22 Sep 2017 13:20:43 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 1 Aug 2018 12:33:24 -0300

perf tools: Allow overriding MAX_NR_CPUS at compile time

After update of kernel, the perf tool doesn't run anymore on my 32MB RAM
powerpc board, but still runs on a 128MB RAM board:

  ~# strace perf
  execve("/usr/sbin/perf", ["perf"], [/* 12 vars */]) = -1 ENOMEM (Cannot allocate memory)
  --- SIGSEGV {si_signo=SIGSEGV, si_code=SI_KERNEL, si_addr=0} ---
  +++ killed by SIGSEGV +++
  Segmentation fault

objdump -x shows that .bss section has a huge size of 24Mbytes:

 27 .bss          016baca8  101cebb8  101cebb8  001cd988  2**3

With especially the following objects having quite big size:

  10205f80 l     O .bss	00140000     runtime_cycles_stats
  10345f80 l     O .bss	00140000     runtime_stalled_cycles_front_stats
  10485f80 l     O .bss	00140000     runtime_stalled_cycles_back_stats
  105c5f80 l     O .bss	00140000     runtime_branches_stats
  10705f80 l     O .bss	00140000     runtime_cacherefs_stats
  10845f80 l     O .bss	00140000     runtime_l1_dcache_stats
  10985f80 l     O .bss	00140000     runtime_l1_icache_stats
  10ac5f80 l     O .bss	00140000     runtime_ll_cache_stats
  10c05f80 l     O .bss	00140000     runtime_itlb_cache_stats
  10d45f80 l     O .bss	00140000     runtime_dtlb_cache_stats
  10e85f80 l     O .bss	00140000     runtime_cycles_in_tx_stats
  10fc5f80 l     O .bss	00140000     runtime_transaction_stats
  11105f80 l     O .bss	00140000     runtime_elision_stats
  11245f80 l     O .bss	00140000     runtime_topdown_total_slots
  11385f80 l     O .bss	00140000     runtime_topdown_slots_retired
  114c5f80 l     O .bss	00140000     runtime_topdown_slots_issued
  11605f80 l     O .bss	00140000     runtime_topdown_fetch_bubbles
  11745f80 l     O .bss	00140000     runtime_topdown_recovery_bubbles

This is due to commit 4d255766d28b1 ("perf: Bump max number of cpus
to 1024"), because many tables are sized with MAX_NR_CPUS

This patch gives the opportunity to redefine MAX_NR_CPUS via

  $ make EXTRA_CFLAGS=-DMAX_NR_CPUS=1

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/20170922112043.8349468C57@po15668-vm-win7.idsi0.si.c-s.fr
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/perf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index d215714f48df..21bf7f5a3cf5 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -25,7 +25,9 @@ static inline unsigned long long rdclock(void)
 	return ts.tv_sec * 1000000000ULL + ts.tv_nsec;
 }
 
+#ifndef MAX_NR_CPUS
 #define MAX_NR_CPUS			1024
+#endif
 
 extern const char *input_name;
 extern bool perf_host, perf_guest;
