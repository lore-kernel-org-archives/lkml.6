Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032728AbeBOCwP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 21:52:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48094 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032483AbeBOCwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 21:52:09 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH V3 2/2] audit: bail before bug check if audit disabled
Date: Wed, 14 Feb 2018 21:47:44 -0500
Message-Id: <4178bdf7c05d08c70323d5eb880e62d117e4450e.1518662391.git.rgb@redhat.com>
In-Reply-To: <cover.1518662391.git.rgb@redhat.com>
References: <cover.1518662391.git.rgb@redhat.com>
In-Reply-To: <cover.1518662391.git.rgb@redhat.com>
References: <cover.1518662391.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If audit is disabled, who cares if there is a bug indicating syscall in
process or names already recorded.  Bail immediately on audit disabled.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/auditsc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index bc534bf..4e0a4ac 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1511,14 +1511,11 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
 	struct audit_context *context = tsk->audit_context;
 	enum audit_state     state;
 
-	if (!context)
+	if (!audit_enabled || !context)
 		return;
 
 	BUG_ON(context->in_syscall || context->name_count);
 
-	if (!audit_enabled)
-		return;
-
 	state = context->state;
 	if (state == AUDIT_DISABLED)
 		return;
-- 
1.8.3.1
