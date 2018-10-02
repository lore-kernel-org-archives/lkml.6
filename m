Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211CCC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FB82083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0FB82083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbeJBUQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:16:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34902 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbeJBUQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:16:52 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 69F74BF0;
        Tue,  2 Oct 2018 13:33:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 071/137] iomap: complete partial direct I/O writes synchronously
Date:   Tue,  2 Oct 2018 06:24:32 -0700
Message-Id: <20181002132503.551607066@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit ebf00be37de35788cad72f4f20b4a39e30c0be4a ]

According to xfstest generic/240, applications seem to expect direct I/O
writes to either complete as a whole or to fail; short direct I/O writes
are apparently not appreciated.  This means that when only part of an
asynchronous direct I/O write succeeds, we can either fail the entire
write, or we can wait for the partial write to complete and retry the
remaining write as buffered I/O.  The old __blockdev_direct_IO helper
has code for waiting for partial writes to complete; the new
iomap_dio_rw iomap helper does not.

The above mentioned fallback mode is needed for gfs2, which doesn't
allow block allocations under direct I/O to avoid taking cluster-wide
exclusive locks.  As a consequence, an asynchronous direct I/O write to
a file range that contains a hole will result in a short write.  In that
case, wait for the short write to complete to allow gfs2 to recover.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/iomap.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -693,6 +693,7 @@ struct iomap_dio {
 	atomic_t		ref;
 	unsigned		flags;
 	int			error;
+	bool			wait_for_completion;
 
 	union {
 		/* used during submission and for synchronous completion: */
@@ -793,9 +794,8 @@ static void iomap_dio_bio_end_io(struct
 		iomap_dio_set_error(dio, blk_status_to_errno(bio->bi_status));
 
 	if (atomic_dec_and_test(&dio->ref)) {
-		if (is_sync_kiocb(dio->iocb)) {
+		if (dio->wait_for_completion) {
 			struct task_struct *waiter = dio->submit.waiter;
-
 			WRITE_ONCE(dio->submit.waiter, NULL);
 			wake_up_process(waiter);
 		} else if (dio->flags & IOMAP_DIO_WRITE) {
@@ -980,13 +980,12 @@ iomap_dio_rw(struct kiocb *iocb, struct
 	dio->end_io = end_io;
 	dio->error = 0;
 	dio->flags = 0;
+	dio->wait_for_completion = is_sync_kiocb(iocb);
 
 	dio->submit.iter = iter;
-	if (is_sync_kiocb(iocb)) {
-		dio->submit.waiter = current;
-		dio->submit.cookie = BLK_QC_T_NONE;
-		dio->submit.last_queue = NULL;
-	}
+	dio->submit.waiter = current;
+	dio->submit.cookie = BLK_QC_T_NONE;
+	dio->submit.last_queue = NULL;
 
 	if (iov_iter_rw(iter) == READ) {
 		if (pos >= dio->i_size)
@@ -1016,7 +1015,7 @@ iomap_dio_rw(struct kiocb *iocb, struct
 	WARN_ON_ONCE(ret);
 	ret = 0;
 
-	if (iov_iter_rw(iter) == WRITE && !is_sync_kiocb(iocb) &&
+	if (iov_iter_rw(iter) == WRITE && !dio->wait_for_completion &&
 	    !inode->i_sb->s_dio_done_wq) {
 		ret = sb_init_dio_done_wq(inode->i_sb);
 		if (ret < 0)
@@ -1031,8 +1030,10 @@ iomap_dio_rw(struct kiocb *iocb, struct
 				iomap_dio_actor);
 		if (ret <= 0) {
 			/* magic error code to fall back to buffered I/O */
-			if (ret == -ENOTBLK)
+			if (ret == -ENOTBLK) {
+				dio->wait_for_completion = true;
 				ret = 0;
+			}
 			break;
 		}
 		pos += ret;
@@ -1046,7 +1047,7 @@ iomap_dio_rw(struct kiocb *iocb, struct
 		iomap_dio_set_error(dio, ret);
 
 	if (!atomic_dec_and_test(&dio->ref)) {
-		if (!is_sync_kiocb(iocb))
+		if (!dio->wait_for_completion)
 			return -EIOCBQUEUED;
 
 		for (;;) {


