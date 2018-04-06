Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49CxtBQBIVC7SP4siFMU9Sy63iHleqiiElpV7L7vGtXRkbkn3R/2JAvEIF8x7Yu/dux2Vha
ARC-Seal: i=1; a=rsa-sha256; t=1523021632; cv=none;
        d=google.com; s=arc-20160816;
        b=iANEQLOfZrTzI2zLx2G40Zt3PJNZtJnxNstBhjJDMX13rGtJDtURxfVOfw6vdB83fl
         voJNxY1OCrfHNNusJzBP8CW5qz1dkWCHlGyOhiagJ2JKrP4TMRCmGmXfsmnW0e4P2l+9
         CaPPXh0VwDK8MvV+PgHTo47hvANMvIu+c2d8529niFWDibzTXm+KXtkDW5jO8XYJweCy
         mvuvkdU4z4EJNzx3wGXwXDSwh89tfTDbxkub101poEtzufrEdemQhv9sOrySNr2k27qD
         t7Nat3X59FCPjiFDFLvG524PUSs4Nt8L5rAxKtY9EvVcivIjuV8zOu0WUfXYNQDiDClA
         Wblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sY86L39RHWMGZ1NZtsx0vKANoUAZrfBvE4U8Jq+QZSg=;
        b=HNnxc6iG4EhXHKJRd9w4sA6vpvM3F75GPsZaD/JGFI9BffU3BUOzE/5C5uBEPKVJ26
         eh9Q8veFXCHlauYOkLkJSFo5y6ujEsyBiUzspY/4cIwmM0d5IDRSItViPJ4D2yWOkHQ6
         ZFqkEAURvRs7qxuX/hTqb9TvChElT8uQt3/Zc5PYPSp5P0HajzyX23QOL6K6cER60Cy9
         1/gzg/fHVq4pFHzFlw2rxw+pSIAn8abte6awVs1fMNWID2Q3zR7Qm75qiOo3vQsyK+5H
         eIv4PnO3x1g/9OMsO1K4aeCCYfudgagvrvb1h8ygDpUZB+Fy4eIiozSi6qSxFd/OyJwN
         grJA==
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
Subject: [PATCH 4.9 007/102] ceph: only dirty ITER_IOVEC pages for direct read
Date: Fri,  6 Apr 2018 15:22:48 +0200
Message-Id: <20180406084332.549269814@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003931792516053?=
X-GMAIL-MSGID: =?utf-8?q?1597003931792516053?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -598,7 +598,8 @@ static ssize_t ceph_sync_read(struct kio
 struct ceph_aio_request {
 	struct kiocb *iocb;
 	size_t total_len;
-	int write;
+	bool write;
+	bool should_dirty;
 	int error;
 	struct list_head osd_reqs;
 	unsigned num_reqs;
@@ -708,7 +709,7 @@ static void ceph_aio_complete_req(struct
 		}
 	}
 
-	ceph_put_page_vector(osd_data->pages, num_pages, !aio_req->write);
+	ceph_put_page_vector(osd_data->pages, num_pages, aio_req->should_dirty);
 	ceph_osdc_put_request(req);
 
 	if (rc < 0)
@@ -890,6 +891,7 @@ ceph_direct_read_write(struct kiocb *ioc
 	size_t count = iov_iter_count(iter);
 	loff_t pos = iocb->ki_pos;
 	bool write = iov_iter_rw(iter) == WRITE;
+	bool should_dirty = !write && iter_is_iovec(iter);
 
 	if (write && ceph_snap(file_inode(file)) != CEPH_NOSNAP)
 		return -EROFS;
@@ -954,6 +956,7 @@ ceph_direct_read_write(struct kiocb *ioc
 			if (aio_req) {
 				aio_req->iocb = iocb;
 				aio_req->write = write;
+				aio_req->should_dirty = should_dirty;
 				INIT_LIST_HEAD(&aio_req->osd_reqs);
 				if (write) {
 					aio_req->mtime = mtime;
@@ -1012,7 +1015,7 @@ ceph_direct_read_write(struct kiocb *ioc
 				len = ret;
 		}
 
-		ceph_put_page_vector(pages, num_pages, !write);
+		ceph_put_page_vector(pages, num_pages, should_dirty);
 
 		ceph_osdc_put_request(req);
 		if (ret < 0)
