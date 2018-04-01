Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754647AbeDAUoU (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:44:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754637AbeDAUoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:44:16 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 40/45] C++: Fix sema_init()
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:44:15 +0100
Message-ID: <152261545562.30503.15516261440506735873.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sema_init() to manually initialise the semaphore rather than using
__SEMAPHORE_INITIALIZER() as that doesn't seem to work on C++.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/semaphore.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/semaphore.h b/include/linux/semaphore.h
index 11c86fbfeb98..364fb4721db5 100644
--- a/include/linux/semaphore.h
+++ b/include/linux/semaphore.h
@@ -32,7 +32,10 @@ struct semaphore {
 static inline void sema_init(struct semaphore *sem, int val)
 {
 	static struct lock_class_key __key;
-	*sem = (struct semaphore) __SEMAPHORE_INITIALIZER(*sem, val);
+
+	sem->count = val;
+	INIT_LIST_HEAD(&sem->wait_list);
+	raw_spin_lock_init(&sem->lock);
 	lockdep_init_map(&sem->lock.dep_map, "semaphore->lock", &__key, 0);
 }
 
