Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbeE1BrR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 21:47:17 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44391 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753007AbeE1BrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 21:47:13 -0400
X-ME-Proxy: <xmx:oF8LW3ntXPs2Mp0GbnslnRgLyC54asK0ncYelKSN6iSfDvaW71bS7w>
X-ME-Proxy: <xmx:oF8LWzEt3DAaQK62mvtM0SXRBe0D9HIv8f2UJ54cAFXZzrKKP5zvdA>
X-ME-Proxy: <xmx:oF8LW7em70wzFQAkHFNaWLXCitIHKwqXaST6cV69U3G3c5rcyD_Jhg>
X-ME-Proxy: <xmx:oF8LW0iqX8le2Kav6OPGwSBNyUaTbYxKHfLrMOGgg2scsAe-DTkhcg>
X-ME-Proxy: <xmx:oF8LWwUfqhGgtTX6HMx1iUSnQiPmafVkBgKiQvpp-ASnt1Zrx-n2xA>
X-ME-Proxy: <xmx:oF8LW7qvawjDsQRv8I2SljF-Z3djhjPSJr2KtQzh787zrOoCScL9KA>
X-ME-Sender: <xms:oF8LW6Fxwc_sWlx6MK_k4xsvCRhHmIiZPZIf0FuO8Bm1tUuR1fefmw>
From: "Tobin C. Harding" <me@tobin.cc>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Tobin C. Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/4] random: Return nbytes filled from hw RNG
Date: Mon, 28 May 2018 11:46:40 +1000
Message-Id: <1527472002-11571-3-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527472002-11571-1-git-send-email-me@tobin.cc>
References: <1527472002-11571-1-git-send-email-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
