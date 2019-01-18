Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAC7C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A860720823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfARM1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:27:45 -0500
Received: from mga05.intel.com ([192.55.52.43]:2175 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbfARM1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:27:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2019 04:27:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,491,1539673200"; 
   d="scan'208";a="268136099"
Received: from elena-thinkpad-x230.fi.intel.com ([10.237.68.34])
  by orsmga004.jf.intel.com with ESMTP; 18 Jan 2019 04:27:41 -0800
From:   Elena Reshetova <elena.reshetova@intel.com>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, keescook@chromium.org,
        tglx@linutronix.de, Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 0/5] sched refcount_t conversions
Date:   Fri, 18 Jan 2019 14:27:25 +0200
Message-Id: <1547814450-18902-1-git-send-email-elena.reshetova@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would really love finally to merge these old patches
(now rebased on top of linux-next/master as of last friday),
since as far as I remember none has raised any more concerns
on them.

refcount_t has been now successfully used in kernel in many places,
helped to detect bugs and mistakes in logic of refcounters.

This series, for scheduler and task struct specifically,
replaces atomic_t reference counters with the new refcount_t type
and API (see include/linux/refcount.h).
By doing this we prevent intentional or accidental
underflows or overflows that can lead to use-after-free vulnerabilities.

The patches are fully independent and can be cherry-picked separately.
More information about each conversion in each patch separately.

Elena Reshetova (5):
  sched: convert sighand_struct.count to refcount_t
  sched: convert signal_struct.sigcnt to refcount_t
  sched: convert numa_group.refcount to refcount_t
  sched/task_struct: convert task_struct.usage to refcount_t
  sched/task_struct: convert task_struct.stack_refcount to refcount_t

 fs/exec.c                        |  4 ++--
 fs/proc/task_nommu.c             |  2 +-
 include/linux/init_task.h        |  1 +
 include/linux/sched.h            |  5 +++--
 include/linux/sched/signal.h     |  5 +++--
 include/linux/sched/task.h       |  4 ++--
 include/linux/sched/task_stack.h |  2 +-
 init/init_task.c                 |  6 +++---
 kernel/fork.c                    | 24 ++++++++++++------------
 kernel/sched/fair.c              | 12 ++++++------
 10 files changed, 34 insertions(+), 31 deletions(-)

-- 
2.7.4

