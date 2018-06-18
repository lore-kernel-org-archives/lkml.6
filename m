Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2502C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EF920864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64EF920864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968175AbeFRIiH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:38:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36862 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030414AbeFRIiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:38:04 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C5AF2CBD;
        Mon, 18 Jun 2018 08:38:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kim Phillips <kim.phillips@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 182/189] efi/libstub/arm64: Handle randomized TEXT_OFFSET
Date:   Mon, 18 Jun 2018 10:14:38 +0200
Message-Id: <20180618081216.529334438@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
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

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 4f74d72aa7067e75af92fbab077e6d7d0210be66 ]

When CONFIG_RANDOMIZE_TEXT_OFFSET=y, TEXT_OFFSET is an arbitrary
multiple of PAGE_SIZE in the interval [0, 2MB).

The EFI stub does not account for the potential misalignment of
TEXT_OFFSET relative to EFI_KIMG_ALIGN, and produces a randomized
physical offset which is always a round multiple of EFI_KIMG_ALIGN.
This may result in statically allocated objects whose alignment exceeds
PAGE_SIZE to appear misaligned in memory. This has been observed to
result in spurious stack overflow reports and failure to make use of
the IRQ stacks, and theoretically could result in a number of other
issues.

We can OR in the low bits of TEXT_OFFSET to ensure that we have the
necessary offset (and hence preserve the misalignment of TEXT_OFFSET
relative to EFI_KIMG_ALIGN), so let's do that.

Reported-by: Kim Phillips <kim.phillips@arm.com>
Tested-by: Kim Phillips <kim.phillips@arm.com>
[ardb: clarify comment and commit log, drop unneeded parens]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Fixes: 6f26b3671184c36d ("arm64: kaslr: increase randomization granularity")
Link: http://lkml.kernel.org/r/20180518140841.9731-2-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -98,6 +98,16 @@ efi_status_t handle_kernel_image(efi_sys
 			     (phys_seed >> 32) & mask : TEXT_OFFSET;
 
 		/*
+		 * With CONFIG_RANDOMIZE_TEXT_OFFSET=y, TEXT_OFFSET may not
+		 * be a multiple of EFI_KIMG_ALIGN, and we must ensure that
+		 * we preserve the misalignment of 'offset' relative to
+		 * EFI_KIMG_ALIGN so that statically allocated objects whose
+		 * alignment exceeds PAGE_SIZE appear correctly aligned in
+		 * memory.
+		 */
+		offset |= TEXT_OFFSET % EFI_KIMG_ALIGN;
+
+		/*
 		 * If KASLR is enabled, and we have some randomness available,
 		 * locate the kernel at a randomized offset in physical memory.
 		 */


