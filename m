Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49qrhnTegmyOI4lO9WcDa/WwDC0UBUeaKtmYwngOGslBSZ8Smnq6s5ZtZGR9vTqYZqs3tF9
ARC-Seal: i=1; a=rsa-sha256; t=1523021947; cv=none;
        d=google.com; s=arc-20160816;
        b=iBv0qeuUYVGf3SFoOCwJlOidege9IoLnHHoQpmF4DHm8LotgBTXNUt0zf0kus5EB7b
         ppVlafIPPCtuX0XPHmY9oXBK4qnjpFLdYkjFrPqxe408ANKCxNMEsmey9n2Gl6ej1NNo
         d8/cC+l8xUQpikGNIIo4UMbD1+77tGERKOtKHuYRhBBAnQCceUxR7dq+jbKiCJrnz5ZU
         I3T4L5AI8mqMsvpeWhPd0VcXkmph7XspIR+Sm7X6QcY5l5o9lWgsRaLcF0byaNmxai3W
         aXecLVfQXlxHKX9HyWBFZWMq5/QRjqxIiTT+0IlCF6JmqP/+iJR1CVG19dZs1BHIGI3e
         rObQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Bcu74ZH/oLIye/HRxcXyo+yvnTbUHb2l7UQYe5fUjDo=;
        b=keeOMdiFkOxtycMht5fY83goHl4OaIwZZhwxbaSHvJBTsS5Zd/NDfeg65vpjpSRcvW
         Jsmv/XkxncysrTZCh1kdmuuejlq0RqsnX/J6yxNWPEzHo8zJAMmZmO3hVAHH0gyK+rX4
         WUrW5JtorKoqXHjxkrJcDGzKo6HbOGkPo9GhkfIL++T9T4OAhxFXEiHmaAMjObXmUNzU
         kYTBcUIl0cU7kNul51swWc+BgDfAcGKYl9lrpg9OgSzxjZctXQoRjMrE7ldWhE80358Y
         SOYjAYK0pamCpHQz4GydJV+n4shTfftY81b42tYacqw9LVwt8GWLnhVThUTHbvWek5O6
         /NWw==
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
Subject: [PATCH 4.14 43/67] /dev/mem: Avoid overwriting "err" in read_mem()
Date: Fri,  6 Apr 2018 15:24:13 +0200
Message-Id: <20180406084347.133202378@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004262523663859?=
X-GMAIL-MSGID: =?utf-8?q?1597004262523663859?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
