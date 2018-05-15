Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZqL8fM9yrh9kPFMAZAXUjH68XGQKYAQN3o23XzlgNjz98FWtonXGHSGsn8HdlD7UMOX+7KQ
ARC-Seal: i=1; a=rsa-sha256; t=1526426289; cv=none;
        d=google.com; s=arc-20160816;
        b=p8nesmp7B/EjdG3r3B1cUaZqmqkCVilHHHAUabg2Pza1PJJ67sS6JUc/GjvG8+pE72
         KtPhEdKyvDAPcLL9OYWQppDizc786FqjZWisR25EiQLlaJBJ+SAaNkPK9OZdFpHTp7oC
         nlDRbL97C5ORE0J605Nt6gGmK3dl03MK16nP9QbiUTto1JbA9nWws/xEvm60677r3KGW
         KLcPSWPjGFdgwrHSuPB1Lz+0ppTzd3uY081eT0kRb/AaE2EjqHeOosYAtG9/UfXTRJKg
         PiIWIbrV98fHNCfx1mX/cfUM1Rx3y77JRDYdAbGAKllYt/FkiQ8u7JbN0FHLfwKSXdZS
         5OMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=SsO3R7KZpu5pPt/dVnVmaq9kOLQt4PRe1a8Z5O0Xc5g=;
        b=v0pQw0j9BMlae/2r1yrU3VgzGyPx2pkeYZN+KxAZzUPnYqVQHjGWJbhyYTSnTvreYO
         MjaCPuTF5KDDhLmIg7WP0uLvrjL+3i25yII3w0mfVCQXGB3bd4cDD2erP6qQn1gSEzEJ
         7JGumiFWp22QarAPeQ/wl9Rs9ahCqOYrA8C9jJqhJStZxX9qzqTmgydTNZED3dIRvbtS
         +wwqDyUFae0nEwIC0BO/qp36bHA4OfLYc/B4yNqwSFWtl/rDJX2u695yTD5NM2PBP0yz
         pZxlFeuhxOgUF9tUL2t77rWy5BXmx1qISOOAiweCcjwZva/49RUqBtYdHkRq877vJAVI
         GiYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=hWRQkgKW;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=ZBT0psKi;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=hWRQkgKW;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=ZBT0psKi;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:sWr7WnEi7Zz6CaB-ElX-DdM87aTe0wU46GWlbclAaZp2NinRtWAfbA>
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
Subject: [PATCH v5 2/3] random: Return nbytes filled from hw RNG
Date: Wed, 16 May 2018 09:17:38 +1000
Message-Id: <1526426259-23012-3-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526426259-23012-1-git-send-email-me@tobin.cc>
References: <1526426259-23012-1-git-send-email-me@tobin.cc>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600497767242955587?=
X-GMAIL-MSGID: =?utf-8?q?1600573973330387411?=
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
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 drivers/char/random.c  | 16 +++++++++-------
 include/linux/random.h |  2 +-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 031d18b31e0f..8b9b537ae634 100644
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
+	int left = nbytes;
 	char *p = buf;
 
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
