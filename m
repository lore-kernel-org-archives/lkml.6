Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AF39AC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640E9208C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/8kAsxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640E9208C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935157AbeFLQxf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:53:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935130AbeFLQx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:53:29 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DFB7208B8;
        Tue, 12 Jun 2018 16:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822409;
        bh=wK6TUtYychSxKvAtG5mJbNuofSYrNbkaxbGVU5D48bE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d/8kAsxJucZVMjagDFd4knn7HqidCo5mkz4KRZTOqQzc3Rza10nviCaFy3yGtzB2X
         BUkXJrHxaCmnZKUeMurJPl30WVwwU15SoXwNcOCf8z4wdD5Ek6Odm+agnmt4gi3gn6
         qGtfS4EieDltz59nI3XJt79km2yt7YdxkvZgqehc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <jbacik@fb.com>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH 4.4 06/24] xfs: fix incorrect log_flushed on fsync
Date:   Tue, 12 Jun 2018 18:51:50 +0200
Message-Id: <20180612164816.861511958@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164816.587001852@linuxfoundation.org>
References: <20180612164816.587001852@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit 47c7d0b19502583120c3f396c7559e7a77288a68 upstream.

When calling into _xfs_log_force{,_lsn}() with a pointer
to log_flushed variable, log_flushed will be set to 1 if:
1. xlog_sync() is called to flush the active log buffer
AND/OR
2. xlog_wait() is called to wait on a syncing log buffers

xfs_file_fsync() checks the value of log_flushed after
_xfs_log_force_lsn() call to optimize away an explicit
PREFLUSH request to the data block device after writing
out all the file's pages to disk.

This optimization is incorrect in the following sequence of events:

 Task A                    Task B
 -------------------------------------------------------
 xfs_file_fsync()
   _xfs_log_force_lsn()
     xlog_sync()
        [submit PREFLUSH]
                           xfs_file_fsync()
                             file_write_and_wait_range()
                               [submit WRITE X]
                               [endio  WRITE X]
                             _xfs_log_force_lsn()
                               xlog_wait()
        [endio  PREFLUSH]

The write X is not guarantied to be on persistent storage
when PREFLUSH request in completed, because write A was submitted
after the PREFLUSH request, but xfs_file_fsync() of task A will
be notified of log_flushed=1 and will skip explicit flush.

If the system crashes after fsync of task A, write X may not be
present on disk after reboot.

This bug was discovered and demonstrated using Josef Bacik's
dm-log-writes target, which can be used to record block io operations
and then replay a subset of these operations onto the target device.
The test goes something like this:
- Use fsx to execute ops of a file and record ops on log device
- Every now and then fsync the file, store md5 of file and mark
  the location in the log
- Then replay log onto device for each mark, mount fs and compare
  md5 of file to stored value

Cc: Christoph Hellwig <hch@lst.de>
Cc: Josef Bacik <jbacik@fb.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/xfs/xfs_log.c |    7 -------
 1 file changed, 7 deletions(-)

--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -3323,8 +3323,6 @@ maybe_sleep:
 		 */
 		if (iclog->ic_state & XLOG_STATE_IOERROR)
 			return -EIO;
-		if (log_flushed)
-			*log_flushed = 1;
 	} else {
 
 no_sleep:
@@ -3432,8 +3430,6 @@ try_again:
 
 				xlog_wait(&iclog->ic_prev->ic_write_wait,
 							&log->l_icloglock);
-				if (log_flushed)
-					*log_flushed = 1;
 				already_slept = 1;
 				goto try_again;
 			}
@@ -3467,9 +3463,6 @@ try_again:
 			 */
 			if (iclog->ic_state & XLOG_STATE_IOERROR)
 				return -EIO;
-
-			if (log_flushed)
-				*log_flushed = 1;
 		} else {		/* just return */
 			spin_unlock(&log->l_icloglock);
 		}


