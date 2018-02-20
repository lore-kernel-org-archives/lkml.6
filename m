Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x227CYJ6gdREXQjh6pmSPZmeDg3s6XfdUfap02lnG/V4l6F5icYb50qSdODZSGeF9vhCJ2umD
ARC-Seal: i=1; a=rsa-sha256; t=1519093536; cv=none;
        d=google.com; s=arc-20160816;
        b=g0rtgXyEj76VszuzKL4TNjDZuNqmGVj/dnlcv3f8PaCocmk+hBcdh1vzLcjgthYCXO
         FXLxesozyNbfAq+4dC98HHhSN+leKPPz3e5W9gJp+k8c9UqcMWsVzcSqSb760d26s44V
         +ggl8gP7dyepIYFDPXyLyYIhk76vuoKtP+4NOx198LHBcr4BtyDg+3w4W/wOXPynsGlX
         nvp/7YQjMP3JfFfqFignZBvvuSjVFBEv9Mev5ihvj58a96973+pgq8SkvxiRHaMsGV0F
         67RgktFfOMiYiTwRaZpN2Js/pwGNYJ151vwhmj7q2jSolgQKoaoxPbhE9MoDKwIF6SEe
         3Uhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=vgwFwSW/OKw7xLeNnjFeBBmNn/XHOas+Smf14NHGioY=;
        b=IHVrHVsYYuuvpa8o7Q6vcnpW6yZAoThSsycPMnDvltEaRVHdl0cauJrS1ZJlSINI+5
         PJeEKwgE+P0QQkaBc2PFZS3DrqeJJT09LWpiNmEJwICMQOmR9XesgnBrw54HmZE2G2ci
         pTGNXSgCbeNLbP1zQdiTh1adCp44peeQPlVmhWcD9EvAJg2BmpM/bWK3CIzopXJ574OZ
         sILC/9CgKLWhSZ2m1GhvC3eEAPvCpvDC3t4y+wa8TytZumy2UE4g4/T6RX6x8E5NnT52
         k22sYF7xrw26e9Wvn7jj1FtQ0HrVC6PSWG8N/SjwjW0P7yU2cGCnyFCOhLazggrlJAis
         SbsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>, James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 20 Feb 2018 13:23:37 +1100
Subject: [PATCH 11/21] staging: lustre: improve some libcfs_kvzalloc calls.
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151909341790.25814.17500193577187717136.stgit@noble>
In-Reply-To: <151909308778.25814.9912662268627044409.stgit@noble>
References: <151909308778.25814.9912662268627044409.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592885024230452604?=
X-GMAIL-MSGID: =?utf-8?q?1592885024230452604?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Using vmalloc with GFP_NOFS is not supported as vmalloc
performs some internal allocations with GFP_KERNEL.

So in cases where the size passed to libcfs_kvzalloc()
is clearly at most 1 page, convert to kzalloc().
In cases where the call clearly doesn't hold any
filesystem locks, convert to GFP_KERNEL.

Unfortunately there are many more that are not easy to fix.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/llite/dir.c          |    2 +-
 drivers/staging/lustre/lustre/llite/file.c         |    4 ++--
 .../lustre/lustre/obdclass/linux/linux-module.c    |    2 +-
 drivers/staging/lustre/lustre/obdclass/llog.c      |    2 +-
 .../lustre/lustre/obdclass/lustre_handles.c        |    2 +-
 drivers/staging/lustre/lustre/ptlrpc/client.c      |    4 ++--
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/dir.c b/drivers/staging/lustre/lustre/llite/dir.c
index 09e3a4999079..d10d27268323 100644
--- a/drivers/staging/lustre/lustre/llite/dir.c
+++ b/drivers/staging/lustre/lustre/llite/dir.c
@@ -1497,7 +1497,7 @@ static long ll_dir_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (totalsize >= MDS_MAXREQSIZE / 3)
 			return -E2BIG;
 
-		hur = libcfs_kvzalloc(totalsize, GFP_NOFS);
+		hur = kzalloc(totalsize, GFP_NOFS);
 		if (!hur)
 			return -ENOMEM;
 
