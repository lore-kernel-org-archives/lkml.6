Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52BEC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40C22086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762243;
	bh=zKv1KDrAhBhwOjBfyfm72o82M3ZEXXWvhZtLuk/YL/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=prh67ZqlaowzuZHSsqR0enDh4xP6qp9Ipc3Pi8lDwQzjC/DnLowLnX92fNaR2Fc6l
	 PUFLyxF0djqpEtM9fLzMao0TPvJWVvRdoTckNInP1pNuPiytcGfCAmQqVByMNkpBps
	 fzICTg0j3JeFxhGB0MeIRGR64TYwtKYHJ3cLCXlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbfA2LoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:44:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:34180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbfA2LoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:44:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B11302086C;
        Tue, 29 Jan 2019 11:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762240;
        bh=zKv1KDrAhBhwOjBfyfm72o82M3ZEXXWvhZtLuk/YL/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DAI2aZEIAwonz8U0hmwfaqJKNDiM7Nnm/nVdAX5s0+WEUfqjD6rH2X+aeuIKxsSpw
         Uy5ZwwI+xVkl233I9TOAVpcyCw7aAD8RFZS0ivE6umti84dpWWpFoJpLF3IkIQhUUC
         SHlgVMuYNGRS7B02U3HfEgk5OlPv6XL/q80g3ZYM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>, stable@kernel.org
Subject: [PATCH 4.19 039/103] s390/mm: always force a load of the primary ASCE on context switch
Date:   Tue, 29 Jan 2019 12:35:16 +0100
Message-Id: <20190129113201.863262716@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -89,8 +89,6 @@ static inline void switch_mm(struct mm_s
 {
 	int cpu = smp_processor_id();
 
-	if (prev == next)
-		return;
 	S390_lowcore.user_asce = next->context.asce;
 	cpumask_set_cpu(cpu, &next->context.cpu_attach_mask);
 	/* Clear previous user-ASCE from CR1 and CR7 */
@@ -102,7 +100,8 @@ static inline void switch_mm(struct mm_s
 		__ctl_load(S390_lowcore.vdso_asce, 7, 7);
 		clear_cpu_flag(CIF_ASCE_SECONDARY);
 	}
-	cpumask_clear_cpu(cpu, &prev->context.cpu_attach_mask);
+	if (prev != next)
+		cpumask_clear_cpu(cpu, &prev->context.cpu_attach_mask);
 }
 
 #define finish_arch_post_lock_switch finish_arch_post_lock_switch


