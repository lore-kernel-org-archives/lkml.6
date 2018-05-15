Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZqq0ocBY1PaZDhB9/Q+sG8XsdHN1n+1slJQSNCyN6LBjOzYLOnm8p7tNklGegAmzPZy72Hl
ARC-Seal: i=1; a=rsa-sha256; t=1526426293; cv=none;
        d=google.com; s=arc-20160816;
        b=QHnRJTSbrQr8LvLLmPr9kmEHH+A/DjPMozKvVj8oVolxJ/+kpiSxUfaNl7jUTSq1zg
         kacCXVfwhbjZr0m8xvkM9KrmD4YlXvAQsLOy8f/ytWPrwSaCKlkk2fRhGELFEkhipVz/
         3o+BEZ/2NinCOPKWutHYBTrm6BK0nV0gxKnU6DGD4L8B2VzxpBwVFKJQRefzpgiosMFJ
         lzuiPEV98Rs7hWRX0JeK9NjF2BJl686dMq2le36Kv3xpD5qjyYAqTlvWGRhczfcxN3+E
         2KIFmwPPNjFo7OW3/cvZPvl/7iGeQUlI5JfnsrbmIQPr73T2fhmnEZHncEd7Mt83yGal
         s7AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=WGmCoyZw6kfQig0vmyrnjLAxcK/WAAtSlqoT6hKcZCs=;
        b=XSgrxqyQcm9R/6hAVDqXgd6BtCQIR18R3NUL7o7cdKsyCxXQCwmJf8epj4Fh4ItKdL
         OQZED+/EHwVLwqBTbfnynri6mIRKzJposzTwJuRnGmdFTHXVoNVOKqcpQOowcWDTWBWS
         D8pYwYZE53JhC/z3+yK+QZD0wSIOV0lITIht3+Rwh5zjxow+leD73GmqZVuBiDx85c5b
         QjVN3AQMfoj+yWM1XOTnn+IAVQ9nLtw8o38u26WM5qARqMdgW8oJriibEdbq/x0QnPfd
         nsJZNlkd2SWcaOvJFGcCofX9XiwthUqjeA+wT0yHByT5GXcBj8XP3VdcfK3f3lK1hk6T
         QKTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=IVlASwN1;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=WNa6TPVj;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=IVlASwN1;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=WNa6TPVj;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:tGr7Wtji9yFQd69f9TMAewzS2sWp9Afj60rrOvK8UvFSU36srPwl7A>
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
Subject: [PATCH v5 3/3] vsprintf: Use hw RNG for ptr_key
Date: Wed, 16 May 2018 09:17:39 +1000
Message-Id: <1526426259-23012-4-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526426259-23012-1-git-send-email-me@tobin.cc>
References: <1526426259-23012-1-git-send-email-me@tobin.cc>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600497770894213434?=
X-GMAIL-MSGID: =?utf-8?q?1600573976593127048?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently we must wait for enough entropy to become available before
hashed pointers can be printed.  We can remove this wait by using the
hw RNG if available.

Use hw RNG to get keying material.

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Tobin C. Harding <me@tobin.cc>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 lib/vsprintf.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index b82f0c6c2aec..a1567dd7066c 100644
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
+	int key_size = sizeof(ptr_key);
+	int ret;
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
