Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZoeKLJl3hsfV8sbPkm4ZI4yyV6tLKiPzXfSOV7JDFIadddsXMEW6aIpzFjq5udEX3yJtCJm
ARC-Seal: i=1; a=rsa-sha256; t=1525301457; cv=none;
        d=google.com; s=arc-20160816;
        b=VFB+ekg8tZ0496Y0tt6d+IACWWZCa9aSBrZOG+ubIH+hrUpXhyILnKpGh3uAESkRCr
         JM6Y8a3wnpZMl0azdcFMVY7AK8alq5JF/6rTLJXuHB2/B+ntfXYRfwVsp9V25y7+IEIc
         S7z/4rF0HBq9Yu+TCC3aVpWdZKQfPWrHMtfKTQkL/DAfGhvfln9eMRiB5FA2g+QJEiqF
         2ufvHiBP9j4xTVne6iX3q+jmxPiWD0C0S0J3d3cJGIW+794XmU2YafsZBhDEdD9mnb9H
         qYAZpgKNLgKR2NyiOO2eFN1/HNgxJlief1RpvEuXqf23y75dFcyz2Q0NOnMxdHS07H7m
         2LQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=FSt+amRc7hgbNGC+4/4/0um0zhoJZow48Lkda2Mrm/s=;
        b=N1c4xRH2CK+lvO6AgQ8el2hdxgSu7pY4SEvPdoerCYeDlTygYkkDE9hb4rMU3+jdNy
         mshiJPp3RkJNtnUY2uHUTFXgCXvwD6nhGApViApsMT8y2h25AK4Qmqy/pCvvCVtI/05F
         VWhQSfOT19ckHgLUj7GOdNYEttTOnrIGLP5Kam+YoNqjMJfE1lgNWoEVKbkQhxtRsCbx
         h833BmVyAGYg7UpYf9PO8i7L97+us0pupzTVoR2Hy6ud3efAaUyjB2NZVkaIOateE7ZN
         /+3OMpxwCz3AE76jJfCt66i/wx+pd6Cy4SSEECqCb+XLRuHXbi3jOHTTWj0+yNMJ2QSD
         TnMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=dqUlhpxa;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=AeRmuRyN;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=dqUlhpxa;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=AeRmuRyN;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:0EDqWvSdn2hEOJdXgskNulhMY10U38O-Tu7RphXvOer6C9hoVPTBfw>
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
Subject: [PATCH v2 2/4] random: Return nbytes filled from hw RNG
Date: Thu,  3 May 2018 08:50:24 +1000
Message-Id: <1525301426-23543-3-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525301426-23543-1-git-send-email-me@tobin.cc>
References: <1525301426-23543-1-git-send-email-me@tobin.cc>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599394500910104401?=
X-GMAIL-MSGID: =?utf-8?q?1599394500910104401?=
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
