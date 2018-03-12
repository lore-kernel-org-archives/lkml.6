Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbeCLGga (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 02:36:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750752AbeCLGg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 02:36:29 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>, Kees Cook <keescook@chromium.org>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak21 V2 1/4] audit: make ANOM_LINK obey audit_enabled and audit_dummy_context
Date: Mon, 12 Mar 2018 02:31:17 -0400
Message-Id: <6b1842619a6f1ba13194328e28b853c18c466c03.1520835596.git.rgb@redhat.com>
In-Reply-To: <cover.1520835596.git.rgb@redhat.com>
References: <cover.1520835596.git.rgb@redhat.com>
In-Reply-To: <cover.1520835596.git.rgb@redhat.com>
References: <cover.1520835596.git.rgb@redhat.com>
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
index 1a3e75d..7026d69 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2308,6 +2308,9 @@ void audit_log_link_denied(const char *operation, const struct path *link)
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
