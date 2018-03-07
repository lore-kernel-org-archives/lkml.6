Return-Path: <paullawrence@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520458851; cv=none;
        d=google.com; s=arc-20160816;
        b=S4tbqfZS9SE+oqqoSBa6xn0coZiVp+A5pR6EMpxOTg5aGW4FChxihDo2ipev93Jj+5
         XwLz9RHtCy8lssZ0DtlEhl+qqzZxnyJhDrQYWMOd7pirXSrK3aDWK50DsZBsbWjs+URC
         U/aU6SM8Snd6tdB+oq5uYTI6f7MwuvCkMOsOIHNWA9JLTenye3xFHXTQd/b9i1OFcisH
         37J0zFbstutBkONBoGssjQb1gV7/PsBCW3Ko4LPNdGgdZkfvCtGyn+PyObI3zEpQ//HU
         +xaPaeaIBD4veNb3k17BMUKNmyjKkxxH0GRbetoJO/43+k7pcu+5Spp4+hC9tLODZhTV
         phPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=u4Vhm/eZ+riIyfjjPrRuoBA80Cv/bPWVvRfrRQPJIoM=;
        b=DGicvmjljgUFFwmBJ6VYNtXW7A5AYLVodgcWpjg7gVh4gr8ez7eNUZfcF98q3RuZSr
         1YI2b5IE+W9+KSAf105MhC3V97xLwb1xE8BZc5FzTbjlbMvw2PS6UbKRN5MCYd7B1IJr
         fOKM+pfYTgRV9ZgztxueXO56KmzwyR57W23w6o9kxGzpNPSIbRKBv1wo/WxBhOqJ0fGN
         rKzXkqR/HMqiiF3EzwDugfPWsQKoWnToEv+bBIoM8kHFk+v3tkYS4Mq97VUXwyD80RcP
         8boQH/IF0gtT7CleGj1F3eg8woBD2t8ZcmqSpc5F9gpAVqd4tpNFigo9q5HVSxQAOoXD
         kKmg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=mWuU5wTX;
       spf=pass (google.com: domain of paullawrence@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=paullawrence@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=mWuU5wTX;
       spf=pass (google.com: domain of paullawrence@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=paullawrence@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELsA71G81u2ZRPt7I90IRiHMhSSdJ7eFVsdXj3ckZTd/ngxKyz4cxpwOmDNCkE7G4XOL4gZFbw==
From: Paul Lawrence <paullawrence@google.com>
To: linux-kernel@vger.kernel.org
Cc: Paul Lawrence <paullawrence@google.com>,
	stable@vger.kernel.org,
	Ben Hutchings <ben@decadent.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Martijn Coenen <maco@android.com>,
	devel@driverdev.osuosl.org
Subject: [PATCH] staging: android: ashmem: Remove deadlock
Date: Wed,  7 Mar 2018 13:40:30 -0800
Message-Id: <20180307214042.135109-1-paullawrence@google.com>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594316660298021299?=
X-GMAIL-MSGID: =?utf-8?q?1594316660298021299?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Regression introduced in commit ce8a3a9e76d0193e2e8d74a06d275b3c324ca652
("staging: android: ashmem: Fix a race condition in pin ioctls")
causing deadlock.

No need to hold ashmem_mutex while copying from user

Stacks are:

ashmem_mmap+0x53/0x400 drivers/staging/android/ashmem.c:379
mmap_region+0x7dd/0xfd0 mm/mmap.c:1694
do_mmap+0x57b/0xbe0 mm/mmap.c:1473

and

lock_acquire+0x12e/0x410 kernel/locking/lockdep.c:3756
__might_fault+0x14a/0x1d0 mm/memory.c:4014
copy_from_user arch/x86/include/asm/uaccess.h:705 [inline]
ashmem_pin_unpin drivers/staging/android/ashmem.c:719 [inline]

Signed-off-by: Paul Lawrence <paullawrence@google.com>
Cc: <stable@vger.kernel.org> # 4.9.x
Cc: <stable@vger.kernel.org> # 4.4.x
Cc: <stable@vger.kernel.org> # 3.18.x: ce8a3a9e76d01
Cc: <stable@vger.kernel.org> # 3.18.x
Cc: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/android/ashmem.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index 6dbba5aff191..8c55706c2cfa 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -702,16 +702,14 @@ static int ashmem_pin_unpin(struct ashmem_area *asma, unsigned long cmd,
 	size_t pgstart, pgend;
 	int ret = -EINVAL;
 
+	if (unlikely(copy_from_user(&pin, p, sizeof(pin))))
+		return -EFAULT;
+
 	mutex_lock(&ashmem_mutex);
 
 	if (unlikely(!asma->file))
 		goto out_unlock;
 
-	if (unlikely(copy_from_user(&pin, p, sizeof(pin)))) {
-		ret = -EFAULT;
-		goto out_unlock;
-	}
-
 	/* per custom, you can pass zero for len to mean "everything onward" */
 	if (!pin.len)
 		pin.len = PAGE_ALIGN(asma->size) - pin.offset;
-- 
2.16.2.395.g2e18187dfd-goog
