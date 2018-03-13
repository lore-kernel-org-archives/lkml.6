Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvx5inwVEjX3adCA+4OKiaaaLueLpaiu+POHOOtSM8oWHVitgepzVPaPOiwj+CWk6yy3zm2
ARC-Seal: i=1; a=rsa-sha256; t=1520955547; cv=none;
        d=google.com; s=arc-20160816;
        b=qrYiYPxWH7G8x13gFHQMVx8mzmwklHD7MN8WeaMF8LQZSyvDzTG38xu3oTzpPsJ6eu
         yuesOcZvlLHMibgsxcCw/tRbI2kiSI1Ppw2AC6++eBdUEFGj1cpgTmLh1yE7osYNFrYk
         UVJiZ7pcAaX/fXEt5o8b7AIKghEchw1Bx0j0UlCw1DNAqytOgM8amzayxMjoF5e0TGKl
         TRubT5563AeJVWnOAE+0xMjA4ITisE8lBpkd8D6IYOj3sxNhohvfIXhjmay2jg6JHlFy
         ZzkNTF5Tf77Wtqr0dpDm3LJB1cxvhbttBw/9OiqKOCeW3tb5issEvvVcuhqeriovGDoW
         4pcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TZJHd7F0gLPUW4cFMfloCLe795Vo+Jm30PxtNzOTiIc=;
        b=wC0jv906DGMbp7toxKGwLyCPc6usXNSHOAcsims8qUQfA9I+7JQmbuWPH1rU9elZAJ
         v+ctwhfbZv9yLXZjaXH5+2r4ZEUfZUVPkHlVC84aH9F58nnYpLQfYScEUX4MaqUy6bMe
         SvgbM5hEAYFH41/BS0Vm5VzktmXCitvtg325Jrz2bOzenc0PssUfAwGGoy54WB2V2ukn
         3EegtRfdB02So7qLFcnI7+/NJo4Mqp2yBF/0AYgh3HrvDGHT/DngMsxLRubLBOsGXkMg
         5RkmQ2kB41a+PZQww012/6fO4aTq+7Go6CwY80nTS7iHpuYTnmcmWjvbFNI1XcbT2Rhu
         LjBg==
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
Subject: [PATCH 4.14 087/140] loop: Fix lost writes caused by missing flag
Date: Tue, 13 Mar 2018 16:24:50 +0100
Message-Id: <20180313152503.996231960@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836972706028461?=
X-GMAIL-MSGID: =?utf-8?q?1594837483545640259?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
