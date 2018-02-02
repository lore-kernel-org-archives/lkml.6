Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227fb1EQuH44CQqaeCbej0KGSCBWkEl/xNRh0NIiuHFD0c83vRLac62dqCXuzG0q36auqn3J
ARC-Seal: i=1; a=rsa-sha256; t=1517591623; cv=none;
        d=google.com; s=arc-20160816;
        b=NEXFB1eZXxgIMw+wQQ0YA+nwp++zfcgvzcSBRssRAOOdkuvV7s4fDtJwB9ppGmEAyP
         OzADz13CdE5wbEoVBfhKaSlBRXCKzf1x0VQ6UV8pU1rGWMaNMug4IjRHdnnco/kgEvIX
         OxpAQWu0vkxvJQfnCcfch5ezMypMu4xxUD4dhH3lFVNye21eFyqHUEhJMlCj6RTm+ze5
         6ze3FqaI9wI4lfmpb5cxFBZyr3ENhaBSNf0jfqYGpsqktGxb8Nok37pSQOKu1iNwKmRQ
         g/048Canuitvzyz20bjZqetv/w1XWHE2OwVjjtArLrbyyv/vBXnG03Jqjj8Mg8DcoCXS
         //jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8qUDj1GCWJRzhZd6FNduVB8Sa8dz8BjMSQh3QnbdBVM=;
        b=C+FMbpr2sNH1ogHGyvJpQKXaAY7goTXjPh+CqkEsAIzqpQITsKnbbNlFsIgQEvtSJQ
         dmPvmgEl9zVj3ZWjffM1eGwZw2hxfGSNgJIAUZFp9BHNXiAwFUpI3HBOg8dFUrOF47jZ
         /xHMSWeK7kxs4Uwm1gjyueiZfiN8Pf+7D4G8SLq3Q0r//Vt/firEwguEB+n44toHs9pI
         MoUROF/3qGH4E4xrV8xusPXPA+WsA+0YKk48lZt3wpYo2xeqSUWkvPCKRec1/wYiOAXY
         exbwG79yUOQkjYpnro7Vcgc5xoWc5uimmXieOkzJGmEEp6eC11LhAR3h6n6d1CCIZgFl
         Wy/g==
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
Subject: [PATCH 4.14 144/156] ANDROID: binder: remove waitqueue when thread exits.
Date: Fri,  2 Feb 2018 17:58:45 +0100
Message-Id: <20180202140846.892505124@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591310154319836900?=
X-GMAIL-MSGID: =?utf-8?q?1591310154319836900?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
