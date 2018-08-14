Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240C8C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD94C216E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD94C216E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbeHNUWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:22:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56300 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbeHNUWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:22:20 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CA174E25;
        Tue, 14 Aug 2018 17:33:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Mian Yousaf Kaukab <yousaf.kaukab@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, stable@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 012/104] init: rename and re-order boot_cpu_state_init()
Date:   Tue, 14 Aug 2018 19:16:26 +0200
Message-Id: <20180814171516.019355637@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171515.270692185@linuxfoundation.org>
References: <20180814171515.270692185@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit b5b1404d0815894de0690de8a1ab58269e56eae6 upstream.

This is purely a preparatory patch for upcoming changes during the 4.19
merge window.

We have a function called "boot_cpu_state_init()" that isn't really
about the bootup cpu state: that is done much earlier by the similarly
named "boot_cpu_init()" (note lack of "state" in name).

This function initializes some hotplug CPU state, and needs to run after
the percpu data has been properly initialized.  It even has a comment to
that effect.

Except it _doesn't_ actually run after the percpu data has been properly
initialized.  On x86 it happens to do that, but on at least arm and
arm64, the percpu base pointers are initialized by the arch-specific
'smp_prepare_boot_cpu()' hook, which ran _after_ boot_cpu_state_init().

This had some unexpected results, and in particular we have a patch
pending for the merge window that did the obvious cleanup of using
'this_cpu_write()' in the cpu hotplug init code:

  -       per_cpu_ptr(&cpuhp_state, smp_processor_id())->state = CPUHP_ONLINE;
  +       this_cpu_write(cpuhp_state.state, CPUHP_ONLINE);

which is obviously the right thing to do.  Except because of the
ordering issue, it actually failed miserably and unexpectedly on arm64.

So this just fixes the ordering, and changes the name of the function to
be 'boot_cpu_hotplug_init()' to make it obvious that it's about cpu
hotplug state, because the core CPU state was supposed to have already
been done earlier.

Marked for stable, since the (not yet merged) patch that will show this
problem is marked for stable.

Reported-by: Vlastimil Babka <vbabka@suse.cz>
Reported-by: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: stable@kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/cpu.h |    2 +-
 init/main.c         |    2 +-
 kernel/cpu.c        |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -30,7 +30,7 @@ struct cpu {
 };
 
 extern void boot_cpu_init(void);
-extern void boot_cpu_state_init(void);
+extern void boot_cpu_hotplug_init(void);
 extern void cpu_init(void);
 extern void trap_init(void);
 
--- a/init/main.c
+++ b/init/main.c
@@ -543,8 +543,8 @@ asmlinkage __visible void __init start_k
 	setup_command_line(command_line);
 	setup_nr_cpu_ids();
 	setup_per_cpu_areas();
-	boot_cpu_state_init();
 	smp_prepare_boot_cpu();	/* arch-specific boot-cpu hooks */
+	boot_cpu_hotplug_init();
 
 	build_all_zonelists(NULL);
 	page_alloc_init();
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2022,7 +2022,7 @@ void __init boot_cpu_init(void)
 /*
  * Must be called _AFTER_ setting up the per_cpu areas
  */
-void __init boot_cpu_state_init(void)
+void __init boot_cpu_hotplug_init(void)
 {
 	per_cpu_ptr(&cpuhp_state, smp_processor_id())->state = CPUHP_ONLINE;
 }


