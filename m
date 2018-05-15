Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZqAWjdbvh3JrJjpdnsPpCThzZ3M4MeDd/Ip1MdCSVInvf7e/TDvh6b6Z8kGhmRqvWbILvzM
ARC-Seal: i=1; a=rsa-sha256; t=1526359142; cv=none;
        d=google.com; s=arc-20160816;
        b=KXA3oBaN4h6vGpsT85BljvNfiH4x/ICyjvCsyMJCMMVYlcLNS0zUkfxme4eWm3emsd
         wHKkpOzZ1K7NwgVk77WMDx9aQH9sXj539QW0TqHLKxIGRDLlKrL4qDYnjsTaKptGKXqD
         GbuNxUtPvGrQjA57mKPJxtMAImbvRAeNPR+0wD9Xx1dvWFiplQbW/vZqLnPtHtLkr8i1
         rUrHTTLOFVYRS6ZjSHYUBNx9uAVA1xwDvXvw/CqUk0DhdSedC5dMqzFATKoJSgzspRG9
         7oWB5D7TdJ56OvpwBL7iDiU6MtbPY1ptvAbqZ4oDExQVMvdkliH4Bh5l7/2BCTv63s2i
         C/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=4+5TaRlfW+gzgDcR0SMbC+RhxwHsS33ySssiCs6v0HM=;
        b=UprTSmxOLnME+ysfnXyIMVkP0lZuipTjNVpzzT5+1KxMSF8EZYJIS1OLYoEjSAZpP6
         L3YmScyoqnutZJAS9lRmH+H7wZwLnwWWYn9xHfno+KF7BPvFCydZCU10tn2vZs/WD669
         Hl1SVBSfq4QGEVg9yh/DsDdYEO4nCQts1EZhd+bcx4HqbNlKwncG64ei/vxXUpK67JGC
         2AuG17hJOKoEwbYKUJDbumgds+BEMtxkhiw4SnXb1zSTL1LnHS5qPgo4WHfsoem1vZ97
         Ap4eLCnzJ9rrwv0hj0DGvHO5IHemK9mxwW+sNJirHVBVABRKohRfB5PxZM5speGG/aFZ
         KqSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=JQvWPlQc;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=jJxhSMZc;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=JQvWPlQc;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=jJxhSMZc;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:ZGT6Wq9HIBunCAaH1qiKlY9fQhKiTt_qz8eN65LbyVKubqpeECj__Q>
From: "Tobin C. Harding" <me@tobin.cc>
To: Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Theodore Ts'o <tytso@mit.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vsprintf: Add command line option debug_boot_weak_hash
Date: Tue, 15 May 2018 14:38:35 +1000
Message-Id: <1526359115-5489-1-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600503563774077130?=
X-GMAIL-MSGID: =?utf-8?q?1600503563774077130?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently printing [hashed] pointers requires enough entropy to be
available.  Early in the boot sequence this may not be the case
resulting in a dummy string '(____ptrval____)' being printed.  This
makes debugging the early boot sequence difficult.  We can relax the
requirement to use cryptographically secure hashing during debugging.
This enables debugging while keeping development/production kernel
behaviour the same.

If new command line option debug_boot_weak_hash is enabled use
cryptographically insecure hashing and hash pointer value immediately.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---

This patch was previously submitted as the last in the set

	[PATCH v3 0/4] enable early printing of hashed pointers

Helps debugging using ftrace.  Original problem reported by Anna-Maria,
solution requested by Steve.

Changes since above mentioned patch set
 - change option name from debug_early_boot -> debug_boot_weak_hash
   (suggested by Steve).


I have only tested this by enabling the option and printing some
pointers.  This does not _prove_ that it fixes the ftrace issue.

thanks,
Tobin.


 Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
 lib/vsprintf.c                                  | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3b8032431585..c95dd6704592 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -748,6 +748,14 @@
 
 	debug		[KNL] Enable kernel debugging (events log level).
 
+	debug_boot_weak_hash
+			[KNL] Enable debugging early in the boot sequence.  If
+			enabled, we use a weak hash instead of siphash to hash
+			pointers.  Use this option if you need to see pointer
+			values during early boot (i.e you are seeing instances
+			of '(___ptrval___)') - cryptographically insecure,
+			please do not use on production kernels.
+
 	debug_locks_verbose=
 			[KNL] verbose self-tests
 			Format=<0|1>
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index b82f0c6c2aec..5ff18f8fe3bd 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1654,6 +1654,18 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 	return widen_string(buf, buf - buf_start, end, spec);
 }
 
+/* Make pointers available for printing early in the boot sequence. */
+static int debug_boot_weak_hash __ro_after_init;
+EXPORT_SYMBOL(debug_boot_weak_hash);
+
+static int __init debug_boot_weak_hash_enable(char *str)
+{
+	debug_boot_weak_hash = 1;
+	pr_info("debug_boot_weak_hash enabled\n");
+	return 0;
+}
+early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
+
 static bool have_filled_random_ptr_key __read_mostly;
 static siphash_key_t ptr_key __read_mostly;
 
@@ -1694,6 +1706,12 @@ static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
 	const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" : "(ptrval)";
 	unsigned long hashval;
 
+	/* When debugging early boot use non-cryptographically secure hash */
+	if (unlikely(debug_boot_weak_hash)) {
+		hashval = hash_long((unsigned long)ptr, 32);
+		return pointer_string(buf, end, (const void *)hashval, spec);
+	}
+
 	if (unlikely(!have_filled_random_ptr_key)) {
 		spec.field_width = 2 * sizeof(ptr);
 		/* string length must be less than default_width */
-- 
2.7.4
