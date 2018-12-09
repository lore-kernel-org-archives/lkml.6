Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E31C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A5E20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A5E20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbeLIWDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:03:45 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35624 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726591AbeLIVz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:28 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72r-0002iZ-7v; Sun, 09 Dec 2018 21:55:25 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72k-0003ed-LF; Sun, 09 Dec 2018 21:55:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Nikita Sobolev" <sobolev@synopsys.com>,
        "Vineet Gupta" <vgupta@synopsys.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.303646149@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 296/328] ARC: clone syscall to setp r25 as thread pointer
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Vineet Gupta <vgupta@synopsys.com>

commit c58a584f05e35d1d4342923cd7aac07d9c3d3d16 upstream.

Per ARC TLS ABI, r25 is designated TP (thread pointer register).
However so far kernel didn't do any special treatment, like setting up
usermode r25, even for CLONE_SETTLS. We instead relied on libc runtime
to do this, in say clone libc wrapper [1]. This was deliberate to keep
kernel ABI agnostic (userspace could potentially change TP, specially
for different ARC ISA say ARCompact vs. ARCv2 with different spare
registers etc)

However userspace setting up r25, after clone syscall opens a race, if
child is not scheduled and gets a signal instead. It starts off in
userspace not in clone but in a signal handler and anything TP sepcific
there such as pthread_self() fails which showed up with uClibc
testsuite nptl/tst-kill6 [2]

Fix this by having kernel populate r25 to TP value. So this locks in
ABI, but it was not going to change anyways, and fwiw is same for both
ARCompact (arc700 core) and ARCvs (HS3x cores)

[1] https://cgit.uclibc-ng.org/cgi/cgit/uclibc-ng.git/tree/libc/sysdeps/linux/arc/clone.S
[2] https://github.com/wbx-github/uclibc-ng-test/blob/master/test/nptl/tst-kill6.c

Fixes: ARC STAR 9001378481
Reported-by: Nikita Sobolev <sobolev@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arc/kernel/process.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -147,6 +147,26 @@ int copy_thread(unsigned long clone_flag
 		task_thread_info(current)->thr_ptr;
 	}
 
+
+	/*
+	 * setup usermode thread pointer #1:
+	 * when child is picked by scheduler, __switch_to() uses @c_callee to
+	 * populate usermode callee regs: this works (despite being in a kernel
+	 * function) since special return path for child @ret_from_fork()
+	 * ensures those regs are not clobbered all the way to RTIE to usermode
+	 */
+	c_callee->r25 = task_thread_info(p)->thr_ptr;
+
+#ifdef CONFIG_ARC_CURR_IN_REG
+	/*
+	 * setup usermode thread pointer #2:
+	 * however for this special use of r25 in kernel, __switch_to() sets
+	 * r25 for kernel needs and only in the final return path is usermode
+	 * r25 setup, from pt_regs->user_r25. So set that up as well
+	 */
+	c_regs->user_r25 = c_callee->r25;
+#endif
+
 	return 0;
 }
 

