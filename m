Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBED7C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B415920844
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548761921;
	bh=d1Qj9i3X8zCEeEXgpOz4IuOBvviNKjRnVTTmXdifVdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pDupb9um5/9Z0/AWf1X2sij+H5lDytiPFLVsGm8kNeZFbd1rICpN9L5n0s64H+txQ
	 BP/T0Qw+0o2Hwno7zJTJSYlGzTRfMqmhlqw4Vx1hwbT2GP5qGSMTCPWdaIRApbFuRz
	 v6zP2wmzk+5eAvXsR6SfygCoyyVkhPBjErlafB9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfA2Lil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:38:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:55276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729207AbfA2Lih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:38:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6758C20844;
        Tue, 29 Jan 2019 11:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761916;
        bh=d1Qj9i3X8zCEeEXgpOz4IuOBvviNKjRnVTTmXdifVdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iMEYb0MQdVDFnywilkd83deoHWTnnUwqvcEAvNeEdz4S/iwOiRy81YLrc9UYm5d3d
         ghlo+Ja91Y7Pu0CS+srOs8gombU6e4asHSsxWvDe2UY1AV+1cWQxNsqhD3PiZlr201
         Z3zM/EoY89jha61u5dTqQNjYYJXpJucYzbojtmhU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>, stable@kernel.org
Subject: [PATCH 4.20 045/117] s390/mm: always force a load of the primary ASCE on context switch
Date:   Tue, 29 Jan 2019 12:34:56 +0100
Message-Id: <20190129113209.845296611@linuxfoundation.org>
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

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

commit a38662084c8bdb829ff486468c7ea801c13fcc34 upstream.

The ASCE of an mm_struct can be modified after a task has been created,
e.g. via crst_table_downgrade for a compat process. The active_mm logic
to avoid the switch_mm call if the next task is a kernel thread can
lead to a situation where switch_mm is called where 'prev == next' is
true but 'prev->context.asce == next->context.asce' is not.

This can lead to a situation where a CPU uses the outdated ASCE to run
a task. The result can be a crash, endless loops and really subtle
problem due to TLBs being created with an invalid ASCE.

Cc: stable@kernel.org # v3.15+
Fixes: 53e857f30867 ("s390/mm,tlb: race of lazy TLB flush vs. recreation")
Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/include/asm/mmu_context.h |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -90,8 +90,6 @@ static inline void switch_mm(struct mm_s
 {
 	int cpu = smp_processor_id();
 
-	if (prev == next)
-		return;
 	S390_lowcore.user_asce = next->context.asce;
 	cpumask_set_cpu(cpu, &next->context.cpu_attach_mask);
 	/* Clear previous user-ASCE from CR1 and CR7 */
@@ -103,7 +101,8 @@ static inline void switch_mm(struct mm_s
 		__ctl_load(S390_lowcore.vdso_asce, 7, 7);
 		clear_cpu_flag(CIF_ASCE_SECONDARY);
 	}
-	cpumask_clear_cpu(cpu, &prev->context.cpu_attach_mask);
+	if (prev != next)
+		cpumask_clear_cpu(cpu, &prev->context.cpu_attach_mask);
 }
 
 #define finish_arch_post_lock_switch finish_arch_post_lock_switch


