Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EE8C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB6221B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbfBKR7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:59:42 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55032 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfBKR7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:59:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96AC1EBD;
        Mon, 11 Feb 2019 09:59:41 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1AD0D3F675;
        Mon, 11 Feb 2019 09:59:39 -0800 (PST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH 0/4] Allow tasks to have their user stack pointer sanity checked
Date:   Mon, 11 Feb 2019 17:59:31 +0000
Message-Id: <20190211175935.4602-1-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I attended an interesting talk at LCA last month that described some of the
security features deployed in OpenBSD [1]. One hardening feature that piqued
my interest was, on syscall entry and page faults from userspace, checking
that the user stack pointer for a task points at pages that were either
allocated by the kernel for the initial process stack of mapped with mmap()
using the MAP_STACK flag. This acts as a basic defense against stack
pivoting attacks.

The problem with this checking is that it is a retrospective tightening
of the ABI, but that hasn't stopped me hacking it together behind a couple
of prctl() options.

Anyway, it was fun to implement so I figured I'd post it as an RFC.

Will

[1] https://2019.linux.conf.au/schedule/presentation/164/

Cc: Kees Cook <keescook@chromium.org>
Cc: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>

--->8

Will Deacon (4):
  mm: Check user stack pointer is mapped with MAP_STACK
  mm: Expose user stack pointer checking via prctl()
  mm: Add kconfig entries for user stack pointer checking
  arm64: Check user stack pointer on syscall entry

 arch/arm64/Kconfig          |  1 +
 arch/arm64/kernel/syscall.c |  4 +++
 include/linux/mm.h          | 15 +++++++++-
 include/linux/mman.h        |  3 +-
 include/linux/sched.h       |  4 +++
 include/uapi/linux/prctl.h  |  5 ++++
 kernel/sys.c                |  5 ++++
 mm/Kconfig                  | 17 ++++++++++++
 mm/memory.c                 | 67 +++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 119 insertions(+), 2 deletions(-)

-- 
2.11.0

