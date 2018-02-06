Return-Path: <joelaf@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517878197; cv=none;
        d=google.com; s=arc-20160816;
        b=SLoPRNo7HmRO6TzLMjCJRrMY1EXkRXFO8x9oCERp4Py+twaWnqGNdi9Cfiqy/+NA2b
         M76DoVwT6W4Jtc+SBc1Kgp04fzEqCHi825KF2DvYhnZdNEhs+3P2PIHv6SkSYTpvhwBu
         XtNnxKVxYGaI5UqHk5aKK5XxBJ1TJ4V8BtquaNk/AHIUa0bNgg+phVTkmrUffYhq5Kjc
         zLyNziCRJ0GtRfNGHrJIYK3uACRKC3pqCG+QFAe3Ep9+Jj1Jx7sLqrAxPmCsk+EW8k0H
         bgrbWphefKrJwsuOEjsrW08AGO561xcwCR1utXu/hjcEh7j7eWVCWiAokyCdyC/A34Mx
         tazA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=OhO9GTIf9u5gW/cyWgvvOkn4LXdSz17B6pcADIXNF6g=;
        b=VRKh78THJuvB/JbrdxmYIniV6nTTmC+WhnlxBPQiyu0Wh6N+R8U2dbZQZL03+U9FFF
         WJ5a0dVVgv4X8FkYVMHEjge7I5fBdiERQAJVojwlo+hcbMUFZEmooKENkjMHkHdtbyko
         0xNOelSNcRS1hAPgkGU2Kt79alQQmy96sAka/NuQVIvWN2wNOL3IoCPvmv4HtAbB5BRs
         SRnzVUT2oH48HIuVyOpf9Eqr/LrpB9qthRiiE6C8/bdL8S8up+vMKbp35Twui2d66awb
         q64K81999OPcYrsnV8aGERzj6WszZsEkWcn4C7wrwO9ccOPZoJKzpVaqdExSGPngASws
         kyWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=vceb2W3S;
       spf=pass (google.com: domain of joelaf@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joelaf@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=vceb2W3S;
       spf=pass (google.com: domain of joelaf@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joelaf@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AH8x227dgcXqKC55/MCnjcZbibzkwOrRFvmksojVkJcpQmT8/mTHNPHtZ6Q9u+7z6wwaWAwbK7skBA==
From: Joel Fernandes <joelaf@google.com>
To: linux-kernel@vger.kernel.org
Cc: Joel Fernandes <joelaf@google.com>,
	Todd Kjos <tkjos@google.com>,
	Arve Hjonnevag <arve@android.com>,
	Greg Hackmann <ghackmann@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] staging: ashmem: Fix lockdep issue during llseek
Date: Mon,  5 Feb 2018 16:49:43 -0800
Message-Id: <20180206004943.224559-1-joelaf@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591610649316490733?=
X-GMAIL-MSGID: =?utf-8?q?1591610649316490733?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ashmem_mutex create a chain of dependencies like so:

(1)
mmap syscall ->
  mmap_sem ->  (acquired)
  ashmem_mmap
  ashmem_mutex (try to acquire)
  (block)

(2)
llseek syscall ->
  ashmem_llseek ->
  ashmem_mutex ->  (acquired)
  inode_lock ->
  inode->i_rwsem (try to acquire)
  (block)

(3)
getdents ->
  iterate_dir ->
  inode_lock ->
  inode->i_rwsem   (acquired)
  copy_to_user ->
  mmap_sem         (try to acquire)

There is a lock ordering created between mmap_sem and inode->i_rwsem
causing a lockdep splat [2] during a syzcaller test, this patch fixes
the issue by unlocking the mutex earlier. Functionally that's Ok since
we don't need to protect vfs_llseek.

[1] https://patchwork.kernel.org/patch/10185031/
[2] https://lkml.org/lkml/2018/1/10/48

Cc: Todd Kjos <tkjos@google.com>
Cc: Arve Hjonnevag <arve@android.com>
Cc: Greg Hackmann <ghackmann@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reported-by: syzbot+8ec30bb7bf1a981a2012@syzkaller.appspotmail.com
Signed-off-by: Joel Fernandes <joelaf@google.com>
---
 drivers/staging/android/ashmem.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index 7e060f32aaa8..c8b74ae53936 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -335,24 +335,23 @@ static loff_t ashmem_llseek(struct file *file, loff_t offset, int origin)
 	mutex_lock(&ashmem_mutex);
 
 	if (asma->size == 0) {
-		ret = -EINVAL;
-		goto out;
+		mutex_unlock(&ashmem_mutex);
+		return -EINVAL;
 	}
 
 	if (!asma->file) {
-		ret = -EBADF;
-		goto out;
+		mutex_unlock(&ashmem_mutex);
+		return -EBADF;
 	}
 
+	mutex_unlock(&ashmem_mutex);
+
 	ret = vfs_llseek(asma->file, offset, origin);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	/** Copy f_pos from backing file, since f_ops->llseek() sets it */
 	file->f_pos = asma->file->f_pos;
-
-out:
-	mutex_unlock(&ashmem_mutex);
 	return ret;
 }
 
-- 
2.16.0.rc1.238.g530d649a79-goog
