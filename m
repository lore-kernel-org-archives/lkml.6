Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrZhmO606CDMH5xibDpbagPKbR+MAvdsJGzDIt7qcWW1gaZDQQ/eO+SaCzuFOCzN3Lhqts/
ARC-Seal: i=1; a=rsa-sha256; t=1526280929; cv=none;
        d=google.com; s=arc-20160816;
        b=E5iGCXelifZdg3I7XJQkOJCnEFYTY6cXl8BSci+QZeOWrUeMDfoY2ZoMesaV+ST2VE
         n4ozovJv3yLPbBqjkZnVi2RUso9KGEIHEYuRqWt1zCmSQWvlrdyiUBUIALxj3MkboaFj
         wglq/1egNIrupA8V8Hi+LG3bdXdGzSs2VwvkXJLiTv3yzvVFLCI50EO1MOlQORsTcYp2
         BTMiEv1boZkwWFSsMHT+HXhIWWhSi4AfmuxrHbMdHOoTlqaJCJ016QUzgxCngVTM9BJ9
         fT2u/jYWiLNNYmuprawJ3B6mHDgWddPruFIrlfpmqh9cbX+wUwjIfXeJjzi7aCaIAgBe
         ndRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=S+cID+rFjF51EmySueft/bK43u2au1yigmKr5XUAW6E=;
        b=NOtyokZdzkYWckg3mCRdQG/m2xXvlr2gattVFaMmY6yBJPbw14V82G0MCYMnvi7s32
         5RDjUDjP9FKZOm4Sa17EVkGg8AxiJmQawU+ZmSNaDI94P4cYVRCMG0iREqTrCnkoJ/WW
         d79fnsvtacyUbEn3b4hZ15CKRUTfA2jy7eXfm9SiJvPU3nyfIVmHsoS4pIo+jHgXBj08
         LS5V2OP67R+Oh5xHimiVnXXBd6gHtdixwufGTlA676Sug9tF5U6lHf5BCI2yt6+jYpxu
         c3xvCW5aOXk4kKXrE7pCKQc5keL7zXwq84/bRff9gRczwgc/9A/3SxWUc7aV3oLHubKi
         kj2A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ztCPbY+X;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ztCPbY+X;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Tejun Heo <tj@kernel.org>,
	syzbot <syzbot+9873874c735f2892e7e9@syzkaller.appspotmail.com>,
	Dave Chinner <dchinner@redhat.com>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 17/62] bdi: Fix oops in wb_workfn()
Date: Mon, 14 May 2018 08:48:33 +0200
Message-Id: <20180514064817.362376640@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421358029134796?=
X-GMAIL-MSGID: =?utf-8?q?1600421552134402502?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit b8b784958eccbf8f51ebeee65282ca3fd59ea391 upstream.

Syzbot has reported that it can hit a NULL pointer dereference in
wb_workfn() due to wb->bdi->dev being NULL. This indicates that
wb_workfn() was called for an already unregistered bdi which should not
happen as wb_shutdown() called from bdi_unregister() should make sure
all pending writeback works are completed before bdi is unregistered.
Except that wb_workfn() itself can requeue the work with:

	mod_delayed_work(bdi_wq, &wb->dwork, 0);

and if this happens while wb_shutdown() is waiting in:

	flush_delayed_work(&wb->dwork);

the dwork can get executed after wb_shutdown() has finished and
bdi_unregister() has cleared wb->bdi->dev.

Make wb_workfn() use wakeup_wb() for requeueing the work which takes all
the necessary precautions against racing with bdi unregistration.

CC: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC: Tejun Heo <tj@kernel.org>
Fixes: 839a8e8660b6777e7fe4e80af1a048aebe2b5977
Reported-by: syzbot <syzbot+9873874c735f2892e7e9@syzkaller.appspotmail.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fs-writeback.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1940,7 +1940,7 @@ void wb_workfn(struct work_struct *work)
 	}
 
 	if (!list_empty(&wb->work_list))
-		mod_delayed_work(bdi_wq, &wb->dwork, 0);
+		wb_wakeup(wb);
 	else if (wb_has_dirty_io(wb) && dirty_writeback_interval)
 		wb_wakeup_delayed(wb);
 
