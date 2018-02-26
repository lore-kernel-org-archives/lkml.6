Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224G7kThmxIKqMQ7ZXyOh9x8fMpdSrezOMgePMkjN2g+3UIda5qzsaVk+pC3AFV7Q4wkRzDL
ARC-Seal: i=1; a=rsa-sha256; t=1519676531; cv=none;
        d=google.com; s=arc-20160816;
        b=qoxPzDu+XaDbgL/q3JMCbGa5ogkWZUguEA1jqXWFb1euXDw4XZu4mNaUEc8NFx0zMa
         Bvlu7xffFhsBomRDUzYS30jK+smQ4cSqHDr65U4qSenTUj5+BoCVgibnuvnXjRc0lgng
         0YOiEUP7lMyiUCSgpikux3m47Rl5rfMGBdX6pALSGjyELCSS2jXkwI0yFRnOKGES3UGV
         7v1BXonqCbPOsZo3YkZDVvvj21gcgTqasfBvdT6l+1b8gFsnh+xKCfwge5vUeofrJd+7
         hehxHYQlyAth8SoHC9SPS1rJd3XATLyBwJISS158XCBmtoL1toSNM6G5NdR6ssfHxDQV
         bAyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ADYHwRgwa8T37TYWpVswWISIkcthHXgD0dtfXWJY7Kw=;
        b=cUlqUJFPMbJJwE5/F2FW2ooYWwyjlXwEr6Q1/B7BpncPdiCKDDFjjlYpjU5/3TJmBW
         dvw5G0OCxWV9X72Q61jL/z9CaHuBuTWFJehGKgK9m6js7r2CKRbBQUs3KAi8qmZV9Xa4
         9OTl9trTP/ua/WfAF4MGr00ZcRNXPF4+wA4OdoEJ0M8MK1QxVUTRh5420jdwodDvjXcV
         WJCg2wR2u7PxfkXKpG3+5IXq0Dm5qiVg7dS24kA7k7PnaiA7zoLZAJiOazYs3UD/yk1l
         Ixu4E8CzJGriWzaAdCZdNa+3S+laGgTjfUU/JoOOofbXDqolfhKSwjQiKYLIvk+30ktQ
         tO5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Eric Biggers <ebiggers@google.com>
Subject: [PATCH 4.9 27/39] binder: add missing binder_unlock()
Date: Mon, 26 Feb 2018 21:20:48 +0100
Message-Id: <20180226201644.856534611@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496028078409631?=
X-GMAIL-MSGID: =?utf-8?q?1593496338962314763?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

When commit 4be5a2810489 ("binder: check for binder_thread allocation
failure in binder_poll()") was applied to 4.4-stable and 4.9-stable it
was forgotten to release the global binder lock in the new error path.
The global binder lock wasn't removed until v4.14, by commit
a60b890f607d ("binder: remove global binder lock").

Fix the new error path to release the lock.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/android/binder.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2628,8 +2628,10 @@ static unsigned int binder_poll(struct f
 	binder_lock(__func__);
 
 	thread = binder_get_thread(proc);
-	if (!thread)
+	if (!thread) {
+		binder_unlock(__func__);
 		return POLLERR;
+	}
 
 	wait_for_proc_work = thread->transaction_stack == NULL &&
 		list_empty(&thread->todo) && thread->return_error == BR_OK;
