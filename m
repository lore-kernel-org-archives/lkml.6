Return-Path: <joern@purestorage.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520975416; cv=none;
        d=google.com; s=arc-20160816;
        b=oN8Y+e4svcvUNAaU6eKO3Ky4TftZXVfovoW8LJ9vapCH9E326Xk5QFYUKjGmkX+WVF
         9GKGVU62WlkI6Lcf5HNWBFUlvU3KXUwhTaSzv/ugvgfcLa+uuip2xWIm4wLWSZHm7m5H
         6gZa3LbrPe47MdnrKubitnKigcoWXe8R47TwEJqCJsV0jxfas0a6XCTUw/kmClKkBYzi
         9ILJZbMznLI3wo5Ota782BdHAxDLRsE6vVoAVmw5o6zqwfEsgF2pwdxsSR/h38hPLWSj
         TZGh6Nt390AyPrRHaN4cV44RxA4UJ9suq8VcyAi3bsfams18c1Aa3pcqkNOW6IXEpEhE
         VqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:message-id:subject:cc:to:from:date
         :dkim-signature:arc-authentication-results;
        bh=1x+enLGXp8EToJZkHeSGFRA4I50aqhWfid5KEdvEZ5w=;
        b=dajol0Riez2W9XwkmwUQipjF9zwEuwxchXkiwl31/EZridoW0zC9kksUoq7k4lamR+
         w+pxkT4eTU9DpdAekI3vuEPFwSmscvCVTlkEVXnHCLlWAQjFHz5ao8J/SJt6tTVOWQjr
         RyhtkHYkE8TNeUAUs+9NwlIU0Iz4l6nJIQ/CKrV/NDdhXR09Pp5R2r1IKQ2g581Wztmb
         erz++qw+Fv2MDnasiZ1I2chuJLL+Z95w5/GacvkVJTz6eys078ncZvNFMCar2Tbc5M55
         e6uAZZtLcRdrXdQDx/psUSz5qBSytHYUZsLs22Z7Qew+P3+r4xozQagxpFpr5GZk4vO3
         cUcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@purestorage.com header.s=google header.b=CQ2p0tGS;
       spf=pass (google.com: domain of joern@purestorage.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joern@purestorage.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=purestorage.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@purestorage.com header.s=google header.b=CQ2p0tGS;
       spf=pass (google.com: domain of joern@purestorage.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joern@purestorage.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=purestorage.com
X-Google-Smtp-Source: AG47ELszEt5q0aWlFrikYwLhAGEFJZe42J0opCfPXZwEFMM8BtNwqMLUWzjcT3xivkxU9lTwne046w==
Date: Tue, 13 Mar 2018 14:10:12 -0700
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@purestorage.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	"Tobin C. Harding" <tobin@apporbit.com>,
	"Tobin C. Harding" <me@tobin.cc>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Tycho Andersen <tycho@tycho.ws>,
	Oleg Drokin <oleg.drokin@intel.com>,
	Andreas Dilger <andreas.dilger@intel.com>,
	James Simmons <jsimmons@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] btree: avoid variable-length allocations
Message-ID: <20180313211012.GB29976@cork>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594858317901849127?=
X-GMAIL-MSGID: =?utf-8?q?1594858317901849127?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I agree that the code is garbage.  In my defense, creating generic
iterator-type functions for multiple data types appears to be one of the
hardest problems in CS with many bad examples of what not to do.

Patch below should fix it.  We have tcm_qla2xxx systems, so I will stick
it into our test system as well.

Jörn

--
It is a cliché that most clichés are true, but then, like most clichés,
that cliché is untrue.
-- Stephen Fry

>From 0077d19b11ec27c3287787d2413b26fc4cf0b3ca Mon Sep 17 00:00:00 2001
From: Joern Engel <joern@purestorage.com>
Date: Tue, 13 Mar 2018 11:36:49 -0700
Subject: [PATCH] btree: avoid variable-length allocations

geo->keylen cannot be larger than 4.  So we might as well make
fixed-size allocations.

Given the one remaining user, geo->keylen cannot even be larger than 1.
Logfs used to have 64bit and 128bit keys, tcm_qla2xxx only has 32bit
keys.  But let's not break the code if we don't have to.

Signed-off-by: Joern Engel <joern@purestorage.com>
---
 lib/btree.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/btree.c b/lib/btree.c
index f93a945274af..590facba2c50 100644
--- a/lib/btree.c
+++ b/lib/btree.c
@@ -3,7 +3,7 @@
  *
  * As should be obvious for Linux kernel code, license is GPLv2
  *
- * Copyright (c) 2007-2008 Joern Engel <joern@logfs.org>
+ * Copyright (c) 2007-2008 Joern Engel <joern@purestorage.com>
  * Bits and pieces stolen from Peter Zijlstra's code, which is
  * Copyright 2007, Red Hat Inc. Peter Zijlstra
  * GPLv2
@@ -76,6 +76,8 @@ struct btree_geo btree_geo128 = {
 };
 EXPORT_SYMBOL_GPL(btree_geo128);
 
+#define MAX_KEYLEN	(2 * LONG_PER_U64)
+
 static struct kmem_cache *btree_cachep;
 
 void *btree_alloc(gfp_t gfp_mask, void *pool_data)
@@ -313,7 +315,7 @@ void *btree_get_prev(struct btree_head *head, struct btree_geo *geo,
 {
 	int i, height;
 	unsigned long *node, *oldnode;
-	unsigned long *retry_key = NULL, key[geo->keylen];
+	unsigned long *retry_key = NULL, key[MAX_KEYLEN];
 
 	if (keyzero(geo, __key))
 		return NULL;
@@ -639,8 +641,8 @@ EXPORT_SYMBOL_GPL(btree_remove);
 int btree_merge(struct btree_head *target, struct btree_head *victim,
 		struct btree_geo *geo, gfp_t gfp)
 {
-	unsigned long key[geo->keylen];
-	unsigned long dup[geo->keylen];
+	unsigned long key[MAX_KEYLEN];
+	unsigned long dup[MAX_KEYLEN];
 	void *val;
 	int err;
 
-- 
2.15.1
