Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A46AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702C22086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfARQAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:00:40 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60290 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727467AbfARQAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:00:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60AE9EBD;
        Fri, 18 Jan 2019 08:00:39 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C14D63F557;
        Fri, 18 Jan 2019 08:00:36 -0800 (PST)
From:   Andrew Murray <andrew.murray@arm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, Grant Likely <Grant.Likely@arm.com>,
        Steven Price <Steven.Price@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>
Subject: [Linux-eng] [RFC 0/3] Abstract empty functions with STUB_UNLESS macro
Date:   Fri, 18 Jan 2019 16:00:27 +0000
Message-Id: <1547827230-55132-1-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A common pattern found in header files is a function declaration dependent
on a CONFIG_ option being enabled, followed by an empty function for when
that option isn't enabled. This boilerplate code can often take up a lot
of space and impact code readability.

This series introduces a STUB_UNLESS macro that simplifies header files as
follows:

STUB_UNLESS(CONFIG_FOO, [body], prototype)

This evaluates to 'prototype' prepended with 'extern' if CONFIG_FOO is set
to 'y'. Otherwise it will evaluate to 'prototype' prepended with 'static
inline' followed by an empty function body. Where optional argument 'body'
is present then 'body' will be used as the function body, intended to allow
simple return statements. Using the macro results in hunks such as this:

-#ifdef CONFIG_HAVE_HW_BREAKPOINT
-extern void hw_breakpoint_thread_switch(struct task_struct *next);
-extern void ptrace_hw_copy_thread(struct task_struct *task);
-#else
-static inline void hw_breakpoint_thread_switch(struct task_struct *next)
-{
-}
-static inline void ptrace_hw_copy_thread(struct task_struct *task)
-{
-}
-#endif
+STUB_UNLESS(CONFIG_HAVE_HW_BREAKPOINT,
+void hw_breakpoint_thread_switch(struct task_struct *next));
+
+STUB_UNLESS(CONFIG_HAVE_HW_BREAKPOINT,
+void ptrace_hw_copy_thread(struct task_struct *task));

This may or may not be considered as more desirable than the status quo.

This series updates arm64 and perf to use the macro as an example.

Andrew Murray (3):
  kconfig.h: abstract empty functions with STUB_UNLESS macro
  cpufreq: update headers to use STUB_UNLESS macro
  arm64: update headers to use STUB_UNLESS macro

 arch/arm64/include/asm/acpi.h           | 38 +++++++++-------------
 arch/arm64/include/asm/alternative.h    |  6 +---
 arch/arm64/include/asm/cpufeature.h     |  6 +---
 arch/arm64/include/asm/cpuidle.h        | 18 +++--------
 arch/arm64/include/asm/debug-monitors.h | 10 ++----
 arch/arm64/include/asm/fpsimd.h         | 57 +++++++++++++--------------------
 arch/arm64/include/asm/hw_breakpoint.h  | 16 +++------
 arch/arm64/include/asm/kasan.h          |  9 ++----
 arch/arm64/include/asm/numa.h           | 19 ++++-------
 arch/arm64/include/asm/ptdump.h         | 13 +++-----
 arch/arm64/include/asm/signal32.h       | 29 +++++------------
 include/linux/cpufreq.h                 | 21 ++++--------
 include/linux/kconfig.h                 | 31 ++++++++++++++++++
 13 files changed, 110 insertions(+), 163 deletions(-)

-- 
2.7.4

