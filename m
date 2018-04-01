Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754635AbeDAUoO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:44:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754042AbeDAUoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:44:10 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 39/45] C++: Fix spinlock initialisation
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:44:09 +0100
Message-ID: <152261544964.30503.6618621118546753722.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a couple of bits of spinlock initialisation:

 (1) owner_cpu is unsigned: set to UINT_MAX rather than -1.

 (2) Don't need to cast the result of __SPIN_LOCK_INITIALIZER().

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/spinlock_types.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/spinlock_types.h b/include/linux/spinlock_types.h
index 24b4e6f2c1a2..d1ab81ee85fd 100644
--- a/include/linux/spinlock_types.h
+++ b/include/linux/spinlock_types.h
@@ -41,7 +41,7 @@ typedef struct raw_spinlock {
 #ifdef CONFIG_DEBUG_SPINLOCK
 # define SPIN_DEBUG_INIT(lockname)		\
 	.magic = SPINLOCK_MAGIC,		\
-	.owner_cpu = -1,			\
+	.owner_cpu = UINT_MAX,			\
 	.owner = SPINLOCK_OWNER_INIT,
 #else
 # define SPIN_DEBUG_INIT(lockname)
@@ -76,7 +76,7 @@ typedef struct spinlock {
 	{ { .rlock = __RAW_SPIN_LOCK_INITIALIZER(lockname) } }
 
 #define __SPIN_LOCK_UNLOCKED(lockname) \
-	(spinlock_t ) __SPIN_LOCK_INITIALIZER(lockname)
+	__SPIN_LOCK_INITIALIZER(lockname)
 
 #define DEFINE_SPINLOCK(x)	spinlock_t x = __SPIN_LOCK_UNLOCKED(x)
 
