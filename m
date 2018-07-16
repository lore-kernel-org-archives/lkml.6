Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29EDECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48A5206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A48A5206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388424AbeGPIHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:07:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47510 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbeGPIHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:07:16 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B02A9CA1;
        Mon, 16 Jul 2018 07:41:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Yandong Zhao <yandong77520@gmail.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.14 39/54] arm64: neon: Fix function may_use_simd() return error status
Date:   Mon, 16 Jul 2018 09:35:36 +0200
Message-Id: <20180716073457.992986671@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073450.534886211@linuxfoundation.org>
References: <20180716073450.534886211@linuxfoundation.org>
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

From: Yandong Zhao <yandong77520@gmail.com>

commit 2fd8eb4ad87104c54800ef3cea498c92eb15c78a upstream.

It does not matter if the caller of may_use_simd() migrates to
another cpu after the call, but it is still important that the
kernel_neon_busy percpu instance that is read matches the cpu the
task is running on at the time of the read.

This means that raw_cpu_read() is not sufficient.  kernel_neon_busy
may appear true if the caller migrates during the execution of
raw_cpu_read() and the next task to be scheduled in on the initial
cpu calls kernel_neon_begin().

This patch replaces raw_cpu_read() with this_cpu_read() to protect
against this race.

Cc: <stable@vger.kernel.org>
Fixes: cb84d11e1625 ("arm64: neon: Remove support for nested or hardirq kernel-mode NEON")
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Yandong Zhao <yandong77520@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/simd.h |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

--- a/arch/arm64/include/asm/simd.h
+++ b/arch/arm64/include/asm/simd.h
@@ -29,20 +29,15 @@ DECLARE_PER_CPU(bool, kernel_neon_busy);
 static __must_check inline bool may_use_simd(void)
 {
 	/*
-	 * The raw_cpu_read() is racy if called with preemption enabled.
-	 * This is not a bug: kernel_neon_busy is only set when
-	 * preemption is disabled, so we cannot migrate to another CPU
-	 * while it is set, nor can we migrate to a CPU where it is set.
-	 * So, if we find it clear on some CPU then we're guaranteed to
-	 * find it clear on any CPU we could migrate to.
-	 *
-	 * If we are in between kernel_neon_begin()...kernel_neon_end(),
-	 * the flag will be set, but preemption is also disabled, so we
-	 * can't migrate to another CPU and spuriously see it become
-	 * false.
+	 * kernel_neon_busy is only set while preemption is disabled,
+	 * and is clear whenever preemption is enabled. Since
+	 * this_cpu_read() is atomic w.r.t. preemption, kernel_neon_busy
+	 * cannot change under our feet -- if it's set we cannot be
+	 * migrated, and if it's clear we cannot be migrated to a CPU
+	 * where it is set.
 	 */
 	return !in_irq() && !irqs_disabled() && !in_nmi() &&
-		!raw_cpu_read(kernel_neon_busy);
+		!this_cpu_read(kernel_neon_busy);
 }
 
 #else /* ! CONFIG_KERNEL_MODE_NEON */


