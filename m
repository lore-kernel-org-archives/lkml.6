Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6E3C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93370217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfAVP6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:58:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729259AbfAVP5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:57:40 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B39F4D964D;
        Tue, 22 Jan 2019 15:57:40 +0000 (UTC)
Received: from jlaw-desktop.bos.redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC3DC1048109;
        Tue, 22 Jan 2019 15:57:39 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        live-patching@vger.kernel.org
Cc:     Balbir Singh <bsingharora@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicolai Stange <nstange@suse.de>, Torsten Duwe <duwe@lst.de>
Subject: [PATCH 4/4] powerpc/livepatch: return -ERRNO values in save_stack_trace_tsk_reliable()
Date:   Tue, 22 Jan 2019 10:57:24 -0500
Message-Id: <20190122155724.27557-5-joe.lawrence@redhat.com>
In-Reply-To: <20190122155724.27557-1-joe.lawrence@redhat.com>
References: <20190122155724.27557-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 22 Jan 2019 15:57:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To match its x86 counterpart, save_stack_trace_tsk_reliable() should
return -EINVAL in cases that it is currently returning 1.  No caller is
currently differentiating non-zero error codes, but let's keep the
arch-specific implementations consistent.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 arch/powerpc/kernel/stacktrace.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index 28c3c25755d7..cf31ce6c1f53 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -133,7 +133,7 @@ save_stack_trace_tsk_reliable(struct task_struct *tsk,
 
 	if (sp < stack_page + sizeof(struct thread_struct) ||
 	    sp > stack_end - STACK_FRAME_MIN_SIZE) {
-		return 1;
+		return -EINVAL;
 	}
 
 	for (firstframe = true; sp != stack_end;
@@ -143,16 +143,16 @@ save_stack_trace_tsk_reliable(struct task_struct *tsk,
 
 		/* sanity check: ABI requires SP to be aligned 16 bytes. */
 		if (sp & 0xF)
-			return 1;
+			return -EINVAL;
 
 		newsp = stack[0];
 		/* Stack grows downwards; unwinder may only go up. */
 		if (newsp <= sp)
-			return 1;
+			return -EINVAL;
 
 		if (newsp != stack_end &&
 		    newsp > stack_end - STACK_FRAME_MIN_SIZE) {
-			return 1; /* invalid backlink, too far up. */
+			return -EINVAL; /* invalid backlink, too far up. */
 		}
 
 		/*
@@ -166,13 +166,13 @@ save_stack_trace_tsk_reliable(struct task_struct *tsk,
 		/* Mark stacktraces with exception frames as unreliable. */
 		if (sp <= stack_end - STACK_INT_FRAME_SIZE &&
 		    stack[STACK_FRAME_MARKER] == STACK_FRAME_REGS_MARKER) {
-			return 1;
+			return -EINVAL;
 		}
 
 		/* Examine the saved LR: it must point into kernel code. */
 		ip = stack[STACK_FRAME_LR_SAVE];
 		if (!__kernel_text_address(ip))
-			return 1;
+			return -EINVAL;
 
 		/*
 		 * FIXME: IMHO these tests do not belong in
@@ -185,7 +185,7 @@ save_stack_trace_tsk_reliable(struct task_struct *tsk,
 		 * as unreliable.
 		 */
 		if (ip == (unsigned long)kretprobe_trampoline)
-			return 1;
+			return -EINVAL;
 #endif
 
 		if (trace->nr_entries >= trace->max_entries)
-- 
2.20.1

