Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu+rGBLGdQBGardgwzgPD72h5qxBvO1nMY5644SHy/i5REJ1vOm909VrnfsLVu4mae3tOkr
ARC-Seal: i=1; a=rsa-sha256; t=1521214460; cv=none;
        d=google.com; s=arc-20160816;
        b=qxbUocuWWZW6yZwzFs1S5WyJ8200JCymsEZ8OCmglm0XjOPmGD8gwym8uaboOsYuw1
         WLGkFDlPeHEKPpLYALJ8jbV/hcQiiRZLlfLCYSgZrBVULzDoKcsD9468S+awxWxoBcEW
         yw0aQer/4AVf5ZRtawOrEfu0R4670vJY4us6OSF6C84ZMAMuIoi+874VAs2n3dxohzCI
         4GJ2eJZAI/OpF632/BKmh/zcZNGfUOCzWJJ6t/IYavLo0j/5U+hFip1uhqeYyeXeV4Hu
         A/QJg3jsJUPE1Ry4ezQ7BjwqDiWUqo87NJrHplcRq3e6gy6dav5gVno7Y1MB4eiWmSLp
         k0MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=L4B7BBtK04anuU11IGqX/pOpMl7Aq98v1n/L7N+G38c=;
        b=kKe+Ms9JqvWK6NyH5zKbhsv9N84xrN8a3QQVqSXvY2OIxuS5/C1jrrPGGc8pMNjWl8
         8KvIQLF51jt4emDK85z3ZwSWi49Szx5iS/6DRHgiYS8BTKVftgrTqV+XNYmQZ1sRdb4y
         WbKAyIVrcbd2KxzDv4PAR/XTDvewKdVbQQBI7H0tW/xakivVRCFmv40mLeCdGm2VwJMo
         CWYE1L4h/CgP6SVCZWyqsSUqSvqeO0HmOWW+J8IcQzHfRt+tal9kxhxceEagxo6EaIsQ
         9Hyu7xSnpdhSnmhqgXpbTegLSeq7KYQcmMyhYKnw0AjZ8OZJljRWduR6Wig8FE+IgaUU
         JFmQ==
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
Subject: [PATCH 4.14 015/109] staging: android: ashmem: Fix lockdep issue during llseek
Date: Fri, 16 Mar 2018 16:22:44 +0100
Message-Id: <20180316152330.774340222@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108314094103407?=
X-GMAIL-MSGID: =?utf-8?q?1595108973958416507?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -334,24 +334,23 @@ static loff_t ashmem_llseek(struct file
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
 
