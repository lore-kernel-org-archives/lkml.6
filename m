Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752624AbeBFJWO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:22:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752207AbeBFJWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:22:00 -0500
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] printk: Print error pointers as negative integers for %p
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, me@tobin.cc
Date: Tue, 06 Feb 2018 09:21:58 +0000
Message-ID: <151790891868.9432.1307772484552574756.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new hashing feature of unadorned printk("%p") makes it hard to spot if
the pointer actually carries an error value.  Make %p print any pointer
that matches IS_ERR() as a negative integer.

Should I set SMALL and the field_width as well, I wonder?

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/vsprintf.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 77ee6ced11b1..d87adca33b12 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1705,6 +1705,12 @@ static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
 		return string(buf, end, "(ptrval)", spec);
 	}
 
+	if (IS_ERR(ptr)) {
+		spec.type = FORMAT_TYPE_INT;
+		spec.flags |= SIGN;
+		return number(buf, end, PTR_ERR(ptr), spec);
+	}
+
 #ifdef CONFIG_64BIT
 	hashval = (unsigned long)siphash_1u64((u64)ptr, &ptr_key);
 	/*
