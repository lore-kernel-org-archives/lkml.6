Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZpbpsGYfzCXhjaeLXY8+k/5i29vZWHBg7b4PEXAtoSsgztVbJ5xpMn0/ebbU5NzE9SqZWIO
ARC-Seal: i=1; a=rsa-sha256; t=1526353617; cv=none;
        d=google.com; s=arc-20160816;
        b=TB791xuAwyf0UwZTbmx1E3YzbVvcKuNVnlkrWAQzVn8WOn6QVIFblX1Qr4vzwBEFFQ
         AmDxNsyxgdo7QjogyynqMUSwvp6lNsPuYqdEJrvewLrk6NuvbIXxe5Z8dJZvjUcv3gNc
         pCt3/2wPt7bqnRYH1G41v5nRBY4+t6p1DQQPoAQHUQdwicAWEQMtKBVzNI1LjSofzDej
         J5Bz7yL0VeKMK6yMFnS9hC1kAyrMb4zUk+Wpe7kmg1Csj/iAwSO6TZ+eyhTEKkz2h+mC
         +afbrRwUoCrkY+NaQcAHwCUFxaKvVVrdu1U3z3hXapALhtsvWCMrkLQUOvJ3T16aNwdm
         bbOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=3J8iFr38H9en7aXo8gN8aG7RBRS5aJLXGbSGSwvwUc8=;
        b=u7l6vBMA3XH9IPkQCvbu2b/wXRsSAs1TtRIhy1xQehjx9c8CWIIzmbG/hheRcJVAUj
         MUWBNoreKZCRTOE9J5ZM7SsYoOFi8Pgr65Y6nUnqyxy3uruncLExHdm68/BXouOAAbJZ
         ETIsHrBV2HiOz/q/+y2XilMUCmcW9Mm/BtxI6I8htZR1itUZtJKjxAIau94Wil31zNi9
         owIlsLCz1TvjMw2bY/bI01MwtJLjLbJg7LvFoobcCY+M+Y+grizWruDQTbWmDbMwAByy
         /7FuSeFURl4Maab1Y1gWJReY1QASRecNO0gSo/jNPVCNDvxQuYy77ZmaAQBamqdQHrmG
         Ur8g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=WFzzVU8W;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=dCKARfHi;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=WFzzVU8W;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=dCKARfHi;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:0E76Wl6u5M8q2Ll_AHk7nMuALN6AgFhhm5h2vPR7tgM1ILvYcZAJDg>
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
Subject: [PATCH v4 3/3] vsprintf: Use hw RNG for ptr_key
Date: Tue, 15 May 2018 13:06:26 +1000
Message-Id: <1526353586-30092-4-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526353586-30092-1-git-send-email-me@tobin.cc>
References: <1526353586-30092-1-git-send-email-me@tobin.cc>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600497770894213434?=
X-GMAIL-MSGID: =?utf-8?q?1600497770894213434?=
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
