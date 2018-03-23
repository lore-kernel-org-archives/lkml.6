Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752383AbeCWXe2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 19:34:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45837 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752053AbeCWXeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 19:34:25 -0400
From: Colin King <colin.king@canonical.com>
To: John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] apparmor: fix error returns checks by making size a ssize_t
Date: Fri, 23 Mar 2018 23:34:22 +0000
Message-Id: <20180323233422.7856-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently variable size is a unsigned size_t, hence comparisons to
see if it is less than zero (for error checking) will always be
false.  Fix this by making size a ssize_t

Detected by CoverityScan, CID#1466080 ("Unsigned compared against 0")

Fixes: 8e51f9087f40 ("apparmor: Add support for attaching profiles via xattr, presence and value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/apparmor/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 57cc892e05a2..590b7e8cd21c 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -314,7 +314,7 @@ static int aa_xattrs_match(const struct linux_binprm *bprm,
 			   struct aa_profile *profile, unsigned int state)
 {
 	int i;
-	size_t size;
+	ssize_t size;
 	struct dentry *d;
 	char *value = NULL;
 	int value_size = 0, ret = profile->xattr_count;
-- 
2.15.1
