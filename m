Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsnEgpa8loMOH/pb9th6lXjYrlIKF+a8Qg0pxF1neJDVzO7wA4+V9LkFAjfKPlOd3T6Zkfa
ARC-Seal: i=1; a=rsa-sha256; t=1520955059; cv=none;
        d=google.com; s=arc-20160816;
        b=uqs+A99IDwwdBWcxj3uicX0lLL6NTQ/Vi+8AFGdQRkj4xtBRKERlec+ydsPaRwIa1J
         ez4ZOSWHem4J+LpPtaLEMFt6L0dqzZXUsSjzuJLJL81VolEQYy/uWRLDOsGvY7Pb28kS
         rP7E+/LZyaVmBi40QP+xpZGUfcV/gRFgHVCqTzQMaW3ldvKZD0tTi8DeywWgLJuJxTby
         9y8MazqNN8lTjWJvjtpWqJSW0EagHlVzKBqA6A6QcSci03b9o1LN2kds8CcVbdTZOQNv
         wFsoGZTzGObIXe/75/DN81LSeAYU+41grZshe8enwX9nZB4+O6p5ACbkY9wnkk/a75eC
         Q5mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=U2hsjp83iwOXQz3XrEbrjfPxzxqCMDlxDb0vuPJKVe8=;
        b=WKgN7ORqmhjYol+PPETxuj8DyHxiwJKjQPzxfunxcHmUnlCxCqYEJal74/OPxOtMWG
         D3XeK/fdfswRQRm2Zx8iNshm1I0eu7GokarbjCvEwva/hF7v1LNf3tVcc7wC0C/HrMHT
         yN2zA8LfScigCxrflFdrVX960IxaoPw4CDqOGOo1shBXvaFzkeB8EOs5IfgBshWIumAa
         N46m8B424HPN7wTrf10tpoicOPIuuLn099UN9zdjiSgm9jOJ2oq6+rEA5JCSM+Mxnbye
         Nox2lrtfZZbKuP/6bRZ8/EzuMzNAjcwTqq1i4QK9uZbx0aChU6qsTk7EJJLEIzsx70Pp
         jjDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.15 051/146] loop: Fix lost writes caused by missing flag
Date: Tue, 13 Mar 2018 16:23:38 +0100
Message-Id: <20180313152324.585155105@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836972706028461?=
X-GMAIL-MSGID: =?utf-8?q?1594836972706028461?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -266,7 +266,7 @@ static int lo_write_bvec(struct file *fi
 	struct iov_iter i;
 	ssize_t bw;
 
-	iov_iter_bvec(&i, ITER_BVEC, bvec, 1, bvec->bv_len);
+	iov_iter_bvec(&i, ITER_BVEC | WRITE, bvec, 1, bvec->bv_len);
 
 	file_start_write(file);
 	bw = vfs_iter_write(file, &i, ppos, 0);
