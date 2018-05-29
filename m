Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968266AbeE2WX6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 18:23:58 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38108 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967772AbeE2WQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 18:16:50 -0400
X-Google-Smtp-Source: ADUXVKJS5CvysDkEy0QkV6q0USyKrsWPTa2MmBmwxP8GEol5s464WGLzsWW/Tp/SsHzwzNZMvwWMkg==
From: Thomas Garnier <thgarnie@google.com>
To: kernel-hardening@lists.openwall.com
Cc: Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/27] x86: relocate_kernel - Adapt assembly for PIE support
Date: Tue, 29 May 2018 15:15:06 -0700
Message-Id: <20180529221625.33541-6-thgarnie@google.com>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
In-Reply-To: <20180529221625.33541-1-thgarnie@google.com>
References: <20180529221625.33541-1-thgarnie@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly code to use only relative references of symbols for the
kernel to be PIE compatible.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/kernel/relocate_kernel_64.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 11eda21eb697..a7227dfe1a2b 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -208,9 +208,11 @@ identity_mapped:
 	movq	%rax, %cr3
 	lea	PAGE_SIZE(%r8), %rsp
 	call	swap_pages
-	movq	$virtual_mapped, %rax
-	pushq	%rax
-	ret
+	jmp	*virtual_mapped_addr(%rip)
+
+	/* Absolute value for PIE support */
+virtual_mapped_addr:
+	.quad virtual_mapped
 
 virtual_mapped:
 	movq	RSP(%r8), %rsp
-- 
2.17.0.921.gf22659ad46-goog
