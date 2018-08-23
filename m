Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C496C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20751206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20751206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbeHWLgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:36:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44918 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbeHWLgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:36:41 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 62921C7B;
        Thu, 23 Aug 2018 08:08:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 048/130] perf report powerpc: Fix crash if callchain is empty
Date:   Thu, 23 Aug 2018 09:52:44 +0200
Message-Id: <20180823074930.356269976@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074927.161454870@linuxfoundation.org>
References: <20180823074927.161454870@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sandipan Das <sandipan@linux.ibm.com>

[ Upstream commit 143c99f6ac6812d23254e80844d6e34be897d3e1 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/arch/powerpc/util/skip-callchain-idx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -243,7 +243,7 @@ int arch_skip_callchain_idx(struct threa
 	u64 ip;
 	u64 skip_slot = -1;
 
-	if (chain->nr < 3)
+	if (!chain || chain->nr < 3)
 		return skip_slot;
 
 	ip = chain->ips[2];


