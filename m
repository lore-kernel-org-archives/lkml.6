Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvLDckE08fNO5EgSL86uFEXekdWPgO+xZe141dPDGqf7QTSvYBIBrt/dSji/rlIAkPoCUAf
ARC-Seal: i=1; a=rsa-sha256; t=1521214112; cv=none;
        d=google.com; s=arc-20160816;
        b=LvfOWeQM7Pq5XPb3tkilgmalMigRJfIx2Xll1hu9FSaY1H5dVA4h+uudr4f0I5Qfcx
         fjGc+xIFOZ2IlzP0v8bRIrhVVqeRifPi5QK6eGZvolawAChSx7ITPtCsmzD5lmACMbvH
         jl9nmm+LF++YXEaQVeXnqIZY8e7L40gC9g3BTUykaaZNsULyzvUPtpEmXvqFuRkRZVID
         9PtMhHeJb+64q0YQ9nOPUwWmhE+/ev0+27viocFx2EYafLEzqXib9lJOaRJYmszW3N2Y
         BC+bmuWWZTCKbafRjd1PNQVT1bV0Hxm/Q6XEiat15SjmJLqJoCbHdUwQR8Ng8wn+HP93
         5Ltg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vaJZr6qozbGFGQ/gLUWXZfd2ZIJCtyPn8xLavc3xd08=;
        b=O1uqvkITqPGNsR1GF8cmfDY5EHsrUzOCL7XJNfVDEfVbrLgriXef7U6iG+BpVfZRAK
         C8G9cywdoH4DFeXtPu6wVWHj/QxwVHdFisCHgOaB7cTgIOV5ZTadtq4LHvR6RphcQspi
         9pZfDzd2tgGIs6nvMt4TY5UaMaE2toZn4+NLaitui4gNzccJjfrEew9XmILmwZ8ydW0z
         IJ4VWmUPxKvG0lhJ8Ko5P//kgaKL1H9syNvtMkaar6AO5YnssHirDfKa/9hhUgI9+HJM
         Wil1xVdLpByga8RNH78ibsyuywaPjLjPuUdllYavR6EfXqSTnp554vsZNFfxiDkIfiVZ
         ienA==
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
Subject: [PATCH 4.4 17/63] loop: Fix lost writes caused by missing flag
Date: Fri, 16 Mar 2018 16:22:49 +0100
Message-Id: <20180316152301.935250657@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108608526044429?=
X-GMAIL-MSGID: =?utf-8?q?1595108608526044429?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
