Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbeDJIpO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 04:45:14 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:52357 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbeDJIpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 04:45:13 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86: fix pgprotval_t format string
Date: Tue, 10 Apr 2018 10:43:59 +0200
Message-Id: <20180410084424.2935759-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:1J/aaDM8sDWqhnDWhngKSfnGxmn0UlwaYwCUl6VEcovJCdEe4C+
 Qj5t244DqScTPZ8aEgSn0ECm8bdF+MZ9Xqmq6NAWFdCuRUG3AcHSFh7svvzM56JjQSEy2vv
 fcRk/34TidjKHXPd9VcPAR5xZUW0XoOQ1UrAE61ptRx8fd+xZZz9xgvbp7kZRwmSx+mnGGq
 AaUWUvFeKj4kmPkbwsJ8g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:s6kauKlWo9E=:gbEtbOY5TV6rVY7RFRcA4P
 7m/M6gOvdtVlP/vxxL8e+z0041yje5WgSRi/0yblTLiY6HzRp6Ib8YcsZxAN2No2lSKnIKVPL
 teuD/OtXeLmujrvynv3wzjVsZMYedf/gBJ8U1CQE8MdvHdYS80UTAY/ood7BQlDDn2WnQmhfD
 g2QP9XcDZIgtJQZ4ZMILI9tmGstD0t2bBvtnjmS2zKxM7qH7YU04etJxsXOxfpYmQ9skxwQG9
 B6+wZM2UahYfSAK23rS2NTSEKex7UBOJ3ZHoiiaD/ZOGnZDk5KvbOWpPSXbXPuBDwON5rg9yW
 FU9Ms5Sp2+vnIx6qaM4uwcrPfv5E57Rous7zbbOyscKZXZ14G7khASdllSlHoVxdSK741KDMe
 HBGs1VbFDr+pO24Yl46yhQh9p8Kjmnh1jatBrVayFb8bxtFEl1agqkdhGxEVOsPes1kYD3Yfj
 65EMsrV6YHTQj9rjoVbd88bEULdkkhgwsslj+UWWqsjq0W2LlhJ7nirvvjC9BMgmz+NErTA8o
 dXWhJVF+/WHP69jSi2Wl2gZGtgPfBDVI/+r/ia3LrXSkog10kVP0HjDvegwoRrSe0qIipdf91
 /9+zyRNvQgOifeYjg5YQ1Uz7BeH6WeUNwUqUUgvAmsPVQXP2WrvyI26v11hiJ/xvJ8Zdgqvs8
 Dt4ZOHxoFh0tmWOG3+Te0XaFEyPovXW61shKLiWqlzpuIP3nb1vnkp2AeUr4XEmqx7UJeZ99t
 MptFeyP+o2dDrnSAdM4GPhVCmM7z3jdYn2VJsg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bit builds, pgprotval_t can be either 32-bit or 64-bit wide depending
on the page table layout. In the latter case, we now get a build warning:

In file included from arch/x86/include/asm/bug.h:83,
                 from include/linux/bug.h:5,
                 from include/linux/crypto.h:23,
                 from arch/x86/kernel/asm-offsets.c:9:
arch/x86/include/asm/pgtable.h: In function 'check_pgprot':
arch/x86/include/asm/pgtable.h:536:5: error: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'pgprotval_t' {aka 'long long unsigned int'} [-Werror=format=]

To work around the problem, we can always print the value as a u64,
and add the respective cast.

Fixes: 64c80759408f ("x86/mm: Do not auto-massage page protections")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/pgtable.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 50b207289ae1..5f49b4ff0c24 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -533,11 +533,11 @@ static inline pgprotval_t check_pgprot(pgprot_t pgprot)
 	/* mmdebug.h can not be included here because of dependencies */
 #ifdef CONFIG_DEBUG_VM
 	WARN_ONCE(pgprot_val(pgprot) != massaged_val,
-		  "attempted to set unsupported pgprot: %016lx "
-		  "bits: %016lx supported: %016lx\n",
-		  pgprot_val(pgprot),
-		  pgprot_val(pgprot) ^ massaged_val,
-		  __supported_pte_mask);
+		  "attempted to set unsupported pgprot: %016llx "
+		  "bits: %016llx supported: %016llx\n",
+		  (u64)pgprot_val(pgprot),
+		  (u64)pgprot_val(pgprot) ^ massaged_val,
+		  (u64)__supported_pte_mask);
 #endif
 
 	return massaged_val;
-- 
2.9.0
