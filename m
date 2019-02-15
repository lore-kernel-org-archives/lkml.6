Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD17C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA39821A4C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbfBORtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:49:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:39206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728758AbfBORtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:49:46 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CD0C21927;
        Fri, 15 Feb 2019 17:49:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92-RC5)
        (envelope-from <rostedt@goodmis.org>)
        id 1guhcP-0008GI-G2; Fri, 15 Feb 2019 12:49:45 -0500
Message-Id: <20190215174712.372898450@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 15 Feb 2019 12:47:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2 v2] [GIT PULL (take two)] tracing: Two more fixes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Two more tracing fixes

 - Have kprobes not use copy_from_user() to access kernel addresses,
   because kprobes can legitimately poke at bad kernel memory, which
   will fault. Copy from user code should never fault in kernel space.
   Using probe_mem_read() can handle kernel address space faulting.

 - Put back the entries counter in the tracing output that was accidentally
   removed.

Please pull the latest trace-v5.0-rc4-3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.0-rc4-3

Tag SHA1: 633d24cef06bed019a34e84ff82c20782449ee5c
Head SHA1: 9e7382153f80ba45a0bbcd540fb77d4b15f6e966


Changbin Du (1):
      kprobe: Do not use uaccess functions to access kernel memory that can fault

Quentin Perret (1):
      tracing: Fix number of entries in trace header

----
 kernel/trace/trace.c        |  2 ++
 kernel/trace/trace_kprobe.c | 10 +---------
 2 files changed, 3 insertions(+), 9 deletions(-)

Changes from v1:

  - Explain that the kprobe change to probe_mem_read() is because
    copy_from_user() can not handle bad memory in kernel space,
    which kprobes can cause. The code itself is unchanged.
    I tweaked the change log of that patch to clarify that as well.
