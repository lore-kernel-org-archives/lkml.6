Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D60C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5952098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoKjGDcB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5952098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbeJKXJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:09:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:09:40 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1652720652;
        Thu, 11 Oct 2018 15:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272516;
        bh=NKNTzb/iWI4WwqEnrxaRMFVqtnHadjJRY9HR1aCydGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OoKjGDcBkjZe7JvyyEsqMbgZ1VUL50Uy8ggnDioO5IWJW5NxUNC0MvWcl4YTjokCj
         DlESZ5kZZ2+U9hBjbqdetCmKZcCFDqVHnRzN/SmyZ3lp5Lsq/Lp95iZu8NwLobtdZ1
         /QDHmDQE4qZnI2iLs1PfaYfdae59nwsgrwdPGu7w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikita Sobolev <sobolev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 4.4 17/27] ARC: clone syscall to setp r25 as thread pointer
Date:   Thu, 11 Oct 2018 17:35:04 +0200
Message-Id: <20181011152534.854496311@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152534.014964888@linuxfoundation.org>
References: <20181011152534.014964888@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Reported-by: Nikita Sobolev <sobolev@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arc/kernel/process.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -153,6 +153,26 @@ int copy_thread(unsigned long clone_flag
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
 


