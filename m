Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/e6vYqHG8/JSsulCGfdTgOn9iG2s22S+YCwJl3Bmg3FVa16GtBERaKhI53kLJZ0HBTzAzG
ARC-Seal: i=1; a=rsa-sha256; t=1522168658; cv=none;
        d=google.com; s=arc-20160816;
        b=ZV9l/akkY3gGZMy4E9hzCTy+58J07wJeimw6CRu6ZNz1NvwTn9dWFSDISFvb8kf4IJ
         Z+7YLQshCi2MV45QmnGpkzpXCBSQm5/wDUQjHR9S3FM13K5HPYav57eDbcOOX2j4rSdd
         RpuMMVFtjOZ9hL6n7wzr0b+QrSnnbQW3hPk6EUVkpKvgijhETR43B3YLZoot7TE5j9eh
         IwCpnyWGvMhwRYrHbWQjwSXsInlX5CSYredVcSA+r1bCZj7yeWOKzs4nTNXcAklPB0qr
         VBQ3nthYeASIWUgf0k2QUmDPMS40WuQMHRfR1Xu9+sckunIjID8gIyMY+Uip5EKgiFJg
         pM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=odODr9SQf+cWPpCy2zJHWmTHjqUQDDthLflWwCxUdQ8=;
        b=lAL4uxK5cBhvp0L0U41bdcuGaNxGtKkmv0sSYJvPuhv74xdNdV5An9zQd4OCy1jleJ
         Mw0WZF/EoAuTkJbdpLqeqXD4vU6JtuEgZScAtUHPEkUCy62vYVhmP46Y7RP9OTv7nPKd
         4R8FieI+ZTol0DbdiPKhX6DNdXpp6SK/yVZ9tObxeSY0xU487nVDO56cwZNZlB6Vy6Fg
         /Obb1OoRyTX4i3xKaMve1TVtKBBalDjyix6Ev80FNNTtBTg9OpiZ49cQ2YgXWXNkAgTb
         /AARjyJ4zWLeOb6wjWIkcS+9MPwzWLx/81rdSL9sUIj5SYrf0+7/zeSqHX3x80WRFq7I
         ufkg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dave Airlie <airlied@redhat.com>,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Jason Ekstrand <jason@jlekstrand.net>,
	Clayton Craft <clayton.a.craft@intel.com>
Subject: [PATCH 4.14 086/101] drm/syncobj: Stop reusing the same struct file for all syncobj -> fd
Date: Tue, 27 Mar 2018 18:27:58 +0200
Message-Id: <20180327162755.341782872@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109522775240882?=
X-GMAIL-MSGID: =?utf-8?q?1596109522775240882?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Wilson <chris@chris-wilson.co.uk>

commit e7cdf5c82f1773c3386b93bbcf13b9bfff29fa31 upstream.

The vk cts test:
dEQP-VK.api.external.semaphore.opaque_fd.export_multiple_times_temporary

triggers a lot of
VFS: Close: file count is 0

Dave pointed out that clearing the syncobj->file from
drm_syncobj_file_release() was sufficient to silence the test, but that
opens a can of worm since we assumed that the syncobj->file was never
unset. Stop trying to reuse the same struct file for every fd pointing
to the drm_syncobj, and allocate one file for each fd instead.

v2: Fixup return handling of drm_syncobj_fd_to_handle
v2.1: [airlied: fix possible syncobj ref race]
v2.2: [jekstrand: back-port to 4.14]

Reported-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Tested-by: Dave Airlie <airlied@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Jason Ekstrand <jason@jlekstrand.net>
Tested-by: Clayton Craft <clayton.a.craft@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_syncobj.c |   81 +++++++++++++++---------------------------
 include/drm/drm_syncobj.h     |    5 --
 2 files changed, 30 insertions(+), 56 deletions(-)

--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -328,28 +328,11 @@ static const struct file_operations drm_
 	.release = drm_syncobj_file_release,
 };
 
