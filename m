Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtxpC7zz0SBRL+xo90vSJgehLiayDy46xrjAbH5fA0uFjkeKDS/6533oH45HrChWvUADe1p
ARC-Seal: i=1; a=rsa-sha256; t=1519412348; cv=none;
        d=google.com; s=arc-20160816;
        b=PClUBVl07p2muoFhkaTwWdxGovHAl2dvs/38xOZeXYQTN9n9VwS4PQ7QZC3QkUpn39
         Ki+t49zwA4zD8OeTc5K7v/k302kwpIsT/AZWKEK+u4t+tKlnSKDZ8quO5MIoYoCD3iPv
         X9m38/MyQMCCAT9x1B5BUXhYtamNUshas1EpBkcFy40eHTdwRfmSGxkCIpt7fxURGXmo
         vcd7FHx0e2LJgEYzwlTwY5+otnpfOiWFY33P5QHzEA79jxdozg5FtgwnN1wxBKLN3mbl
         HnpSuHloldpvNV1QSGutEu4voeHwVdjLmD0gPdeYVqIy7hAkBbyT6wHXHyu/mNnFJjB4
         nRMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8eXIdH+H3sLBgDhQyYXxkOg1t2qIrCNRRl6z8kxnAnU=;
        b=bScDBQaSs8AaYY1UxRKchJNVCh7tXuuYqk6MZi5s8iB0bXh3k5+gBJ+fbk9DBqeiCj
         5iCJpL4xTbZfH4uSfZ8Dp6VnBQ/+oTB1vjgLCS51rF6C5kh+eIWasTKJfHaV0l9Hbnr7
         Dp/V47t2x8VzJQcpqgyPx+iIqgLXOkpNWG58X+P29PwWSPNHo5hymvmjdctdSEJektS+
         adyLw2tgw/9pIHr4KmNdJyOLIvMGLYA0e2zeLs1pHHzsVMJd71zZBwb6gA7xLsxaM/To
         x1xfp+DOfya3XEW658bqEr8kWv0mLLCR3El+o9IPnBU9B1NFbLPue3+ouGMBaSamrW5m
         RTRQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Todd Kjos <tkjos@android.com>,
	syzbot <syzkaller@googlegroups.com>
Subject: [PATCH 4.15 29/45] ANDROID: binder: remove WARN() for redundant txn error
Date: Fri, 23 Feb 2018 19:29:08 +0100
Message-Id: <20180223170719.993178153@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218836859842993?=
X-GMAIL-MSGID: =?utf-8?q?1593219322929117263?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Todd Kjos <tkjos@android.com>

commit e46a3b3ba7509cb7fda0e07bc7c63a2cd90f579b upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/android/binder.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1933,8 +1933,14 @@ static void binder_send_failed_reply(str
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
