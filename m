Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932997AbeEHPBO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 11:01:14 -0400
Received: from ozlabs.org ([203.11.71.1]:44627 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932765AbeEHO77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 10:59:59 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxram@us.ibm.com
Cc: mingo@redhat.com, linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com
Subject: [PATCH 3/8] mm/pkeys: Remove include of asm/mmu_context.h from pkeys.h
Date: Wed,  9 May 2018 00:59:43 +1000
Message-Id: <20180508145948.9492-4-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180508145948.9492-1-mpe@ellerman.id.au>
References: <20180508145948.9492-1-mpe@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to unify the pkey handling in show_smap() between x86 and
powerpc we stumbled across various build failures due to the order of
includes between the two arches.

Part of the problem is that linux/pkeys.h includes asm/mmu_context.h,
and the relationship between asm/mmu_context.h and asm/pkeys.h is not
consistent between the two arches.

It would be cleaner if linux/pkeys.h only included asm/pkeys.h,
creating a single integration point for the arch pkey definitions.

So this patch removes the include of asm/mmu_context.h from
linux/pkeys.h.

We can't prove that this is safe in the general case, but it passes
all the build tests I've thrown at it. Also asm/mmu_context.h is
included widely while linux/pkeys.h is not, so most likely any code
that is including linux/pkeys.h is already getting asm/mmu_context.h
from elsewhere.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 include/linux/pkeys.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index 0794ca78c379..ed06e1a67bfa 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -3,7 +3,6 @@
 #define _LINUX_PKEYS_H
 
 #include <linux/mm_types.h>
-#include <asm/mmu_context.h>
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
 #include <asm/pkeys.h>
-- 
2.14.1