diff --git a/drivers/staging/lustre/lustre/llite/file.c b/drivers/staging/lustre/lustre/llite/file.c
index 4aad2e331948..002a56793e89 100644
--- a/drivers/staging/lustre/lustre/llite/file.c
+++ b/drivers/staging/lustre/lustre/llite/file.c
@@ -1318,7 +1318,7 @@ static int ll_lov_setea(struct inode *inode, struct file *file,
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	lump = libcfs_kvzalloc(lum_size, GFP_NOFS);
+	lump = kzalloc(lum_size, GFP_NOFS);
 	if (!lump)
 		return -ENOMEM;
 
@@ -2998,7 +2998,7 @@ static int ll_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 	num_bytes = sizeof(*fiemap) + (extent_count *
 				       sizeof(struct fiemap_extent));
-	fiemap = libcfs_kvzalloc(num_bytes, GFP_NOFS);
+	fiemap = kvzalloc(num_bytes, GFP_KERNEL);
 	if (!fiemap)
 		return -ENOMEM;
 
diff --git a/drivers/staging/lustre/lustre/obdclass/linux/linux-module.c b/drivers/staging/lustre/lustre/obdclass/linux/linux-module.c
index 5b1122c408fb..f8967fd44363 100644
--- a/drivers/staging/lustre/lustre/obdclass/linux/linux-module.c
+++ b/drivers/staging/lustre/lustre/obdclass/linux/linux-module.c
@@ -180,7 +180,7 @@ int obd_ioctl_getdata(char **buf, int *len, void __user *arg)
 	 * obdfilter-survey is an example, which relies on ioctl. So we'd
 	 * better avoid vmalloc on ioctl path. LU-66
 	 */
-	*buf = libcfs_kvzalloc(hdr.ioc_len, GFP_NOFS);
+	*buf = libcfs_kvzalloc(hdr.ioc_len, GFP_KERNEL);
 	if (!*buf) {
 		CERROR("Cannot allocate control buffer of len %d\n",
 		       hdr.ioc_len);
diff --git a/drivers/staging/lustre/lustre/obdclass/llog.c b/drivers/staging/lustre/lustre/obdclass/llog.c
index 934f067adb14..ed310696a95d 100644
--- a/drivers/staging/lustre/lustre/obdclass/llog.c
+++ b/drivers/staging/lustre/lustre/obdclass/llog.c
@@ -155,7 +155,7 @@ int llog_init_handle(const struct lu_env *env, struct llog_handle *handle,
 	LASSERT(!handle->lgh_hdr);
 
 	LASSERT(chunk_size >= LLOG_MIN_CHUNK_SIZE);
-	llh = libcfs_kvzalloc(sizeof(*llh), GFP_NOFS);
+	llh = libcfs_kvzalloc(sizeof(*llh), GFP_KERNEL);
 	if (!llh)
 		return -ENOMEM;
 	handle->lgh_hdr = llh;
diff --git a/drivers/staging/lustre/lustre/obdclass/lustre_handles.c b/drivers/staging/lustre/lustre/obdclass/lustre_handles.c
index 2d6da2431a09..9a6377502ae4 100644
--- a/drivers/staging/lustre/lustre/obdclass/lustre_handles.c
+++ b/drivers/staging/lustre/lustre/obdclass/lustre_handles.c
@@ -185,7 +185,7 @@ int class_handle_init(void)
 	LASSERT(!handle_hash);
 
 	handle_hash = libcfs_kvzalloc(sizeof(*bucket) * HANDLE_HASH_SIZE,
-				      GFP_NOFS);
+				      GFP_KERNEL);
 	if (!handle_hash)
 		return -ENOMEM;
 
diff --git a/drivers/staging/lustre/lustre/ptlrpc/client.c b/drivers/staging/lustre/lustre/ptlrpc/client.c
index 3d689d6100bc..781462621d92 100644
--- a/drivers/staging/lustre/lustre/ptlrpc/client.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/client.c
@@ -544,10 +544,10 @@ int ptlrpc_add_rqs_to_pool(struct ptlrpc_request_pool *pool, int num_rq)
 		struct lustre_msg *msg;
 
 		spin_unlock(&pool->prp_lock);
-		req = ptlrpc_request_cache_alloc(GFP_NOFS);
+		req = ptlrpc_request_cache_alloc(GFP_KERNEL);
 		if (!req)
 			return i;
-		msg = libcfs_kvzalloc(size, GFP_NOFS);
+		msg = libcfs_kvzalloc(size, GFP_KERNEL);
 		if (!msg) {
 			ptlrpc_request_cache_free(req);
 			return i;
