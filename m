Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BAEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE59208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZ3+Qc/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FE59208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389394AbeKTDMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:12:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388538AbeKTDMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:12:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77332206BA;
        Mon, 19 Nov 2018 16:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646101;
        bh=K9ho3sEv2i7h0HJPBiloRm9kJsUkXwEH+0XUgA/8kPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZ3+Qc/SIj9jMW3lJqnVhHAfsADv+AfPvtLGYpmhCRd+np6zBjtfP0l2MxoV7HOu9
         W+0GC6ZEiesu1F5aznF4veAIhEo36qtvqQ7AM8cdWJPGhhq/VEoh6Wuzw16GA1xhjs
         8+aQV8IpkvhdOnrhtuG3XCuehIEszl7Odp+9OvqU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Axtens <dja@axtens.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 007/124] powerpc/nohash: fix undefined behaviour when testing page size support
Date:   Mon, 19 Nov 2018 17:27:41 +0100
Message-Id: <20181119162614.376604800@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/mm/tlb_nohash.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -500,6 +500,9 @@ static void setup_page_sizes(void)
 		for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
 			struct mmu_psize_def *def = &mmu_psize_defs[psize];
 
+			if (!def->shift)
+				continue;
+
 			if (tlb1ps & (1U << (def->shift - 10))) {
 				def->flags |= MMU_PAGE_SIZE_DIRECT;
 


