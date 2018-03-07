Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtISzs3odLvkPfLXK8EQeN3oIq6SoVySurgw5r6DmPYCziOTT5W/9YpyiUliZfvbOQsGSx0
ARC-Seal: i=1; a=rsa-sha256; t=1520451726; cv=none;
        d=google.com; s=arc-20160816;
        b=nJPFDUG8cIdTrhlizoJ2reaunIitLyHVUHBG+K7QKQXUckVrNnzUS1NoSkJnjgDgE7
         l9VuLGoHRyj5ZkxBMGuaH0wq4B+P8nD3fXUEdAHVAC99xZsZMScOOHDz3qL5mnqGTi/A
         wNwvlTR6/ZroOCjGhtxLDtUAnfxcbNPhuSA9Xrdc8tr5pIcD7sux/r+nBrDLM8KACdCT
         BJsWH7kQEF452iifrIt+H/7WlalQ1+StxuYOHS/Ay8cSSF8gQRJ/e2of1JFpjq6PIeB1
         B0wY+0b9xJmB9wr6eg24k2ezd8I16XrCZfS/IFKoJxW/XHFdHJHy1u8Mvw0nv6rMPXyw
         mPbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UjmWtRLLpxFxrerOKYPIz7CnINahb1XCvWzNMLrU2GQ=;
        b=hlMcuJ+/h8illUvlEBhYkP3LVuxSX5UluzAuo5FIIVbfuOroLqrUMWq3N+P/XP9nK8
         +OTLsLwunlTrKSUw0doocnVP6pUQxZ7ZbwqnwtV/li/532WHfzT9rB+6Gn7FUNHFYm38
         9z7cqe3h5IYumzzzypu9QvPWVLJjEhv5MuwbgaEapqs4DvN2WfQWM3HP6ZbkoQWxW0l9
         4SJzCGRc53Nr4UjCifC39zhvJFczdRdOob/dGlCOHBHXluDHF+B9YkFyJMPgORbdD5eC
         Y5BIBiqUOHWpUk19TVYSxr0Z/4sdKQtJrabC3wkDv6AfqwZOX3J7UVdaoXy+BDMbLJmE
         tOTA==
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
Subject: [PATCH 4.15 035/122] direct-io: Fix sleep in atomic due to sync AIO
Date: Wed,  7 Mar 2018 11:37:27 -0800
Message-Id: <20180307191734.231518222@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309189650061540?=
X-GMAIL-MSGID: =?utf-8?q?1594309189650061540?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
