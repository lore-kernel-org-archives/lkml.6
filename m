Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751607AbeCPVg1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 17:36:27 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43882 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeCPVgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 17:36:25 -0400
X-Google-Smtp-Source: AG47ELueSBHVDwBkYFBCbtUDeD6iEg4abLS38Aza0Lrl4Wp4izlO7ML4gNt63VCB9Fi59QPPDcnjJw==
From: Shakeel Butt <shakeelb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Greg Thelen <gthelen@google.com>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        John Sperbeck <jsperbeck@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Shakeel Butt <shakeelb@google.com>
Subject: SIGSEGV on OSPKE machine
Date: Fri, 16 Mar 2018 14:36:04 -0700
Message-Id: <20180316213604.167305-1-shakeelb@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The following simple program is producing SIGSEGV on machines which have
X86_FEATURE_OSPKE feature on 4.15 kernel.

#include <sys/mman.h>

int main(int argc, char *argv[])
{
	void *p = mmap(0, 4096, PROT_EXEC, MAP_ANONYMOUS|MAP_PRIVATE,
		       -1, 0);
	mprotect(p, 4096, PROT_NONE);
	mprotect(p, 4096, PROT_READ);
	(void)*(volatile unsigned char *)p;
}

On further inspection it seems like transition from PROT_EXEC to
PROT_NONE leaves the exec-only pkey lingering in the vma flags.  That
is, new_vma_pkey is non-zero in do_mprotect_pkey().  Later, then
enabling PROT_READ, the pkey remains and overrides the normal page
protections.

This change seems to help but is this the right way to solve it?

---
 arch/x86/mm/pkeys.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index d7bc0eea20a5..4a837a220516 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -94,6 +94,10 @@ int __arch_override_mprotect_pkey(struct vm_area_struct *vma, int prot, int pkey
 	 */
 	if (pkey != -1)
 		return pkey;
+
+	if ((prot & (PROT_READ|PROT_WRITE|PROT_EXEC)) == 0)
+		return 0;
+
 	/*
 	 * Look for a protection-key-drive execute-only mapping
 	 * which is now being given permissions that are not
-- 
2.16.2.804.g6dcf76e118-goog
