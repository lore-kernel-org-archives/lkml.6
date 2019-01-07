Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610B3C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322B121736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546867321;
	bh=h9LTy0tGgWEZWgtB4DOuI6eYEdJ1ZNH6Bb66WJUVFEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mF+rCIV9eJewwcEeBUId+jkFqie6eLsV+/Lzg+WzvhKDO6jCEp8Bs/aeVGHGMsw7Z
	 ADBfhDm95x9FQc7suJToPfLThcinBkll704Movhm4aN83tCktC3cYiSl8ShfIgtUkK
	 F54jwz8hcQRYCmoj7vSHzjSw5/u7rQg5G9vPVPqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbfAGMon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:44:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:33370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727832AbfAGMok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:44:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40BC92183E;
        Mon,  7 Jan 2019 12:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865079;
        bh=h9LTy0tGgWEZWgtB4DOuI6eYEdJ1ZNH6Bb66WJUVFEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J1kZRPrq1MURS60eea99tiZEcenYko4wzzM0zDPnHPyAm+uO40DAu2JrULxSGFj6N
         ewIu6DCt1v2rvWYUsl8tDA40uvQuwP/R/6Nw/qP8igqC3tuvnllJW154yNAwkgrN5W
         v8Ce/nwz9WlQ7Helq4sZVSv44MhHALvLiR4zYOpQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.20 141/145] arm64: compat: Avoid sending SIGILL for unallocated syscall numbers
Date:   Mon,  7 Jan 2019 13:32:58 +0100
Message-Id: <20190107104455.596144836@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit 169113ece0f29ebe884a6cfcf57c1ace04d8a36a upstream.

The ARM Linux kernel handles the EABI syscall numbers as follows:

  0           - NR_SYSCALLS-1	: Invoke syscall via syscall table
  NR_SYSCALLS - 0xeffff		: -ENOSYS (to be allocated in future)
  0xf0000     - 0xf07ff		: Private syscall or -ENOSYS if not allocated
  > 0xf07ff			: SIGILL

Our compat code gets this wrong and ends up sending SIGILL in response
to all syscalls greater than NR_SYSCALLS which have a value greater
than 0x7ff in the bottom 16 bits.

Fix this by defining the end of the ARM private syscall region and
checking the syscall number against that directly. Update the comment
while we're at it.

Cc: <stable@vger.kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>
Reported-by: Pi-Hsun Shih <pihsun@chromium.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/unistd.h |    5 +++--
 arch/arm64/kernel/sys_compat.c  |    4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -40,8 +40,9 @@
  * The following SVCs are ARM private.
  */
 #define __ARM_NR_COMPAT_BASE		0x0f0000
-#define __ARM_NR_compat_cacheflush	(__ARM_NR_COMPAT_BASE+2)
-#define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE+5)
+#define __ARM_NR_compat_cacheflush	(__ARM_NR_COMPAT_BASE + 2)
+#define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
+#define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
 #define __NR_compat_syscalls		399
 #endif
--- a/arch/arm64/kernel/sys_compat.c
+++ b/arch/arm64/kernel/sys_compat.c
@@ -102,12 +102,12 @@ long compat_arm_syscall(struct pt_regs *
 
 	default:
 		/*
-		 * Calls 9f00xx..9f07ff are defined to return -ENOSYS
+		 * Calls 0xf0xxx..0xf07ff are defined to return -ENOSYS
 		 * if not implemented, rather than raising SIGILL. This
 		 * way the calling program can gracefully determine whether
 		 * a feature is supported.
 		 */
-		if ((no & 0xffff) <= 0x7ff)
+		if (no < __ARM_NR_COMPAT_END)
 			return -ENOSYS;
 		break;
 	}


