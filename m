Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E6CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E5E21783
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546270451;
	bh=4KcgVECzclSHL8ukJ3OsyVhmAvx/j0Qh7Y598f0Bsrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XDNuhSZvdkOF5R1Fy72RReFqkAOrxFreobulRKG5N7JygM+vTQFKwzFkePdjeTklD
	 07wal7m0nZOJ40jZbfP0WJAi5nuDXLcp05lBf5lVj5Omw1AGx86zZebcedUGNd0Vg4
	 3E+SSX6Bp7n1ODpCoQ09vDkhu4SwJUqPKVqrKCKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbeLaPeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 10:34:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:59764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbeLaPeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 10:34:10 -0500
Received: from localhost.localdomain (unknown [183.128.55.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03ED62133F;
        Mon, 31 Dec 2018 15:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546270449;
        bh=4KcgVECzclSHL8ukJ3OsyVhmAvx/j0Qh7Y598f0Bsrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PVrxiNz99WTyvc++Bm2qD1NUhSD1MC8wzNDzYkBt5+lyuTNj4ut8oMsCsSUUdL6ai
         d4XqaS4xiaK7p4hVIWpgKphD+jyRF3t7S4gydsWpan/UWVq7PkenlI8wSD41B/Zmp5
         qYwdml+YbZtbf8mTlaW85NkR9cQRPay9zbLb9WIg=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     guoren@kernel.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, oleg@redhat.com,
        linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 04/14] csky: remove syscall_exit_work
Date:   Mon, 31 Dec 2018 23:32:56 +0800
Message-Id: <1546270384-4590-4-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546270384-4590-1-git-send-email-guoren@kernel.org>
References: <1546270384-4590-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Remove syscall_exit_work and union all to ret_from_exception.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/kernel/entry.S | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index 79f92b8..2b4a851 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -183,18 +183,10 @@ ENTRY(csky_systemcall)
 #endif
 	stw	a0, (sp, LSAVE_A0)	/* Save return value */
 
-	movi	a0, 1			/* leave system call */
-	mov	a1, sp			/* sp = pt_regs pointer */
-	jbsr	syscall_trace
-
-syscall_exit_work:
-	ld	syscallid, (sp, LSAVE_PSR)
-	btsti	syscallid, 31
-	bt	2f
-
-	jmpi	resume_userspace
-
-2:      RESTORE_ALL
+	movi    a0, 1                   /* leave system call */
+	mov     a1, sp                  /* right now, sp --> pt_regs */
+	jbsr    syscall_trace
+	br	ret_from_exception
 
 ENTRY(ret_from_kernel_thread)
 	jbsr	schedule_tail
-- 
2.7.4

