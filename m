Return-Path: <minchan.kim@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522305624; cv=none;
        d=google.com; s=arc-20160816;
        b=uTah2clKBeB7OTjxpOb7ezgXbF6XXLNHKurqraRQJpRq9Z2btQifcodETq4Fj13aff
         ZNHGwR3LH/4W2EpM6nr8U+4dbFdehwpuKxj6Fzjbxb7mKHzItPBgspieuMv4fOn44oIR
         OfHm6F/eM+xpcXQ0rUy4Azzf99PL1L1LrlrIWgPTBT32VZW9/Oenb+IhyAfIVHPjSecE
         0vXPLFmst5qylQy9CO+t9ZYN7XsefwLc961Pl2U/uyYsNNXo7XTRzzvhvz1DBJI+Gc6T
         M0Z7crVhpyrpP3AD0/jpBxFdtEsQE0E15wGzWwK43jVlA1/0PIkAWFvxcQif/H+vMAAE
         8GHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:dkim-signature:arc-authentication-results;
        bh=YRpqwQWnfvkuaYUvzTtWe22q7On6ih7yH3Mo8Hyl1ZA=;
        b=bTCrdSGq1i/WKlqXxJZG8IK2Wk+sxedGg2TnO48PpN8Vx9lETJBRtmbt3Vs8UtVTQ0
         k5uQQWuh+JNmii/DEXGyn495lAHrVc6XU8dUZC9yVVStApi4g6mkVnvSBX823HUwOepU
         OanxQNTsULSfU7TNTPC73lUmfpGz/FOSPsRi00LP5cuu3O2n+TZmHuPkEh6ZRWXQxofc
         r/wQRj7tBgiJKionXbl9Ltu2k69lWy7Mj1ojTEoF+POhcg84cH9eYY4PgDj7Cfkdvfpd
         8Cu4vEPNCuRkVe2wpIGpq4IETPE6nYKYrv2XyXjaVWknLNsdlS6MO7iRu42CpEbArug2
         TZ/w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YJhL6q9n;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YJhL6q9n;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
X-Google-Smtp-Source: AIpwx49TBviob7fTYhOHGUY6uvtVInjWTgg0n6rgTl84Cg/VECVBjLgxR80KGziIZfaOkFcdyrZg3Q==
Sender: Minchan Kim <minchan.kim@gmail.com>
From: Minchan Kim <minchan@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Minchan Kim <minchan@kernel.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Martijn Coenen <maco@android.com>
Subject: [PATCH v4] ANDROID: binder: change down_write to down_read
Date: Thu, 29 Mar 2018 15:40:13 +0900
Message-Id: <20180329064013.198620-1-minchan@kernel.org>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596231778699320743?=
X-GMAIL-MSGID: =?utf-8?q?1596253142305223778?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

binder_update_page_range needs down_write of mmap_sem because
vm_insert_page need to change vma->vm_flags to VM_MIXEDMAP unless
it is set. However, when I profile binder working, it seems
every binder buffers should be mapped in advance by binder_mmap.
It means we could set VM_MIXEDMAP in bider_mmap time which is
already hold a mmap_sem as down_write so binder_update_page_range
doesn't need to hold a mmap_sem as down_write.

Android suffers from mmap_sem contention so let's reduce mmap_sem
down_write.

Cc: Arve Hjønnevåg <arve@android.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Martijn Coenen <maco@android.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
>From v3:
  * Fix typoe

>From v2:
  * Fix vma->flag setting - Arve

>From v1:
  * remove WARN_ON_ONCE - Greg
  * add reviewed-by - Martijn

Martijn, I took your LGTM of v1 as Reviewed-by. If you don't like it
or want to change it to acked-by, please, tell me.

 drivers/android/binder.c       | 3 ++-
 drivers/android/binder_alloc.c | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 764b63a5aade..fe62be7d7113 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4722,7 +4722,8 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
 		failure_string = "bad vm_flags";
 		goto err_bad_arg;
 	}
-	vma->vm_flags = (vma->vm_flags | VM_DONTCOPY) & ~VM_MAYWRITE;
+	vma->vm_flags = (vma->vm_flags | VM_DONTCOPY | VM_MIXEDMAP) &
+							~VM_MAYWRITE;
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
