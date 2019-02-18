Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCE8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B8F20838
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500872;
	bh=OBx6JNLa1hI9LhRWfyQlJpPEvT3oLoGwM0s0EDpCPXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RzWgy+K5adYmGr9XzFf00ZsYRQIGF1fpZbPSF4LeRokP5z0+3BoFDun6+YQPUo9GX
	 DbGIJLxPIQ+1WGmt56U6JpiefRlzZm7SFKjAug9v03GGx/9FCInD3j9zeDY1wvQ0NG
	 NcMeEA0XS2iIdqq+MPtw1KDTgM4Er0oKq1f6qCps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387771AbfBROlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:41:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:59342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731491AbfBRNv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:51:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4F1D20449;
        Mon, 18 Feb 2019 13:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497888;
        bh=OBx6JNLa1hI9LhRWfyQlJpPEvT3oLoGwM0s0EDpCPXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zCPo3ROWTTOO6dZcywjnk4uKIRCUEsjYKPxTQWr38gId3tGyQDw2MfZHH/7+iNCDk
         Dtg9WxrB1wnR/iQRhZaJrLbhS9nymyzcjDMHp6aQFddQsvtpy5B0ExxSGlONV/YQOR
         BIRb4koGxBf/xWAiyudNiWviA9hK9jjwyhp0Jiso=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aurelien Jarno <aurelien@aurel32.net>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 25/85] tools uapi: fix RISC-V 64-bit support
Date:   Mon, 18 Feb 2019 14:42:51 +0100
Message-Id: <20190218133502.381996968@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



