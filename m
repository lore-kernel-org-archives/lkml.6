Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECD5ECDE46
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7C92085B
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q390avwr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7C92085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731717AbeKDXJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:09:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:49222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731705AbeKDXJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:09:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E15E2086C;
        Sun,  4 Nov 2018 13:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339663;
        bh=XhnytXMPlUsaEpRiIup1v9RPbaGi4TCWYQ+alomLy2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q390avwrB9rf1NUZz5AII4ziMjYwLEV9YWymY/QHADqsEeUdfOUuD7PdmPY3cGwVY
         YOfqnmah5nP5BP/Wk540dM+xXnKrJsCDI0nAg0tcMr/JcCWsmkHcglMW7iA5B3xxX8
         5BJSDpSl132hdTAZBmGdflAQlUsX3YVNyuo9KBEI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Axtens <dja@axtens.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 04/15] powerpc/nohash: fix undefined behaviour when testing page size support
Date:   Sun,  4 Nov 2018 08:54:06 -0500
Message-Id: <20181104135417.88671-4-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135417.88671-1-sashal@kernel.org>
References: <20181104135417.88671-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Axtens <dja@axtens.net>

[ Upstream commit f5e284803a7206d43e26f9ffcae5de9626d95e37 ]

When enumerating page size definitions to check hardware support,
we construct a constant which is (1U << (def->shift - 10)).

However, the array of page size definitions is only initalised for
various MMU_PAGE_* constants, so it contains a number of 0-initialised
elements with def->shift == 0. This means we end up shifting by a
very large number, which gives the following UBSan splat:

================================================================================
UBSAN: Undefined behaviour in /home/dja/dev/linux/linux/arch/powerpc/mm/tlb_nohash.c:506:21
shift exponent 4294967286 is too large for 32-bit type 'unsigned int'
CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc3-00045-ga604f927b012-dirty #6
Call Trace:
[c00000000101bc20] [c000000000a13d54] .dump_stack+0xa8/0xec (unreliable)
[c00000000101bcb0] [c0000000004f20a8] .ubsan_epilogue+0x18/0x64
[c00000000101bd30] [c0000000004f2b10] .__ubsan_handle_shift_out_of_bounds+0x110/0x1a4
[c00000000101be20] [c000000000d21760] .early_init_mmu+0x1b4/0x5a0
[c00000000101bf10] [c000000000d1ba28] .early_setup+0x100/0x130
[c00000000101bf90] [c000000000000528] start_here_multiplatform+0x68/0x80
================================================================================

Fix this by first checking if the element exists (shift != 0) before
constructing the constant.

Signed-off-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/tlb_nohash.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index bb04e4df3100..1b784b8fd8b4 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -487,6 +487,9 @@ static void setup_page_sizes(void)
 		for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
 			struct mmu_psize_def *def = &mmu_psize_defs[psize];
 
+			if (!def->shift)
+				continue;
+
 			if (tlb1ps & (1U << (def->shift - 10))) {
 				def->flags |= MMU_PAGE_SIZE_DIRECT;
 
-- 
2.17.1

