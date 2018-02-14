Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032464AbeBNQWz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:22:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36046 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032446AbeBNQWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:22:53 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>, Kees Cook <keescook@chromium.org>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [RFC PATCH ghak21 1/4] audit: make ANOM_LINK obey audit_enabled and audit_dummy_context
Date: Wed, 14 Feb 2018 11:18:21 -0500
Message-Id: <3a9542b261d93bc4eaecfaf359affbba152cf965.1518603831.git.rgb@redhat.com>
In-Reply-To: <cover.1518603831.git.rgb@redhat.com>
References: <cover.1518603831.git.rgb@redhat.com>
In-Reply-To: <cover.1518603831.git.rgb@redhat.com>
References: <cover.1518603831.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audit link denied events emit disjointed records when audit is disabled.
No records should be emitted when audit is disabled.

See: https://github.com/linux-audit/audit-kernel/issues/21
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/audit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/audit.c b/kernel/audit.c
index 227db99..4c3fd24 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2261,6 +2261,9 @@ void audit_log_link_denied(const char *operation, const struct path *link)
 	struct audit_buffer *ab;
 	struct audit_names *name;
 
+	if (!audit_enabled || audit_dummy_context())
+		return;
+
 	name = kzalloc(sizeof(*name), GFP_NOFS);
 	if (!name)
 		return;
-- 
1.8.3.1
