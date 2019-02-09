Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9163FC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588F120643
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738644;
	bh=YhIMmOSwti1zPESoOl0fTvV5sFCRMp9I5uuDvqzkyWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rrE9bFk6UDlDiFJbgcdZxAcjWpP2fDzZxG4qPwXZHvnZy4uA9KHtkNXKZDOBL4iP4
	 ycQMdjXSPXr3Xg1gCqFX2HTZFMmSuAIeSicncXfIdGeCFKD8WtPGe7qaNSAuQC5f0T
	 nh28Bc7Zc4ELes4tO6PX/4+jzcz50UAfwKUrucFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfBISrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:47:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:60314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbfBISro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:47:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C99C20821;
        Sat,  9 Feb 2019 18:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738063;
        bh=YhIMmOSwti1zPESoOl0fTvV5sFCRMp9I5uuDvqzkyWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MTQ6pQKudmnQrPEzZHttWIuKUGGulNEeNWvng3bVEc8hhui+7SSXUscudxfFyKzfS
         Dzik9CQUeB8P3fckDhiO42FTFvnJbD3h5KMIYqcY/1bKbwCFdgTAjZYZFaLXJowKmj
         WsK5aPq/5HfHhY7LLxZMDo/zWdLk6Vgg45CskOBI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 07/42] tools uapi: fix RISC-V 64-bit support
Date:   Sat,  9 Feb 2019 13:46:59 -0500
Message-Id: <20190209184734.125935-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184734.125935-1-sashal@kernel.org>
References: <20190209184734.125935-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aurelien Jarno <aurelien@aurel32.net>

[ Upstream commit d0df00e30e4bf9bc27ddbd092ad683ff6121b360 ]

The BPF library is not built on 64-bit RISC-V, as the BPF feature is
not detected. Looking more in details, feature/test-bpf.c fails to build
with the following error:

| In file included from /tmp/linux-4.19.12/tools/include/uapi/asm/bitsperlong.h:17,
|                  from /tmp/linux-4.19.12/tools/include/uapi/asm-generic/unistd.h:2,
|                  from /usr/include/riscv64-linux-gnu/asm/unistd.h:1,
|                  from test-bpf.c:2:
| /tmp/linux-4.19.12/tools/include/asm-generic/bitsperlong.h:14:2: error: #error Inconsistent word size. Check asm/bitsperlong.h
|  #error Inconsistent word size. Check asm/bitsperlong.h
|   ^~~~~

The UAPI from the tools directory is missing RISC-V support, therefore
bitsperlong.h from asm-generic is used, defaulting to 32 bits.

Fix that by adding tools/arch/riscv/include/uapi/asm/bitsperlong.h as
a copy of arch/riscv/include/uapi/asm/bitsperlong.h and by updating
tools/include/uapi/asm/bitsperlong.h.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../arch/riscv/include/uapi/asm/bitsperlong.h | 25 +++++++++++++++++++
 tools/include/uapi/asm/bitsperlong.h          |  2 ++
 2 files changed, 27 insertions(+)
 create mode 100644 tools/arch/riscv/include/uapi/asm/bitsperlong.h

diff --git a/tools/arch/riscv/include/uapi/asm/bitsperlong.h b/tools/arch/riscv/include/uapi/asm/bitsperlong.h
new file mode 100644
index 000000000000..0b3cb52fd29d
--- /dev/null
+++ b/tools/arch/riscv/include/uapi/asm/bitsperlong.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2015 Regents of the University of California
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _UAPI_ASM_RISCV_BITSPERLONG_H
+#define _UAPI_ASM_RISCV_BITSPERLONG_H
+
+#define __BITS_PER_LONG (__SIZEOF_POINTER__ * 8)
+
+#include <asm-generic/bitsperlong.h>
+
+#endif /* _UAPI_ASM_RISCV_BITSPERLONG_H */
diff --git a/tools/include/uapi/asm/bitsperlong.h b/tools/include/uapi/asm/bitsperlong.h
index 8dd6aefdafa4..fd92ce8388fc 100644
--- a/tools/include/uapi/asm/bitsperlong.h
+++ b/tools/include/uapi/asm/bitsperlong.h
@@ -13,6 +13,8 @@
 #include "../../arch/mips/include/uapi/asm/bitsperlong.h"
 #elif defined(__ia64__)
 #include "../../arch/ia64/include/uapi/asm/bitsperlong.h"
+#elif defined(__riscv)
+#include "../../arch/riscv/include/uapi/asm/bitsperlong.h"
 #else
 #include <asm-generic/bitsperlong.h>
 #endif
-- 
2.19.1

