Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C972C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4420D25FB4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjUo4UP5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4420D25FB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965097AbeFYRpJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964817AbeFYRlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:41:11 -0400
Received: from jouet.infradead.org (unknown [177.79.80.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A80F925C82;
        Mon, 25 Jun 2018 17:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529948469;
        bh=CTxKceQzmGigHvH4SfDhL30dReZZWZRRZ7XtPcUx5dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BjUo4UP5H5N/4rapBTR0m0lss2M5dy7EYsCLWrxF6qPDTM1ZSp7VSft7dWwFkMEX1
         CSC9wouEL4sJMK8vIkwHJXerbs++hdnI62PvyC5r/aYe+4mZELZ2fst1B8UJyJrTid
         vBafSW3p5HI3g5aqDAwi9c2aFbAAJQVMcWYMBX3M=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Sandipan Das <sandipan@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/19] perf report powerpc: Fix crash if callchain is empty
Date:   Mon, 25 Jun 2018 14:40:29 -0300
Message-Id: <20180625174045.25765-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180625174045.25765-1-acme@kernel.org>
References: <20180625174045.25765-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandipan Das <sandipan@linux.ibm.com>

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
-- 
2.14.3

