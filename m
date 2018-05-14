Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr5s2fD+JlhXHZG0dWAOzy3uqDBGVLC06bHW8k0+F5+NqBtu0viW7A1LGU7pMUnyG+B3WzT
ARC-Seal: i=1; a=rsa-sha256; t=1526280744; cv=none;
        d=google.com; s=arc-20160816;
        b=vEav0REKvMT0P/4R2M77O8Fle8AToagh9LwTMmq8TMUcQnMjMOb0T+TL3ZVXd5YKuG
         u+GyWqXRbD+Y2FwiPT/o6p8gD1D3eP3MIo/2mqZRp9yyZXtbomwRICe6wAe3Fcat4Ho3
         wy7H9lw7HSymZ4D0e09heDVKbl9l4Okf+TqXkvqW+tgi5DmTOV2V101NfM159zveJ0BP
         WbpybhFCA9ozBktsRPjeSH5xecD3bG58c//qWq3Q708bjmM92d+apvwW68Sqod5OSgSD
         66MMRTGV+NsEEOG13eQeFdY9VaJNZT7bZPoNxBSe978c8asuT45Aae4Brd2sLWmWBpVZ
         VEVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=dHlcsbucE6E10TrwewBBFKoVm0/y5Q7sbHZarf4Sg50=;
        b=Zf9V9OLFYm2tzToYFpcYdgk1hoXw2SBlPhZTysoq0wCbEOCOM5U+5UC7Y35DvtgTpY
         SUBKki4i0SZpOr5QB9cwTqYBFnRSMbYJ5CN5dwjHgS7HrWQDAarG6TzscseUXsZVY5fh
         ACmwOPzuWJak9/NtSzxJ2ytoPOVUVj2E9BxTUQLs9a0bY9r07z8iLYwoNGThlLq6qKay
         mjJc7ZaUCaJd+UIKTWwVdtFahuypmVox7fNXQMhUe6mcCDYQfcYun/20Sck7WhKQsUaN
         bq/+Ox4O2xqpf5BAQW00scM/94n/CPbOhxFMhvULs+UaLhHwx/iHF3ugn46PM6NvyD3h
         ldGA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TPQ4fT/e;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TPQ4fT/e;
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
Subject: [PATCH 4.4 41/56] bdi: Fix oops in wb_workfn()
Date: Mon, 14 May 2018 08:48:46 +0200
Message-Id: <20180514064758.581040850@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421358029134796?=
X-GMAIL-MSGID: =?utf-8?q?1600421358029134796?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1906,7 +1906,7 @@ void wb_workfn(struct work_struct *work)
 	}
 
 	if (!list_empty(&wb->work_list))
-		mod_delayed_work(bdi_wq, &wb->dwork, 0);
+		wb_wakeup(wb);
 	else if (wb_has_dirty_io(wb) && dirty_writeback_interval)
 		wb_wakeup_delayed(wb);
 
