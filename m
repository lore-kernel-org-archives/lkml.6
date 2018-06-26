Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA6BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C5324F13
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C5324F13
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbeFZGw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:52:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58181 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751134AbeFZGwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:52:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5Q6qlYr1591165
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 25 Jun 2018 23:52:47 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5Q6qlON1591162;
        Mon, 25 Jun 2018 23:52:47 -0700
Date:   Mon, 25 Jun 2018 23:52:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sandipan Das <tipbot@zytor.com>
Message-ID: <tip-143c99f6ac6812d23254e80844d6e34be897d3e1@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, jolsa@redhat.com,
        sukadev@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com,
        sandipan@linux.ibm.com, hpa@zytor.com,
        naveen.n.rao@linux.vnet.ibm.com, tglx@linutronix.de,
        acme@redhat.com
Reply-To: linux-kernel@vger.kernel.org, jolsa@redhat.com,
          ravi.bangoria@linux.ibm.com, sukadev@linux.vnet.ibm.com,
          hpa@zytor.com, sandipan@linux.ibm.com, mingo@kernel.org,
          acme@redhat.com, naveen.n.rao@linux.vnet.ibm.com,
          tglx@linutronix.de
In-Reply-To: <20180611104049.11048-1-sandipan@linux.ibm.com>
References: <20180611104049.11048-1-sandipan@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf report powerpc: Fix crash if callchain is
 empty
Git-Commit-ID: 143c99f6ac6812d23254e80844d6e34be897d3e1
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

Commit-ID:  143c99f6ac6812d23254e80844d6e34be897d3e1
Gitweb:     https://git.kernel.org/tip/143c99f6ac6812d23254e80844d6e34be897d3e1
Author:     Sandipan Das <sandipan@linux.ibm.com>
AuthorDate: Mon, 11 Jun 2018 16:10:49 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Jun 2018 11:59:35 -0300

perf report powerpc: Fix crash if callchain is empty

For some cases, the callchain provided by the kernel may be empty. So,
the callchain ip filtering code will cause a crash if we do not check
whether the struct ip_callchain pointer is NULL before accessing any
members.

This can be observed on a powerpc64le system running Fedora 27 as shown
below.

  # perf record -b -e cycles:u ls

Before:

  # perf report --branch-history

  perf: Segmentation fault
  -------- backtrace --------
  perf[0x1027615c]
  linux-vdso64.so.1(__kernel_sigtramp_rt64+0x0)[0x7fff856304d8]
  perf(arch_skip_callchain_idx+0x44)[0x10257c58]
  perf[0x1017f2e4]
  perf(thread__resolve_callchain+0x124)[0x1017ff5c]
  perf(sample__resolve_callchain+0xf0)[0x10172788]
  ...

After:

  # perf report --branch-history

  Samples: 25  of event 'cycles:u', Event count (approx.): 2306870
    Overhead  Source:Line            Symbol                   Shared Object
  +   11.60%  _init+35736            [.] _init                ls
  +    9.84%  strcoll_l.c:137        [.] __strcoll_l          libc-2.26.so
  +    9.16%  memcpy.S:175           [.] __memcpy_power7      libc-2.26.so
  +    9.01%  gconv_charset.h:54     [.] _nl_find_locale      libc-2.26.so
  +    8.87%  dl-addr.c:52           [.] _dl_addr             libc-2.26.so
  +    8.83%  _init+236              [.] _init                ls
  ...

Reported-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20180611104049.11048-1-sandipan@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/skip-callchain-idx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
index 3598b8b75d27..ef5d59a5742e 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -243,7 +243,7 @@ int arch_skip_callchain_idx(struct thread *thread, struct ip_callchain *chain)
 	u64 ip;
 	u64 skip_slot = -1;
 
-	if (chain->nr < 3)
+	if (!chain || chain->nr < 3)
 		return skip_slot;
 
 	ip = chain->ips[2];
