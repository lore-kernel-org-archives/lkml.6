Return-Path: <minchan.kim@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522306472; cv=none;
        d=google.com; s=arc-20160816;
        b=pIEr9VrsP73Cc+if2d1+Nr1zqdUnxTvBKK6S1yxJ6ZbjKTqUbJw91B1ehTWM9W3HHH
         3Orzr7YJve0X/K9Nfpt0uzOzFDT5B0cy1NbUNJ27IKfLmfrv/K/aTMpcIgvp4DArP2Zf
         S8ebT5G7lC0SEv0pkseAudx10+11VzGPZosNyfb8sWYYczq+0E/XothCZ6WrJxKY+mz5
         ZkYRopVGc4dMdQPApq3NQ6W2z8hBlfVBYsPZpvanwtS+hNsbYxeIvcU72TvUjMVMZg8z
         NU+5mObeoAlKtUUelVBskRi2PykltHnCpkhnu5EOcYB29Udk+0cGDcM6nJ0pJYC+yy0C
         jupw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:dkim-signature:arc-authentication-results;
        bh=z0Ci4/IBlR4xy1mmF5s5NpANnuryDcpKb9nfeso5yDc=;
        b=HMyGf0InF+wlX+EcxZXuhYKfsChPcf8y2M1W1hkBDZxipd2pfHVspVPt2EsHxb05e6
         wO2xjRtPDYFPDWotmuRmT1AOMttydPIXejWzCvNVwTZ7GCGc3gMdzrzLXKakjwhM+PNk
         a/Br0qj8ZWBHKVGwyPQhTC8l4Iac2evBIlvYU8ooqxoQ2l3mc6NKux/Lcbs//9yBSpWY
         omXAVk9drabNlxyxTiOUnDqZeX0qIn6D4R4uxYb2BVSLBu25T0r7kqCH22hKBtyrRirt
         5ZYC7zptb4CxRr5Hy8cjIBWbel6wu/PAOc0jzZ9X2a+oZq9/0lbjjxPiTmj00Oe92wYq
         k7OQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CD2gTQpE;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CD2gTQpE;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
X-Google-Smtp-Source: AIpwx4/Ndd6ipuAj8bO4itintszink3l7oTbqfHgF5IMdqprzirmclMZtuNBxClGtICqq8DKIoCexg==
Sender: Minchan Kim <minchan.kim@gmail.com>
From: Minchan Kim <minchan@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Joe Perches <joe@perches.com>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Martijn Coenen <maco@android.com>
Subject: [PATCH v5] ANDROID: binder: change down_write to down_read
Date: Thu, 29 Mar 2018 15:54:24 +0900
Message-Id: <20180329065424.203172-1-minchan@kernel.org>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596254032587353794?=
X-GMAIL-MSGID: =?utf-8?q?1596254032587353794?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

binder_update_page_range needs down_write of mmap_sem because
vm_insert_page need to change vma->vm_flags to VM_MIXEDMAP unless
it is set. However, when I profile binder working, it seems
every binder buffers should be mapped in advance by binder_mmap.
It means we could set VM_MIXEDMAP in binder_mmap time which is
already hold a mmap_sem as down_write so binder_update_page_range
doesn't need to hold a mmap_sem as down_write.

Android suffers from mmap_sem contention so let's reduce mmap_sem
down_write.

Cc: Joe Perches <joe@perches.com>
Cc: Arve Hjønnevåg <arve@android.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Martijn Coenen <maco@android.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
>From v4:
  * Fix typo and VM flags clear handling - Joe

>From v3:
  * Fix typo

>From v2:
  * Fix vma->flag setting - Arve

>From v1:
  * remove WARN_ON_ONCE - Greg
  * add reviewed-by - Martijn

Martijn, I took your LGTM of v1 as Reviewed-by. If you don't like it
or want to change it to acked-by, please, tell me.

 drivers/android/binder.c       | 4 +++-
 drivers/android/binder_alloc.c | 6 +++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 764b63a5aade..bb63e3b54e0c 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4722,7 +4722,9 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
 		failure_string = "bad vm_flags";
 		goto err_bad_arg;
 	}
-	vma->vm_flags = (vma->vm_flags | VM_DONTCOPY) & ~VM_MAYWRITE;
+	vma->vm_flags |= VM_DONTCOPY | VM_MIXEDMAP;
+	vma->vm_flags &= ~VM_MAYWRITE;
+
 	vma->vm_ops = &binder_vm_ops;
 	vma->vm_private_data = proc;
 
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 5a426c877dfb..4f382d51def1 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -219,7 +219,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 		mm = alloc->vma_vm_mm;
 
 	if (mm) {
-		down_write(&mm->mmap_sem);
+		down_read(&mm->mmap_sem);
 		vma = alloc->vma;
 	}
 
@@ -288,7 +288,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 		/* vm_insert_page does not seem to increment the refcount */
 	}
 	if (mm) {
-		up_write(&mm->mmap_sem);
+		up_read(&mm->mmap_sem);
 		mmput(mm);
 	}
 	return 0;
@@ -321,7 +321,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 	}
 err_no_vma:
 	if (mm) {
-		up_write(&mm->mmap_sem);
+		up_read(&mm->mmap_sem);
 		mmput(mm);
 	}
 	return vma ? -ENOMEM : -ESRCH;
-- 
2.17.0.rc1.321.gba9d0f2565-goog
