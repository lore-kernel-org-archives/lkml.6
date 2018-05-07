Return-Path: <minchan.kim@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525702546; cv=none;
        d=google.com; s=arc-20160816;
        b=k8FWG4dLCaHQXx3N/49cJ2yCX7abAHq4nAzDjOsgoLub1PgtKnMghdPhCSYG/7Sv+t
         F7uGLhY8jBc8xVY0pOGJYjvCiD7ZvJv65PtOUEKlc4YxWeqLYwGBPjViQBXMmLMwBkSt
         xyvd9pdxL0eJVF6GJGubybt0dJPDHnaaFwPgRe1cPLvrtA4n1iHcd8XPBKwsx8o4ZVfz
         g9dJM+QogpV3zAzwSpJ0NMdHDJWKXc+PwUsnvncc/ORe2GG+BoKjJAEJASOcIekziL77
         CkOqGvXESoLcF+O0PccQa0do5SAbkARXL7uXX0h8s5c/d2qOO3sdUBXrj8k3kjchNTU1
         4pqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:dkim-signature:arc-authentication-results;
        bh=A8za/HAl2IiLicvYE/2KOWhqmHyqEzVAnVWz7lYvwto=;
        b=rUSGvXcLkaevWbzkVEeW3Hd6JWV16xK02QDJWpjM5jkSSD0EhcJBqAeARk6B7B1JUs
         UHfiD2x/T0dwHsdiuTmPSeEZDIOg7MW/Cv47/hc5epR9GNIvoIonJzrU4beRwDW7+GPP
         wvC8XDWyGLNlx/EWfTSb5AqezFSNfipU/a27voSxkMSxy8et5NZyPAx+j+92rS3eMHYG
         82Le2ZlMIPr+vBoD0IYZB0/myh+ecZUR/mSFzlQAxniCWBODzBjk6FCX3Ba/5ymcv/5A
         Xh+8DVtRD77Qrc4COqf6zQxLDS7/FY0qWaNKnDlXGlrWJ4ZEsBWnsm8act+Jfx8Dicd7
         QHCg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bhB/NEn8;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bhB/NEn8;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Google-Smtp-Source: AB8JxZrInYWV3192pHeDCCc/dTRmQupY8OCyxwj4OqkOrc+ZQGtt48lgeLirPMPnJml41eGuBwMQ+g==
Sender: Minchan Kim <minchan.kim@gmail.com>
From: Minchan Kim <minchan@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Ganesh Mahendran <opensource.ganesh@gmail.com>,
	Joe Perches <joe@perches.com>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Martijn Coenen <maco@android.com>
Subject: [PATCH v6] ANDROID: binder: change down_write to down_read
Date: Mon,  7 May 2018 23:15:37 +0900
Message-Id: <20180507141537.4855-1-minchan@kernel.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599815073448562806?=
X-GMAIL-MSGID: =?utf-8?q?1599815073448562806?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

binder_update_page_range needs down_write of mmap_sem because
vm_insert_page need to change vma->vm_flags to VM_MIXEDMAP unless
it is set. However, when I profile binder working, it seems
every binder buffers should be mapped in advance by binder_mmap.
It means we could set VM_MIXEDMAP in binder_mmap time which is
already hold a mmap_sem as down_write so binder_update_page_range
doesn't need to hold a mmap_sem as down_write.
Please use proper API down_read. It would help mmap_sem contention
problem as well as fixing down_write abuse.

Ganesh Mahendran tested app launching and binder throughput test
and he said he couldn't find any problem and I did binder latency
test per Greg KH request(Thanks Martijn to teach me how I can do)
I cannot find any problem, too.

Cc: Ganesh Mahendran <opensource.ganesh@gmail.com>
Cc: Joe Perches <joe@perches.com>
Cc: Arve Hjønnevåg <arve@android.com>
Cc: Todd Kjos <tkjos@google.com>
Reviewed-by: Martijn Coenen <maco@android.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 drivers/android/binder.c       | 4 +++-
 drivers/android/binder_alloc.c | 6 +++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 4eab5be3d00f..7b8e96f60719 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4730,7 +4730,9 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
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
2.17.0.441.gb46fe60e1d-goog
