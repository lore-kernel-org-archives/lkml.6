Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvZiUWDoF74rOQhIaInbjTHksp0wZn/Ws4Ra3g75tp/JWMs9OTN5mSo3UPULwm5Rpm6p+R+
ARC-Seal: i=1; a=rsa-sha256; t=1520955269; cv=none;
        d=google.com; s=arc-20160816;
        b=0OZfv/f8DNqKnlYg79l7YuxlZbMUwzg+M2n3aqL35a1QV31V2c1KOTG2rZjC4srBJQ
         69QIb5Id3Vc/9Gi+gkkKkwCEnvYs4ZdTIwJJCoPHu7i+4JuD2i8a2xV0hPntbXy9xb+g
         NtQrDAUGzTXuWorfOXhQejTM81sZi/Kuu6ZrHv8QvMitKOqIzdPC736Mc16UxjDxIPnB
         2vF1vpmtShYt/cLli6KeexP+2P7OJWDCy0G8FC2O7nqsPAdJJgkus3Uue89uBZicojT0
         0QyjZqF2UukcC/b3OJOevx0GSH4OemONK9+VHY7kcM3A7aAciAqgDKn+Fi2qkksTowge
         yMAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VPuwkOsvHtT5dY4Z2qhSiVHQOrvvmLRP9WScoONf+y8=;
        b=MU3Bb/JVnActWk/Z2HrLoXCKgGnpYFFyY80Z34ejd+p74FSkvTOsrVfLeyXvOSejJg
         9KpF38fguYx3k5/WnKhVY37Ei3w47ZTVN3v4OHhQHquFqLu3rvun3dY49CdOgTpHoPP3
         6FjzGYb9Q7JWN7jXsUvfrW1H8M6K02cuLfyiEt+Zg+0t3XjYrJH2DRIsN11b+WsKP7dO
         mmJSApm0WT0i8dO+/mhncjAwBdryhoeuiP1+Y1afTO7bnVu8ftSMcnwOd/LGfCwp/R6x
         LmnR0OyUt9pzhlYmgIPC9YMwN3id5CW4Lo5nDijaYJ2YqNXEnpnuWvFoXrRH3G6czqFF
         3VcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Scott Mayhew <smayhew@redhat.com>,
	Trond Myklebust <trond.myklebust@primarydata.com>
Subject: [PATCH 4.15 146/146] NFS: Fix unstable write completion
Date: Tue, 13 Mar 2018 16:25:13 +0100
Message-Id: <20180313152331.331679814@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837192650127949?=
X-GMAIL-MSGID: =?utf-8?q?1594837192650127949?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@primarydata.com>

commit c4f24df942a181699c5bab01b8e5e82b925f77f3 upstream.

We do want to respect the FLUSH_SYNC argument to nfs_commit_inode() to
ensure that all outstanding COMMIT requests to the inode in question are
complete. Currently we may exit early from both nfs_commit_inode() and
nfs_write_inode() even if there are COMMIT requests in flight, or unstable
writes on the commit list.

In order to get the right semantics w.r.t. sync_inode(), we don't need
to have nfs_commit_inode() reset the inode dirty flags when called from
nfs_wb_page() and/or nfs_wb_all(). We just need to ensure that
nfs_write_inode() leaves them in the right state if there are outstanding
commits, or stable pages.

Reported-by: Scott Mayhew <smayhew@redhat.com>
Fixes: dc4fd9ab01ab ("nfs: don't wait on commit in nfs_commit_inode()...")
Cc: stable@vger.kernel.org # v4.14+
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/write.c |   83 +++++++++++++++++++++++++++++----------------------------
 1 file changed, 43 insertions(+), 40 deletions(-)

--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1878,40 +1878,43 @@ int nfs_generic_commit_list(struct inode
 	return status;
 }
 
-int nfs_commit_inode(struct inode *inode, int how)
+static int __nfs_commit_inode(struct inode *inode, int how,
+		struct writeback_control *wbc)
 {
 	LIST_HEAD(head);
 	struct nfs_commit_info cinfo;
 	int may_wait = how & FLUSH_SYNC;
-	int error = 0;
-	int res;
+	int ret, nscan;
 
 	nfs_init_cinfo_from_inode(&cinfo, inode);
 	nfs_commit_begin(cinfo.mds);
-	res = nfs_scan_commit(inode, &head, &cinfo);
-	if (res)
-		error = nfs_generic_commit_list(inode, &head, how, &cinfo);
+	for (;;) {
+		ret = nscan = nfs_scan_commit(inode, &head, &cinfo);
+		if (ret <= 0)
+			break;
+		ret = nfs_generic_commit_list(inode, &head, how, &cinfo);
+		if (ret < 0)
+			break;
+		ret = 0;
+		if (wbc && wbc->sync_mode == WB_SYNC_NONE) {
+			if (nscan < wbc->nr_to_write)
+				wbc->nr_to_write -= nscan;
+			else
+				wbc->nr_to_write = 0;
+		}
+		if (nscan < INT_MAX)
+			break;
+		cond_resched();
+	}
 	nfs_commit_end(cinfo.mds);
-	if (res == 0)
-		return res;
-	if (error < 0)
-		goto out_error;
-	if (!may_wait)
-		goto out_mark_dirty;
-	error = wait_on_commit(cinfo.mds);
-	if (error < 0)
-		return error;
-	return res;
-out_error:
-	res = error;
-	/* Note: If we exit without ensuring that the commit is complete,
-	 * we must mark the inode as dirty. Otherwise, future calls to
-	 * sync_inode() with the WB_SYNC_ALL flag set will fail to ensure
-	 * that the data is on the disk.
-	 */
-out_mark_dirty:
-	__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
-	return res;
+	if (ret || !may_wait)
+		return ret;
+	return wait_on_commit(cinfo.mds);
+}
+
+int nfs_commit_inode(struct inode *inode, int how)
+{
+	return __nfs_commit_inode(inode, how, NULL);
 }
 EXPORT_SYMBOL_GPL(nfs_commit_inode);
 
@@ -1921,11 +1924,11 @@ int nfs_write_inode(struct inode *inode,
 	int flags = FLUSH_SYNC;
 	int ret = 0;
 
-	/* no commits means nothing needs to be done */
-	if (!atomic_long_read(&nfsi->commit_info.ncommit))
-		return ret;
-
 	if (wbc->sync_mode == WB_SYNC_NONE) {
+		/* no commits means nothing needs to be done */
+		if (!atomic_long_read(&nfsi->commit_info.ncommit))
+			goto check_requests_outstanding;
+
 		/* Don't commit yet if this is a non-blocking flush and there
 		 * are a lot of outstanding writes for this mapping.
 		 */
@@ -1936,16 +1939,16 @@ int nfs_write_inode(struct inode *inode,
 		flags = 0;
 	}
 
-	ret = nfs_commit_inode(inode, flags);
-	if (ret >= 0) {
-		if (wbc->sync_mode == WB_SYNC_NONE) {
-			if (ret < wbc->nr_to_write)
-				wbc->nr_to_write -= ret;
-			else
-				wbc->nr_to_write = 0;
-		}
-		return 0;
-	}
+	ret = __nfs_commit_inode(inode, flags, wbc);
+	if (!ret) {
+		if (flags & FLUSH_SYNC)
+			return 0;
+	} else if (atomic_long_read(&nfsi->commit_info.ncommit))
+		goto out_mark_dirty;
+
+check_requests_outstanding:
+	if (!atomic_read(&nfsi->commit_info.rpcs_out))
+		return ret;
 out_mark_dirty:
 	__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
 	return ret;
