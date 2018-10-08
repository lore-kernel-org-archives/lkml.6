Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07839C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43F221569
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSA8L4db"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43F221569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbeJHWj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:39:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729122AbeJHWj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:39:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90FCB21533;
        Mon,  8 Oct 2018 15:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012463;
        bh=yHB5ahIa4TX9QioB9aOdBoc+GN7Joxg/E5HNDfee7+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YSA8L4dbGcB+3iFmv7WtYy26kLQiSadhKlCpPcvEJo1i9mo6Nu5BzxREx541Ityax
         pSig5KQMfssF+Ons/GpwrnlP6Jr3VlAAMtQ2YtCaU1CiktbSYEk0oR7WmFZKAekhXS
         7Ue9QjXpP00O2KDD8jli0W9nmHwpljqh9MFXrqu8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     James Cowgill <jcowgill@debian.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 7/9] RISC-V: include linux/ftrace.h in asm-prototypes.h
Date:   Mon,  8 Oct 2018 11:27:32 -0400
Message-Id: <20181008152734.70962-7-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152734.70962-1-sashal@kernel.org>
References: <20181008152734.70962-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Cowgill <jcowgill@debian.org>

[ Upstream commit 57a489786de9ec37d6e25ef1305dc337047f0236 ]

Building a riscv kernel with CONFIG_FUNCTION_TRACER and
CONFIG_MODVERSIONS enabled results in these two warnings:

  MODPOST vmlinux.o
WARNING: EXPORT symbol "return_to_handler" [vmlinux] version generation failed, symbol will not be versioned.
WARNING: EXPORT symbol "_mcount" [vmlinux] version generation failed, symbol will not be versioned.

When exporting symbols from an assembly file, the MODVERSIONS code
requires their prototypes to be defined in asm-prototypes.h (see
scripts/Makefile.build). Since both of these symbols have prototypes
defined in linux/ftrace.h, include this header from RISC-V's
asm-prototypes.h.

Reported-by: Karsten Merker <merker@debian.org>
Signed-off-by: James Cowgill <jcowgill@debian.org>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/riscv/include/asm/asm-prototypes.h | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 arch/riscv/include/asm/asm-prototypes.h

diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/include/asm/asm-prototypes.h
new file mode 100644
index 000000000000..c9fecd120d18
--- /dev/null
+++ b/arch/riscv/include/asm/asm-prototypes.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_PROTOTYPES_H
+
+#include <linux/ftrace.h>
+#include <asm-generic/asm-prototypes.h>
+
+#endif /* _ASM_RISCV_PROTOTYPES_H */
-- 
2.17.1

