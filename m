Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7001ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513CE2084E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QQCp1QnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513CE2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbeGPRUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:20:49 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:49754 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbeGPRUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:20:49 -0400
Received: by mail-yw0-f202.google.com with SMTP id w190-v6so13365648ywg.16
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 09:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=Vv2zUSqUEoVObJ7gX9tQ/jmINLK6RKnaNNb6+C7byY4=;
        b=QQCp1QnON717jciiDCMJHtWx1vB7WSKK/o0Q09wdpm0eQISvVXwMiYAwPZJwLDeNfo
         V0KI4X8qFD8fPeJErjiYfXNAwewsK76FUuOeeDbndbdOm5BccYUm01zxKSQ6KYdA/NH3
         1wCYvM1D/TD1CsSVzlcfU+MuetwfUyCG6E8T2z4PH9bn/swhW0EYwrjVBtNPmYIi2vVk
         Ri2bBQUW2E+38uxmxXe+ogR3tTmiGMSmAQsc2cEbqOjLQw1vEMJ+wco7TTnOkteyZ4fG
         NrkqD19NjFaMq+BGHQv1izSMK+1GHSMceZj3B9va/1zDCVVlsMq67WcD6CWBddXNVD7x
         fJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=Vv2zUSqUEoVObJ7gX9tQ/jmINLK6RKnaNNb6+C7byY4=;
        b=RR71lV+HaxEVS+jWCDXguUxy5GVWVziE6y3B2JcnlOT5eCA2yBqWGtVX8DrF3nPBRZ
         GTzyAw0kTWw0LotGzpzt9te9Iy6+fbBHCjy4Q5u6r8mUe2PzsUujeg71PrxWjua39dzp
         sUzwgCyRkz/mO5JU6FyR5+KRE5wHncFihoqSJfmg40C/EEkHOEKt9XpCiPWz9jZKkHx0
         s97cStZuLhuR3293ldoKzH5Xmxg/awzEaSudGX9a5e9N+urcoysXAWjbScxqe0pnB/Sl
         yjUnh/2y3SxYSvw2pP/Kp2rSDt+nvI9EeUXiri98pK9kWpgt5969RT9wxanbYZ9oQKCv
         5lBA==
X-Gm-Message-State: AOUpUlEB5OYP8J4zlLlGMA1jaY9EtA/4cEbyeXx+Ut4rLjIiq3P7Z2pk
        +iQHj/vQLzutyApgiNrvseFFz11DjQ==
X-Google-Smtp-Source: AAOMgpewhSbveTLkjo6hHIV9Qu8ws1I82EDUeHt6qLbl9Ittn6Wu+hWbFY3yQs0f0eOU9Blwk8ISovYFfw==
MIME-Version: 1.0
X-Received: by 2002:a25:39d3:: with SMTP id g202-v6mr5618773yba.4.1531759952995;
 Mon, 16 Jul 2018 09:52:32 -0700 (PDT)
