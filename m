Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B81EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690EF222A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897092;
	bh=IRoFmFFnk+XzrWAkQ5W5xQv907Qq1K/SUskDM+au3Ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LTC89GkBZhkivtyAjVyrMHhU9kb7p8/SuNoYJO1KxmR6nvCv5jGfjl0gau7aebtg0
	 Liv1gX0som9z8sawD8QrCB5pT1h3LCqrIWXRpS69iAOCa2+9Ym5Ha7YDEiEU/4KsYB
	 joxCfipGfcCFR/723qDtYeTEG861bKlFii+9A+Mc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389495AbfBKO6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:58:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:45700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389478AbfBKO6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:58:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5E9020700;
        Mon, 11 Feb 2019 14:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897087;
        bh=IRoFmFFnk+XzrWAkQ5W5xQv907Qq1K/SUskDM+au3Ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RalG1KT5wxSBiAoDQZj+H1Rr0uHA+XO2Lz4DB/ai+7ZYpeEz2l77kgTcW4G352hgt
         YVUsgqopjtLIZyr7W/s21rml/aGUdEqORDU2SbWMQ7B4SEod23wEJ9rkGsrwzpFUoc
         xYgZ9tJovIHX2QzRt1wHaXlqGz1xYfcjdKkxFzrE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Torsten Duwe <duwe@suse.de>, Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 056/205] arm64: ftrace: dont adjust the LR value
Date:   Mon, 11 Feb 2019 15:17:34 +0100
Message-Id: <20190211141832.472147729@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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



