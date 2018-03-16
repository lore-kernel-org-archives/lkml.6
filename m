Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtxXqIx+uoHro1b4bhlvah9rVR9kr6SBFokNKeslwclaRmfHpw623sHeMlqagqm/7AIuavd
ARC-Seal: i=1; a=rsa-sha256; t=1521214143; cv=none;
        d=google.com; s=arc-20160816;
        b=mMGETuSXjTCYfiM1fpAawMJa4rCH4tDE++pB7aza42KdVteng8BfADsqydPwUYFsLB
         sBb9ItmLidKcruQHD3zF/lSEx/OC1pbuHqL3ZyNP4A4Umtb0g+8Ovk3g4LpOeLncy/xH
         46QdsHdFXzTVWHIrpliQUXHTngOlwENOMag0L+omL3X0VIsm574y93s4CGy+j1pvvIS/
         UhYlXn5ieY6YFZD7phbv51ZJ7RGLCMfZ5ZScaFXDdZVWcwi5zFJ/Db3g910KKzDGz+hJ
         o+3LHlO7C/oew7VM7+svj74oG+G+PrAQk2EV1vVWEkL8oLv2FaBocUVMHvXUuqbgjCqx
         XDeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VHMZzaxwstEZu9HyG7rRb3SWlk8I6fkedj+UjlIVhw0=;
        b=dXGExl/mHfFqJ7K1HV0DLB+bM96u+PuTgV5D39MpV66GMVv8lSFXQDvuGJNyGHXX2W
         ua3pTkBpKObzs63sxXrVWMFbVSwSM+wX3yVICoQf7/PNl/uqW0osMbvE7g4lqYfyzQxc
         f51XmzEarHkzxA8ymWcfMXcJA6a0RiN+Ox8m2Jvs8yqk8fCOxC1lbfbRGSRjG5RZKUnQ
         hQTRXJOVW2aR8MrIFW6Rp4vuUnDsdtpI4XUhRQBJyErZcJovu+Hir80Cpo8J7vx+hepy
         4860ACEznVSKexLIDi5UHM56OUKgeF4dV+vd8rEheNH1XoCd4nbucyEZklQxkywTa3oz
         yBxw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Todd Kjos <tkjos@google.com>,
	Arve Hjonnevag <arve@android.com>,
	syzbot+8ec30bb7bf1a981a2012@syzkaller.appspotmail.com,
	Joel Fernandes <joelaf@google.com>,
	Greg Hackmann <ghackmann@google.com>
Subject: [PATCH 4.4 56/63] staging: android: ashmem: Fix lockdep issue during llseek
Date: Fri, 16 Mar 2018 16:23:28 +0100
Message-Id: <20180316152306.137677684@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108314094103407?=
X-GMAIL-MSGID: =?utf-8?q?1595108642101954360?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joel Fernandes <joelaf@google.com>

commit cb57469c9573f6018cd1302953dd45d6e05aba7b upstream.

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

Acked-by: Todd Kjos <tkjos@google.com>
Cc: Arve Hjonnevag <arve@android.com>
Cc: stable@vger.kernel.org
Reported-by: syzbot+8ec30bb7bf1a981a2012@syzkaller.appspotmail.com
Signed-off-by: Joel Fernandes <joelaf@google.com>
Acked-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/android/ashmem.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -330,24 +330,23 @@ static loff_t ashmem_llseek(struct file
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
 