-static int drm_syncobj_alloc_file(struct drm_syncobj *syncobj)
-{
-	struct file *file = anon_inode_getfile("syncobj_file",
-					       &drm_syncobj_file_fops,
-					       syncobj, 0);
-	if (IS_ERR(file))
-		return PTR_ERR(file);
-
-	drm_syncobj_get(syncobj);
-	if (cmpxchg(&syncobj->file, NULL, file)) {
-		/* lost the race */
-		fput(file);
-	}
-
-	return 0;
-}
-
 static int drm_syncobj_handle_to_fd(struct drm_file *file_private,
 				    u32 handle, int *p_fd)
 {
 	struct drm_syncobj *syncobj = drm_syncobj_find(file_private, handle);
-	int ret;
+	struct file *file;
 	int fd;
 
 	if (!syncobj)
@@ -361,46 +344,40 @@ static int drm_syncobj_handle_to_fd(stru
 		return fd;
 	}
 
-	if (!syncobj->file) {
-		ret = drm_syncobj_alloc_file(syncobj);
-		if (ret)
-			goto out_put_fd;
+	file = anon_inode_getfile("syncobj_file",
+				  &drm_syncobj_file_fops,
+				  syncobj, 0);
+	if (IS_ERR(file)) {
+		put_unused_fd(fd);
+		drm_syncobj_put(syncobj);
+		return PTR_ERR(file);
 	}
-	fd_install(fd, syncobj->file);
-	drm_syncobj_put(syncobj);
+
+	drm_syncobj_get(syncobj);
+	fd_install(fd, file);
+
 	*p_fd = fd;
 	return 0;
-out_put_fd:
-	put_unused_fd(fd);
-	drm_syncobj_put(syncobj);
-	return ret;
 }
 
-static struct drm_syncobj *drm_syncobj_fdget(int fd)
-{
-	struct file *file = fget(fd);
-
-	if (!file)
-		return NULL;
-	if (file->f_op != &drm_syncobj_file_fops)
-		goto err;
-
-	return file->private_data;
-err:
-	fput(file);
-	return NULL;
-};
-
 static int drm_syncobj_fd_to_handle(struct drm_file *file_private,
 				    int fd, u32 *handle)
 {
-	struct drm_syncobj *syncobj = drm_syncobj_fdget(fd);
+	struct drm_syncobj *syncobj;
+	struct file *file;
 	int ret;
 
-	if (!syncobj)
+	file = fget(fd);
+	if (!file)
+		return -EINVAL;
+
+	if (file->f_op != &drm_syncobj_file_fops) {
+		fput(file);
 		return -EINVAL;
+	}
 
 	/* take a reference to put in the idr */
+	syncobj = file->private_data;
 	drm_syncobj_get(syncobj);
 
 	idr_preload(GFP_KERNEL);
@@ -409,12 +386,14 @@ static int drm_syncobj_fd_to_handle(stru
 	spin_unlock(&file_private->syncobj_table_lock);
 	idr_preload_end();
 
-	if (ret < 0) {
-		fput(syncobj->file);
-		return ret;
-	}
-	*handle = ret;
-	return 0;
+	if (ret > 0) {
+		*handle = ret;
+		ret = 0;
+	} else
+		drm_syncobj_put(syncobj);
+
+	fput(file);
+	return ret;
 }
 
 int drm_syncobj_import_sync_file_fence(struct drm_file *file_private,
--- a/include/drm/drm_syncobj.h
+++ b/include/drm/drm_syncobj.h
@@ -60,11 +60,6 @@ struct drm_syncobj {
 	 * locks cb_list and write-locks fence.
 	 */
 	spinlock_t lock;
-	/**
-	 * @file:
-	 * a file backing for this syncobj.
-	 */
-	struct file *file;
 };
 
 typedef void (*drm_syncobj_func_t)(struct drm_syncobj *syncobj,
