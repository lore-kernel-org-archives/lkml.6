Return-Path: <keescook@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522184777; cv=none;
        d=google.com; s=arc-20160816;
        b=oQTMpEhp78r44vDfmob7lISt+LCZhX0PDCLPhw7mQJwTvCnS8nyIuB7HxU09C4faZc
         1U2JXhxba3yjq9Jy9hP9YTuqgpqCdYC6sDJRx4fNafcxwjurcv60JpIhuoB7w7Vpi7Cc
         bzxFD6yCACqWkrLV1+TpHl6dWggWGEmfEtZjk3Fzf/JdXMIfkP+iQyKGI4SywkvSytRh
         i8dlKuJGePoP8HK5AwxH9JrxUDtGoJ88gM0pyyMz5N/T6o5jZDnZUIJRCaxsvSEFTCun
         8PO108NREszi/7wIs8aQURQdCaHWauB4+f8zap7J8OqhjIGF05ST5avBx+7QWwyfSwFb
         +Tyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :dkim-signature:arc-authentication-results;
        bh=9V/Vi65mJ0eavWYwVsr3h7HU86giyL/xFmQgJJH6o6Y=;
        b=ZQEqPU/XIYla8Pt/XwFDIDQMndKslgDAjcjQizrVA1B+a4oahnLK7Iw1LBHkb3qhvd
         gfBVjUKQNxuFu54dou4PM1zbH9qQxd8zOaQLYRxj5kCc3NR4DznootIGwcystAAFJlm2
         r2nXUrxOLcGRmniA7j3UwBFyi5NkYVeUTYyuEOarohbMjwBSrLOD9EjVUrGVhaj3ElRL
         fynU0UTkLXBWCSYDlRGrfdA4nqtrDDT/H2uU2YkdEoAsRSMG4FiUMdJhP0GAPMt6nL5d
         J0gn/2mq+IeY1YT9stpR1XAbkjWEZmaLc8XMhObvmfZpa5x5W/EfeLy6qVFs2mBlB6ru
         ICYA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=eWtQGhi7;
       spf=pass (google.com: domain of keescook@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=eWtQGhi7;
       spf=pass (google.com: domain of keescook@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx48DMz7x07eXFZ8kkJN6KP5OKSSbVd3aAOhCUmw7H/jBBlaWxKF6vpj0SOTDJpWy35nLhSGQLA==
Date: Tue, 27 Mar 2018 14:06:14 -0700
From: Kees Cook <keescook@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Brad Spengler <spender@grsecurity.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] /dev/mem: Avoid overwriting "err" in read_mem()
Message-ID: <20180327210614.GA18309@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596126424661979443?=
X-GMAIL-MSGID: =?utf-8?q?1596126424661979443?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Successes in probe_kernel_read() would mask failures in copy_to_user()
during read_mem().

Reported-by: Brad Spengler <spender@grsecurity.net>
Fixes: 22ec1a2aea73 ("/dev/mem: Add bounce buffer for copy-out")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/char/mem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 052011bcf100..ffeb60d3434c 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -137,7 +137,7 @@ static ssize_t read_mem(struct file *file, char __user *buf,
 
 	while (count > 0) {
 		unsigned long remaining;
-		int allowed;
+		int allowed, probe;
 
 		sz = size_inside_page(p, count);
 
@@ -160,9 +160,9 @@ static ssize_t read_mem(struct file *file, char __user *buf,
 			if (!ptr)
 				goto failed;
 
-			err = probe_kernel_read(bounce, ptr, sz);
+			probe = probe_kernel_read(bounce, ptr, sz);
 			unxlate_dev_mem_ptr(p, ptr);
-			if (err)
+			if (probe)
 				goto failed;
 
 			remaining = copy_to_user(buf, bounce, sz);
-- 
2.7.4


-- 
Kees Cook
Pixel Security
