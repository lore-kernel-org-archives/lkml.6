Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752293AbeBBPAU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:00:20 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:51639 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbeBBPAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:00:13 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kdb: use memmove instead of overlapping memcpy
Date: Fri,  2 Feb 2018 15:59:40 +0100
Message-Id: <20180202145952.285505-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:SubtK34vEUDc40i3yM+YiUxps2AqvTjFoJI2E+eKnuXTdFr1/et
 XbXaA1winbsP2TXTbsPES/SqobfFmOyFkr3tiFo0T//cHYip+hFoaOB4wOpEPB8YPqitFRo
 sjbkU3U9zsfstUfWSoYDBHhnkaudJEP/CYDyA3wnxvgkjSkdRTiH+BhI/bxT+x/MPvcL3CE
 fJEkCWDtDqKrtuozRPhiw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:A+JeHXP8Sro=:hYNGjcWM9negGh/4a6VPLt
 2V2CL/k1OQyICv5WnEwfLJ/mtUQyU+skqoYlp0QRO6F3bjsu4DtKqgZRgYo3w1kPjfw2SxzYX
 oMVNjPozb75hOqxkgZnk/gyWCiQxGdOVLPzkj4gqqHP2lSHFIxTefR5f6GUBAw5ZpAuiymirO
 tcYeaMO/HyhjIgAnJODgBrURFu7iCZHA/6bE67jE7xpEQ21MpJJ055OV0XZZ5wAwBQ//bSqGr
 R4OFD6un2jk6RsYj0jg1pPxCRoFG77iqHW6LLuKF2fLSzsMR9Zf6+JMkyu2rKvpDohyreLRyc
 BkRk+QSJTWE+CQs6zGK+L5lrL8qg1tSSzVU49xlNRMkXuqmuwCHzc9CguX/ttJyBBXJIGA99u
 XdMqOJ+6vmGordLQgK4oKHBoSe3C0x4KZhNuSxuajE/pvDPN2z8TAHYMiN3Azwsv9a1z4+kVG
 FeywOKnM2Mad9Ib5IKNXAi8BDcJxV8VL1bEfuuVNL/8PUfko0Q4B1qaEGDNSO8F4w5aucqdMP
 xayzvpCbdfRiO13uejhvcQHInR1tnJuDs5JDC+hgLsbLrLNTMhGn+ObCba+6Vf+60rBgnSqhB
 uTa91zU+xB0oRqD3sCkCnctoE4Fa8PYCkWmpBD/IvUG4Of7Z4lmXMo4GdcceAFiDWfyKmx5z3
 DAS4BZjpObA8TjUukJ8/esmclWAXLjWyij2/98sgLdykqpcXnQhP7DZn5+jyR4iXxZGZJKOkS
 emwv7FEkWFXAsbDVVwzU9Rjo6jvPgFqV+9ONEQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc discovered that the memcpy() arguments in kdbnearsym() overlap, so
we should really use memmove(), which is defined to handle that correctly:

In function 'memcpy',
    inlined from 'kdbnearsym' at /git/arm-soc/kernel/debug/kdb/kdb_support.c:132:4:
/git/arm-soc/include/linux/string.h:353:9: error: '__builtin_memcpy' accessing 792 bytes at offsets 0 and 8 overlaps 784 bytes at offset 8 [-Werror=restrict]
  return __builtin_memcpy(p, q, size);

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/debug/kdb/kdb_support.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
index 5d8ef3a07ecd..1ad4370ccbf0 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -129,13 +129,13 @@ int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
 		}
 		if (i >= ARRAY_SIZE(kdb_name_table)) {
 			debug_kfree(kdb_name_table[0]);
-			memcpy(kdb_name_table, kdb_name_table+1,
+			memmove(kdb_name_table, kdb_name_table+1,
 			       sizeof(kdb_name_table[0]) *
 			       (ARRAY_SIZE(kdb_name_table)-1));
 		} else {
 			debug_kfree(knt1);
 			knt1 = kdb_name_table[i];
-			memcpy(kdb_name_table+i, kdb_name_table+i+1,
+			memmove(kdb_name_table+i, kdb_name_table+i+1,
 			       sizeof(kdb_name_table[0]) *
 			       (ARRAY_SIZE(kdb_name_table)-i-1));
 		}
-- 
2.9.0
