Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x22712bNnVj3DLJ8e+jvQ1qIvWkXTSHHWa/Yn1Y47eM5U7Nwe4Fmr2QgkCLe4smOwNvQV6O1N
ARC-Seal: i=1; a=rsa-sha256; t=1517591785; cv=none;
        d=google.com; s=arc-20160816;
        b=GpGviL8GA6ymaCbO6/QX/Uio1r79L0fobwFfQ3LNohdTQq+ZF848rNgncMyxRNj5rV
         sk15Qbo/o3mDeECUhOUUM5H+zGqI8JYI5Y42KQfarejjGjKhI6IEk0FAQq2Eo/5AKWKR
         kXT+1ixwdnJnYiAe6sF6wBcwaHdeWm5FGXi3HMnYiJTBm9q/t159n20Rm1Dw0XYid7Xv
         0CYWa+9oD9A1ib5PVIPUU41mKEOSvBc7ejn9ZGkRvW/FCQMhZ9R2uD0C7gSrhGa4SWIU
         RY3ItQ0IFL4N1DqggS39Kwoqs00QB/trvzJ1C/dm/3XbpSeP+L4XKL+iUaDccdz8EJIJ
         e4bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jDfy7Pq5emuuQxc8kuk93WXZ83nDXTEXgW4mjkeAKHw=;
        b=LsTv1X3Ztx6OKFo3ZGjUJR1qnysSYLM9blF7o58u9YZ3fEaTFJcfH16Qs8cw0KHZRO
         pdfVLS/1CkMm3HUtuTW3/+25WtpUZ8qZnGTachF/6hBsFBpIvUW1oOBvT5FcHUmHv0CB
         DBnamPcNB6cp+eJF5E55IZuW4e1mYEucMogr8pIefdNN5v/nTQHLPe9mllyRvwhFk2ce
         8MnBpvyp6jBfZ4UDwf82OFA7JiiIT1Bd6t+2LoR11DAoRkQvo0Rrzdr3X+c7xiGmQ/kK
         +AO9foIPs351W/DgqtT7wJhaETnG+LGgUjaSkJHflFCh5WYPe6FBshhPWITuQvd/DoE8
         IjTw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martijn Coenen <maco@android.com>,
	syzbot <syzkaller@googlegroups.com>
Subject: [PATCH 4.15 42/55] ANDROID: binder: remove waitqueue when thread exits.
Date: Fri,  2 Feb 2018 17:59:00 +0100
Message-Id: <20180202140830.212435163@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591310154319836900?=
X-GMAIL-MSGID: =?utf-8?q?1591310324173749127?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martijn Coenen <maco@android.com>

commit f5cb779ba16334b45ba8946d6bfa6d9834d1527f upstream.

binder_poll() passes the thread->wait waitqueue that
can be slept on for work. When a thread that uses
epoll explicitly exits using BINDER_THREAD_EXIT,
the waitqueue is freed, but it is never removed
from the corresponding epoll data structure. When
the process subsequently exits, the epoll cleanup
code tries to access the waitlist, which results in
a use-after-free.

Prevent this by using POLLFREE when the thread exits.

Signed-off-by: Martijn Coenen <maco@android.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/android/binder.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4302,6 +4302,18 @@ static int binder_thread_release(struct
 		if (t)
 			spin_lock(&t->lock);
 	}
+
+	/*
+	 * If this thread used poll, make sure we remove the waitqueue
+	 * from any epoll data structures holding it with POLLFREE.
+	 * waitqueue_active() is safe to use here because we're holding
+	 * the inner lock.
+	 */
+	if ((thread->looper & BINDER_LOOPER_STATE_POLL) &&
+	    waitqueue_active(&thread->wait)) {
+		wake_up_poll(&thread->wait, POLLHUP | POLLFREE);
+	}
+
 	binder_inner_proc_unlock(thread->proc);
 
 	if (send_reply)
