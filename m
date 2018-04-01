Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbeDAFJt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 01:09:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50904 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbeDAFJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 01:09:48 -0400
From: rao.shoaib@oracle.com
To: linux-kernel@vger.kernel.org
Cc: paulmck@linux.vnet.ibm.com, joe@perches.com, willy@infradead.org,
        brouer@redhat.com, linux-mm@kvack.org,
        Rao Shoaib <rao.shoaib@oracle.com>
Subject: [PATCH 1/1] MACRO_ARG_REUSE in checkpatch.pl is confused about * in typeof
Date: Sat, 31 Mar 2018 22:04:05 -0700
Message-Id: <1522559045-18105-1-git-send-email-rao.shoaib@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8849 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=937
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804010054
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rao Shoaib <rao.shoaib@oracle.com>

Example:

CHECK: Macro argument reuse 'ptr' - possible side-effects?
+#define kfree_rcu(ptr, rcu_name)       \
+       do {                            \
+               unsigned long __off = offsetof(typeof(*(ptr)), rcu_name); \
+               struct rcu_head *__rptr = (void *)ptr + __off; \
+               __kfree_rcu(__rptr, __off); \
+       } while (0)

Fix supplied by Joe Perches.

Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3d40403..def6bb2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4998,7 +4998,7 @@ sub process {
 			        next if ($arg =~ /\.\.\./);
 			        next if ($arg =~ /^type$/i);
 				my $tmp_stmt = $define_stmt;
-				$tmp_stmt =~ s/\b(typeof|__typeof__|__builtin\w+|typecheck\s*\(\s*$Type\s*,|\#+)\s*\(*\s*$arg\s*\)*\b//g;
+				$tmp_stmt =~ s/\b(?:typeof|__typeof__|__builtin\w+|typecheck\s*\(\s*$Type\s*,|\#+)\s*\(*(?:\s*\*\s*)*\s*\(*\s*$arg\s*\)*\b//g;
 				$tmp_stmt =~ s/\#+\s*$arg\b//g;
 				$tmp_stmt =~ s/\b$arg\s*\#\#//g;
 				my $use_cnt = $tmp_stmt =~ s/\b$arg\b//g;
-- 
2.7.4
