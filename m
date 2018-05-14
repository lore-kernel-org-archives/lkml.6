Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZobSg0zpmU+ubqarBUAg4RNQHkVEKv4Lkfr0PIibzifVGoQik7zijJHMIjltryl6kHokLsQ
ARC-Seal: i=1; a=rsa-sha256; t=1526280927; cv=none;
        d=google.com; s=arc-20160816;
        b=fUMsguE1sKi83M70PlQ0HEahMJW+AVblNs+bUBRRneMoCl7GVk3CJ/5pNkW4eR2NwV
         IlHOOTQLXP+USHn+NdDEl42Lip2LN4XMHNqj2sPjSUySY8VdodsE3efpJWszZyUWv1UR
         D5cSjObsgnrQruaXAld8VdygplXaGf9mnKZsaBXZI9UQiCAXhkZ0ec0AxRb2MuJ9r8jx
         CecYw1XixCTBxcBvdHVKTj6YQkYs/5sKDhqXZgy2kbJs3kWb1skgmsVY+mVoboxk2eB+
         nTHzLtCVWIu21XsHEQlvb5Plu8GhdXP+BaW7Zbya35NWxzYXd6j9IfQ6OBoS/RjEHcjA
         6oUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=DwOad4wtG48M8ONAwJbGMpFSqs6TaqLw3HXkimGJVAI=;
        b=wSffw6372I6WbR1DGyjIdpEHLMakD9U6NzOpgoc4oqfraMLaBcdtsXZcb5hglvguaW
         Rq/orvGdM810IA1fxvY8jJgixFa5XDHeW/qsVBy+bH74xI2gBXmaK5mesgkagiTh5bG4
         GFoggOh5J2dBfAm05qNxmUZOk3zbTKRiFLuLP8hKJB+bJPnnxhc7yGsF/ySaRezzBQdd
         1BPsZGRxoLgKRjWUgIkAfJ+gMf/j/FLUS9cvq6sFWbnjFYvkmvbEJGXukDNIcW7hLPUS
         uDopvtnjRXgZHMkv5QI8fH7TdcFRc16kPzueHpwoiui+MCYLGb3eaGeBclwf0GZ4/hPp
         VEgA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=mJLSQM+5;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=mJLSQM+5;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot <syzbot+c0cf869505e03bdf1a24@syzkaller.appspotmail.com>,
	Tejun Heo <tj@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 16/62] bdi: wake up concurrent wb_shutdown() callers.
Date: Mon, 14 May 2018 08:48:32 +0200
Message-Id: <20180514064817.309551494@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421549344981628?=
X-GMAIL-MSGID: =?utf-8?q?1600421549344981628?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit 8236b0ae31c837d2b3a2565c5f8d77f637e824cc upstream.

syzbot is reporting hung tasks at wait_on_bit(WB_shutting_down) in
wb_shutdown() [1]. This seems to be because commit 5318ce7d46866e1d ("bdi:
Shutdown writeback on all cgwbs in cgwb_bdi_destroy()") forgot to call
wake_up_bit(WB_shutting_down) after clear_bit(WB_shutting_down).

Introduce a helper function clear_and_wake_up_bit() and use it, in order
to avoid similar errors in future.

[1] https://syzkaller.appspot.com/bug?id=b297474817af98d5796bc544e1bb806fc3da0e5e

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+c0cf869505e03bdf1a24@syzkaller.appspotmail.com>
Fixes: 5318ce7d46866e1d ("bdi: Shutdown writeback on all cgwbs in cgwb_bdi_destroy()")
Cc: Tejun Heo <tj@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/wait_bit.h |   17 +++++++++++++++++
 mm/backing-dev.c         |    2 +-
 2 files changed, 18 insertions(+), 1 deletion(-)

--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -259,4 +259,21 @@ int wait_on_atomic_t(atomic_t *val, int
 	return out_of_line_wait_on_atomic_t(val, action, mode);
 }
 
+/**
+ * clear_and_wake_up_bit - clear a bit and wake up anyone waiting on that bit
+ *
+ * @bit: the bit of the word being waited on
+ * @word: the word being waited on, a kernel virtual address
+ *
+ * You can use this helper if bitflags are manipulated atomically rather than
+ * non-atomically under a lock.
+ */
+static inline void clear_and_wake_up_bit(int bit, void *word)
+{
+	clear_bit_unlock(bit, word);
+	/* See wake_up_bit() for which memory barrier you need to use. */
+	smp_mb__after_atomic();
+	wake_up_bit(word, bit);
+}
+
 #endif /* _LINUX_WAIT_BIT_H */
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -381,7 +381,7 @@ static void wb_shutdown(struct bdi_write
 	 * the barrier provided by test_and_clear_bit() above.
 	 */
 	smp_wmb();
-	clear_bit(WB_shutting_down, &wb->state);
+	clear_and_wake_up_bit(WB_shutting_down, &wb->state);
 }
 
 static void wb_exit(struct bdi_writeback *wb)
