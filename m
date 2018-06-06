Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3339F601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933656AbeFFRB1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 13:01:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933630AbeFFRBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 13:01:23 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Cc: luto@kernel.org, jlayton@redhat.com, carlos@redhat.com,
        viro@zeniv.linux.org.uk, dhowells@redhat.com, simo@redhat.com,
        eparis@parisplace.org, serge@hallyn.com, ebiederm@xmission.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [RFC PATCH ghak90 (was ghak32) V3 05/10] audit: add containerid support for tty_audit
Date: Wed,  6 Jun 2018 12:58:32 -0400
Message-Id: <28ab8ad3c4e5de6f61b928eeb2af030b04a8820b.1528304204.git.rgb@redhat.com>
In-Reply-To: <cover.1528304203.git.rgb@redhat.com>
References: <cover.1528304203.git.rgb@redhat.com>
In-Reply-To: <cover.1528304203.git.rgb@redhat.com>
References: <cover.1528304203.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add audit container identifier auxiliary record to tty logging rule
event standalone records.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 drivers/tty/tty_audit.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
index e30aa6b..66bd850 100644
--- a/drivers/tty/tty_audit.c
+++ b/drivers/tty/tty_audit.c
@@ -66,8 +66,9 @@ static void tty_audit_log(const char *description, dev_t dev,
 	uid_t uid = from_kuid(&init_user_ns, task_uid(tsk));
 	uid_t loginuid = from_kuid(&init_user_ns, audit_get_loginuid(tsk));
 	unsigned int sessionid = audit_get_sessionid(tsk);
+	struct audit_context *context = audit_alloc_local();
 
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_TTY);
+	ab = audit_log_start(context, GFP_KERNEL, AUDIT_TTY);
 	if (ab) {
 		char name[sizeof(tsk->comm)];
 
@@ -80,6 +81,8 @@ static void tty_audit_log(const char *description, dev_t dev,
 		audit_log_n_hex(ab, data, size);
 		audit_log_end(ab);
 	}
+	audit_log_contid(context, "tty", audit_get_contid(tsk));
+	audit_free_context(context);
 }
 
 /**
-- 
1.8.3.1
