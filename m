Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lGEXGwhHGVujOgAAmS7hNA
	; Thu, 07 Jun 2018 14:54:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 84081608B8; Thu,  7 Jun 2018 14:54:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id ED154601C3;
	Thu,  7 Jun 2018 14:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ED154601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935325AbeFGOyD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:54:03 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40966 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935307AbeFGOyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:54:00 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbU-0005Zq-Bp; Thu, 07 Jun 2018 15:09:28 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbB-0003Ay-58; Thu, 07 Jun 2018 15:09:09 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Greg Hackmann" <ghackmann@google.com>,
        "Arve Hjonnevag" <arve@android.com>,
        "Todd Kjos" <tkjos@google.com>,
        "Joel Fernandes" <joelaf@google.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        syzbot+8ec30bb7bf1a981a2012@syzkaller.appspotmail.com
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.570915286@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 316/410] staging: android: ashmem: Fix lockdep issue
 during llseek
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Joel Fernandes <joelaf@google.com>

commit cb57469c9573f6018cd1302953dd45d6e05aba7b upstream.

ashmem_mutex create a chain of dependencies like so:

(1)
mmap syscall ->
  mmap_sem ->  (acquired)
  ashmem_mmap
  ashmem_mutex (try to acquire)
  (block)

(2)
llseek syscall ->
  ashmem_llseek ->
  ashmem_mutex ->  (acquired)
  inode_lock ->
  inode->i_rwsem (try to acquire)
  (block)

(3)
getdents ->
  iterate_dir ->
  inode_lock ->
  inode->i_rwsem   (acquired)
  copy_to_user ->
  mmap_sem         (try to acquire)

There is a lock ordering created between mmap_sem and inode->i_rwsem
causing a lockdep splat [2] during a syzcaller test, this patch fixes
the issue by unlocking the mutex earlier. Functionally that's Ok since
we don't need to protect vfs_llseek.

[1] https://patchwork.kernel.org/patch/10185031/
[2] https://lkml.org/lkml/2018/1/10/48

Acked-by: Todd Kjos <tkjos@google.com>
Cc: Arve Hjonnevag <arve@android.com>
Reported-by: syzbot+8ec30bb7bf1a981a2012@syzkaller.appspotmail.com
Signed-off-by: Joel Fernandes <joelaf@google.com>
Acked-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/android/ashmem.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -330,24 +330,23 @@ static loff_t ashmem_llseek(struct file
 	mutex_lock(&ashmem_mutex);
 
 	if (asma->size == 0) {
-		ret = -EINVAL;
-		goto out;
+		mutex_unlock(&ashmem_mutex);
+		return -EINVAL;
 	}
 
 	if (!asma->file) {
-		ret = -EBADF;
-		goto out;
+		mutex_unlock(&ashmem_mutex);
+		return -EBADF;
 	}
 
+	mutex_unlock(&ashmem_mutex);
+
 	ret = asma->file->f_op->llseek(asma->file, offset, origin);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	/** Copy f_pos from backing file, since f_ops->llseek() sets it */
 	file->f_pos = asma->file->f_pos;
-
-out:
-	mutex_unlock(&ashmem_mutex);
 	return ret;
 }
 
