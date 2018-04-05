Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeDEU3k (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:29:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750726AbeDEU3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:29:37 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 01/20] vfs: Remove the const from dir_context::actor
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Apr 2018 21:29:36 +0100
Message-ID: <152296017599.31027.6544474490397113598.stgit@warthog.procyon.org.uk>
In-Reply-To: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
References: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the const marking from the actor function pointer in the dir_context
struct.  The const prevents the structure from being used as part of a
kmalloc'd object as it makes the compiler require that the actor member be
set at object initialisation time (or not at all), incuring something like
the following error if you try and set it later:

	fs/afs/dir.c:556:20: error: assignment of read-only member 'actor'

Marking the member const like this adds very little in the way of sanity
checking as the type checking system is likely to provide sufficient - and
if not, the kernel is very likely to oops repeatably in this case.

Fixes: ac6614b76478 ("[readdir] constify ->actor")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/fs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index c6baf767619e..dc7de5f06702 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1665,7 +1665,7 @@ typedef int (*filldir_t)(struct dir_context *, const char *, int, loff_t, u64,
 			 unsigned);
 
 struct dir_context {
-	const filldir_t actor;
+	filldir_t actor;
 	loff_t pos;
 };
 
