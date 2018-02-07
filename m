Return-Path: <tkjos@android.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518035951; cv=none;
        d=google.com; s=arc-20160816;
        b=SdiJB35vv2DpCGOiBj/RzquO1PrBnNb4YZytoWfRSivMKE0ZtDnD6b2HOkticmFC7B
         tufwTsdC1lJpEmxKvkiW5BW5GiIhCni7x8ne4d1CXyySfyCWPgyYIPyJWD1OEHd2R64h
         Qe2plIm5jpFscnl1eWjglxM086wJwHwmIXhS1rqoiBEInWxJ5g2Zy2QgOndDvGd/T6wW
         90fIoiRk+CiaKU7umx27a4DYWP7Xc/zQBoA4tr4MGU3X7U3qN62l46MDDW55vrxoPEDG
         YGUMbGZvtUkTwqgYFLxspyBmtirDKu02aj2nuaxocjAW9gidfpE7RdXaa6SzQcbCkKYl
         Hkbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=o8IMEkSxoVlAaqDsuDtm14jdTZuAXhxVj0xEjWRW1Ps=;
        b=jrE67DP7lZxpJHvdFGkYY9Kj0y4nqy3gJKonbVsl/ERnEdL6cMu2jetvwONuB9PAb+
         unA+KStfd3IjaZERTaeYHsgOQq7rxgMC4JKdCrRJcJsuUPtKtbzSeS5u/mbjDA4s8sbx
         K6IkHdsMeApiF16pA8PsMMRFZj3zMbwebQ5EgTfvlHL1q/+KmpY4ANba+BoGrNYT9SMv
         lQhyr3GGW7yHhY+qZQUme+ubZIrcBoH09oD+95+CszgNaXL7idqOMYpXBdcmknfW9QKW
         p+UZHowuiE7ai553R0fHg6JPzNCdjcAQfvO0JYer4jA6keY3TADfgPXsAGmq5br41dg9
         eDtA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=hLKblo3H;
       spf=pass (google.com: domain of tkjos@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tkjos@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=hLKblo3H;
       spf=pass (google.com: domain of tkjos@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tkjos@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
X-Google-Smtp-Source: AH8x226AQ96YgsualCyhefdLhWK+u7plm5MKJ1Ns0PJdVqSB2VTjn1pTtAl6UO9zXSf90KDq4Ca0ug==
From: Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To: tkjos@google.com,
	gregkh@linuxfoundation.org,
	arve@android.com,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	maco@google.com
Cc: android-kernel-team@google.com,
	Todd Kjos <tkjos@android.com>
Subject: [PATCH] ANDROID: binder: remove WARN() for redundant txn error
Date: Wed,  7 Feb 2018 12:38:47 -0800
Message-Id: <20180207203847.228298-1-tkjos@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591776066478683214?=
X-GMAIL-MSGID: =?utf-8?q?1591776066478683214?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

binder_send_failed_reply() is called when a synchronous
transaction fails. It reports an error to the thread that
is waiting for the completion. Given that the transaction
is synchronous, there should never be more than 1 error
response to that thread -- this was being asserted with
a WARN().

However, when exercising the driver with syzbot tests, cases
were observed where multiple "synchronous" requests were
sent without waiting for responses, so it is possible that
multiple errors would be reported to the thread. This testing
was conducted with panic_on_warn set which forced the crash.

This is easily reproduced by sending back-to-back
"synchronous" transactions without checking for any
response (eg, set read_size to 0):

    bwr.write_buffer = (uintptr_t)&bc1;
    bwr.write_size = sizeof(bc1);
    bwr.read_buffer = (uintptr_t)&br;
    bwr.read_size = 0;
    ioctl(fd, BINDER_WRITE_READ, &bwr);
    sleep(1);
    bwr2.write_buffer = (uintptr_t)&bc2;
    bwr2.write_size = sizeof(bc2);
    bwr2.read_buffer = (uintptr_t)&br;
    bwr2.read_size = 0;
    ioctl(fd, BINDER_WRITE_READ, &bwr2);
    sleep(1);

The first transaction is sent to the servicemanager and the reply
fails because no VMA is set up by this client. After
binder_send_failed_reply() is called, the BINDER_WORK_RETURN_ERROR
is sitting on the thread's todo list since the read_size was 0 and
the client is not waiting for a response.

The 2nd transaction is sent and the BINDER_WORK_RETURN_ERROR has not
been consumed, so the thread's reply_error.cmd is still set (normally
cleared when the BINDER_WORK_RETURN_ERROR is handled). Therefore
when the servicemanager attempts to reply to the 2nd failed
transaction, the error is already set and it triggers this warning.

This is a user error since it is not waiting for the synchronous
transaction to complete. If it ever does check, it will see an
error.

Changed the WARN() to a pr_warn().

Signed-off-by: Todd Kjos <tkjos@android.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: stable <stable@vger.kernel.org>
---
 drivers/android/binder.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index a7ecfde66b7b..37289683939c 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1933,8 +1933,14 @@ static void binder_send_failed_reply(struct binder_transaction *t,
 					&target_thread->todo);
 				wake_up_interruptible(&target_thread->wait);
 			} else {
-				WARN(1, "Unexpected reply error: %u\n",
-						target_thread->reply_error.cmd);
+				/*
+				 * Cannot get here for normal operation, but
+				 * we can if multiple synchronous transactions
+				 * are sent without blocking for responses.
+				 * Just ignore the 2nd error in this case.
+				 */
+				pr_warn("Unexpected reply error: %u\n",
+					target_thread->reply_error.cmd);
 			}
 			binder_inner_proc_unlock(target_thread->proc);
 			binder_thread_dec_tmpref(target_thread);
-- 
2.16.0.rc1.238.g530d649a79-goog
