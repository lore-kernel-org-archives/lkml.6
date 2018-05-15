Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZpxlEKW6BVaSijUOLiBAtJUXQZaEMqNb7z0dXjLNbV0LnNAXhRbmoS7iptpliWxewR/9qDH
ARC-Seal: i=1; a=rsa-sha256; t=1526353614; cv=none;
        d=google.com; s=arc-20160816;
        b=hmI+BuyB+eLEStxnwK7EjJ+fa0jmGdFJuuGXQodsZKZL2ixG9/wQsUUN/ayPqrvQLz
         mK2dXtom0vK/yx0VquOZ1co/l2MQfsiqxEu1FYy7bPXQ+cr7RHeBKDQCKb0Bi61weaML
         aJhXVh0pd0QZckjZBlaXZATq8M/CMKdnn4zR7p59Qq8yWc4oUl409lSTjJXUjvjxmxwl
         f4dqdiWYJTklXioWJ3FuO+Sn4WdJkDTc1C4fqvo5NClkC7tvC9edgBJTZ9vj9eBQ/T/4
         Wp6GRDOegNyF+8yLgiSj/VKO4jZ+cuz4zhE918agI2S9DNt9EioBBEpls+h0DVJRNLaX
         ICzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=7IQP43I/gdy9VxE7EP6kgOd9q6qvbzSeEwUDWNx0GyA=;
        b=FqjfvfXcDoyk+/MOr0seViM5RDVMU7ozhqmTzH9CHjBKnT24pjxM9IciM0cKQJqRML
         omJuz7ih/A342davYlxJdyJZ9BV6D7hYN1maUbOu22g4FDVMb24KCkaA2ZUn/VCBd/Ko
         E1GuiCMTli5pyCS38H+IdrYu82sJVcsnknjzhSQPHZOgEFSVazoJmmRlNeDRdN9ErDwk
         mZt0jnYz8ZXtFZEGytg1BiApVLwJ3Cujpf2ueuPgRHv5VProvz8+hlXMNl+WLilFHzOy
         jgH2/UjG4tkagezhvIngXRDrPwNfS7OUrPBDX3D+qeVdi5bNU/zOYGfCduYTiAtSlBu7
         sadQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=aoG3mIV7;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Pq3f585y;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=aoG3mIV7;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Pq3f585y;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:zU76WvO3W9KyI0MKEOm7_QKRehJvRCCO7SkssbgKtqGJDK0X_dAWkQ>
From: "Tobin C. Harding" <me@tobin.cc>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Kees Cook <keescook@chromium.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] random: Return nbytes filled from hw RNG
Date: Tue, 15 May 2018 13:06:25 +1000
Message-Id: <1526353586-30092-3-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526353586-30092-1-git-send-email-me@tobin.cc>
References: <1526353586-30092-1-git-send-email-me@tobin.cc>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600497767242955587?=
X-GMAIL-MSGID: =?utf-8?q?1600497767242955587?=
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
