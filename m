Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751734AbeBYO0C (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 09:26:02 -0500
Received: from mr11p00im-asmtp003.me.com ([17.110.69.254]:46825 "EHLO
        mr11p00im-asmtp003.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751590AbeBYO0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 09:26:01 -0500
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2018-02-25_05:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1011 suspectscore=3 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1802250180
From: Chengguang Xu <cgxu519@icloud.com>
To: jack@suse.cz
Cc: linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@icloud.com>
Subject: [PATCH] udf: fix potential refcnt problem of nls module
Date: Sun, 25 Feb 2018 21:25:07 +0800
Message-id: <1519565107-213857-1-git-send-email-cgxu519@icloud.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When specifiying iocharset multiple times in a mount
or once/multiple in a remount, current option parsing
may cause inaccurate refcount of nls module.
Also, in the failure cleanup of option parsing,
the condition of calling unload_nls is not sufficient.

Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
---

Hi Jan,

I found this issue by checking code so now post the fix for rewiew,
but sorry I did't get enough resource to fully test it, I can only
make sure the fix can successfuly comiple with no error.

 fs/udf/super.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 7b27b06..7e73a98 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -523,8 +523,12 @@ static int udf_parse_options(char *options, struct udf_options *uopt,
 			break;
 #ifdef CONFIG_UDF_NLS
 		case Opt_iocharset:
-			uopt->nls_map = load_nls(args[0].from);
-			uopt->flags |= (1 << UDF_FLAG_NLS_MAP);
+			if (!remount) {
+				if (uopt->nls_map)
+					unload_nls(uopt->nls_map);
+				uopt->nls_map = load_nls(args[0].from);
+				uopt->flags |= (1 << UDF_FLAG_NLS_MAP);
+			}
 			break;
 #endif
 		case Opt_uignore:
@@ -2082,8 +2086,8 @@ error_out:
 		for (i = 0; i < sbi->s_partitions; i++)
 			udf_free_partition(&sbi->s_partmaps[i]);
 #ifdef CONFIG_UDF_NLS
-	if (UDF_QUERY_FLAG(sb, UDF_FLAG_NLS_MAP))
-		unload_nls(sbi->s_nls_map);
+	if (uopt.nls_map)
+		unload_nls(uopt.nls_map);
 #endif
 	if (!(sb->s_flags & MS_RDONLY))
 		udf_close_lvid(sb);
-- 
1.8.3.1
