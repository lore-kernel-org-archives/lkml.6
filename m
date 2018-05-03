Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZq6WiKiMis8TyaDCiySkynQzeyzwt4QUf1gkFkL0N4kBrutSSBFFj+pA0yDHecdHtfitPfL
ARC-Seal: i=1; a=rsa-sha256; t=1525388904; cv=none;
        d=google.com; s=arc-20160816;
        b=ZuCqaprB7fDPoznSbvDnH2vVwrcfTJgqzvUSBbFivGGPJzkbySQOUz3m1k97hkj56E
         uquhuJeYai8FNnAWuwf80ItPEZiwAkSupp9FebI2AQQ/NEXthyKOgnFy9u78ZnkNCf1I
         sPHADPOWIZ43Ne5o8H+oPytOOPoxDqM62hc1Zk1jtLI0lyygRQd8WU9P2775UvJBim62
         QG4qRmaqE/e1Cl17m+Ld0ZeBG1R1/T7/QUqpuhNXxqswZDV73N+wMkIiDlxPHijY+AW/
         TaYt20Zeq60uC7W5T8SObT0OK44DRY2h6ED055ieanIagZjUvL1lXz1lnrhGNZa5ZbuF
         rC0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=3J8iFr38H9en7aXo8gN8aG7RBRS5aJLXGbSGSwvwUc8=;
        b=0Lu1Z/h6rnCIHkwXTsYaVGGLq8aiqZIctRueu+X3OieBiy8DED6rUC4TJ6+UraTG+G
         EdxoC5Y0SSY7nXO9OTfgrfu5KYqeChR4ToIzGvKxRqohxzXv4ncW+YBHVNI8FPqYXFGc
         Y8ozXgT2LV8vGatUndsCwmufGzMW605T6BAkY9GuA0g+Dx23aiUa+1ktbIGDT1OWCYWS
         RvpO/5HItStL6H5MbOeZqTZsYbHv3At8oTzfy4U9GoipeK9vah8lS4a85rq99wb7ksuU
         BffrEjKo7sn8qTmVX9ZZXwmoBIXF0/MGEsqT3jZhSGgA/P1KrImMh25JPOPL40KeGG+R
         CiGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=lZ9+NsTg;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=VaaqYBWQ;
       spf=neutral (google.com: 66.111.4.25 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=lZ9+NsTg;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=VaaqYBWQ;
       spf=neutral (google.com: 66.111.4.25 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:Z5brWjfbci0sC_mAe024aJu-Vs32tzmCp4HphV7WbEjPUzbiHMV5lA>
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
Subject: [PATCH v3 3/4] vsprintf: Use hw RNG for ptr_key
Date: Fri,  4 May 2018 09:07:40 +1000
Message-Id: <1525388861-27018-4-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525388861-27018-1-git-send-email-me@tobin.cc>
References: <1525388861-27018-1-git-send-email-me@tobin.cc>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599486196077937530?=
X-GMAIL-MSGID: =?utf-8?q?1599486196077937530?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently we must wait for enough entropy to become available before
hashed pointers can be printed.  We can remove this wait by using the
hw RNG if available.

Use hw RNG to get keying material.

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
