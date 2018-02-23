Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsoiOrDa9OuAZ5GLI22YKVSqUUheub9N/2D7aGD1fQNm7uUo8UgYuBD48ih9A593SSbak5p
ARC-Seal: i=1; a=rsa-sha256; t=1519412351; cv=none;
        d=google.com; s=arc-20160816;
        b=Xvp2uoqAs65gNyJcyaDnJhMGgoTjdjDnMcFkJloGLGTb6S85MFAwX7XO4mq3jfiQAJ
         Lj1ieNIFVldEVaZixNQ+4TSgQBCb7+bOjBs7sjpKRrMxHobFWdpA4uN0gGQqg4zdeiPC
         WTaLgUfv7pwyZgvniB/vIhrJA842EyFwZtAvCxQQbUDOTOb7mWUAgPrTMIqaMDQD9Hz+
         LBmfBhYd5PBrd5YLu92TUE6ZKEDWRDcGurMlpaHsVS34/O6Ewh0OtcarfUixXhns1QPt
         jsCUaV2qs97DX3nUuAwCnkIHfxv3us0nTP/RKd5t1e2zZrrG4uJMrBzGDGV4O/a1A51C
         kVMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HYN66nuO6Jb9EDVb2zNRo5Q+TgP2aNn9Kw/Ieg0W84E=;
        b=1KNdsOIiMQFo3CIn6RoXbgGJYp2+/y57JyBcaZ9F4AHgdzJ1Zq1V8zdsn2TLg2ugB8
         M+GM0jp15bvdo7MuDPUURsS6U4dOt5MEke+XwXiwfACKSVQno1HkpBwffki1x/Xy7FNo
         zcI90wPCQrCPpdLgGdCViNeVTto2ON3hmlki5yoyp3Zs7P6GijC8h6MrfndRsN8B3cPT
         ylE/of7ot4AhmzscbNmlgOh+cC51E8o9/qyX75yu0nXm/DGc3PghdPyTduAWSFYoTQUI
         Ayceas3qB05dBJ4+m6HfUZ4NIxJ2GMwIvDPFYhY01TGQCjsbItPFB2EP9uKAnsJqOUTi
         oHGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+a2a3c4909716e271487e@syzkaller.appspotmail.com,
	Martijn Coenen <maco@android.com>
Subject: [PATCH 4.15 30/45] ANDROID: binder: synchronize_rcu() when using POLLFREE.
Date: Fri, 23 Feb 2018 19:29:09 +0100
Message-Id: <20180223170720.098617539@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218839872393039?=
X-GMAIL-MSGID: =?utf-8?q?1593219325813806583?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martijn Coenen <maco@android.com>

commit 5eeb2ca02a2f6084fc57ae5c244a38baab07033a upstream.

To prevent races with ep_remove_waitqueue() removing the
waitqueue at the same time.

Reported-by: syzbot+a2a3c4909716e271487e@syzkaller.appspotmail.com
Signed-off-by: Martijn Coenen <maco@android.com>
Cc: stable <stable@vger.kernel.org> # 4.14+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/android/binder.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4322,6 +4322,15 @@ static int binder_thread_release(struct
 
 	binder_inner_proc_unlock(thread->proc);
 
+	/*
+	 * This is needed to avoid races between wake_up_poll() above and
+	 * and ep_remove_waitqueue() called for other reasons (eg the epoll file
+	 * descriptor being closed); ep_remove_waitqueue() holds an RCU read
+	 * lock, so we can be sure it's done after calling synchronize_rcu().
+	 */
+	if (thread->looper & BINDER_LOOPER_STATE_POLL)
+		synchronize_rcu();
+
 	if (send_reply)
 		binder_send_failed_reply(send_reply, BR_DEAD_REPLY);
 	binder_release_work(proc, &thread->todo);
