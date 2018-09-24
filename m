Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2072ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821F621486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821F621486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbeIXRm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:42:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50956 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbeIXRmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:42:55 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EB12B1073;
        Mon, 24 Sep 2018 11:41:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Stafford Horne <shorne@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org, Jamie Iles <jamie.iles@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 3.18 036/105] kthread: fix boot hang (regression) on MIPS/OpenRISC
Date:   Mon, 24 Sep 2018 13:33:22 +0200
Message-Id: <20180924113117.566426729@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113113.268650190@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vegard Nossum <vegard.nossum@oracle.com>

commit b0f5a8f32e8bbdaae1abb8abe2d3cbafaba57e08 upstream.

This fixes a regression in commit 4d6501dce079 where I didn't notice
that MIPS and OpenRISC were reinitialising p->{set,clear}_child_tid to
NULL after our initialisation in copy_process().

We can simply get rid of the arch-specific initialisation here since it
is now always done in copy_process() before hitting copy_thread{,_tls}().

Review notes:

 - As far as I can tell, copy_process() is the only user of
   copy_thread_tls(), which is the only caller of copy_thread() for
   architectures that don't implement copy_thread_tls().

 - After this patch, there is no arch-specific code touching
   p->set_child_tid or p->clear_child_tid whatsoever.

 - It may look like MIPS/OpenRISC wanted to always have these fields be
   NULL, but that's not true, as copy_process() would unconditionally
   set them again _after_ calling copy_thread_tls() before commit
   4d6501dce079.

Fixes: 4d6501dce079c1eb6bf0b1d8f528a5e81770109e ("kthread: Fix use-after-free if kthread fork fails")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net> # MIPS only
Acked-by: Stafford Horne <shorne@gmail.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: openrisc@lists.librecores.org
Cc: Jamie Iles <jamie.iles@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/process.c     |    1 -
 arch/openrisc/kernel/process.c |    2 --
 2 files changed, 3 deletions(-)

--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -87,7 +87,6 @@ int copy_thread(unsigned long clone_flag
 	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs, *regs = current_pt_regs();
 	unsigned long childksp;
-	p->set_child_tid = p->clear_child_tid = NULL;
 
 	childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE - 32;
 
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -152,8 +152,6 @@ copy_thread(unsigned long clone_flags, u
 
 	top_of_kernel_stack = sp;
 
-	p->set_child_tid = p->clear_child_tid = NULL;
-
 	/* Locate userspace context on stack... */
 	sp -= STACK_FRAME_OVERHEAD;	/* redzone */
 	sp -= sizeof(struct pt_regs);


