Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C85C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23BFB2084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbfBCOUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:20:43 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55498 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730053AbfBCOUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:40 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdS-0006LA-SK; Sun, 03 Feb 2019 14:20:38 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9m-0007J8-Mi; Sun, 03 Feb 2019 14:49:58 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Max Filippov" <jcmvbkbc@gmail.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.291811583@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 237/305] xtensa: enable coprocessors that are being
 flushed
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Max Filippov <jcmvbkbc@gmail.com>

commit 2958b66694e018c552be0b60521fec27e8d12988 upstream.

coprocessor_flush_all may be called from a context of a thread that is
different from the thread being flushed. In that case contents of the
cpenable special register may not match ti->cpenable of the target
thread, resulting in unhandled coprocessor exception in the kernel
context.
Set cpenable special register to the ti->cpenable of the target register
for the duration of the flush and restore it afterwards.
This fixes the following crash caused by coprocessor register inspection
in native gdb:

  (gdb) p/x $w0
  Illegal instruction in kernel: sig: 9 [#1] PREEMPT
  Call Trace:
    ___might_sleep+0x184/0x1a4
    __might_sleep+0x41/0xac
    exit_signals+0x14/0x218
    do_exit+0xc9/0x8b8
    die+0x99/0xa0
    do_illegal_instruction+0x18/0x6c
    common_exception+0x77/0x77
    coprocessor_flush+0x16/0x3c
    arch_ptrace+0x46c/0x674
    sys_ptrace+0x2ce/0x3b4
    system_call+0x54/0x80
    common_exception+0x77/0x77
  note: gdb[100] exited with preempt_count 1
  Killed

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/xtensa/kernel/process.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -83,18 +83,21 @@ void coprocessor_release_all(struct thre
 
 void coprocessor_flush_all(struct thread_info *ti)
 {
-	unsigned long cpenable;
+	unsigned long cpenable, old_cpenable;
 	int i;
 
 	preempt_disable();
 
+	RSR_CPENABLE(old_cpenable);
 	cpenable = ti->cpenable;
+	WSR_CPENABLE(cpenable);
 
 	for (i = 0; i < XCHAL_CP_MAX; i++) {
 		if ((cpenable & 1) != 0 && coprocessor_owner[i] == ti)
 			coprocessor_flush(ti, i);
 		cpenable >>= 1;
 	}
+	WSR_CPENABLE(old_cpenable);
 
 	preempt_enable();
 }

