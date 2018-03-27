Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752735AbeC0NgG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:36:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45800 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752279AbeC0NgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:36:00 -0400
From: Colin King <colin.king@canonical.com>
To: John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH][next] apparmor: fix memory leak on buffer on error exit path
Date: Tue, 27 Mar 2018 14:35:58 +0100
Message-Id: <20180327133558.13072-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently on the error exit path the allocated buffer is not free'd
causing a memory leak. Fix this by kfree'ing it.

Detected by CoverityScan, CID#1466876 ("Resource leaks")

Fixes: 1180b4c757aa ("apparmor: fix dangling symlinks to policy rawdata after replacement")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/apparmor/apparmorfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 96bb6b73af65..949dd8a48164 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -1497,8 +1497,10 @@ static char *gen_symlink_name(int depth, const char *dirname, const char *fname)
 	}
 
 	error = snprintf(s, size, "raw_data/%s/%s", dirname, fname);
-	if (error >= size || error < 0)
+	if (error >= size || error < 0) {
+		kfree(buffer);
 		return ERR_PTR(-ENAMETOOLONG);
+	}
 
 	return buffer;
 }
-- 
2.15.1
