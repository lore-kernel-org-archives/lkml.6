Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F8FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1561121741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694937;
	bh=/1+cGG7MMJIMOdJXVVsZ7Bso+Yx8F4zMnB2XyWF3RIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dlkc17G+8nY8v9VlXIit/i6KexSvvUDO3NphH14N89VKcH6VpDp9KhFt5V/SWAEr0
	 e+0n1Uayq1kw6uVFUht+k/2FbCCyQELFHs3efEIfegluzB70fkucHBKIx6JV7YhV2q
	 BPxsdFdnYvkae0Z1RRN+IRfU5DYua+lLUnge+HiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387868AbfA1RCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:02:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:43958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387627AbfA1QOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:14:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20EFC2086C;
        Mon, 28 Jan 2019 16:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692072;
        bh=/1+cGG7MMJIMOdJXVVsZ7Bso+Yx8F4zMnB2XyWF3RIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vqjouM1+jTmB02c3xVRqql190Eaqv1nGMWXe5+cbnanSamV0XcEuqjKYEmssS9gV6
         V18y/8wR+pI7n7kMbIVbwtXsJvccsdzzZD/3iFj4UdjRQlXqZZO4QOKxrtrFEZ9FsG
         YgU75zFA9EGvb2SRMOUkOLQcpKIAycJ3RuOv1CVU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Torsten Duwe <duwe@suse.de>, Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 059/170] arm64: ftrace: don't adjust the LR value
Date:   Mon, 28 Jan 2019 11:10:09 -0500
Message-Id: <20190128161200.55107-59-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 6e803e2e6e367db9a0d6ecae1bd24bb5752011bd ]

The core ftrace code requires that when it is handed the PC of an
instrumented function, this PC is the address of the instrumented
instruction. This is necessary so that the core ftrace code can identify
the specific instrumentation site. Since the instrumented function will
be a BL, the address of the instrumented function is LR - 4 at entry to
the ftrace code.

This fixup is applied in the mcount_get_pc and mcount_get_pc0 helpers,
which acquire the PC of the instrumented function.

The mcount_get_lr helper is used to acquire the LR of the instrumented
function, whose value does not require this adjustment, and cannot be
adjusted to anything meaningful. No adjustment of this value is made on
other architectures, including arm. However, arm64 adjusts this value by
4.

This patch brings arm64 in line with other architectures and removes the
adjustment of the LR value.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Torsten Duwe <duwe@suse.de>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/entry-ftrace.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index e1be42e11ff5..5a10e3a3e843 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -79,7 +79,6 @@
 	.macro mcount_get_lr reg
 	ldr	\reg, [x29]
 	ldr	\reg, [\reg, #8]
-	mcount_adjust_addr	\reg, \reg
 	.endm
 
 	.macro mcount_get_lr_addr reg
-- 
2.19.1

