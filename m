Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC5DC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A477721477
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQLmn1O1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A477721477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbeJKXQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:16:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731315AbeJKXQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:16:39 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DA0821477;
        Thu, 11 Oct 2018 15:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272933;
        bh=gfylHL+OWUxtrqYxAAzslezrxUMPwvDOC0FfMEEqMSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PQLmn1O1Xurfka3YLhnhsmXdgeJ1n2lIoYiSFxXzpmyhJgh9/TmGMhW/drN/e205M
         x7fuu0VIuSoQeLwAWZTdvv7nBv0/HEZg9G/n5PADuE+JnkAupsF/Ms9uziqPWZIrmd
         HiI3954EJmAkiqhph/R7M5DgRb6gdrHslpQ9WrEE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikita Sobolev <sobolev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 4.18 38/44] ARC: clone syscall to setp r25 as thread pointer
Date:   Thu, 11 Oct 2018 17:40:16 +0200
Message-Id: <20181011152454.129494587@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152452.571669983@linuxfoundation.org>
References: <20181011152452.571669983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -241,6 +241,26 @@ int copy_thread(unsigned long clone_flag
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
 


