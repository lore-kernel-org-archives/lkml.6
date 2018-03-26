Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbeCZXcF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 19:32:05 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36602 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeCZXcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 19:32:03 -0400
X-Google-Smtp-Source: AG47ELvpkDPjG/B21sdxwD8NdkPml3HGIpe7HoY9LWsnbHL5gj/WS6nBVTae39qNi1qs/baw9xi+8A==
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
        aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
        hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
        linuxram@us.ibm.com, fweimer@redhat.com, msuchanek@suse.com,
        tglx@linutronix.de, shuah@kernel.org
Subject: [PATCH] powerpc, pkey: make protection key 0 less special
Date: Mon, 26 Mar 2018 16:31:41 -0700
Message-Id: <1522107101-16083-1-git-send-email-linuxram@us.ibm.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applications need the ability to associate an address-range with some
key and latter revert to its initial default key. Pkey-0 comes close to
providing this function but falls short, because the current
implementation disallows applications to explicitly associate pkey-0 to
the address range.

Lets make pkey-0 less special and treat it almost like any other key.
Thus it can be explicitly associated with any address range, and can be
freed. This gives the application more flexibility and power.  The
ability to free pkey-0 must be used responsibily, since pkey-0 is
associated with almost all address-range by default.

Even with this change pkey-0 continues to be slightly more special
from the following point of view.
(a) it is implicitly allocated.
(b) it is the default key assigned to any address-range.

Tested on powerpc.

cc: Thomas Gleixner <tglx@linutronix.de>
cc: Dave Hansen <dave.hansen@intel.com>
cc: Michael Ellermen <mpe@ellerman.id.au>
cc: Ingo Molnar <mingo@kernel.org>
cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/pkeys.h | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 0409c80..9c7d3bd 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -101,10 +101,18 @@ static inline u16 pte_to_pkey_bits(u64 pteflags)
 
 static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
 {
-	/* A reserved key is never considered as 'explicitly allocated' */
-	return ((pkey < arch_max_pkey()) &&
-		!__mm_pkey_is_reserved(pkey) &&
-		__mm_pkey_is_allocated(mm, pkey));
+	/* pkey 0 is allocated by default. */
+	if (!pkey)
+		return true;
+
+	if (pkey < 0 || pkey >= arch_max_pkey())
+		return false;
+
+	/* Reserved keys are never allocated. */
+	if (__mm_pkey_is_reserved(pkey))
+		return false;
+
+	return __mm_pkey_is_allocated(mm, pkey);
 }
 
 extern void __arch_activate_pkey(int pkey);
@@ -200,6 +208,14 @@ static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 {
 	if (static_branch_likely(&pkey_disabled))
 		return -EINVAL;
+
+	/*
+	 * userspace is discouraged from changing permissions of
+	 * pkey-0. powerpc hardware does not support it anyway.
+	 */
+	if (!pkey)
+		return init_val ? -EINVAL : 0;
+
 	return __arch_set_user_pkey_access(tsk, pkey, init_val);
 }
 
-- 
1.8.3.1
