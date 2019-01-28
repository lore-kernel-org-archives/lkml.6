Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317FCC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FAA20663
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693110;
	bh=kH9pAKRntDbs6L6fgNgkhboTk7TRTgNYxNpXZp7XtrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m2gvV7pgwdXVrZ460bxuV38BnPZVkn+tYfn3gJ9WZ2zrEL9n9/Yt/jRwSt3jXR9pM
	 1QS6yxTUtyZ0HS5mnd727pa34BjrEHA19sAix6cQ16u/SU0P0cv1pQe9ucd2pb7pYj
	 K5Svb60IVDmZximo2twxwQ265KpUL0cvMUmYtjIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390327AbfA1Q1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:27:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:36424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388850AbfA1Q0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:26:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AA512084A;
        Mon, 28 Jan 2019 16:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692810;
        bh=kH9pAKRntDbs6L6fgNgkhboTk7TRTgNYxNpXZp7XtrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fFqKAQMTzwLH95UISPiuUOM92V7HCEGXFcULZIFlvX46HwEezl9ZaQ2gfBciWdsud
         3Csv9lgPXkn57CMyRCzDNFb9bEdRnZ04Y6kaVuXwDal08A1Is6AIKVsBMyuDvNkU9K
         +Vggo6OaFooI8qlL/ObzgXI3y5Z8j9UBN3L9W6bM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Torsten Duwe <duwe@suse.de>, Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 18/61] arm64: ftrace: don't adjust the LR value
Date:   Mon, 28 Jan 2019 11:25:40 -0500
Message-Id: <20190128162623.59854-18-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162623.59854-1-sashal@kernel.org>
References: <20190128162623.59854-1-sashal@kernel.org>
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
index c85a02b6cca0..b3fdbba80d4b 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -78,7 +78,6 @@
 	.macro mcount_get_lr reg
 	ldr	\reg, [x29]
 	ldr	\reg, [\reg, #8]
-	mcount_adjust_addr	\reg, \reg
 	.endm
 
 	.macro mcount_get_lr_addr reg
-- 
2.19.1

