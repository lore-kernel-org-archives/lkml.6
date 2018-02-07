Return-Path: <tkjos@android.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518040672; cv=none;
        d=google.com; s=arc-20160816;
        b=sRCsNcS/C41EBGf52IjwyuEzvSWg6HxRqOXwuMSVRULtJdZIQB2t2aIBYswX90n8aR
         9R/3/uQZU6QLxRqiBi8LNpEnnptgoHGid+AzChzm/1Cnre/J0c8S5U0hoyhpg/IqK/Kd
         Bl+4gwOfmsE27VqLGb02AZQ2GcncP8ZskIbvX53KxfCtVT6zmqnjtf3BTrRI/QdLia3s
         RWhR5Y1gi5tX2IYfM1q1vAaS23+Mh5y6aQGBr2d9WMggpAYFxfHMTkUuoKmTsf9T8CbB
         WlUrKhPS2opdkgymro7uqpSqMInVVx4qx+ORSyxcHfRrQniip02VqtsD43DKe/icn4Ue
         HN7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:to:from:dkim-signature
         :arc-authentication-results;
        bh=+3JvWWN7bOSuAFhnIEkLDzQqJaROPb+1mhFVa7KgSw8=;
        b=Hi4xdB1wLwuc+cIxmAnl6xA/EYyLXt3Yv9kF9SeqHFItGULgYSl9B8jIFZxgAKpWN7
         yHKymHRkt2aETYQ6Jp6rtBch/M7Tnlgn6eO8PX+h1BXaR/8AKEeVuzNY65k0mfv4DlC4
         ctIDTI9a2GY5Po/JuE9bWX/KQp60aSGt3wMmSJEwCLClMkTqqlQ698ZCyUaW8m1b7gTH
         Ys2Y1/2JwYJJWvm/pxZaW5mgw+LABTbPSWQMZXZNQtClwKs7nOrHxnLHM46JNVG8JkLZ
         HghxbFdKKA4XslLWtKpK7ybIo5P2kLAhB7r5W3/vf+AWBiOx14OnWDDUJtUPrh5Pvehr
         UjUw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=X3dPMYeM;
       spf=pass (google.com: domain of tkjos@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tkjos@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=X3dPMYeM;
       spf=pass (google.com: domain of tkjos@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tkjos@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
X-Google-Smtp-Source: AH8x226NKuOlc2yes9xUIdJ+2mDu6zna8Xvx8QuLoLnzgYIJ7duObpcX1y5qc+iSvwCiP5idv2mMPw==
From: Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To: tkjos@google.com,
	gregkh@linuxfoundation.org,
	arve@android.com,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	maco@google.com
Subject: [PATCH] binder: replace "%p" with "%pK"
Date: Wed,  7 Feb 2018 13:57:37 -0800
Message-Id: <20180207215737.251082-1-tkjos@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591781015607420162?=
X-GMAIL-MSGID: =?utf-8?q?1591781015607420162?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The format specifier "%p" can leak kernel addresses. Use
"%pK" instead. There were 4 remaining cases in binder.c.

Signed-off-by: Todd Kjos <tkjos@google.com>
Cc: stable <stable@vger.kernel.org>
---
 drivers/android/binder.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 37289683939c..7da09b10dae8 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2141,7 +2141,7 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 	int debug_id = buffer->debug_id;
 
 	binder_debug(BINDER_DEBUG_TRANSACTION,
-		     "%d buffer release %d, size %zd-%zd, failed at %p\n",
+		     "%d buffer release %d, size %zd-%zd, failed at %pK\n",
 		     proc->pid, buffer->debug_id,
 		     buffer->data_size, buffer->offsets_size, failed_at);
 
@@ -3653,7 +3653,7 @@ static int binder_thread_write(struct binder_proc *proc,
 				}
 			}
 			binder_debug(BINDER_DEBUG_DEAD_BINDER,
-				     "%d:%d BC_DEAD_BINDER_DONE %016llx found %p\n",
+				     "%d:%d BC_DEAD_BINDER_DONE %016llx found %pK\n",
 				     proc->pid, thread->pid, (u64)cookie,
 				     death);
 			if (death == NULL) {
@@ -4968,7 +4968,7 @@ static void print_binder_transaction_ilocked(struct seq_file *m,
 	spin_lock(&t->lock);
 	to_proc = t->to_proc;
 	seq_printf(m,
-		   "%s %d: %p from %d:%d to %d:%d code %x flags %x pri %ld r%d",
+		   "%s %d: %pK from %d:%d to %d:%d code %x flags %x pri %ld r%d",
 		   prefix, t->debug_id, t,
 		   t->from ? t->from->proc->pid : 0,
 		   t->from ? t->from->pid : 0,
@@ -4992,7 +4992,7 @@ static void print_binder_transaction_ilocked(struct seq_file *m,
 	}
 	if (buffer->target_node)
 		seq_printf(m, " node %d", buffer->target_node->debug_id);
-	seq_printf(m, " size %zd:%zd data %p\n",
+	seq_printf(m, " size %zd:%zd data %pK\n",
 		   buffer->data_size, buffer->offsets_size,
 		   buffer->data);
 }
-- 
2.16.0.rc1.238.g530d649a79-goog
