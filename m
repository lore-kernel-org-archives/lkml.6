Return-Path: <baijiaju1990@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525770408; cv=none;
        d=google.com; s=arc-20160816;
        b=NjI3fpmVrunW0MtqdadXIqTn3HHbd/es+l8SH+8d3aasMHWFZBgGKOzasNqSJ2I1Lu
         /TZqJSQ4CwDL39R7dWZWlPusiHQ/WPG/cQM5LgVyXpgdQV7XZpSIsNlFMf5mjakVUtY7
         hsDVASO8H7pNlQd16J4l1JWFGoM0CzlbcgQtplbabdySKclFP/TjfcrjbeNawQS5hFLq
         kShHVYiMvkljehe9yoWxSg7gpjEv/B22UxKVsoeOHCEyoqhsDj+qXzY86vJaftS8V7z+
         Y5+TnYGkmwW/nSciRQRVk3Zhoi1bV91dkTvvdywgBMEzhMfUhSmOE4B4rN5Ml4/NpOMX
         DCDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=lZCTNsYiE+droQiYeJWtssiD0JCUWQy57jGyZYntK8g=;
        b=MgMnSQf9K2CBN4+6Iy3I2yOUNVp1KSlWLi3eWUn9QjD9cbXSPlAjjnUHPDyl3MhQfw
         PiOG7lnuH+sF512+pVTQIBAayqUqGqwIG8X1mL5pgYJGkZfCwcDGl5qqhsKzYGE29jEb
         j69dlhJUvLxzukS2zQTB8BYPjpMaofxj04CKoH2FN8SgOlc3IT79o5SBjPlLv3P3L2oJ
         MNj1xlUzwAyTTxuBPlUhAnmBq/FlLyfHpoUdBwFLRhg90tJ2TJeKKg1MJVhSyqBjk9a6
         Dm1olVbs+bS80EyNZro6TVaEM2dfGjku5D1QCwxAugYkKxYeKCuiDab0rqD3Jc26foAX
         d45g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DZxsSsiQ;
       spf=pass (google.com: domain of baijiaju1990@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=baijiaju1990@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DZxsSsiQ;
       spf=pass (google.com: domain of baijiaju1990@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=baijiaju1990@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrdXNOPzfVuBDEEKMRDTzxuGsbOa1vOEhnAER68H/FRXvTRfXh9IlFWazSFKkukKq+QAMSrtw==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	maco@android.com
Cc: devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] android: binder: Fix a possible data race in binder_alloc_mmap_handler
Date: Tue,  8 May 2018 17:06:39 +0800
Message-Id: <20180508090639.14275-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599886231521179884?=
X-GMAIL-MSGID: =?utf-8?q?1599886231521179884?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The write operations to "alloc->buffer" are protected by
the lock on line 679 and 730, but the read operation to
this data on line 712 is not protected by the lock.
Thus, there may exist a data race for "alloc->buffer".

To fix this data race, the read operation to "alloc->buffer" 
should be also protected by the lock.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/android/binder_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 5a426c877dfb..596acc3a84e4 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -709,7 +709,9 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 		goto err_alloc_buf_struct_failed;
 	}
 
+	mutex_lock(&binder_alloc_mmap_lock);
 	buffer->data = alloc->buffer;
+	mutex_unlock(&binder_alloc_mmap_lock);
 	list_add(&buffer->entry, &alloc->buffers);
 	buffer->free = 1;
 	binder_insert_free_buffer(alloc, buffer);
-- 
2.17.0
