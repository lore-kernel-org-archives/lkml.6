Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZprlWxjuRveuFUKMtijNArkzdCv8qYbtt9Clg1ISm2/kF82S5sbNaXeM71I7tiL+kC6+Jiv
ARC-Seal: i=1; a=rsa-sha256; t=1525301460; cv=none;
        d=google.com; s=arc-20160816;
        b=TT4liVMZN5M64DXW0R8xmDM/sdAJFbF6iZ9dhrFaVuEindnSL/+uES7DM8nSSxEKSz
         5Ra+uptR6yqHQb+egespD+HBuzGQDRlcSqaImbmq8o0jUCoh4KM0ZYssiLCjTeI8w3rq
         ME1jO6N3V8bXcZ8fx6ZH5DvNA9J1PlF3xfQoJrEefVhbFJ2Bz8OR4c6mX5K7SpQHz21W
         zk/B1Di90uLzXQ/mDEPhW8tUJrJXaR725HqTLsIEITpmUug5BMWsS5MVhLMoBQn/KWTz
         MJsV+bAbHC6zV5RPnYTSTpot9hmJjEfYdJWYHwkd+ZzjJhgOsYZgAXCgI9cjMlchudPY
         OYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=FC6nqHyS60nfB0gaHgaENceZxusVMpSUE6rV0RYUsDU=;
        b=kB0sQ3lgkNFhrqCKxSaCr8t0YTfjjiurCJlSPT0jtABFiYJH4+iWgsL4k3Ncv4n6P6
         rCBOoTdDkyzYqAz/5BIfx7wfHen0LtTo+Yao4iqiRa82X5qzr3A0C1OfqUWGKNCVgeFJ
         IOjdrZ7J1KnWx/0rG2BAl6sHz+mU1xIiV5S+20O3SyRJC/Wu/uKig12teYIy7dgU3bby
         zW3+w9abXQ2ZntsmP2rx1ry2wMtyVXffB3J9vqUw9x4zHGNcc1yqkbEAEBiMiNBNZxjX
         CBQADLi1gMUPX1llsSkgIQeiuUYemLtQX6HpxY7+HGNnXc26g4VFPERdscZPj2shs+7l
         tl/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=HI/CljwU;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=jFAY15Q9;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=HI/CljwU;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=jFAY15Q9;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:1EDqWvpU9aQysfumWUQ6SK6LoImYEJXiai6KobrjDY3XkEXbQt4SKQ>
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
Subject: [PATCH v2 3/4] vsprintf: Use hw RNG for ptr_key
Date: Thu,  3 May 2018 08:50:25 +1000
Message-Id: <1525301426-23543-4-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525301426-23543-1-git-send-email-me@tobin.cc>
References: <1525301426-23543-1-git-send-email-me@tobin.cc>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599394504285215490?=
X-GMAIL-MSGID: =?utf-8?q?1599394504285215490?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently we must wait for enough entropy to become available before
hashed pointers can be printed.  We can remove this wait by using the
hw RNG if available.

Use hw RNG to get keying material by default if available.

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 lib/vsprintf.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index b82f0c6c2aec..3697a19c2b25 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1657,9 +1657,8 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 static bool have_filled_random_ptr_key __read_mostly;
 static siphash_key_t ptr_key __read_mostly;
 
-static void fill_random_ptr_key(struct random_ready_callback *unused)
+static void ptr_key_ready(void)
 {
-	get_random_bytes(&ptr_key, sizeof(ptr_key));
 	/*
 	 * have_filled_random_ptr_key==true is dependent on get_random_bytes().
 	 * ptr_to_id() needs to see have_filled_random_ptr_key==true
@@ -1669,14 +1668,28 @@ static void fill_random_ptr_key(struct random_ready_callback *unused)
 	WRITE_ONCE(have_filled_random_ptr_key, true);
 }
 
+static void fill_random_ptr_key(struct random_ready_callback *unused)
+{
+	get_random_bytes(&ptr_key, sizeof(ptr_key));
+	ptr_key_ready();
+}
+
 static struct random_ready_callback random_ready = {
 	.func = fill_random_ptr_key
 };
 
 static int __init initialize_ptr_random(void)
 {
-	int ret = add_random_ready_callback(&random_ready);
+	int ret;
+	int key_size = sizeof(ptr_key);
+
+	/* Use hw RNG if available */
+	if (get_random_bytes_arch(&ptr_key, key_size) == key_size) {
+		ptr_key_ready();
+		return 0;
+	}
 
+	ret = add_random_ready_callback(&random_ready);
 	if (!ret) {
 		return 0;
 	} else if (ret == -EALREADY) {
-- 
2.7.4
