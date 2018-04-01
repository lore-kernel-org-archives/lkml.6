Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753996AbeDAUkc (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:40:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753977AbeDAUk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:40:29 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 02/45] Fix exception_enter() return value
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:40:27 +0100
Message-ID: <152261522745.30503.11022506204837457606.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the return value of exception_enter() to return CONTEXT_KERNEL rather
than 0 when the facility is disabled as the function returns an ctx_state
enum rather than a plain integer.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/context_tracking.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index d05609ad329d..b4e9f9d80745 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -50,7 +50,7 @@ static inline enum ctx_state exception_enter(void)
 	enum ctx_state prev_ctx;
 
 	if (!context_tracking_is_enabled())
-		return 0;
+		return CONTEXT_KERNEL;
 
 	prev_ctx = this_cpu_read(context_tracking.state);
 	if (prev_ctx != CONTEXT_KERNEL)
@@ -85,7 +85,7 @@ static inline void user_enter(void) { }
 static inline void user_exit(void) { }
 static inline void user_enter_irqoff(void) { }
 static inline void user_exit_irqoff(void) { }
-static inline enum ctx_state exception_enter(void) { return 0; }
+static inline enum ctx_state exception_enter(void) { return CONTEXT_KERNEL; }
 static inline void exception_exit(enum ctx_state prev_ctx) { }
 static inline enum ctx_state ct_state(void) { return CONTEXT_DISABLED; }
 #endif /* !CONFIG_CONTEXT_TRACKING */
