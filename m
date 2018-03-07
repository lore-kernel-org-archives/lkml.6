Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsXqnBwxro18wRwpuKhPD6+UmcUZ3mlO+beFKm/UFkaBV/n893OuNQjVMw521snGBKNp+JA
ARC-Seal: i=1; a=rsa-sha256; t=1520451919; cv=none;
        d=google.com; s=arc-20160816;
        b=oxDrZUl6OgQ6Ohmb4ZMlgskgfCJdwiXZXZfPpJn5bOm0RmERiIa7VpT2XALCBRBoDL
         4PYcWRZl3UGzVOIY4HR4WmUb+5FkmZl4ziaEUtUwPmnMjOtvGlX+pYNdy4y8y0pImjqH
         2a+JJ1lgXveA2CUZ88lAqN7oW6tUadrltvXl/cJGbc/RWnXghbg0j0B9ayKWpu5FtTqR
         WYc21eeLE6ZnFeYGxbuz7FBBdqYg6q+E5DPqCXaNA1TdtbxG1N5e2NhPg5RNqV9BjRO6
         AhYf3q21YFlBPgh1/uVXKFuDZP9SF9qe+XFiH4tI1v+RctEaAQRwo3u9WCqsRmhRnEEh
         2TxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=q+NkoRr61B8fzZvijhbY7BzPs24s1nBFXYQQB8209Og=;
        b=qTo9Kh5XNMjoRzKQnVb3RCVpPN5prhavq9rBajGr8QSR9n1DRZW0Q5xFt3acKJyqxk
         NdugffHAnDJE5j1+zsgyvEb/JILs4TOAG5oiOBw7nruOm0mF4O4wkhDxtk5KygbLZuvt
         0IjQEO2PyywqQbbWKIbWi4yt6lv3EIVWueyE2nE6oNn26JWhKqdVmdFHLItT3J9wK1w+
         V2q/AU81FXZVqJMsZ97a97hFE0rsDOMb2I78pwCpl5kAgtNtxT2WggcJ0J3PPTMUEpQa
         cTObciJRiOkFD8+Ekl+qembgMMfZFwa1qeF7YUJ6dEgFtglaARTQcREXYbyN92kAiS7a
         nvNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 030/110] direct-io: Fix sleep in atomic due to sync AIO
Date: Wed,  7 Mar 2018 11:38:13 -0800
Message-Id: <20180307191043.605785501@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309189650061540?=
X-GMAIL-MSGID: =?utf-8?q?1594309391460707714?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit d9c10e5b8863cfb6886d1640386455075c6e979d upstream.

Commit e864f39569f4 "fs: add RWF_DSYNC aand RWF_SYNC" added additional
way for direct IO to become synchronous and thus trigger fsync from the
IO completion handler. Then commit 9830f4be159b "fs: Use RWF_* flags for
AIO operations" allowed these flags to be set for AIO as well. However
that commit forgot to update the condition checking whether the IO
completion handling should be defered to a workqueue and thus AIO DIO
with RWF_[D]SYNC set will call fsync() from IRQ context resulting in
sleep in atomic.

Fix the problem by checking directly iocb flags (the same way as it is
done in dio_complete()) instead of checking all conditions that could
lead to IO being synchronous.

CC: Christoph Hellwig <hch@lst.de>
CC: Goldwyn Rodrigues <rgoldwyn@suse.com>
CC: stable@vger.kernel.org
Reported-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Fixes: 9830f4be159b29399d107bffb99e0132bc5aedd4
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/direct-io.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1252,8 +1252,7 @@ do_blockdev_direct_IO(struct kiocb *iocb
 	 */
 	if (dio->is_async && iov_iter_rw(iter) == WRITE) {
 		retval = 0;
-		if ((iocb->ki_filp->f_flags & O_DSYNC) ||
-		    IS_SYNC(iocb->ki_filp->f_mapping->host))
+		if (iocb->ki_flags & IOCB_DSYNC)
 			retval = dio_set_defer_completion(dio);
 		else if (!dio->inode->i_sb->s_dio_done_wq) {
 			/*
