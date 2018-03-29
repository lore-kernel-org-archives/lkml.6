Return-Path: <minchan.kim@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522291331; cv=none;
        d=google.com; s=arc-20160816;
        b=CiwLg/Nmo4Qaq6fxb75x2ZGy7Kuk2dx7S7oNz7r57EEMN0TbvcZKyLnOydVSoCvrgj
         8GsPQwelX6d+bGekxpGSh2vRVPs9PB7eRXr+GHVOT8QhsYC9OOouvCDcy9BlNLkNJbox
         QsTJCKZk/HWDCtDT2ZgaIJUP0FUK7mZv/HR2CLuZSBWP7NDQIiiB1plAiiyaf3MRBryJ
         vQ7c9zG2QqoQuYDksDegHAqAwUZxf/fA4TAwegjXMRzx13g//I8lq7cEowhG6r0Wq+nL
         j+KQxsQtSLd5eKGHVjmRVV5A3EsprKGWw2jrnBrYalapNd5pVBrNB9ECXU5EL/BU/hL3
         J9Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:sender:dkim-signature:arc-authentication-results;
        bh=7A6UO742e0YPfs1fr/TuYRbA+MrpVigyX0IGlf9j5vo=;
        b=Es0kP5ViGWAVUIuk24E99kmKYv4MJK1pfQr+phYDF+PfL+MJzdwBQGzpKCxrr2jkSn
         QfWUs1SoYKVOabE3vyfSo5sGbcwTGeSFBR3uwPNIjJQ2+qAroW8UhBRAKFKebGMWSjOV
         hNXc5N9zxgYzMpWNxgAMlEUfa7J0xKAjDUVFMTwfnZ+o1/HfP+CJfysNwAuZHgsFr3PZ
         YNy4w50YRl60KGUuBBzJVfE+qCaF5PPQkpXEuEEtsih2wNsEJoEk7qBXmxnSpWqBOqup
         jZHONxY3eS/ZEgFII5VK8VLdit5MC50X2X1zJMimh+vBFD8iyI1xKlBrp0CNHNvK3N1w
         53bw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mOJLsQko;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mOJLsQko;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
X-Google-Smtp-Source: AIpwx48BB8tQwB7u95fc7C5M2WQGgOwtgJfxNBohZQ78ZQvF3jGDQ/Bs7xSgBdoQK/ZJwJ3jymoNGQ==
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Thu, 29 Mar 2018 11:42:04 +0900
From: Minchan Kim <minchan@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Todd Kjos <tkjos@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v3] ANDROID: binder: change down_write to down_read
Message-ID: <20180329024204.GB91696@rodete-desktop-imager.corp.google.com>
References: <20180329023712.133164-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180329023712.133164-1-minchan@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596231778699320743?=
X-GMAIL-MSGID: =?utf-8?q?1596238154661509619?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On Thu, Mar 29, 2018 at 11:37:12AM +0900, Minchan Kim wrote:
> binder_update_page_range needs down_write of mmap_sem because
> vm_insert_page need to change vma->vm_flags to VM_MIXEDMAP unless
> it is set. However, when I profile binder working, it seems
> every binder buffers should be mapped in advance by binder_mmap.
> It means we could set VM_MIXEDMAP in bider_mmap time which is
> already hold a mmap_sem as down_write so binder_update_page_range
> doesn't need to hold a mmap_sem as down_write.
> 
> Android suffers from mmap_sem contention so let's reduce mmap_sem
> down_write.
> 
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arve Hjønnevåg <arve@android.com>
> Reviewed-by: Martijn Coenen <maco@android.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Sent wrong version. Sorry for that. Please ignore this and take it.

>From 480e992d4a650fb98e1397114d75dea7af8e6d0c Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Wed, 28 Mar 2018 11:32:42 +0900
Subject: [PATCH v3] ANDROID: binder: change down_write to down_read
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
