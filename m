Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754817AbeEaLZE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:25:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8224 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754757AbeEaLWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:22:43 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: <andy.shevchenko@gmail.com>, Yisheng Xie <xieyisheng1@huawei.com>,
        "Mimi Zohar" <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
Subject: [PATCH v2 13/21] ima: use match_string() helper
Date: Thu, 31 May 2018 19:11:18 +0800
Message-ID: <1527765086-19873-14-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used instead of open coded variant.

Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
v2:
 - add Reviewed-by tag.

 security/integrity/ima/ima_main.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 74d0bd7..f807093 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -61,14 +61,11 @@ static int __init hash_setup(char *str)
 		goto out;
 	}
 
-	for (i = 0; i < HASH_ALGO__LAST; i++) {
-		if (strcmp(str, hash_algo_name[i]) == 0) {
-			ima_hash_algo = i;
-			break;
-		}
-	}
-	if (i == HASH_ALGO__LAST)
+	i = match_string(hash_algo_name, HASH_ALGO__LAST, str);
+	if (i < 0)
 		return 1;
+
+	ima_hash_algo = i;
 out:
 	hash_setup_done = 1;
 	return 1;
-- 
1.7.12.4
