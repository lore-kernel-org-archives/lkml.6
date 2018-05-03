Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AB8JxZrz+RFjHxd61t6mjLN+rMrK2i6w+nnNuV8Be1uNXVFkP+gixLknAIN3ab8LPDjs6xDy/KKr
ARC-Seal: i=1; a=rsa-sha256; t=1525364275; cv=none;
        d=google.com; s=arc-20160816;
        b=dX2NF/5txRRKmJfej0BkwjG4wUJHAJc2REo89oy4mCj0aC8HI0wFW+zI7mdE1lV9cl
         gqhGAP246fZ+UcJy7XEgK/BRnl+zYqAD8y57KN8M7nuRs1ArJ3rZ2vRp6dMbeAXgwDhy
         Alol1de1bEsLY2xvXil7GY1SYkHe3PAF04pkhfTKn9dRWGLZL19xhoExSOXAMwZqbbWi
         XWICHZnyCqCrv8b99ZUPlOr8BSpRbkIbSiDjCbdoIyAZAWaaK/0rjCeWEeBbh60irccb
         eiKQO8r7YGM7ztH4f19yE2GuphounTrJ8NH/8/ljxwEu5hKwAbM7crrBwEdAgLM/ArBe
         iqfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=Y3rGq5gJ5kt99sh9zGu+GkzzAt+/tCy1il0TB1zPDm4=;
        b=uW8WdLZEz6Kp/lYo7/kTckBt2Rll8yittm1jnR/p/vUJqjpd+K7m+9idl8SVnCiVrO
         RmPM7RUDf6/ST/ThTKMnTvo59i/goFuQHhMc9dxllTjWZd7h4wWFPyxQ6LrdVFHZ8Fdc
         doHACyTzD5ZD4SVdTyhnvU17NDdCO8Cvj2uyiubqQpLM+WG08vdHhMACYldAyZ+lyFok
         YfaJvY7PAMHlnXpuzVqv7zzAPLyFzY1n1cDLzef8lUznTZMFTWIbO2XspeXZ0rL0CZyD
         g2JZ9AHHISeZycS9yl3BCjFZTRaeVVrhNoCJg2dBzSxLzVoBroADaf2HmImiEKrcdg+l
         XZVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,359,1520924400";
   d="scan'208";a="225526549"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Nicolai Stange <nicstange@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] debugfs: Re-use kstrtobool_from_user()
Date: Thu,  3 May 2018 19:17:52 +0300
Message-Id: <20180503161752.19401-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599460370633363778?=
X-GMAIL-MSGID: =?utf-8?q?1599460370633363778?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Re-use kstrtobool_from_user() instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/debugfs/file.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 1f99678ff5d3..4fce1da7db23 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -796,19 +796,13 @@ EXPORT_SYMBOL_GPL(debugfs_read_file_bool);
 ssize_t debugfs_write_file_bool(struct file *file, const char __user *user_buf,
 				size_t count, loff_t *ppos)
 {
-	char buf[32];
-	size_t buf_size;
 	bool bv;
 	int r;
 	bool *val = file->private_data;
 	struct dentry *dentry = F_DENTRY(file);
 
-	buf_size = min(count, (sizeof(buf)-1));
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-
-	buf[buf_size] = '\0';
-	if (strtobool(buf, &bv) == 0) {
+	r = kstrtobool_from_user(user_buf, count, &bv);
+	if (!r) {
 		r = debugfs_file_get(dentry);
 		if (unlikely(r))
 			return r;
-- 
2.17.0