Date:   Mon, 16 Jul 2018 18:51:54 +0200
Message-Id: <20180716165154.58794-1-jannh@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH v4] bsg: mitigate read/write abuse, block uaccess in release
From:   Jann Horn <jannh@google.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        jannh@google.com
Cc:     linux-kernel@vger.kernel.org,
        Douglas Gilbert <dgilbert@interlog.com>,
        Al Viro <viro@zeniv.linux.org.uk>, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, kernel-hardening@lists.openwall.com,
        security@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Al Viro noted in commit 128394eff343 ("sg_write()/bsg_write() is not fit
to be called under KERNEL_DS"), bsg improperly accesses userspace
memory outside the provided buffer, permitting kernel memory corruption via
splice().
But bsg doesn't just do it on ->write(), also on ->read() and ->release().

As a band-aid, make sure that the ->read() and ->write() handlers can not
be called in weird contexts (kernel context or credentials different from
file opener), like for ib_safe_file_access().
Also, completely prevent user memory accesses in ->release() context.

Also put a deprecation warning in the read/write handlers.

This is similar to commit 26b5b874aff5 ("scsi: sg: mitigate read/write
abuse"), which deals with similar issues in /dev/sg*.

Fixes: 3d6392cfbd7d ("bsg: support for full generic block layer SG v3")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jann Horn <jannh@google.com>
---
Resending for bsg as requested by Christoph Hellwig.

("PATCH v4" is a bit of a misnomer, but probably less confusing than
anything else I could have put in the subject line? Is there a canonical
way to deal with patch series that have been split up?)

changes:
 - fix control flow in bsg_transport_complete_rq (v1 had a bug there)
 - extract bsg part, since sg part has already landed separately
   (Christoph Hellwig)
 - put deprecation warning in read/write handlers, similar to Linus'
   suggested patch for sg

 block/bsg-lib.c     |  7 +++++--
 block/bsg.c         | 43 ++++++++++++++++++++++++++++++++++---------
 include/linux/bsg.h |  3 ++-
 3 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index 9419def8c017..e21f246526e2 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -53,7 +53,8 @@ static int bsg_transport_fill_hdr(struct request *rq, struct sg_io_v4 *hdr,
 	return 0;
 }
 
-static int bsg_transport_complete_rq(struct request *rq, struct sg_io_v4 *hdr)
+static int bsg_transport_complete_rq(struct request *rq, struct sg_io_v4 *hdr,
+				     bool cleaning_up)
 {
 	struct bsg_job *job = blk_mq_rq_to_pdu(rq);
 	int ret = 0;
@@ -79,7 +80,9 @@ static int bsg_transport_complete_rq(struct request *rq, struct sg_io_v4 *hdr)
 	if (job->reply_len && hdr->response) {
 		int len = min(hdr->max_response_len, job->reply_len);
 
-		if (copy_to_user(uptr64(hdr->response), job->reply, len))
+		if (cleaning_up)
+			ret = -EINVAL;
+		else if (copy_to_user(uptr64(hdr->response), job->reply, len))
 			ret = -EFAULT;
 		else
 			hdr->response_len = len;
diff --git a/block/bsg.c b/block/bsg.c
index 3da540faf673..deedce8c9ec2 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -21,6 +21,7 @@
 #include <linux/idr.h>
 #include <linux/bsg.h>
 #include <linux/slab.h>
+#include <linux/cred.h> /* for bsg_check_file_access() */
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_ioctl.h>
@@ -159,7 +160,8 @@ static int bsg_scsi_fill_hdr(struct request *rq, struct sg_io_v4 *hdr,
 	return 0;
 }
 
-static int bsg_scsi_complete_rq(struct request *rq, struct sg_io_v4 *hdr)
+static int bsg_scsi_complete_rq(struct request *rq, struct sg_io_v4 *hdr,
+				bool cleaning_up)
 {
 	struct scsi_request *sreq = scsi_req(rq);
 	int ret = 0;
@@ -179,7 +181,9 @@ static int bsg_scsi_complete_rq(struct request *rq, struct sg_io_v4 *hdr)
 		int len = min_t(unsigned int, hdr->max_response_len,
 					sreq->sense_len);
 
-		if (copy_to_user(uptr64(hdr->response), sreq->sense, len))
+		if (cleaning_up)
+			ret = -EINVAL;
+		else if (copy_to_user(uptr64(hdr->response), sreq->sense, len))
 			ret = -EFAULT;
 		else
 			hdr->response_len = len;
@@ -381,11 +385,12 @@ static struct bsg_command *bsg_get_done_cmd(struct bsg_device *bd)
 }
 
 static int blk_complete_sgv4_hdr_rq(struct request *rq, struct sg_io_v4 *hdr,
-				    struct bio *bio, struct bio *bidi_bio)
+				    struct bio *bio, struct bio *bidi_bio,
+				    bool cleaning_up)
 {
 	int ret;
 
-	ret = rq->q->bsg_dev.ops->complete_rq(rq, hdr);
+	ret = rq->q->bsg_dev.ops->complete_rq(rq, hdr, cleaning_up);
 
 	if (rq->next_rq) {
 		blk_rq_unmap_user(bidi_bio);
@@ -451,7 +456,7 @@ static int bsg_complete_all_commands(struct bsg_device *bd)
 			break;
 
 		tret = blk_complete_sgv4_hdr_rq(bc->rq, &bc->hdr, bc->bio,
-						bc->bidi_bio);
+						bc->bidi_bio, true);
 		if (!ret)
 			ret = tret;
 
@@ -486,7 +491,7 @@ __bsg_read(char __user *buf, size_t count, struct bsg_device *bd,
 		 * bsg_complete_work() cannot do that for us
 		 */
 		ret = blk_complete_sgv4_hdr_rq(bc->rq, &bc->hdr, bc->bio,
-					       bc->bidi_bio);
+					       bc->bidi_bio, false);
 
 		if (copy_to_user(buf, &bc->hdr, sizeof(bc->hdr)))
 			ret = -EFAULT;
@@ -523,6 +528,15 @@ static inline int err_block_err(int ret)
 	return 0;
 }
 
+static int bsg_check_file_access(struct file *file, const char *caller)
+{
+	if (file->f_cred != current_real_cred())
+		return -EPERM;
+	if (uaccess_kernel())
+		return -EACCES;
+	return 0;
+}
+
 static ssize_t
 bsg_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
@@ -532,6 +546,13 @@ bsg_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 
 	bsg_dbg(bd, "read %zd bytes\n", count);
 
+	pr_err_once("process %d (%s) does direct read on /dev/bsg/*\n",
+		task_tgid_vnr(current), current->comm);
+
+	ret = bsg_check_file_access(file, __func__);
+	if (ret)
+		return ret;
+
 	bsg_set_block(bd, file);
 
 	bytes_read = 0;
@@ -606,8 +627,12 @@ bsg_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 
 	bsg_dbg(bd, "write %zd bytes\n", count);
 
-	if (unlikely(uaccess_kernel()))
-		return -EINVAL;
+	pr_err_once("process %d (%s) does direct write on /dev/bsg/*\n",
+		task_tgid_vnr(current), current->comm);
+
+	ret = bsg_check_file_access(file, __func__);
+	if (ret)
+		return ret;
 
 	bsg_set_block(bd, file);
 
@@ -857,7 +882,7 @@ static long bsg_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 		at_head = (0 == (hdr.flags & BSG_FLAG_Q_AT_TAIL));
 		blk_execute_rq(bd->queue, NULL, rq, at_head);
-		ret = blk_complete_sgv4_hdr_rq(rq, &hdr, bio, bidi_bio);
+		ret = blk_complete_sgv4_hdr_rq(rq, &hdr, bio, bidi_bio, false);
 
 		if (copy_to_user(uarg, &hdr, sizeof(hdr)))
 			return -EFAULT;
diff --git a/include/linux/bsg.h b/include/linux/bsg.h
index dac37b6e00ec..c22bc359552a 100644
--- a/include/linux/bsg.h
+++ b/include/linux/bsg.h
@@ -11,7 +11,8 @@ struct bsg_ops {
 	int	(*check_proto)(struct sg_io_v4 *hdr);
 	int	(*fill_hdr)(struct request *rq, struct sg_io_v4 *hdr,
 				fmode_t mode);
-	int	(*complete_rq)(struct request *rq, struct sg_io_v4 *hdr);
+	int	(*complete_rq)(struct request *rq, struct sg_io_v4 *hdr,
+				bool cleaning_up);
 	void	(*free_rq)(struct request *rq);
 };
 
-- 
2.18.0.203.gfac676dfb9-goog

