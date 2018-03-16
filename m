Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsKBVydWk0Z3GLy0vXzvjdnmECNi9CLmeSv7ZH7sLzOPbmhF2VTl9shySwEfFFJSIpA9HjJ
ARC-Seal: i=1; a=rsa-sha256; t=1521214231; cv=none;
        d=google.com; s=arc-20160816;
        b=LKKiP/RA6YtGBsFRIvNXPhPbe3EXBVIKQy6mJMqOlEAXGGEVdQ62j7rfEGMwwYfsXs
         Pb34sRi+S+t4V20zoWh73GJd5fqOGIZbwufeMe02x7pOaknGgnuKahTv2Muikdiz7Q5L
         sRm6BCunBGz+dVfDsCqM2DnIHhu6FOFSOlpBUUCA/Md4VFuGEuOkYfVJBhzJKch/GnxF
         UC4LBmj/ETcV+qV+4bHEZuccm1SzEybkxg64e2iilq0KjooMdwnmsZGb7OnNbPZ87IEg
         7AWLupJ3hz6PzNFnW8ZLlJPqDnYhWlC2X3s/0Q62OMMaxq8ZNFdgt9wWXAfKkbV4btNG
         8b9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hs9RdNpT5/TvbD6g1vNTMJ9AAw+GzbjT1Bh4vt5aIOg=;
        b=neIBBeDK3XR7nTgAZc3N//E0EtJF30MP2MGgVY/W5Xmr6eMBvxGiwdwEop6Vnvi5XL
         fWCj4AmYrlHrlE87WVpJY07Ey1FhgpWHXHWpHS7hIleB7clsTG48O0SxSGcV3q4iXuRn
         9BD/+ZQDEGGwz8E2OIusy9ScZy8/c3I1Ge7pP8ZCzcxXd93NkDrWuUD2xfukPLgOQBzD
         SdMneZ8LWA3C+1ucC+YlCI9bFm4h9WV705R/bsY8/PSvYiuR4WJoQRjm3xI1LhwR8g4v
         TdLczdktIi6gPmib0m9GanVBvzBqUucCO71u+SEWCqudHNC7VU0SEe77rLVpRtOoNekk
         v+vw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.9 21/86] loop: Fix lost writes caused by missing flag
Date: Fri, 16 Mar 2018 16:22:44 +0100
Message-Id: <20180316152318.808531379@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108608526044429?=
X-GMAIL-MSGID: =?utf-8?q?1595108733763214299?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ross Zwisler <ross.zwisler@linux.intel.com>

commit 1d037577c323e5090ce281e96bc313ab2eee5be2 upstream.

The following commit:

commit aa4d86163e4e ("block: loop: switch to VFS ITER_BVEC")

replaced __do_lo_send_write(), which used ITER_KVEC iterators, with
lo_write_bvec() which uses ITER_BVEC iterators.  In this change, though,
the WRITE flag was lost:

-       iov_iter_kvec(&from, ITER_KVEC | WRITE, &kvec, 1, len);
+       iov_iter_bvec(&i, ITER_BVEC, bvec, 1, bvec->bv_len);

This flag is necessary for the DAX case because we make decisions based on
whether or not the iterator is a READ or a WRITE in dax_iomap_actor() and
in dax_iomap_rw().

We end up going through this path in configurations where we combine a PMEM
device with 4k sectors, a loopback device and DAX.  The consequence of this
missed flag is that what we intend as a write actually turns into a read in
the DAX code, so no data is ever written.

The very simplest test case is to create a loopback device and try and
write a small string to it, then hexdump a few bytes of the device to see
if the write took.  Without this patch you read back all zeros, with this
you read back the string you wrote.

For XFS this causes us to fail or panic during the following xfstests:

	xfs/074 xfs/078 xfs/216 xfs/217 xfs/250

For ext4 we have a similar issue where writes never happen, but we don't
currently have any xfstests that use loopback and show this issue.

Fix this by restoring the WRITE flag argument to iov_iter_bvec().  This
causes the xfstests to all pass.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: stable@vger.kernel.org
Fixes: commit aa4d86163e4e ("block: loop: switch to VFS ITER_BVEC")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -263,7 +263,7 @@ static int lo_write_bvec(struct file *fi
 	struct iov_iter i;
 	ssize_t bw;
 
-	iov_iter_bvec(&i, ITER_BVEC, bvec, 1, bvec->bv_len);
+	iov_iter_bvec(&i, ITER_BVEC | WRITE, bvec, 1, bvec->bv_len);
 
 	file_start_write(file);
 	bw = vfs_iter_write(file, &i, ppos);
