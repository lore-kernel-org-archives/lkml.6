Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZqnHkJEwYNcAr+PwvtTGhF/Mm0kyD/ejOyWEEhEFOmogTcKXFQl3Vmi4+O4lT02VTBQJEPG
ARC-Seal: i=1; a=rsa-sha256; t=1525217671; cv=none;
        d=google.com; s=arc-20160816;
        b=lNsGmWJaoFVF5urFGeT/77nyYayZCmjE/3zIviun7BUyTvndSZq3h+oSeWzj6xfiKz
         SlXlVsRN0WytgPrWD9xjNKpBavxs+Y1RgbwWJ4zp0nMbr/Yr2G2e5rpvj3svL77wdIRj
         /UHpbWwbivn0iErVpDCYvCRT9lRIY3BPwhwHC+RWRu/n1SOp8dmCkryiO9t5lnQImS2m
         At85QtuOl/bAkzmInFGQvbN6Nyz/2cntVtUwiwaLh0mqqxQBUvnQzsl3ylZf3hde5xZU
         QT91nfUpsuA0Wr5wfTByeGexdjDYh4K6FJabTjPcyABPz4Thf0ZFCkoajcF/7ngUFeJo
         W7DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=FbLyIHYkBqT18RrhqpCDTQeafDLAoBl3yfAs43RRStg=;
        b=mzxOGEn2S4Y0p+6NKDqtQXIC+iDJnqKW9cRIfvvBecIY8q8HQ7lDRIrfYimwh3RKDD
         zWfjrdGLcNJZZmayGdMuBkARtvjZOp84EJOdb/PwMXUEqMgyRodE9FFYDTrFNqhSb4gL
         m9xcDSfeVqgueYZYzZlsu7rP5hECo3SJp2977ovL+9l4LA+TBPyBSBPsfbKK+D0UPQjF
         Vx/Zq+dUsZmCZAvLhPOsDB/CgmK3VmW/CzPpIE094F9j0fjID7XWZmY8brBtdPfprKBK
         rOX35OsUtNBgbTIvn5sPk40IuDcCClQo4bxscFre5JylKSyuq114kmtco1T86YaDFwi2
         UHgw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=FRrnB+U4;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Za0+UjHR;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=FRrnB+U4;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Za0+UjHR;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:h_noWtnINUOFvCwHkj3JR57Z6xv2ewips49vqh0dqFYk5nWLGySang>
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
Subject: [PATCH 3/3] vsprintf: Add use-early-random-bytes cmd line option
Date: Wed,  2 May 2018 09:33:40 +1000
Message-Id: <1525217620-4107-4-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525217620-4107-1-git-send-email-me@tobin.cc>
References: <1525217620-4107-1-git-send-email-me@tobin.cc>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599306645428721863?=
X-GMAIL-MSGID: =?utf-8?q?1599306645428721863?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently if an attempt is made to print a pointer before there is
enough entropy then '(____ptrval____)' is printed.  This makes debugging
early stage stack traces difficult.  We can relax the requirement for
cryptographically secure hashing when debugging while still maintaining
pointer hashing behaviour.

Add a command line option 'use-early-random-bytes'.  When enabled get
key material from the hw RNG if available.

This option should NOT be enabled on production kernels.

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 lib/vsprintf.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index b82f0c6c2aec..7b9cf6bb9fd2 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1654,12 +1654,39 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 	return widen_string(buf, buf - buf_start, end, spec);
 }
 
+/*
+ * Command line option use_early_random_bytes allows debugging early in
+ * the boot sequence, if enabled we attempt to use the hw RNG to get
+ * ptr_key material.  Do NOT use on production kernels.
+ */
+static int use_early_random_bytes;
+EXPORT_SYMBOL(use_early_random_bytes);
+
+/*
+ * Process kernel command-line parameter at boot time.
+ * use_early_random_bytes=0 or use_early_random_bytes=1
+ */
+static int __init use_early_random_bytes_enable(char *str)
+{
+	long option;
+	int ret;
+
+	ret = !!kstrtol(str, 10, &option);
+	if (ret == 0 && option != 0)
+		use_early_random_bytes = 1;
+
+	pr_info("use_early_random_bytes: %s\n",
+	        use_early_random_bytes ? "enabled" : "disabled");
+
+	return 1;
+}
+__setup("use-early-random-bytes=", use_early_random_bytes_enable);
+
 static bool have_filled_random_ptr_key __read_mostly;
 static siphash_key_t ptr_key __read_mostly;
 
-static void fill_random_ptr_key(struct random_ready_callback *unused)
+static void ptr_key_ready(void)
 {
-	get_random_bytes(&ptr_key, sizeof(ptr_key));
 	/*
 	 * have_filled_random_ptr_key==true is dependent on get_random_bytes().
 	 * ptr_to_id() needs to see have_filled_random_ptr_key==true
@@ -1669,13 +1696,30 @@ static void fill_random_ptr_key(struct random_ready_callback *unused)
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
+
+	if (use_early_random_bytes) {
+		int nbytes = sizeof(ptr_key);
+
+		if (get_random_bytes_arch(&ptr_key, nbytes) == nbytes) {
+			ptr_key_ready();
+			return 0;
+		}
+	}
+
+	ret = add_random_ready_callback(&random_ready);
 
 	if (!ret) {
 		return 0;
-- 
2.7.4
