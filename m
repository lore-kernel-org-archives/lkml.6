Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv2gWmU4M7G1F8wAdSnn3oKUPOEcnUY3pBAZXigKu8/pDedC0tQxcwmpirPfBypqoYFhV6c
ARC-Seal: i=1; a=rsa-sha256; t=1521214365; cv=none;
        d=google.com; s=arc-20160816;
        b=dTwx2JUBFNOQ6LZlR69+CZboUj8dkGp+2HSuZpYbdxwfMTNv7GncGnFzngTsUec/5q
         AkFuQD97J150hdEyxmakpK48OhwykLJgeXgmFZlo7QUrzoy4GqAUX6Y3fKngvQR8+KZQ
         Z/tA3sX9Ux2Fw59P52BxQTzgMJCRe0JKKSAKxwUSa4V0DIcF2liYlmeOZdlIBMsoseiO
         hJ+KRJtYKfbgGcBW26ytiEcu5UyzTYSURhaRZOBKRle7xoa8t+kz8x1hVSB3Gp/N/el9
         crvfvvKeoCfoNSAdy3hHFmOp2GGeUpQwKqWuLUINl9GAoHONt/WWfoXfuvN81nA54Id/
         oZ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BE1GAs4Kg1vWrTuosrQoQ3Qn3a4T5FwAxZmbbu16G2Y=;
        b=vdqRd8gc5uils6TJ3mBpX3XmftfCukFlPd9ottbrZCbngZNrXtqriuQ2ldaMshH+87
         yj8bv4l1Nwjo1um6asmW1RPrfiB60eq/QkggJY8Xw0fg3K0EloR+EDshYRDG4oNllt32
         MN0hIX1N5zfH78ekaLGnaileJYKO0a1IZC2Rfmyti8X39ZpMkgUqKPp3W5MreORCfJxf
         yS+su/LoNfw+TKPt9MVBpm2L2OaqGkeKDvXl7f+bQiob9FrCpS4KPpDknJZ9guEBP3Os
         h0RtxuZ7o/Y41RfQrbcTTca6sQVFGvbtyRrPlbkPAav6DKN4F0TE3NquIkYuqN1deGKi
         i5Jg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Scott Mayhew <smayhew@redhat.com>,
	Trond Myklebust <trond.myklebust@primarydata.com>
Subject: [PATCH 4.9 68/86] NFS: Fix unstable write completion
Date: Fri, 16 Mar 2018 16:23:31 +0100
Message-Id: <20180316152321.959682435@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108875088099694?=
X-GMAIL-MSGID: =?utf-8?q?1595108875088099694?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1847,40 +1847,43 @@ int nfs_generic_commit_list(struct inode
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
 
@@ -1890,11 +1893,11 @@ int nfs_write_inode(struct inode *inode,
 	int flags = FLUSH_SYNC;
 	int ret = 0;
 
-	/* no commits means nothing needs to be done */
-	if (!nfsi->commit_info.ncommit)
-		return ret;
-
 	if (wbc->sync_mode == WB_SYNC_NONE) {
+		/* no commits means nothing needs to be done */
+		if (!nfsi->commit_info.ncommit)
+			goto check_requests_outstanding;
+
 		/* Don't commit yet if this is a non-blocking flush and there
 		 * are a lot of outstanding writes for this mapping.
 		 */
@@ -1905,16 +1908,16 @@ int nfs_write_inode(struct inode *inode,
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
+	} else if (nfsi->commit_info.ncommit)
+		goto out_mark_dirty;
+
+check_requests_outstanding:
+	if (!atomic_read(&nfsi->commit_info.rpcs_out))
+		return ret;
 out_mark_dirty:
 	__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
 	return ret;
