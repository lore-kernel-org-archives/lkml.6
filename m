Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbeCNVBB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 17:01:01 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45931 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbeCNVA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 17:00:56 -0400
X-Google-Smtp-Source: AG47ELvqa5JEHFzQbPGUK0Ng1kW6BFIg0pnTQBjL9W+n4zzQUNs4AlX5LozhkfsCyfT6b8qpX3F1Tw==
From: Ram Pai <linuxram@us.ibm.com>
To: mingo@redhat.com
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
        linuxram@us.ibm.com, corbet@lwn.net, arnd@arndb.de, fweimer@redhat.com,
        msuchanek@suse.com, Ulrich.Weigand@de.ibm.com
Subject: [PATCH v3] x86: treat pkey-0 special
Date: Wed, 14 Mar 2018 14:00:14 -0700
Message-Id: <1521061214-22385-1-git-send-email-linuxram@us.ibm.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applications need the ability to associate an address-range with some
key and latter revert to its initial default key. Pkey-0 comes close to
providing this function but falls short, because the current
implementation disallows applications to explicitly associate pkey-0 to
the address range.

This patch clarifies the semantics of pkey-0 and provides the
corresponding implementation on powerpc.

Pkey-0 is special with the following semantics.
(a) it is implicitly allocated and can never be freed. It always exists.
(b) it is the default key assigned to any address-range.
(c) it can be explicitly associated with any address-range.

Tested on x86_64.

History:
    v3 : added clarification of the semantics of pkey0.
    		-- suggested by Dave Hansen
    v2 : split the patch into two, one for x86 and one for powerpc
    		-- suggested by Michael Ellermen

cc: Dave Hansen <dave.hansen@intel.com>
cc: Michael Ellermen <mpe@ellerman.id.au>
cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/x86/include/asm/pkeys.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index a0ba1ff..6ea7486 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -52,7 +52,7 @@ bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
 	 * from pkey_alloc().  pkey 0 is special, and never
 	 * returned from pkey_alloc().
 	 */
-	if (pkey <= 0)
+	if (pkey < 0)
 		return false;
 	if (pkey >= arch_max_pkey())
 		return false;
@@ -92,7 +92,8 @@ int mm_pkey_alloc(struct mm_struct *mm)
 static inline
 int mm_pkey_free(struct mm_struct *mm, int pkey)
 {
-	if (!mm_pkey_is_allocated(mm, pkey))
+	/* pkey 0 is special and can never be freed */
+	if (!pkey || !mm_pkey_is_allocated(mm, pkey))
 		return -EINVAL;
 
 	mm_set_pkey_free(mm, pkey);
-- 
1.8.3.1
