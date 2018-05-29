Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936692AbeE2Ovo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:51:44 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:40199 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936627AbeE2Oqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:46:38 -0400
X-Google-Smtp-Source: ADUXVKKzNyhohHh8NqQst/Bq2V9YmKrnEOkKrzhUAtBVucc6qixMBDvMw8mGK64Z+gTnbCkmK1QSlQ==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/28] ovl: Check redirects for metacopy files
Date: Tue, 29 May 2018 16:46:02 +0200
Message-Id: <20180529144612.16675-19-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144612.16675-1-mszeredi@redhat.com>
References: <20180529144612.16675-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vivek Goyal <vgoyal@redhat.com>

Right now we rely on path based lookup for data origin of metacopy upper.
This will work only if upper has not been renamed.  We solved this problem
already for merged directories using redirect.  Use same logic for metacopy
files.

This patch just goes on to check redirects for metacopy files.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 451cd6effcf6..e38fa61e08df 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -272,7 +272,8 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
 
 		d->metacopy = err;
 		d->stop = !d->metacopy;
-		goto out;
+		if (!d->metacopy || d->last)
+			goto out;
 	} else {
 		if (last_element)
 			d->is_dir = true;
@@ -874,7 +875,6 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		if (upperdentry && !d.is_dir) {
 			unsigned int origin_ctr = 0;
 
-			BUG_ON(d.redirect);
 			/*
 			 * Lookup copy up origin by decoding origin file handle.
 			 * We may get a disconnected dentry, which is fine,
-- 
2.14.3
