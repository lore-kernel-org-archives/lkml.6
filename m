Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48NwnEABYI91jGI+dt9uA7zL5/bj7XqhbXnedyDD07W4b4JY9l/VS7yLckK36K8kY9UqxUX
ARC-Seal: i=1; a=rsa-sha256; t=1523022156; cv=none;
        d=google.com; s=arc-20160816;
        b=tV95L/ENDYMNNlSTxGyHihunlZWo4dKUtB7ok93SrhL/Pi7gJ9mtGLabd29Y5It/Fl
         bdC+O4uC1w5RU+61ZN3W5Gd6LQIrtHIyO/Zx9ImtRU1BWYRhUf9kiLCos/19sQQTGTdD
         +VYgVpyvce4kcCkflXeX2WMhY+fLJeIjSy118czxBKUrB6Fu1u0AFmDvT9lEM1eWd4zA
         4XYlZbpgCY4V9yge6+2I7WrywQp+8yudcOGBc4UI5W+69c2Q5I8y3YRK93VlLjM6Yx53
         tzG+ZeWX1d6GLLEY+s8HNDhDNp+Vb5gEhn0kuISquyPXRI/7SSvHKvtwcgh7t0GDNY1h
         PXJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XpDSt3CbGPInFfScktXiOSHqNzqYejyq+MJzJLisuBs=;
        b=m0giIspSGtMlR+VRo/xMOmmrH+S8XKFcJlqSZUWBiyoaPCn1Z9wJ1CPEhFr3C2Y8rb
         USR53VcaPGY0+iCQjDOVxXD15m0C6PkDOufVPWjo/1AvwRRL33YJXzpMGOKxJIOx4OzH
         xR5Q1AoKW0Ci05pKBrJv13+K08Lq8olFW410gqX6iPV+nIR3hQGUqFx9WUU0zti+UZFV
         gwcPfrvJOo+McNAJWHDGiewYMOunrYB83+5XfuQ61oeKKZY6U45bcxkwAFF/dIqCYc/D
         16sbmC3dVzMQk+SZQ7FKp6vtuCwmTfxyNsR0p1JBpZzB0oeHt0iz62JUoPNjm21sw8eO
         kzPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Brad Spengler <spender@grsecurity.net>,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.15 46/72] /dev/mem: Avoid overwriting "err" in read_mem()
Date: Fri,  6 Apr 2018 15:24:21 +0200
Message-Id: <20180406084352.803320780@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004262523663859?=
X-GMAIL-MSGID: =?utf-8?q?1597004480145094056?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit b5b38200ebe54879a7264cb6f33821f61c586a7e upstream.

Successes in probe_kernel_read() would mask failures in copy_to_user()
during read_mem().

Reported-by: Brad Spengler <spender@grsecurity.net>
Fixes: 22ec1a2aea73 ("/dev/mem: Add bounce buffer for copy-out")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/mem.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -137,7 +137,7 @@ static ssize_t read_mem(struct file *fil
 
 	while (count > 0) {
 		unsigned long remaining;
-		int allowed;
+		int allowed, probe;
 
 		sz = size_inside_page(p, count);
 
@@ -160,9 +160,9 @@ static ssize_t read_mem(struct file *fil
 			if (!ptr)
 				goto failed;
 
-			err = probe_kernel_read(bounce, ptr, sz);
+			probe = probe_kernel_read(bounce, ptr, sz);
 			unxlate_dev_mem_ptr(p, ptr);
-			if (err)
+			if (probe)
 				goto failed;
 
 			remaining = copy_to_user(buf, bounce, sz);
