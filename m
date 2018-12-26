Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2414C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939E3214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864432;
	bh=o81EuJgkXKgsPy/BgWUnSLGjwRup3hC2Y+as07xe2PE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FMWTQVjeThEHUnlXi18B2z7DX4HKRMElZF73WuO9LMDlw+/93/sI8jvsavNcxJV16
	 IXJNL6kY/5lAB0xsK97zOhq2O+e7MGuaFLYrTXZ/Ad8KHCGAtcqS215HvCPza7tuuk
	 SY/orLrBPtRfO/Ra6ct8brvGa3u7ihXjEOhivQQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbeLZWrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:47:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:40078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727214AbeLZWkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:40:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26C44218E2;
        Wed, 26 Dec 2018 22:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864001;
        bh=o81EuJgkXKgsPy/BgWUnSLGjwRup3hC2Y+as07xe2PE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lN+WWm+Wh3gWopZnjuFznvRYnZK4Ajb1craoY4+z1t6fIk08WKib6lIICWMLRrvPB
         2jGYp3DbWk7gEOTZHC8xg6mgNRLIdzs26Y7tjWUxDzj/P3r48IKoKTy9CnvjSNezzb
         qJzIzEUEKHIzSv5TwT0WWvdLR70KwhMuEHlvyqF4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.14 03/59] powerpc/mm: Fix linux page tables build with some configs
Date:   Wed, 26 Dec 2018 17:37:43 -0500
Message-Id: <20181226223839.150262-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223839.150262-1-sashal@kernel.org>
References: <20181226223839.150262-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 462951cd32e1496dc64b00051dfb777efc8ae5d8 ]

For some configs the build fails with:

  arch/powerpc/mm/dump_linuxpagetables.c: In function 'populate_markers':
  arch/powerpc/mm/dump_linuxpagetables.c:306:39: error: 'PKMAP_BASE' undeclared (first use in this function)
  arch/powerpc/mm/dump_linuxpagetables.c:314:50: error: 'LAST_PKMAP' undeclared (first use in this function)

These come from highmem.h, including that fixes the build.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/dump_linuxpagetables.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
index 31c1c61afaa4..0bbaf7344872 100644
--- a/arch/powerpc/mm/dump_linuxpagetables.c
+++ b/arch/powerpc/mm/dump_linuxpagetables.c
@@ -19,6 +19,7 @@
 #include <linux/hugetlb.h>
 #include <linux/io.h>
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <asm/fixmap.h>
-- 
2.19.1

