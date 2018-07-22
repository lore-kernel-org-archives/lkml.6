Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1962C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 17:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7C520854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 17:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmGTz6Ix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7C520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbeGVSnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 14:43:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729890AbeGVSnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 14:43:01 -0400
Received: from localhost (c-71-202-137-17.hsd1.ca.comcast.net [71.202.137.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A26720854;
        Sun, 22 Jul 2018 17:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532281535;
        bh=bd9EEdys5rQAjVLXugcrnTezGdh8ABa5hs8bMUe7Dmo=;
        h=From:To:Cc:Subject:Date:From;
        b=nmGTz6IxZk0SZMZCFYUFD1UcRQvxkuplMe6OZ6Vq9qsTlixIjSGttuovRI7BEEjSz
         p5zOomYtmgerCl/A41sx7mtZsKJY03u5YspPHjEHeUO2aKERJS9j6BpooCfAjZ/o39
         K8WF/gCfEMyDlxH0fSztZHlEXrKNvlDJd/lNZPA0=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [RFC 0/2] Get rid of the entry trampoline
Date:   Sun, 22 Jul 2018 10:45:25 -0700
Message-Id: <cover.1532281180.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all-

I think there's general agreement that the current entry trampoline
sucks, mainly because it's dog-slow.  Thanks, Spectre.

There are three possible fixes I know of:

a) Linus' hack: use R11 for scratch space.  This doesn't actually
   speed it up, but it improves the addressing situation a bit.
   I don't like it, though: it causes the SYSCALL64 path to forget
   the arithmetic flags and all of the MSR_SYCALL_MASK flags.  The
   latter may be a showstopper, given that we've seen some evidence
   of nasty Wine use cases that expect setting EFLAGS.NT and doing
   a system call to actually do something intelligent.  Similarly,
   there could easily be user programs out there that set AC because
   they want alignment checking and expect AC to remain set across
   system calls.

b) Move the trampoline within 2G of the entry text and copy it for
   each CPU.  This is certainly possible, but it's a bit gross,
   and it uses num_possible_cpus() * 64 bytes of memory (rounded
   up to a page).  It will also result in more complicated code.

c) This series.  Just make %gs work in the entry trampoline.  It's
   actually a net code deletion.

I suspect that (b) would be faster in code that does a lot of system
calls and doesn't totally blow away the cache or the TLB between
system calls.  I suspect that (c) is faster in code that does
cache-cold system calls.

Andy Lutomirski (2):
  x86/entry/64: Use the TSS sp2 slot for rsp_scratch
  x86/pti/64: Remove the SYSCALL64 entry trampoline

 arch/x86/entry/entry_64.S          | 66 +-----------------------------
 arch/x86/include/asm/processor.h   |  5 +++
 arch/x86/include/asm/thread_info.h |  1 +
 arch/x86/kernel/asm-offsets_64.c   |  1 +
 arch/x86/kernel/cpu/common.c       | 11 +----
 arch/x86/kernel/kprobes/core.c     | 10 +----
 arch/x86/kernel/process_64.c       |  2 -
 arch/x86/kernel/vmlinux.lds.S      | 10 -----
 arch/x86/mm/cpu_entry_area.c       |  5 ---
 arch/x86/mm/pti.c                  | 24 ++++++++++-
 10 files changed, 33 insertions(+), 102 deletions(-)

-- 
2.17.1

