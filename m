Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZoZhxYjT6QvnaARPkVbKixLGLMVnWSnkfA8icRKvr8wPX+UmbXLTXExHJCkGPba1ZjwQ7y7
ARC-Seal: i=1; a=rsa-sha256; t=1525388902; cv=none;
        d=google.com; s=arc-20160816;
        b=VZ5qCTR5uqoAZwbXVFJAnhblTk6dawYsQKfP7jXo3D+bDYLayhEHyt9cQ5noxOzaZk
         3xAifdq0pE9gpm17Q9OXw+fAcq73vMLFj/pdLh3xrz4CmTCcaWVfEnr/tCjkpTT5FRnS
         /3WSzvdsLcodnUqW/Xj/o5DqKPy1GUdVcU08T+5KkTkIq7+oIoIH6MW2mEbxuoIz49JB
         PZy/OIo33XgnPba0Gj192v0XrOp7zeSacQbB2j9ZH52zrtCg9BkPAqVDqN7xgbCyt2Xb
         9HH75jfz2ADWrTyLbOxyhnsYWANKpgk5CaesoAcgcVWtoD6PDC+rpcxDFnW5JEhZlytC
         8heg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=7IQP43I/gdy9VxE7EP6kgOd9q6qvbzSeEwUDWNx0GyA=;
        b=clJ+zL7AJUwMjamQNc/Wpfw2ukMZ83cZ9Y5lheRZM+hqWRHMFHojChxLbYEjPcRRxB
         uhEtnXx9xSEWSJRWOzDj8y+H685WJ1VBbtIy8jM1RrxuVUl1o+6tuN6FdDlnmb+d9T6r
         KumOHX+zh3YkGEM3/kdnLz8xeyHpwoLeWSSpQpKbnoXGkzlzY4HLOyI9htTW0/qmmvXR
         GGWL0Fb2AKtISDBxa9S7bjG0V0PZr2IXgCoI/3EHmmIP2kxdas03B01j7cYZ05hEhx/C
         7nI9XxiVCpnwsVgLiT7h8g7mg+hIvOmv+b8MPPkaO5h/94gKHoPaaroPyZ9QOyY6Yk1F
         jA9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=YR+Pqy4m;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=c1rvG948;
       spf=neutral (google.com: 66.111.4.25 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=YR+Pqy4m;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=c1rvG948;
       spf=neutral (google.com: 66.111.4.25 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:ZJbrWq1NIxPI_KG2H0gq3ewTROiHaCqE5fjsVsySOJMmNJMcry1PXQ>
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
Subject: [PATCH v3 2/4] random: Return nbytes filled from hw RNG
Date: Fri,  4 May 2018 09:07:39 +1000
Message-Id: <1525388861-27018-3-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525388861-27018-1-git-send-email-me@tobin.cc>
References: <1525388861-27018-1-git-send-email-me@tobin.cc>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599486193521059964?=
X-GMAIL-MSGID: =?utf-8?q?1599486193521059964?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently the function get_random_bytes_arch() has return value 'void'.
If the hw RNG fails we currently fall back to using get_random_bytes().
This defeats the purpose of requesting random material from the hw RNG
in the first place.

There are currently no intree users of get_random_bytes_arch().

Only get random bytes from the hw RNG, make function return the number
of bytes retrieved from the hw RNG.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
Acked-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 drivers/char/random.c  | 16 +++++++++-------
 include/linux/random.h |  2 +-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 031d18b31e0f..4b0ec597e783 100644
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
+		int chunk = min_t(int, left, (int)sizeof(unsigned long));
 
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
index 2ddf13b4281e..f1c9bc5cd231 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -38,7 +38,7 @@ extern void get_random_bytes(void *buf, int nbytes);
 extern int wait_for_random_bytes(void);
 extern int add_random_ready_callback(struct random_ready_callback *rdy);
 extern void del_random_ready_callback(struct random_ready_callback *rdy);
-extern void get_random_bytes_arch(void *buf, int nbytes);
+extern int __must_check get_random_bytes_arch(void *buf, int nbytes);
 
 #ifndef MODULE
 extern const struct file_operations random_fops, urandom_fops;
-- 
2.7.4
