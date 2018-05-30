Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753784AbeE3MT3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:19:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753056AbeE3MT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:19:27 -0400
Date: Wed, 30 May 2018 08:19:22 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] branch-check: fix long->int truncation when profiling
 branches
In-Reply-To: <20180528155432.2864616-1-arnd@arndb.de>
Message-ID: <alpine.LRH.2.02.1805300818140.24812@file01.intranet.prod.int.rdu2.redhat.com>
References: <20180528155432.2864616-1-arnd@arndb.de>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function __builtin_expect returns long type (see the gcc
documentation), and so do macros likely and unlikely. Unfortunatelly, when
CONFIG_PROFILE_ANNOTATED_BRANCHES is selected, the macros likely and
unlikely expand to __branch_check__ and __branch_check__ truncates the
long type to int. This unintended truncation may cause bugs in various
kernel code (we found a bug in dm-writecache because of it), so it's
better to fix __branch_check__ to return long.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 include/linux/compiler.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/include/linux/compiler.h
===================================================================
--- linux-2.6.orig/include/linux/compiler.h	2018-02-26 20:34:17.000000000 +0100
+++ linux-2.6/include/linux/compiler.h	2018-05-30 14:11:53.000000000 +0200
@@ -21,7 +21,7 @@ void ftrace_likely_update(struct ftrace_
 #define unlikely_notrace(x)	__builtin_expect(!!(x), 0)
 
 #define __branch_check__(x, expect, is_constant) ({			\
-			int ______r;					\
+			long ______r;					\
 			static struct ftrace_likely_data		\
 				__attribute__((__aligned__(4)))		\
 				__attribute__((section("_ftrace_annotated_branch"))) \
