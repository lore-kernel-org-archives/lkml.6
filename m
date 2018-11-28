Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4CEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 07:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF0620832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 07:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF0620832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeK1SYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 13:24:04 -0500
Received: from mga02.intel.com ([134.134.136.20]:58213 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbeK1SYE (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 13:24:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 23:23:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,289,1539673200"; 
   d="scan'208";a="113152582"
Received: from skl.sh.intel.com ([10.239.161.125])
  by fmsmga004.fm.intel.com with ESMTP; 27 Nov 2018 23:23:23 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 0/3] perf report/annotate: Support average IPC and IPC coverage for function
Date:   Wed, 28 Nov 2018 23:14:55 +0800
Message-Id: <1543418098-10435-1-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add supporting of displaying the average IPC and IPC coverage
percentage per function.

For example,

$ perf record -b ...
$ perf report -s symbol or
  perf report -s symbol --stdio

Overhead  Symbol                           IPC   [IPC Coverage]
  39.60%  [.] __random                     2.30  [ 54.8%]
  18.02%  [.] main                         0.43  [ 54.3%]
  14.21%  [.] compute_flag                 2.29  [100.0%]
  14.16%  [.] rand                         0.36  [100.0%]
   7.06%  [.] __random_r                   2.57  [ 70.5%]
   6.85%  [.] rand@plt                     0.00  [  0.0%]
  ...

$ perf annotate --stdio2

Percent  IPC Cycle (Average IPC: 2.30, IPC Coverage: 54.8%)

                        Disassembly of section .text:

                        000000000003aac0 <random@@GLIBC_2.2.5>:
  8.32  3.28              sub    $0x18,%rsp
        3.28              mov    $0x1,%esi
        3.28              xor    %eax,%eax
        3.28              cmpl   $0x0,argp_program_version_hook@@GLIBC_2.2.5+0x1e0
 11.57  3.28     1      ↓ je     20
                          lock   cmpxchg %esi,__abort_msg@@GLIBC_PRIVATE+0x8a0
                        ↓ jne    29
                        ↓ jmp    43
 11.57  1.10        20:   cmpxchg %esi,__abort_msg@@GLIBC_PRIVATE+0x8a0
 ...

v3:
---
    Remove the sortkey "ipc" from command-line. The columns "IPC"
    and "[IPC Coverage]" are automatically enabled when "symbol"
    is specified.

    Patch "perf report: Display average IPC and IPC coverage per symbol"
    is impacted.

v2:
---
  1. Merge in Jiri's patch to support stdio mode

  2. Add a new patch "perf annotate: Create a annotate2 flag
     in struct symbol" which records if the symbol has been
     annotated yet.

  3. Minor update such as adding { } for multiline code in 'if'
     condition.

Jin Yao (3):
  perf annotate: Compute average IPC and IPC coverage per symbol
  perf annotate: Create a annotate2 flag in struct symbol
  perf report: Display average IPC and IPC coverage per symbol

 tools/perf/builtin-report.c | 26 ++++++++++++++++---
 tools/perf/util/annotate.c  | 42 ++++++++++++++++++++++++++++---
 tools/perf/util/annotate.h  |  5 ++++
 tools/perf/util/hist.h      |  1 +
 tools/perf/util/sort.c      | 61 +++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/sort.h      |  2 ++
 tools/perf/util/symbol.h    |  1 +
 7 files changed, 132 insertions(+), 6 deletions(-)

-- 
2.7.4

