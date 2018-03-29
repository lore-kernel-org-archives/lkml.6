Return-Path: <minchan.kim@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522285250; cv=none;
        d=google.com; s=arc-20160816;
        b=RXukR10WEbXrq/eqv7OU8KHiiXcL9hf+MZsTEpU84H/YAPFWTkXTqypFnoxP/AOg8k
         T0uR6+vt7kVg8kULyx39l2QpL3eNLtpt9fdf+Kp42R8N2AMYV5MwpzffEKXeArVUfZXv
         VI7LvtiKyprjkyWjOWd5ifq5Zp0ukF9g4KwfAqQC+FnK1LJuliAv9edNoNiPdrpj+z+y
         Nnz6uI0QE6LyNBxq8nd2GH1B5phJL9uIdHxLF19I5bPbz1e+o5WtyuVt576m3ntuYVPw
         JYEAOOgNhjhuVCJNKGtMlQ7Jv534/M/7bWy7xio8jdB7sBGIJNv9uyyz5F2RIjQgBSUX
         W6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:sender:dkim-signature
         :arc-authentication-results;
        bh=N2aURBRe0w1n4wUc4M3WZykN/13gESjGQGoIxDvr3y0=;
        b=k4P/c+J4jJdBx5Dj/FL07Q512a/UjaJotgdl4Tw3Z/+9r1rJq7few23GFxyUiv2Gta
         Z1a2AFZ1em9BiFf2O6ZNDW2TID49lVhzly27GTfHdVQVTS0sqwnJ9+hvtNIKkqL+LYov
         NISHrX5Oe8cQGSpVzhrChhFR3A/+tMnll0gKig4E2TPymF4imSDT6b2Z1e0L9mo1QpJm
         Y4h72wWXILexvJMBHgBkxQO4ONs1fc+GO0JYOnJADeLLMgQQvKF5xnszLZ2PccIe8BsU
         BAsGi3+y9iy5ohhoCVXhXgT8cMg7i7askEPtO05ds7JFBYvaFH6c/AOdlAz99+LhkO9m
         Y6HA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OBB42fjx;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OBB42fjx;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
X-Google-Smtp-Source: AIpwx48sFllERyWoZGQ8e5L0mM6Bo92MhrY2Viq0m7+1bUAkM9aSDWjDvcizWW/HC0T6zv3LoDGiCA==
Sender: Minchan Kim <minchan.kim@gmail.com>
From: Minchan Kim <minchan@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Todd Kjos <tkjos@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Martijn Coenen <maco@android.com>
Subject: [PATCH v2] ANDROID: binder: change down_write to down_read
Date: Thu, 29 Mar 2018 10:00:40 +0900
Message-Id: <20180329010040.96760-1-minchan@kernel.org>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596231778699320743?=
X-GMAIL-MSGID: =?utf-8?q?1596231778699320743?=
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

Cc: Todd Kjos <tkjos@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Martijn Coenen <maco@android.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
>From v1: 
  * remove WARN_ON_ONCE - Greg
  * add reviewed-by - Martijn

Martijn, I took your LGTM of v1 as Reviewed-by. If you don't like it
or want to change it to acked-by, please, tell me. 

 drivers/android/binder.c       | 2 +-
 drivers/android/binder_alloc.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 764b63a5aade..9a14c6dd60c4 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4722,7 +4722,7 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
 		failure_string = "bad vm_flags";
 		goto err_bad_arg;
 	}
-	vma->vm_flags = (vma->vm_flags | VM_DONTCOPY) & ~VM_MAYWRITE;
+	vma->vm_flags |= (VM_DONTCOPY | VM_MIXEDMAP) & ~VM_MAYWRITE;
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
