Return-Path: <minchan.kim@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522204984; cv=none;
        d=google.com; s=arc-20160816;
        b=VPwGzTJ6t3aFPuz6nfaR5SE77Dg0k8SPwJWih5iFlRPeSFWtdMWArV+AncK43LzdoG
         Ee1BGWAeVdYq2mPyZyUJEXrvtbX7oaPpgwuf3qIdsEt0LV143mwJIX+yXan5jXRAE4y3
         L3fLUksDNcNRj0xFw+ToX5AJmodu/TOzFcSWVsL4RSlgMlcf2FtWdHYPhI+SqJQlLfxh
         ym7cmToQXf8BAgfA+5ivl4bdc3x5rQSEwJrtdenF6aNzxa4XhZcX9TQh4ncbd8QGKmqq
         yJkSn084sAHuKOwH0ZxXTdMfWCVGqHhe97TmAZ139hqSbYtJVTBdXA7PWoQ+5Nlvghnx
         Claw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:sender:dkim-signature
         :arc-authentication-results;
        bh=ZyiASAWzA5FNg52XeRfImeS/Xl9zZV1iV2JBY9hNYyU=;
        b=u4NVEEoZgzzjRydywSyxIfbFlvJkP+Dh4E0IMhywlaSsBIPqDfU7yLiXBYGqlUjn5/
         n5G5otPCsrj8cbRVj4rFFiO8RRfsmHvS0OaSl5N/lknuQ4bbkjrI0jlmda2Zba669+tY
         jvOC7zzCjPqZVpFKWABiQTIyy9H8ZkDXuaM/pCRfBabYz9fDmRh7nDKX0P1VrvGcd+Fx
         diT48XFA1BTvOfkVE/71xJH6dfBIrE+5CT+MYNM9jNImw8UeoyvazlKXKtp+0oZumZaR
         3lwLY7looWhYT9LTpPt+tKcr1HVZ+KxUjsfeU2QnTLxFQWyi5Tywc7ftUkl6NvwuG+aT
         /d2g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=g9S/S2tI;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=g9S/S2tI;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
X-Google-Smtp-Source: AIpwx49eWlAdEDLLLRgJ9qbvntvu2HubdgGCcXIylJ/+sJwWbfOQK7wsuwtwSAWH9nDd6W/KWFu8fw==
Sender: Minchan Kim <minchan.kim@gmail.com>
From: Minchan Kim <minchan@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Martijn Coenen <maco@android.com>,
	Todd Kjos <tkjos@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] ANDROID: binder: change down_write to down_read
Date: Wed, 28 Mar 2018 11:42:31 +0900
Message-Id: <20180328024231.239725-1-minchan@kernel.org>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596147613657109396?=
X-GMAIL-MSGID: =?utf-8?q?1596147613657109396?=
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

Cc: Martijn Coenen <maco@android.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 drivers/android/binder.c       | 2 +-
 drivers/android/binder_alloc.c | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

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
index 5a426c877dfb..a184bf12eb15 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -219,7 +219,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 		mm = alloc->vma_vm_mm;
 
 	if (mm) {
-		down_write(&mm->mmap_sem);
+		down_read(&mm->mmap_sem);
 		vma = alloc->vma;
 	}
 
@@ -229,6 +229,8 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 		goto err_no_vma;
 	}
 
+	WARN_ON_ONCE(vma && !(vma->vm_flags & VM_MIXEDMAP));
+
 	for (page_addr = start; page_addr < end; page_addr += PAGE_SIZE) {
 		int ret;
 		bool on_lru;
@@ -288,7 +290,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 		/* vm_insert_page does not seem to increment the refcount */
 	}
 	if (mm) {
-		up_write(&mm->mmap_sem);
+		up_read(&mm->mmap_sem);
 		mmput(mm);
 	}
 	return 0;
@@ -321,7 +323,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
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
