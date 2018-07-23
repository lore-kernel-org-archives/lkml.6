Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E05ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3AF920880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3AF920880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389338AbeGWNbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:31:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46284 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388578AbeGWNbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:31:39 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F0BBEC74;
        Mon, 23 Jul 2018 12:30:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Weimer <fweimer@redhat.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 43/44] powerpc/powernv: Fix save/restore of SPRG3 on entry/exit from stop (idle)
Date:   Mon, 23 Jul 2018 14:25:19 +0200
Message-Id: <20180723122439.472816387@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122437.447870153@linuxfoundation.org>
References: <20180723122437.447870153@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

commit b03897cf318dfc47de33a7ecbc7655584266f034 upstream.

On 64-bit servers, SPRN_SPRG3 and its userspace read-only mirror
SPRN_USPRG3 are used as userspace VDSO write and read registers
respectively.

SPRN_SPRG3 is lost when we enter stop4 and above, and is currently not
restored.  As a result, any read from SPRN_USPRG3 returns zero on an
exit from stop4 (Power9 only) and above.

Thus in this situation, on POWER9, any call from sched_getcpu() always
returns zero, as on powerpc, we call __kernel_getcpu() which relies
upon SPRN_USPRG3 to report the CPU and NUMA node information.

Fix this by restoring SPRN_SPRG3 on wake up from a deep stop state
with the sprg_vdso value that is cached in PACA.

Fixes: e1c1cfed5432 ("powerpc/powernv: Save/Restore additional SPRs for stop4 cpuidle")
Cc: stable@vger.kernel.org # v4.14+
Reported-by: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Reviewed-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/idle_book3s.S |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -140,6 +140,8 @@ power9_restore_additional_sprs:
 	ld	r4, STOP_MMCR2(r13)
 	mtspr	SPRN_MMCR1, r3
 	mtspr	SPRN_MMCR2, r4
+	ld	r4, PACA_SPRG_VDSO(r13)
+	mtspr	SPRN_SPRG3, r4
 	blr
 
 /*


