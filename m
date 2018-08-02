Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2695C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B47208DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B47208DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeHBIqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:46:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:40027 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbeHBIqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:46:30 -0400
Received: from homer.simpson.net ([185.191.216.67]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYOCL-1fPRos0Dc9-00V8Vj; Thu, 02
 Aug 2018 08:56:23 +0200
Message-ID: <1533192980.11791.8.camel@gmx.de>
Subject: [rt-patch 4/3] arm,KVM: Move phys_timer handling to hard irq context
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Thu, 02 Aug 2018 08:56:20 +0200
In-Reply-To: <1532768853.9882.73.camel@gmx.de>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
         <1532764179.9882.14.camel@gmx.de> <1532768853.9882.73.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:tRqZbZ4ii0YEQnFH5QzY4FnVNgN++R/6D/nfTMKEkbnhc3OPu8/
 /Fkz/f+5HYLbXUXm1b4IO+hht/lszV0M8e2xWF8adP/80/B84YSkNY14DuuRjIINX655eVH
 Go5CrphvmK28gVwFCu51PkZ/abwdAEkj1PT5y5dC/1zwjMjI387EG4nLyUVR8aXgxEOy5er
 gniosEUxLpmJi+4OHDHTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:muuBhGYaHD0=:aDOSoUtiUMHw8sSJXcVxL7
 LsybNeHVQrdNc5kD0GtyZIQh/hTB6mOfsaFa77zI5Um0ROLumgAgcH7WPSo/7fkjzV/26nORc
 lvkiE2hrksWlIfuPuzpLR83IsVwnY70DMPdc//M6eyW3WTDglDidAL5Te4ujMGisAyqNpI27E
 h5bbpL9BDN/RyOCHkloqa/tJZ8YaZ7oasz0OoF5YUbCWm4xbF8TEu6h9B4WQIOSWsl3mzaW40
 Hr1deI6cZPD+OChOUcnYXUfpHpBKMR8N63N/NAkwJDhYtlxYd10P3zVpfZ9FDgHLtfy+cytrT
 P1GvH1NCau5UN6M3Ubqu/ROWOr76VpOS79q7edxkO1dwQHgn//bvDd5xCsqeyzsV1RtBj5qtB
 aYeOQA2xc2t/SPwu04mrI+hfOTPBApnpKgPj1edfbfZGRazms8IsV1r/vYw2jYwO2Z9TtNTTQ
 EmMAuHqv0qDTo7lb8v4GQy2AzBGMuQCUFufoQug6DUes9JGxzRuKV6Phv0UdlyKgfHB52XPJv
 NJ/feoVjdzTGVjJVvrb8weeg3DTtCdGNE17uf2HKLLhS+50UCPOChJ0lCpiTmb4UfEkWPq0SS
 9IJv+gWRrET7VZbDKfQw0T1qnkM8VX6x0IfRaeFVGRg4wd/Xo/SLroxVhXRFYYSCTwULAv/Px
 MiTt3XkDBofcWxHrn1AVUwIVIfUXxyp2j3Q5d00IAVEuiO5FsFxYa29U3hUMHZ5odL3259PB0
 bXqWNK8hjOKCPNmLZpIiRZ7Nlwv3TbvqNGikCC6E0lGXdPU5BVpfFwREDVWiGeMtCB90oQiDL
 CvA+ps3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(arm-land adventures 1/3 take2 will have to wait, my cup runeth over) 

v4.14..v4.15 timer handling changes including calling kvm_timer_vcpu_load()
during kvm_preempt_ops.sched_in and taking vgic_dist.lpi_list_lock in the
timer interrupt handler required locks for which locking rules/context had
been changed be converted to raw_spinlock_t...

Quoting virt/kvm/arm/vgic/vgic.c:
 * Locking order is always:
 * kvm->lock (mutex)
 *   its->cmd_lock (mutex)
 *     its->its_lock (mutex)
 *       vgic_cpu->ap_list_lock         must be taken with IRQs disabled
 *         kvm->lpi_list_lock           must be taken with IRQs disabled
 *           vgic_irq->irq_lock         must be taken with IRQs disabled
 *
 * As the ap_list_lock might be taken from the timer interrupt handler,
 * we have to disable IRQs before taking this lock and everything lower
 * than it.

...and fixed the obvious bricking consequence of those changes for RT,
but left an RT specific kvm unit test timer failure in its wake.  Handling
phys_timer in hard interrupt context as expected cures that failure.

Pre:
PASS selftest-setup (2 tests)
PASS selftest-vectors-kernel (2 tests)
PASS selftest-vectors-user (2 tests)
PASS selftest-smp (65 tests)
PASS pci-test (1 tests)
PASS pmu (3 tests)
PASS gicv2-ipi (3 tests)
PASS gicv3-ipi (3 tests)
PASS gicv2-active (1 tests)
PASS gicv3-active (1 tests)
PASS psci (4 tests)
FAIL timer (8 tests, 1 unexpected failures)

Post:
PASS selftest-setup (2 tests)
PASS selftest-vectors-kernel (2 tests)
PASS selftest-vectors-user (2 tests)
PASS selftest-smp (65 tests)
PASS pci-test (1 tests)
PASS pmu (3 tests)
PASS gicv2-ipi (3 tests)
PASS gicv3-ipi (3 tests)
PASS gicv2-active (1 tests)
PASS gicv3-active (1 tests)
PASS psci (4 tests)
PASS timer (8 tests)

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 virt/kvm/arm/arch_timer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -634,7 +634,7 @@ void kvm_timer_vcpu_init(struct kvm_vcpu
 	hrtimer_init(&timer->bg_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	timer->bg_timer.function = kvm_bg_timer_expire;
 
-	hrtimer_init(&timer->phys_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	hrtimer_init(&timer->phys_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
 	timer->phys_timer.function = kvm_phys_timer_expire;
 
 	vtimer->irq.irq = default_vtimer_irq.irq;
