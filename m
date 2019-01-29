Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BADC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F25720882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548761915;
	bh=GqG+SLxeOD9lNNgk5NQn+0Ns9z9+XR9nMc+aOv1p16M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LbmgINJGMAk2VPVLmFyBq/8xCmBBAgoJ3V/ooKcFfywKC6bRrvAmf1b6i1o97BWPm
	 jGEhnpOWfB5NujKryhPO06gRZRSmtdcXJeervN6/vV9FEwTeRpTsA50Vjk/FKYb2YV
	 mywz0GiWcU1cmbpgHbQyKOInYQDBVgns4dPYmb08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfA2Lid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:38:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:55182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729180AbfA2Lib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:38:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B39920844;
        Tue, 29 Jan 2019 11:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761911;
        bh=GqG+SLxeOD9lNNgk5NQn+0Ns9z9+XR9nMc+aOv1p16M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TL5322kWDWIJ1Avb4iaC5m07hV5Mfku08meL45hyDc4ANh7AJQjkvDlHaeVb4KtNn
         +gYC7BvxLv91EO9rABoXo8UB6xAaY2JP9jpiWew5UQ+fKRphYI8O8VLdovn0BlBltJ
         FAlHI48AqQIml1ndgkqK9g2ZY03UN0S+1V/J69dM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Liebler <stli@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.20 044/117] s390/vdso: correct vdso mapping for compat tasks
Date:   Tue, 29 Jan 2019 12:34:55 +0100
Message-Id: <20190129113209.796939375@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

From: Vasily Gorbik <gor@linux.ibm.com>

commit 190f056fba230abee80712eb810939ef9a8c462f upstream.

While "s390/vdso: avoid 64-bit vdso mapping for compat tasks" fixed
64-bit vdso mapping for compat tasks under gdb it introduced another
problem. "compat_mm" flag is not inherited during fork and when
31-bit process forks a child (but does not perform exec) it ends up
with 64-bit vdso. To address that, init_new_context (which is called
during fork and exec) now initialize compat_mm based on thread TIF_31BIT
flag. Later compat_mm is adjusted in arch_setup_additional_pages, which
is called during exec.

Fixes: d1befa65823e ("s390/vdso: avoid 64-bit vdso mapping for compat tasks")
Reported-by: Stefan Liebler <stli@linux.ibm.com>
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: <stable@vger.kernel.org> # v4.20+
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/include/asm/mmu_context.h |    2 +-
 arch/s390/kernel/vdso.c             |    5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -25,7 +25,7 @@ static inline int init_new_context(struc
 	atomic_set(&mm->context.flush_count, 0);
 	mm->context.gmap_asce = 0;
 	mm->context.flush_mm = 0;
-	mm->context.compat_mm = 0;
+	mm->context.compat_mm = test_thread_flag(TIF_31BIT);
 #ifdef CONFIG_PGSTE
 	mm->context.alloc_pgste = page_table_allocate_pgste ||
 		test_thread_flag(TIF_PGSTE) ||
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -224,10 +224,9 @@ int arch_setup_additional_pages(struct l
 
 	vdso_pages = vdso64_pages;
 #ifdef CONFIG_COMPAT
-	if (is_compat_task()) {
+	mm->context.compat_mm = is_compat_task();
+	if (mm->context.compat_mm)
 		vdso_pages = vdso32_pages;
-		mm->context.compat_mm = 1;
-	}
 #endif
 	/*
 	 * vDSO has a problem and was disabled, just don't "enable" it for


