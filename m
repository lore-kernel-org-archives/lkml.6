Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165302AbeE1NSb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:18:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163480AbeE1Ktx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:49:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chengguang Xu <cgxu519@icloud.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 194/496] ceph: fix potential memory leak in init_caches()
Date: Mon, 28 May 2018 11:59:39 +0200
Message-Id: <20180528100328.106815693@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengguang Xu <cgxu519@icloud.com>

[ Upstream commit 1c789249578895bb14ab62b4327306439b754857 ]

There is lack of cache destroy operation for ceph_file_cachep
when failing from fscache register.

Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ceph/super.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -712,14 +712,17 @@ static int __init init_caches(void)
 		goto bad_dentry;
 
 	ceph_file_cachep = KMEM_CACHE(ceph_file_info, SLAB_MEM_SPREAD);
-
 	if (!ceph_file_cachep)
 		goto bad_file;
 
-	if ((error = ceph_fscache_register()))
-		goto bad_file;
+	error = ceph_fscache_register();
+	if (error)
+		goto bad_fscache;
 
 	return 0;
+
+bad_fscache:
+	kmem_cache_destroy(ceph_file_cachep);
 bad_file:
 	kmem_cache_destroy(ceph_dentry_cachep);
 bad_dentry:
