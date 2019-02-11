Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7205C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B666B20700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549901380;
	bh=dSTna1BVmIjtekNhv0Td8QLhTu5kU9lddzIBk0PnI+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wSz1FTbgBT1jop2fYwwevw51hIevBEJMbJQfDtNAPZTIN/gu+1FPzgUrftjR7pTkL
	 Gkn2lYb4dGYS2LRq1KdldfhOPsE+42llHT9l1LeNz8eWBeayUlKl5GIonoUKvKJyXB
	 BEI3NaYBrvFnDmfO7JTLoGUAxfBRf9TJMxRWkwZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbfBKQJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:09:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:58730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729357AbfBKOZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:25:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4941C20821;
        Mon, 11 Feb 2019 14:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895119;
        bh=dSTna1BVmIjtekNhv0Td8QLhTu5kU9lddzIBk0PnI+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ra4+pkwodzO//eh1IkDDgiq08LoZwZGCqheqBuq8tozU2CNHyxaraop/+RDIf4e9P
         pc/iNk4+aG5ntFJmX3/FDew1rr9kr5Z3MJ9kXogk4V/fHwp/KArJUh+gSiCqYQM22J
         qG+JTZsWq4fAxwaJ3AxlUjYhwHXC7iSb/1COc3qs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Torsten Duwe <duwe@suse.de>, Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 098/352] arm64: ftrace: dont adjust the LR value
Date:   Mon, 11 Feb 2019 15:15:25 +0100
Message-Id: <20190211141852.061272496@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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
index 1175f5827ae1..295951f3172e 100644
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



