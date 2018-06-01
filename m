Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbeFAEvn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 00:51:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57886 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbeFAEvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 00:51:42 -0400
MIME-Version: 1.0
Message-ID: <888102f0-fd22-459d-b090-a1bd8a00cb2b@default>
Date: Thu, 31 May 2018 21:51:05 -0700 (PDT)
From: Zhenzhong Duan <zhenzhong.duan@oracle.com>
To: <linux-kernel@vger.kernel.org>
Cc: <mingo@redhat.com>, <tglx@linutronix.de>,
        Srinivas REDDY Eeda <srinivas.eeda@oracle.com>, <bp@alien8.de>,
        <hpa@zytor.com>
Subject: [PATCH] x86/microcode/intel: Fix memleak in save_microcode_patch
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8910 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=724
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806010053
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w514plMD006339

Free useless ucode_patch entry when it's replaced.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
---
 arch/x86/kernel/cpu/microcode/intel.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 1c2cfa0..461e315 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -150,6 +150,12 @@ static bool microcode_matches(struct microcode_header_intel *mc_header,
 	return false;
 }
 
+static void memfree_patch(struct ucode_patch *p)
+{
+	kfree(p->data);
+	kfree(p);
+}
+
 static struct ucode_patch *memdup_patch(void *data, unsigned int size)
 {
 	struct ucode_patch *p;
@@ -190,8 +196,10 @@ static void save_microcode_patch(void *data, unsigned int size)
 			p = memdup_patch(data, size);
 			if (!p)
 				pr_err("Error allocating buffer %p\n", data);
-			else
+			else {
 				list_replace(&iter->plist, &p->plist);
+				memfree_patch(iter);
+			}
 		}
 	}
 
-- 
1.7.1
