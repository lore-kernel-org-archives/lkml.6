Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbeBSGkO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 01:40:14 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:42735 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbeBSGkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 01:40:13 -0500
X-Google-Smtp-Source: AH8x227XtfvzL36TZqVOeyrwhqRh3BVwIy1vii+2FFNUFaIVhVM+zvl1d5btSxMWK1etZ2m3jLEqQw==
From: Bhupesh Sharma <bhsharma@redhat.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: bhsharma@redhat.com, bhupesh.linux@gmail.com
Subject: [PATCH] arm64: Fix compilation error while accessing MPIDR_HWID_BITMASK from .S files
Date: Mon, 19 Feb 2018 12:09:54 +0530
Message-Id: <1519022394-11326-1-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit e1a50de37860b3a93a9d643b09638db5aff47650 (arm64: cputype:
Silence Sparse warnings), compilation of arm64 architecture is broken
with the following error messages:

  AR      arch/arm64/kernel/built-in.o
  arch/arm64/kernel/head.S: Assembler messages:
  arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
  arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
  arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
  arch/arm64/kernel/head.S:677: Error: junk at end of line, first
  unrecognized character is `L'
  arch/arm64/kernel/head.S:677: Error: unexpected characters following
  instruction at operand 2 -- `movz x1,:abs_g1_s:0xff00ffffffUL'
  arch/arm64/kernel/head.S:677: Error: unexpected characters following
  instruction at operand 2 -- `movk x1,:abs_g0_nc:0xff00ffffffUL'

This patch fixes the same by using the UL() macro correctly for
assigning the MPIDR_HWID_BITMASK macro value.

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 arch/arm64/include/asm/cputype.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index eda8c5f629fc..350c76a1d15b 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -20,7 +20,7 @@
 
 #define MPIDR_UP_BITMASK	(0x1 << 30)
 #define MPIDR_MT_BITMASK	(0x1 << 24)
-#define MPIDR_HWID_BITMASK	0xff00ffffffUL
+#define MPIDR_HWID_BITMASK	UL(0xff00ffffff)
 
 #define MPIDR_LEVEL_BITS_SHIFT	3
 #define MPIDR_LEVEL_BITS	(1 << MPIDR_LEVEL_BITS_SHIFT)
-- 
2.7.4
