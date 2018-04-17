Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbeDQIX1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 04:23:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33550 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752609AbeDQIVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 04:21:14 -0400
From: Thomas Richter <tmricht@linux.ibm.com>
To: jeyu@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc: borntraeger@de.ibm.com, schwidefsky@de.ibm.com,
        brueckner@linux.vnet.ibm.com, heiko.carstens@de.ibm.com,
        peterz@infradead.org, acme@kernel.org, me@tobin.cc,
        keescook@chromium.org, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] modules: Fix display of wrong  module .text address
Date: Tue, 17 Apr 2018 10:20:54 +0200
X-Mailer: git-send-email 2.13.5
X-TM-AS-GCONF: 00
x-cbid: 18041708-0012-0000-0000-000005CBB89C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041708-0013-0000-0000-0000194801A6
Message-Id: <20180417082054.26978-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170075
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel v4.16.0 the module .text address is displayed
wrong when using /sys/module/*/sections/.text file.
Commit ef0010a30935 ("vsprintf: don't use 'restricted_pointer()' when
not restricting")
is the first bad commit.

Here is the issue, using module qeth_l2 on s390 which is the
ethernet device driver:

[root@s35lp76 ~]# lsmod
Module                  Size  Used by
qeth_l2                94208  1
...

[root@s35lp76 ~]# cat /proc/modules | egrep '^qeth_l2'
qeth_l2 94208 1 - Live 0x000003ff80401000
                       ^ This is the correct address in memory
[root@s35lp76 ~]# cat /sys/module/qeth_l2/sections/.text
0x0000000018ea8363      <---- This is a wrong address
[root@s35lp76 ~]#

This breaks the perf tool which uses this address on s390
to calculate start of .text section in memory.

Fix this by printing the correct (unhashed) address.

Thanks to Jessica Yu for helping on this.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Jessica Yu <jeyu@kernel.org>
---
 kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index a6e43a5806a1..77ab7211ddef 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1472,7 +1472,7 @@ static ssize_t module_sect_show(struct module_attribute *mattr,
 {
 	struct module_sect_attr *sattr =
 		container_of(mattr, struct module_sect_attr, mattr);
-	return sprintf(buf, "0x%pK\n", (void *)sattr->address);
+	return sprintf(buf, "%#lx\n", kptr_restrict < 2 ? sattr->address : 0);
 }
 
 static void free_sect_attrs(struct module_sect_attrs *sect_attrs)
-- 
2.14.3
