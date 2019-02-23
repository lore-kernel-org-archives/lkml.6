Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB117C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0DB20661
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550957575;
	bh=GE+mPLyhh69BARRWnXLLzoROZAHtbTM/OsFr8vTvpl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tUUtZxbt/5iXujvwpe15+u1vWF8KMe+huFIwCdfiD1DZrxXt3Q9TLqIzzLkracPkh
	 fvyvTD3b994Hi4i7EeqKSMCFRipRJD4BxVPu7xch9hv+SjMkFaEUdP+iOcNPvbgiu2
	 3zs01MeldiJ/58G4qcPWnP/GsRltcnKw59ZdUOJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfBWVFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:05:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbfBWVFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:05:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8A54206B6;
        Sat, 23 Feb 2019 21:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550955901;
        bh=GE+mPLyhh69BARRWnXLLzoROZAHtbTM/OsFr8vTvpl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TdtNm+JSXegYRUuJf11/kcIJz2NX61EZ1E6Q9QQ/STCF29px41tzJ4XQCyU7cXriW
         Q50to5Uo79WZ80o/iN7tcJ7usukJgEMIVVX/RUbSBsI0UmwF7PgJF5UaeJaahhxMn3
         Zp+aG0onqX6aTXpceWoF0z8RD9Bvg9MUP5np68Gc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandre Ghiti <aghiti@upmem.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 4.20 23/72] riscv: Adjust mmap base address at a third of task size
Date:   Sat, 23 Feb 2019 16:03:33 -0500
Message-Id: <20190223210422.199966-23-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210422.199966-1-sashal@kernel.org>
References: <20190223210422.199966-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Ghiti <aghiti@upmem.com>

[ Upstream commit ae662eec8a515ab550524e04c793b5ddf1aae3a1 ]

This ratio is the most used among all other architectures and make
icache_hygiene libhugetlbfs test pass: this test mmap lots of
hugepages whose addresses, without this patch, reach the end of
the process user address space.

Signed-off-by: Alexandre Ghiti <aghiti@upmem.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 0531f49af5c30..ce70bceb8872e 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -22,7 +22,7 @@
  * This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
-#define TASK_UNMAPPED_BASE	PAGE_ALIGN(TASK_SIZE >> 1)
+#define TASK_UNMAPPED_BASE	PAGE_ALIGN(TASK_SIZE / 3)
 
 #define STACK_TOP		TASK_SIZE
 #define STACK_TOP_MAX		STACK_TOP
-- 
2.19.1

