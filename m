Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846A8C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261B02646D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="scO5jOmF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261B02646D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965275AbeFZC7T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 22:59:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965232AbeFZC7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 22:59:18 -0400
Received: from localhost.localdomain (h2133.porttelecom.ru [193.189.69.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D11BF257C6;
        Tue, 26 Jun 2018 02:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529981958;
        bh=gFrEUNKK5Jvn4ekydSEjv5zlBq+1Gix6/pSB6hRuoXY=;
        h=From:To:Cc:Subject:Date:From;
        b=scO5jOmFoZDfvrN21SljU6rSm/Hyy7a6e+uMOcfrJE8uAxP/AiioMv+nFBNBm/4Dg
         qLaGbEL9Fr53lOQH2FBeBrbKXAP9V2aAnI8zTc7aEUAIS3ua2lqX6m9U1nxjsHykHP
         7pnTcRxoxB5n+Mv+Ajbheb7bZSvur9KmCSMuRMg0=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Joel Fernandes <joel.opensrc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [GIT PULL] breakpoint: Rework arch validation v4
Date:   Tue, 26 Jun 2018 04:58:47 +0200
Message-Id: <1529981939-8231-1-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

Please pull the perf/breakpoint-v4 branch that can be found at:

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	perf/breakpoint-v4

HEAD: ba25ee9c7b3ef1543c2a24a7ca6a621433803ee4

Only change since v3 is a rebase against latest tip:perf/core

---
When we modify a hardware breakpoint, the architecture code fills up
the architecture data as the validation of generic attributes progresses.
If something goes wrong in the middle, the architecture data changes
aren't rolled back and we are left with a halfway fiddled breakpoint.

This set fixes the various misdesigns that back this bad behaviour.

Thanks,
	Frederic
---

Frederic Weisbecker (12):
      perf/breakpoint: Split attribute parse and commit
      perf/breakpoint: Pass arch breakpoint struct to arch_check_bp_in_kernelspace()
      x86: Implement hw_breakpoint_arch_parse()
      powerpc: Implement hw_breakpoint_arch_parse()
      arm: Implement hw_breakpoint_arch_parse()
      arm64: Implement hw_breakpoint_arch_parse()
      sh: Remove "struct arch_hw_breakpoint::name" unused field
      sh: Implement hw_breakpoint_arch_parse()
      xtensa: Implement hw_breakpoint_arch_parse()
      perf/breakpoint: Remove default hw_breakpoint_arch_parse()
      perf/breakpoint: Pass new breakpoint type to modify_breakpoint_slot()
      perf/breakpoint: Clean up and consolidate modify_user_hw_breakpoint_check()


 arch/arm/include/asm/hw_breakpoint.h     |   7 +-
 arch/arm/kernel/hw_breakpoint.c          |  78 +++++++++---------
 arch/arm64/include/asm/hw_breakpoint.h   |   7 +-
 arch/arm64/kernel/hw_breakpoint.c        |  86 ++++++++++----------
 arch/powerpc/include/asm/hw_breakpoint.h |   7 +-
 arch/powerpc/kernel/hw_breakpoint.c      |  47 ++++++-----
 arch/sh/include/asm/hw_breakpoint.h      |   8 +-
 arch/sh/kernel/hw_breakpoint.c           |  53 ++++++-------
 arch/x86/include/asm/hw_breakpoint.h     |   7 +-
 arch/x86/kernel/hw_breakpoint.c          | 131 ++++++++++++++++---------------
 arch/xtensa/include/asm/hw_breakpoint.h  |   7 +-
 arch/xtensa/kernel/hw_breakpoint.c       |  40 ++++------
 kernel/events/hw_breakpoint.c            |  92 +++++++++++++---------
 13 files changed, 294 insertions(+), 276 deletions(-)
