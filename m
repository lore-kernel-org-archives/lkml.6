Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZoGz0kZjFEMR/6v73H2rVIyPYsRcbTrZnOt0H7RQcBosVRtxct59QVDPEhEGjQnldW1Q/j+
ARC-Seal: i=1; a=rsa-sha256; t=1525217668; cv=none;
        d=google.com; s=arc-20160816;
        b=I9yhFw+vNlOG5Qvze0WxtJPWFQGj6QIYxje4NI2jb5q92bsRTKuRtMoyaw9m2oY45M
         tTDTGfhJsqPuXti6VFjAJQDnIATEhJVMJ9NiaSliW1WO7W1+4j6HKT3V5ftkL44TiyR7
         rtN9XkcapuCquoya+tmwrkY5A0KlFgmEFoun+SbD3nrU649u3wSnE3RumNEasmGJN0NY
         QkNS+qwPnNN59Ww7GDwIP9pB41e2nI+5eNGXelzqOVt3ifB8pshQl6eD3KSHxkWEwXMa
         gTdXfFAArZEpBHa9++8mInZFXNr9cavfWu+FOrPQX8vaq3RM2aFUD72jxjvDKy8yZvxj
         9fSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=RO430ptCF7wGCqopZmtf7rPGE1DEsNcjpEpiqxtD37o=;
        b=Vvi8ZwliFJCRUrikReIuyWmOG2UwEcxxHSmEzvU3D5ujBx8IMJPcxjAf+KPrfBWosq
         NQl96juwnQVgQ2+l9s+c6wB3xkT5hRIID6NG8Tw/z7tVj+7u4+vHNez/wQkXFcbpd4Eu
         5M9JOAwlsmu2+MXvnWow1lbMuZoxiqrU1cwafLpkdUul9YI04vHmIYiu5MwVdQL2D0nw
         tV8UyEeu0xkWuu+4sdadDqURU2jgjWTO4V3z86lUYDU/iUgObQCI2hiGWQitpe27Wyz4
         nYAMa9XWsdRcQnQ4VrY1IO582MlrjSpaGc46D83mmgzAzOIqekAPcIWSFfjx1kA7YKVW
         8AYg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=MHoBstDa;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=JYTI+Dd0;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=MHoBstDa;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=JYTI+Dd0;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:g_noWp7MlKb9PfAfA79ZjBhwv4vmCbRUJFux_nhpXvy0lybrZQzbOA>
From: "Tobin C. Harding" <me@tobin.cc>
To: linux-kernel@vger.kernel.org
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Kees Cook <keescook@chromium.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/3] random: Return nbytes filled from hw RNG
Date: Wed,  2 May 2018 09:33:39 +1000
Message-Id: <1525217620-4107-3-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525217620-4107-1-git-send-email-me@tobin.cc>
References: <1525217620-4107-1-git-send-email-me@tobin.cc>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599306642017406992?=
X-GMAIL-MSGID: =?utf-8?q?1599306642017406992?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently the function get_random_bytes_arch() has return value 'void'.
If the hw RNG fails we currently fall back to using get_random_bytes().
This defeats the purpose of requesting random material from the hw RNG
in the first place.

There are currently no intree users of get_random_bytes_arch().

Only get random bytes from the hw RNG, make function return the number
of bytes retrieved from the hw RNG.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 drivers/char/random.c  | 16 +++++++++-------
 include/linux/random.h |  2 +-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 031d18b31e0f..3a66507ea60b 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1725,26 +1725,28 @@ EXPORT_SYMBOL(del_random_ready_callback);
  * key known by the NSA).  So it's useful if we need the speed, but
  * only if we're willing to trust the hardware manufacturer not to
  * have put in a back door.
+ *
+ * Return number of bytes filled in.
  */
-void get_random_bytes_arch(void *buf, int nbytes)
+int __must_check get_random_bytes_arch(void *buf, int nbytes)
 {
 	char *p = buf;
+	int left = nbytes;
 
-	trace_get_random_bytes_arch(nbytes, _RET_IP_);
-	while (nbytes) {
+	trace_get_random_bytes_arch(left, _RET_IP_);
+	while (left) {
 		unsigned long v;
-		int chunk = min(nbytes, (int)sizeof(unsigned long));
+		int chunk = min(left, (int)sizeof(unsigned long));
 
 		if (!arch_get_random_long(&v))
 			break;
 
 		memcpy(p, &v, chunk);
 		p += chunk;
-		nbytes -= chunk;
+		left -= chunk;
 	}
 
-	if (nbytes)
-		get_random_bytes(p, nbytes);
+	return nbytes - left;
 }
 EXPORT_SYMBOL(get_random_bytes_arch);
 
diff --git a/include/linux/random.h b/include/linux/random.h
index 2ddf13b4281e..308168c0a637 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -38,7 +38,7 @@ extern void get_random_bytes(void *buf, int nbytes);
 extern int wait_for_random_bytes(void);
 extern int add_random_ready_callback(struct random_ready_callback *rdy);
 extern void del_random_ready_callback(struct random_ready_callback *rdy);
-extern void get_random_bytes_arch(void *buf, int nbytes);
+extern int get_random_bytes_arch(void *buf, int nbytes);
 
 #ifndef MODULE
 extern const struct file_operations random_fops, urandom_fops;
-- 
2.7.4
