Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZpTKbQW32xio5rj3fI1KuEgT+Dpi68wyzLPrm/VpAVjAvhtCwUUT0bg/Lp5ioV3Ws5O0jZX
ARC-Seal: i=1; a=rsa-sha256; t=1525301464; cv=none;
        d=google.com; s=arc-20160816;
        b=hLQto2CFUeI+smago+OwpRhPeze8cadE7cAJOS2LRkM8bs5zmC++V/Jo8tqDp9CsVi
         g6OMuwSfksctOa7QHJ0wE356Njw7DcA5XCQNIl2qj77cwrAeL8L1l6JlIJtgkGnjWHaN
         Ekaazx3ikVfuhSzPAvLCJsAps9hwUOQP0LGLeP9odmGDBVoybPpillupBf2BQN6mN1cz
         9UzDggS4p+KWOS6Si3NbMEEqBF+F6Dh6W6YDdWsuvSG27cQH8WSn/F9tOPMjF2yT/FWt
         fyPHQtX4+QZP49ZHRYiUBh0tDBnWJnVSD3/V4uCA3riwRAEnP/gz9NvSy0PitMA3G/UL
         dJig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=h/FGUBZw2zocMpQ7VJfcFxRmZsTqvC1Y7wxS2SZshaI=;
        b=LNIIlex6my9NQ99/N3jCBIl6gIDb6TDCKYruyGCQnV1zcG/xWoVHbEmmxwO9C73Pj5
         vcWkjKMM1aBOVL5uSI7smc/6LRnEFyXayN6xnR5pOIY9/yFnjeuooKhAd1d4LWCgc+uO
         osqg14gM/PG+UtpTM9rZNEGXYb19TjuMTyGiDpatJmMFaMv45FiVa8kUYjnZYoRxoV/U
         CaPSJyDjTxf7VujhuC+tyOyEtypwKClfbLhrAVu8Ddp3VQLgbthxSaWcm8KXnozpZkEJ
         h4L5tUK8Qn4qfDVr6rsLFqzUpFDUciOlIWCI/POR227Dc0YENFKAjgEOLaN5e+JjT3Nw
         PjCA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=E9CcfSq9;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=lwuatShw;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=E9CcfSq9;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=lwuatShw;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:10DqWi_rSebdRF2aQOUaUUXHopGqWXxhPhJffvFBeCZTWNUS6cM-pg>
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
Subject: [PATCH v2 4/4] vsprintf: Add command line option debug_early_boot
Date: Thu,  3 May 2018 08:50:26 +1000
Message-Id: <1525301426-23543-5-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525301426-23543-1-git-send-email-me@tobin.cc>
References: <1525301426-23543-1-git-send-email-me@tobin.cc>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599394508196651405?=
X-GMAIL-MSGID: =?utf-8?q?1599394508196651405?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently printing [hashed] pointers requires either a hw RNG or enough
entropy to be available.  Early in the boot sequence these conditions
may not be met resulting in a dummy string '(____ptrval____)' being
printed.  This makes debugging the early boot sequence difficult.  We
can relax the requirement to use cryptographically secure hashing during
debugging.  This enables debugging while keeping development/production
kernel behaviour the same.

If new command line option debug_early_boot is enabled use
cryptographically insecure hashing and hash pointer value immediately.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
 lib/vsprintf.c                                  | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b8d1379aa039..ab619c4ccbf2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -748,6 +748,14 @@
 
 	debug		[KNL] Enable kernel debugging (events log level).
 
+	debug_early_boot
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
index 3697a19c2b25..6c139b442267 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1654,6 +1654,18 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 	return widen_string(buf, buf - buf_start, end, spec);
 }
 
+/* Make pointers available for printing early in the boot sequence. */
+static int debug_early_boot;
+EXPORT_SYMBOL(debug_early_boot);
+
+static int __init debug_early_boot_enable(char *str)
+{
+	debug_early_boot = 1;
+	pr_info("debug_early_boot enabled\n");
+	return 0;
+}
+early_param("debug_early_boot", debug_early_boot_enable);
+
 static bool have_filled_random_ptr_key __read_mostly;
 static siphash_key_t ptr_key __read_mostly;
 
@@ -1707,6 +1719,12 @@ static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
 	const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" : "(ptrval)";
 	unsigned long hashval;
 
+	/* When debugging early boot use non-cryptographically secure hash */
+	if (unlikely(debug_early_boot)) {
+		hashval = hash_long((unsigned long)ptr, 32);
+		return pointer_string(buf, end, (const void *)hashval, spec);
+	}
+
 	if (unlikely(!have_filled_random_ptr_key)) {
 		spec.field_width = 2 * sizeof(ptr);
 		/* string length must be less than default_width */
-- 
2.7.4
