Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D79C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0F12088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A0F12088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbeGZL5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:57:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:44790 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729177AbeGZL5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:57:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E2C8FAD73;
        Thu, 26 Jul 2018 10:40:53 +0000 (UTC)
From:   Nicolai Stange <nstange@suse.de>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Nicolai Stange <nstange@suse.de>,
        live-patching@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/1] x86/ftrace: fix live patching vs. tracing race
Date:   Thu, 26 Jul 2018 12:40:28 +0200
Message-Id: <20180726104029.7736-1-nstange@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

if a user starts to trace a live patched function, its mcount call will get
redirected from a trampoline to ftrace_regs_caller.

In preparation for that, ftrace on x86 first installs an int3 insn at that
call site.

ftrace_int3_handler() in turn simply skips over the mcount call insn,
effectively reverting the livepatch for that function during
ftrace_replace_code().

This breaks KLP's consistency model.


There are two possible options for fixing this:
1.) At the ftrace level.
2.) Search for a matching klp_ops from ftrace_int3_handler() and
    handle the redirection if needed.

Both have their drawbacks, hence the RFC mode for this patch implementing
1.).

The main disadvantage is that it doesn't work on 32 bits (c.f. the patch
description), but for KLP this would be fine.

OTOH, it keeps KLP specific code out of ftrace_int3_handler() and might
perhaps be beneficial in other contexts as well.

Thanks for your comments!

Nicolai

Nicolai Stange (1):
  x86/ftrace: make ftrace_int3_handler() not to skip fops invocation

 arch/x86/kernel/ftrace.c    | 48 ++++++++++++++++++++++++++++++++------
 arch/x86/kernel/ftrace_64.S | 56 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+), 7 deletions(-)

-- 
2.13.7

