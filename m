Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE94AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9000920866
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956034;
	bh=YDB4IuOTQz8jkL+GMIEQ5QZI603zNxn1Ra1X8nIh8js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oxDzgZNxTCi8S5HlFI/ewfv23OFPIwwNrgGNLqHrP14YvUMuay9rLsHD00Jm0PR7/
	 QIWYqdmKbISIq1IYcDMnPVWkMp1R9Ns/Qtke4Y/qVp8Xcn2Lc6jZm2mf9sVWDj+mOH
	 LYAiw/tj0jFUWBBu+YX+NOiRNju6thER+sE3jt0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfBWVHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:07:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727927AbfBWVHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:07:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1FBB20861;
        Sat, 23 Feb 2019 21:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956029;
        bh=YDB4IuOTQz8jkL+GMIEQ5QZI603zNxn1Ra1X8nIh8js=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mwY/iCN4brmse6q3oak3YRoS0I890JGykbycDnIVIFMQoebyAXmfFu+cv5H3PNEDh
         GQ2MR7LkCBmMeGvia34fbNJhqc5Xn5n4aBMmJeHRBfoWCgAd0NfRnX2uCTDNSFNlTO
         y0BMCDwUsdwAv9wmzq1nfRRUsB9dTGu5NzEzmD/0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandre Ghiti <aghiti@upmem.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 19/65] riscv: Adjust mmap base address at a third of task size
Date:   Sat, 23 Feb 2019 16:05:54 -0500
Message-Id: <20190223210640.200911-19-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210640.200911-1-sashal@kernel.org>
References: <20190223210640.200911-1-sashal@kernel.org>
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
index 3fe4af8147d2d..c23578a37b443 100644
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

