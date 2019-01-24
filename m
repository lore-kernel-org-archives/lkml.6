Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0E3C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57814218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358964;
	bh=+OTlQXf2WPDqQDpfcmOcYhokNvO14YPsmgZoCmDVWgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kuvw0Bt56+mdxCVGfM+f9CgwqP2mYfKvL62W3+DcnC3D/F7oHRaK+e9qaDEReWdfG
	 WqkmkAbrzOlOZLBD1J0m+14Bg/kZ4G0utr0SeroD1A6pizGB8sDZSz0QRGZQPVuDpX
	 QmC/oIP+VH9/a9nePEjDICDrJruEIWtyY3As5tWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387826AbfAXTmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:42:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733252AbfAXTkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:40:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D004C218F0;
        Thu, 24 Jan 2019 19:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358836;
        bh=+OTlQXf2WPDqQDpfcmOcYhokNvO14YPsmgZoCmDVWgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jn8UpWZf53WRIGYB5zorBOc81Lvf9ngXrLlhmxZqKyQ7P2KNlO9yXpgexnUg2y8A5
         P92gAFSkU3GNB7/MfFkQ2B7QFFALtLblVLTp4HSwX1NSWLyV5QguuLZwSLz1MaCzV8
         wHquPD+z2xbPoY3GBP6zuAOIeQmrXWGmIg0j3vhc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Morse <james.morse@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 044/127] arm64: Use a raw spinlock in __install_bp_hardening_cb()
Date:   Thu, 24 Jan 2019 20:19:50 +0100
Message-Id: <20190124190214.134552997@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
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

[ Upstream commit d8797b125711f23d83f5a71e908d34dfcd1fc3e9 ]

__install_bp_hardening_cb() is called via stop_machine() as part
of the cpu_enable callback. To force each CPU to take its turn
when allocating slots, they take a spinlock.

With the RT patches applied, the spinlock becomes a mutex,
and we get warnings about sleeping while in stop_machine():
| [    0.319176] CPU features: detected: RAS Extension Support
| [    0.319950] BUG: scheduling while atomic: migration/3/36/0x00000002
| [    0.319955] Modules linked in:
| [    0.319958] Preemption disabled at:
| [    0.319969] [<ffff000008181ae4>] cpu_stopper_thread+0x7c/0x108
| [    0.319973] CPU: 3 PID: 36 Comm: migration/3 Not tainted 4.19.1-rt3-00250-g330fc2c2a880 #2
| [    0.319975] Hardware name: linux,dummy-virt (DT)
| [    0.319976] Call trace:
| [    0.319981]  dump_backtrace+0x0/0x148
| [    0.319983]  show_stack+0x14/0x20
| [    0.319987]  dump_stack+0x80/0xa4
| [    0.319989]  __schedule_bug+0x94/0xb0
| [    0.319991]  __schedule+0x510/0x560
| [    0.319992]  schedule+0x38/0xe8
| [    0.319994]  rt_spin_lock_slowlock_locked+0xf0/0x278
| [    0.319996]  rt_spin_lock_slowlock+0x5c/0x90
| [    0.319998]  rt_spin_lock+0x54/0x58
| [    0.320000]  enable_smccc_arch_workaround_1+0xdc/0x260
| [    0.320001]  __enable_cpu_capability+0x10/0x20
| [    0.320003]  multi_cpu_stop+0x84/0x108
| [    0.320004]  cpu_stopper_thread+0x84/0x108
| [    0.320008]  smpboot_thread_fn+0x1e8/0x2b0
| [    0.320009]  kthread+0x124/0x128
| [    0.320010]  ret_from_fork+0x10/0x18

Switch this to a raw spinlock, as we know this is only called with
IRQs masked.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/cpu_errata.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 6ad715d67df8..99622e5ad21b 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -135,7 +135,7 @@ static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
 				      const char *hyp_vecs_start,
 				      const char *hyp_vecs_end)
 {
-	static DEFINE_SPINLOCK(bp_lock);
+	static DEFINE_RAW_SPINLOCK(bp_lock);
 	int cpu, slot = -1;
 
 	/*
@@ -147,7 +147,7 @@ static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
 		return;
 	}
 
-	spin_lock(&bp_lock);
+	raw_spin_lock(&bp_lock);
 	for_each_possible_cpu(cpu) {
 		if (per_cpu(bp_hardening_data.fn, cpu) == fn) {
 			slot = per_cpu(bp_hardening_data.hyp_vectors_slot, cpu);
@@ -163,7 +163,7 @@ static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
 
 	__this_cpu_write(bp_hardening_data.hyp_vectors_slot, slot);
 	__this_cpu_write(bp_hardening_data.fn, fn);
-	spin_unlock(&bp_lock);
+	raw_spin_unlock(&bp_lock);
 }
 #else
 #define __smccc_workaround_1_smc_start		NULL
-- 
2.19.1



