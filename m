Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB05BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 03:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8219120830
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 03:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="eSsOFQXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfBEC77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 21:59:59 -0500
Received: from mx.aristanetworks.com ([162.210.129.12]:46907 "EHLO
        prod-mx.aristanetworks.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726606AbfBEC76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 21:59:58 -0500
X-Greylist: delayed 409 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Feb 2019 21:59:58 EST
Received: from prod-mx.aristanetworks.com (localhost [127.0.0.1])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id 00ECEDF0;
        Mon,  4 Feb 2019 18:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1549335189;
        bh=KQTcnQuNEamwrMHfFUCPU7vfCyC1nyGvf7NNrOYsq6s=;
        h=Date:From:To:Cc:Subject;
        b=eSsOFQXXFb5XzjNkN4dOHh/WBzUT0p5wwyhirABa0lMKLNaTOnTFAZY8C6LFAjHWb
         3gctI0/olXPyPvDA7WHROEOAAM46L8eAJnVBDxdfTXWvVGZ6UxZ5ocqHb7Ki43ShtO
         fZRQuG/hiElEXUHM2EncL5es9Q4OtzX5YRUorE7Ug+s6C/Hl4AR4WRZ29THvnRNDJT
         qHVwASgWVoKxXkkTourkAEx90TAszhFDMSRiiqOnGFT8dO4+U1KY0dE/GTm3XkFuOs
         cBV9h2E1gEF4q+I+yyFBXM/KQGHQ1QJFWT77aed6CxuydduqQj6Pw5KVpc08J2CyDZ
         0ZMJBstpIw+pA==
Received: from visor (unknown [172.20.208.17])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id E7D80DA9;
        Mon,  4 Feb 2019 18:53:08 -0800 (PST)
Date:   Mon, 4 Feb 2019 18:53:08 -0800
From:   Ivan Delalande <colona@arista.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2] exec: don't force_sigsegv processes with a pending fatal
 signal
Message-ID: <20190205025308.GA24455@visor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We were seeing unexplained segfaults in coreutils processes and other
basic utilities on systems with print-fatal-signals enabled:

	[  311.001986] potentially unexpected fatal signal 11.
	[  311.001993] CPU: 3 PID: 4565 Comm: tail Tainted: P           O    4.9.100.Ar-8497547.eostrunkkernel49 #1
	[  311.001995] task: ffff88021431b400 task.stack: ffffc90004cec000
	[  311.001997] RIP: 0023:[<00000000f7722c09>]  [<00000000f7722c09>] 0xf7722c09
	[  311.002003] RSP: 002b:00000000ffcc8aa4  EFLAGS: 00000296
	[  311.002004] RAX: fffffffffffffff2 RBX: 0000000057efc530 RCX: 0000000057efdb68
	[  311.002006] RDX: 0000000057effb60 RSI: 0000000057efdb68 RDI: 00000000f768f000
	[  311.002007] RBP: 0000000057efc530 R08: 0000000000000000 R09: 0000000000000000
	[  311.002008] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
	[  311.002009] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
	[  311.002011] FS:  0000000000000000(0000) GS:ffff88021e980000(0000) knlGS:0000000000000000
	[  311.002013] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
	[  311.002014] CR2: 00000000f77bf097 CR3: 0000000150f6f000 CR4: 00000000000406f0

We tracked these crashes down to binfmt_elf failing to load segments
for ld.so inside the kernel. Digging further, the actual problem
seems to occur when a process gets sigkilled while it is still being
loaded by the kernel. In our case when _do_page_fault goes for a retry
it will return early as it first checks for fatal_signal_pending(), so
load_elf_interp also returns with error and as a result
search_binary_handler will force_sigsegv() which is pretty confusing as
nothing actually failed here.


v2: add a message when load_binary fails, add a check for fatal signals
in signal_delivered (avoiding a single check in force_sigsegv as other
architectures use it directly and may have different expectations).

Thanks to Dmitry Safonov and Oleg Nesterov for their comments and
suggestions.

Fixes: 19d860a140be ("handle suicide on late failure exits in execve() in search_binary_handler()")
Reference: https://lkml.org/lkml/2013/2/14/5
Signed-off-by: Ivan Delalande <colona@arista.com>
---
 fs/exec.c       | 7 ++++++-
 kernel/signal.c | 6 +++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index fb72d36f7823..caf584064f89 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1660,7 +1660,12 @@ int search_binary_handler(struct linux_binprm *bprm)
 		if (retval < 0 && !bprm->mm) {
 			/* we got to flush_old_exec() and failed after it */
 			read_unlock(&binfmt_lock);
-			force_sigsegv(SIGSEGV, current);
+			if (!fatal_signal_pending(current)) {
+				if (print_fatal_signals)
+					pr_info("load_binary() failed: %d\n",
+						retval);
+				force_sigsegv(SIGSEGV, current);
+			}
 			return retval;
 		}
 		if (retval != -ENOEXEC || !bprm->file) {
diff --git a/kernel/signal.c b/kernel/signal.c
index e1d7ad8e6ab1..674076e63624 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2552,10 +2552,10 @@ static void signal_delivered(struct ksignal *ksig, int stepping)
 
 void signal_setup_done(int failed, struct ksignal *ksig, int stepping)
 {
-	if (failed)
-		force_sigsegv(ksig->sig, current);
-	else
+	if (!failed)
 		signal_delivered(ksig, stepping);
+	else if (!fatal_signal_pending(current))
+		force_sigsegv(ksig->sig, current);
 }
 
 /*
-- 
2.20.1
