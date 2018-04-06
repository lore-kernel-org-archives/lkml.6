Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+ojyOSaByI0NPStITHk4y4/dWfjAHiFXhEqh/la8xZi5Ek3kEK7wIumuVwtWq4LZtsKPmH
ARC-Seal: i=1; a=rsa-sha256; t=1523021863; cv=none;
        d=google.com; s=arc-20160816;
        b=rTh6T4cbKHC/b6OrsC4SNbNJAA17wDLdK3OuvfrV8Psdl72XHiDSF3szy24ndSDuZG
         qI0rpb9VGAdheaklWzSPwMM0hZHiUmyTmbRpKs1BsdCep3t0dP2dTa3Zu+hTBPG0HxUm
         Zxf1GgBPhLGSC8lntyIeJGPTDL/Kq3zHmwxnadGG0BJ01tUX01xRLEk31IyE7O3R7FHZ
         eQ85jzwFC79Ir/zFpGuAeso72NzPOQguLFIArFpX3InQrDG3dMGRyMpHe77TSL23+s7R
         PgqLGBrM0xBRra2ky50wPUOfXLrTx0ffbDcW5bG17Uipkb+j5x6jvwlqy2WKBMSWX0Tr
         iUtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HTAQ4KU4Iqt11BnvPCPe6S12B08TDOK6VXQQF9JzUIo=;
        b=Co2ihkdavZgWt1q3f+k6MSHSMi242bIFVBBE9LSjmbkth4gj6/JsUXVAUwo0cyl6Je
         FHOPbY5spnIz4xBGYJJx10KAz/jCrcs5T9d6xq6njkdYyxJD6ujTei7lc/I1UbvjHzln
         p4pUOXRvU8Ng74dS2Y+ReLOjI1hWaTy/bZ3YjJnJA+r/877Efn+P+ozG9y9nhBr3hQR8
         S8gzR4++UH9kokzb8afvWFXm76q3PZOwD1FRsX8vTh8qsJaDfzH6okZ6BFpIjx5bpcFa
         l9gUWs13Rl5GTEkeMNWWd2mVbqgvHkwggyhp/BGAmDK6zgiBpmT8q8iflI7cFn55Wuik
         crDA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	stable@kernel.org,
	"Yan, Zheng" <zyan@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4.14 12/67] ceph: only dirty ITER_IOVEC pages for direct read
Date: Fri,  6 Apr 2018 15:23:42 +0200
Message-Id: <20180406084342.906759671@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003931792516053?=
X-GMAIL-MSGID: =?utf-8?q?1597004173428894250?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yan, Zheng <zyan@redhat.com>

commit 85784f9395987a422fa04263e7c0fb13da11eb5c upstream.

If a page is already locked, attempting to dirty it leads to a deadlock
in lock_page().  This is what currently happens to ITER_BVEC pages when
a dio-enabled loop device is backed by ceph:

  $ losetup --direct-io /dev/loop0 /mnt/cephfs/img
  $ xfs_io -c 'pread 0 4k' /dev/loop0

Follow other file systems and only dirty ITER_IOVEC pages.

Cc: stable@kernel.org
Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ceph/file.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -635,7 +635,8 @@ static ssize_t ceph_sync_read(struct kio
 struct ceph_aio_request {
 	struct kiocb *iocb;
 	size_t total_len;
-	int write;
+	bool write;
+	bool should_dirty;
 	int error;
 	struct list_head osd_reqs;
 	unsigned num_reqs;
@@ -745,7 +746,7 @@ static void ceph_aio_complete_req(struct
 		}
 	}
 
-	ceph_put_page_vector(osd_data->pages, num_pages, !aio_req->write);
+	ceph_put_page_vector(osd_data->pages, num_pages, aio_req->should_dirty);
 	ceph_osdc_put_request(req);
 
 	if (rc < 0)
@@ -842,6 +843,7 @@ ceph_direct_read_write(struct kiocb *ioc
 	size_t count = iov_iter_count(iter);
 	loff_t pos = iocb->ki_pos;
 	bool write = iov_iter_rw(iter) == WRITE;
+	bool should_dirty = !write && iter_is_iovec(iter);
 
 	if (write && ceph_snap(file_inode(file)) != CEPH_NOSNAP)
 		return -EROFS;
@@ -909,6 +911,7 @@ ceph_direct_read_write(struct kiocb *ioc
 			if (aio_req) {
 				aio_req->iocb = iocb;
 				aio_req->write = write;
+				aio_req->should_dirty = should_dirty;
 				INIT_LIST_HEAD(&aio_req->osd_reqs);
 				if (write) {
 					aio_req->mtime = mtime;
@@ -966,7 +969,7 @@ ceph_direct_read_write(struct kiocb *ioc
 				len = ret;
 		}
 
-		ceph_put_page_vector(pages, num_pages, !write);
+		ceph_put_page_vector(pages, num_pages, should_dirty);
 
 		ceph_osdc_put_request(req);
 		if (ret < 0)
