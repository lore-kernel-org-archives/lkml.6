Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F278C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4549420846
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7gW/a5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4549420846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeIACb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:31:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbeIACb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:31:26 -0400
Received: from localhost (c-71-202-137-17.hsd1.ca.comcast.net [71.202.137.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C36F2083F;
        Fri, 31 Aug 2018 22:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535754114;
        bh=/33ohNnP2Tie7wG5eD8wrzCSjkSAtcWRGqhcbVWsn8o=;
        h=From:To:Cc:Subject:Date:From;
        b=Y7gW/a5e4aT+27SSs34vtrilWaUv4heWODdynUVJX6r6S0GGO4A6yO71gIsbHTf7j
         8LMurTh0h+6C0z/RTBzCmMGLOr4S27+QhfQfo9O4uHX+QhMKuxKBLI3AHFn6xNpDhe
         uYsY9x2ej+biWEVLh+2ENsPBZ2GEd2Ro6nQ7dld4=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 0/3] x86/pti: Get rid of entry trampolines and add some docs
Date:   Fri, 31 Aug 2018 15:21:46 -0700
Message-Id: <cover.1535753890.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This gets rid of entry trampolines.  It's more or less the same as
the RFC version, except that I rebased it to v4.19-rc1 due to
massive conflicts with some perf changes.  I have *not* reverted all
of the perf support for entry trampolines -- I leave that to the
perf crew, if needed.

Andy Lutomirski (3):
  x86/entry/64: Document idtentry
  x86/entry/64: Use the TSS sp2 slot for rsp_scratch
  x86/pti/64: Remove the SYSCALL64 entry trampoline

 arch/x86/entry/entry_64.S             | 101 +++++++++-----------------
 arch/x86/include/asm/cpu_entry_area.h |   2 -
 arch/x86/include/asm/processor.h      |   6 ++
 arch/x86/include/asm/sections.h       |   1 -
 arch/x86/include/asm/thread_info.h    |   1 +
 arch/x86/kernel/asm-offsets.c         |   5 +-
 arch/x86/kernel/cpu/common.c          |  11 +--
 arch/x86/kernel/kprobes/core.c        |  10 +--
 arch/x86/kernel/process_64.c          |   2 -
 arch/x86/kernel/traps.c               |   4 +
 arch/x86/kernel/vmlinux.lds.S         |  10 ---
 arch/x86/mm/cpu_entry_area.c          |  36 ---------
 arch/x86/mm/pti.c                     |  33 ++++++++-
 13 files changed, 83 insertions(+), 139 deletions(-)

-- 
2.17.1

