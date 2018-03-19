Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755650AbeCSOeQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 10:34:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35154 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755629AbeCSOeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 10:34:11 -0400
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, luto@kernel.org,
        x86@kernel.org, jgross@suse.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH] x86/vsyscall/64: Use proper accessor to update p4d entry
Date: Mon, 19 Mar 2018 10:31:54 -0400
Message-Id: <20180319143154.3742-1-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 2.14.3
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8836 signatures=668693
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=5 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=558
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803190149
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Writing to it directly does not work for Xen PV guests.

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/entry/vsyscall/vsyscall_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 8560ef68a9d6..317be365bce3 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -347,7 +347,7 @@ void __init set_vsyscall_pgtable_user_bits(pgd_t *root)
 	set_pgd(pgd, __pgd(pgd_val(*pgd) | _PAGE_USER));
 	p4d = p4d_offset(pgd, VSYSCALL_ADDR);
 #if CONFIG_PGTABLE_LEVELS >= 5
-	p4d->p4d |= _PAGE_USER;
+	set_p4d(p4d, __p4d(p4d_val(*p4d) | _PAGE_USER));
 #endif
 	pud = pud_offset(p4d, VSYSCALL_ADDR);
 	set_pud(pud, __pud(pud_val(*pud) | _PAGE_USER));
-- 
2.14.3
