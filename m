Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755013AbeDTNT2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:19:28 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.140]:41587 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754903AbeDTNTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:19:21 -0400
X-Authority-Reason: nr=8
Date: Fri, 20 Apr 2018 08:19:19 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <sfrench@samba.org>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] cifs: dir: fix memory leak in cifs_mknod
Message-ID: <20180420131919.GA1766@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.6.211
X-Source-L: No
X-Exim-ID: 1f9Vwe-001SdE-2N
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.175.6.211]:50368
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free allocated memory for full_path and xid before return.

Addresses-Coverity-ID: 1468029 ("Resource leak")
Fixes: 49162bfde140 ("cifs: do not allow creating sockets except with
SMB1 posix exensions")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/cifs/dir.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index f0a759d..71e32d9 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -684,8 +684,11 @@ int cifs_mknod(struct inode *inode, struct dentry *direntry, umode_t mode,
 		goto mknod_out;
 	}
 
-	if (!S_ISCHR(mode) && !S_ISBLK(mode))
+	if (!S_ISCHR(mode) && !S_ISBLK(mode)) {
+		kfree(full_path);
+		free_xid(xid);
 		return -EPERM;
+	}
 
 	if (!(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_UNX_EMUL))
 		goto mknod_out;
-- 
2.7.4
