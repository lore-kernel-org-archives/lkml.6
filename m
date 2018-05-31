Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753967AbeEaGsI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 02:48:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52186 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753825AbeEaGsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 02:48:04 -0400
Date: Thu, 31 May 2018 09:47:36 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        NeilBrown <neilb@suse.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] autofs: small cleanup in autofs_getpath()
Message-ID: <20180531064736.lnisb55eajwjynvk@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8909 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1805310076
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't set "*name" so it's slightly nicer to just pass "name" instead
of "&name".

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
index 8c858126c751..f6385c6ef0a5 100644
--- a/fs/autofs/waitq.c
+++ b/fs/autofs/waitq.c
@@ -179,7 +179,7 @@ static void autofs_notify_daemon(struct autofs_sb_info *sbi,
 }
 
 static int autofs_getpath(struct autofs_sb_info *sbi,
-			  struct dentry *dentry, char **name)
+			  struct dentry *dentry, char *name)
 {
 	struct dentry *root = sbi->sb->s_root;
 	struct dentry *tmp;
@@ -189,7 +189,7 @@ static int autofs_getpath(struct autofs_sb_info *sbi,
 	unsigned seq;
 
 rename_retry:
-	buf = *name;
+	buf = name;
 	len = 0;
 
 	seq = read_seqbegin(&rename_lock);
@@ -395,7 +395,7 @@ int autofs_wait(struct autofs_sb_info *sbi,
 	if (IS_ROOT(dentry) && autofs_type_trigger(sbi->type))
 		qstr.len = sprintf(name, "%p", dentry);
 	else {
-		qstr.len = autofs_getpath(sbi, dentry, &name);
+		qstr.len = autofs_getpath(sbi, dentry, name);
 		if (!qstr.len) {
 			kfree(name);
 			return -ENOENT;
