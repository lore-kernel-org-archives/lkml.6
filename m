Return-Path: <minchan.kim@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522291041; cv=none;
        d=google.com; s=arc-20160816;
        b=SoZHOPoWMWwN02zG2FPf7I0hCHMLLEg+aq09oB45AyVm7eFrOddXLOs5Rm9a+Xxc9V
         AJXeZvgJr4cffXgLio95DbnKYV8GDV2sC+KEYLWoS83jiLk267weRqczXG3CakCiLbYL
         oQBppUfg6XO5S0Lgo5AAQLaboreDBs9PbznE39x8Q96lln+kmLuauUjPw+TmbWW66ImM
         8QZutzyRkI2L+tP1I4m5mv9kp35xte1x50vc0qZ414kZlgXG24oPa0hSd07LhMHPGPAi
         j1PbZ8u2BA4KlA+79upAuqWIKxH/3V3FNZjgWQH9mrnJwnE4cd+vwMVEcvffwhZrxINK
         wzdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:dkim-signature:arc-authentication-results;
        bh=HNH/LKSvsRp5XP2Ozip2z4GI1SjVDHrJDOvNU4bQSlw=;
        b=Kn3dn4R5Ccg5y1pOrJ5yWDU/KxkFWvRvlrf4xWYR5O6T6zTcGEXw2rWRYP8Cm9T1rU
         a2grHXnMy+B7hZb/5mHm2InrghSfKH9EpF5iNZQfBu5Ao21jBFPEbY2CizuRkD+lW40T
         LLCzLuj2OzQ+mNTeAHS6GVCY9mO7hXscolyYIhZASuQjv+C6Se87tVV17XJalojuPw+y
         JAHqL/1FF0DXSfnnxcwOCqy+guLkpI3dYkek2sHmjVCPC+SyKmtt/mk6al5u89Zgjkms
         9uAmv1xs6OOC+gT15hwbw0qA52srkHaf15GwgrsKbCBByhhp5bYZd2Q5qtL7C/PUe4kL
         oKuA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Mbq/D5EH;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Mbq/D5EH;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
X-Google-Smtp-Source: AIpwx49U2tnmMiNJNrkDZUhv/Xt999XbAzzIarx36peWyOIrpk6NEIkjdVuQeHP1I6llVkP61DcblA==
Sender: Minchan Kim <minchan.kim@gmail.com>
From: Minchan Kim <minchan@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Todd Kjos <tkjos@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Martijn Coenen <maco@android.com>
Subject: [PATCH v3] ANDROID: binder: change down_write to down_read
Date: Thu, 29 Mar 2018 11:37:12 +0900
Message-Id: <20180329023712.133164-1-minchan@kernel.org>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596231778699320743?=
X-GMAIL-MSGID: =?utf-8?q?1596237850535850184?=
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
Cc: Arve Hjønnevåg <arve@android.com>
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
index 764b63a5aade..875ab21fa2e0 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4722,7 +4722,8 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
 		failure_string = "bad vm_flags";
 		goto err_bad_arg;
 	}
-	vma->vm_flags = (vma->vm_flags | VM_DONTCOPY) & ~VM_MAYWRITE;
+	vma->vm_flags = (vma->flags | VM_DONTCOPY | VM_MIXEDMAP) &
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
