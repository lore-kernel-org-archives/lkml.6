Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423075AbeE1MIw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:08:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423063AbeE1LE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:04:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        PaX Team <pageexec@freemail.hu>, Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.16 025/272] arm64: export tishift functions to modules
Date: Mon, 28 May 2018 12:00:58 +0200
Message-Id: <20180528100242.726561940@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason A. Donenfeld <Jason@zx2c4.com>

commit 255845fc43a3aaf806852a1d3bc89bff1411ebe3 upstream.

Otherwise modules that use these arithmetic operations will fail to
link. We accomplish this with the usual EXPORT_SYMBOL, which on most
architectures goes in the .S file but the ARM64 maintainers prefer that
insead it goes into arm64ksyms.

While we're at it, we also fix this up to use SPDX, and I personally
choose to relicense this as GPL2||BSD so that these symbols don't need
to be export_symbol_gpl, so all modules can use the routines, since
these are important general purpose compiler-generated function calls.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Reported-by: PaX Team <pageexec@freemail.hu>
Cc: stable@vger.kernel.org
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/arm64ksyms.c |    8 ++++++++
 arch/arm64/lib/tishift.S       |   15 ++-------------
 2 files changed, 10 insertions(+), 13 deletions(-)

--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -75,3 +75,11 @@ NOKPROBE_SYMBOL(_mcount);
 	/* arm-smccc */
 EXPORT_SYMBOL(__arm_smccc_smc);
 EXPORT_SYMBOL(__arm_smccc_hvc);
+
+	/* tishift.S */
+extern long long __ashlti3(long long a, int b);
+EXPORT_SYMBOL(__ashlti3);
+extern long long __ashrti3(long long a, int b);
+EXPORT_SYMBOL(__ashrti3);
+extern long long __lshrti3(long long a, int b);
+EXPORT_SYMBOL(__lshrti3);
--- a/arch/arm64/lib/tishift.S
+++ b/arch/arm64/lib/tishift.S
@@ -1,17 +1,6 @@
-/*
- * Copyright (C) 2017 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ * Copyright (C) 2017-2018 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  */
 
 #include <linux/linkage.h>
