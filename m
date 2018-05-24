Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935455AbeEXDim (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 23:38:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39308 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S935171AbeEXDij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 23:38:39 -0400
From: nixiaoming <nixiaoming@huawei.com>
To: <ard.biesheuvel@linaro.org>, <akpm@linux-foundation.org>,
        <yamada.masahiro@socionext.com>, <caoj.fnst@cn.fujitsu.com>,
        <linux@roeck-us.net>, <rostedt@goodmis.org>, <peterz@infradead.org>,
        <jhogan@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <nixiaoming@huawei.com>
Subject: [PATCH] scripts: Fixed printf format mismatch
Date: Thu, 24 May 2018 11:16:12 +0800
Message-ID: <20180524031612.79723-1-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.10.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/kallsyms.c: function write_src:
"printf", the #1 format specifier "d" need arg type "int",
but the according arg "table_cnt" has type "unsigned int"

scripts/recordmcount.c: function do_file:
"fprintf", the #1 format specifier "d" need arg type "int",
but the according arg "(*w2)(ehdr->e_machine)" has type "unsigned int"

scripts/recordmcount.h: function find_secsym_ndx:
"fprintf", the #1 format specifier "d" need arg type "int",
but the according arg "txtndx" has type "unsigned int"

Signed-off-by: nixiaoming <nixiaoming@huawei.com>
---
 scripts/kallsyms.c     | 2 +-
 scripts/recordmcount.c | 2 +-
 scripts/recordmcount.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 5abfbf1..e0c416a 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -424,7 +424,7 @@ static void write_src(void)
 	}
 
 	output_label("kallsyms_num_syms");
-	printf("\tPTR\t%d\n", table_cnt);
+	printf("\tPTR\t%u\n", table_cnt);
 	printf("\n");
 
 	/* table of offset markers, that give the offset in the compressed stream
diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 8c9691c..895c40e 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -500,7 +500,7 @@ do_file(char const *const fname)
 	gpfx = 0;
 	switch (w2(ehdr->e_machine)) {
 	default:
-		fprintf(stderr, "unrecognized e_machine %d %s\n",
+		fprintf(stderr, "unrecognized e_machine %u %s\n",
 			w2(ehdr->e_machine), fname);
 		fail_file();
 		break;
diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index b9897e2..2e77937 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -441,7 +441,7 @@ static unsigned find_secsym_ndx(unsigned const txtndx,
 			return symp - sym0;
 		}
 	}
-	fprintf(stderr, "Cannot find symbol for section %d: %s.\n",
+	fprintf(stderr, "Cannot find symbol for section %u: %s.\n",
 		txtndx, txtname);
 	fail_file();
 }
-- 
2.10.1
