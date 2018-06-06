Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8386860555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753854AbeFFRJK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 13:09:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752257AbeFFRJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 13:09:08 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: eparis@parisplace.org, Steve Grubb <sgrubb@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v3 1/6] AUDIT_CONTAINER_ID message type basic support
Date: Wed,  6 Jun 2018 13:07:24 -0400
Message-Id: <1528304849-31826-2-git-send-email-rgb@redhat.com>
In-Reply-To: <1528304849-31826-1-git-send-email-rgb@redhat.com>
References: <1528304849-31826-1-git-send-email-rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This defines the message number for the audit container identifier
registration record should the kernel headers not be up to date, gives
the record number a name for printing and allows the record to be
interpreted since it is in the 1000 range like AUDIT_LOGIN.

See: https://github.com/linux-audit/audit-userspace/issues/51
See: https://github.com/linux-audit/audit-kernel/issues/90
See: https://github.com/linux-audit/audit-testsuite/issues/64
See: https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Container-ID
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 lib/libaudit.h    | 4 ++++
 lib/msg_typetab.h | 1 +
 lib/netlink.c     | 1 +
 3 files changed, 6 insertions(+)

diff --git a/lib/libaudit.h b/lib/libaudit.h
index b681e8d..6cdd269 100644
--- a/lib/libaudit.h
+++ b/lib/libaudit.h
@@ -242,6 +242,10 @@ extern "C" {
 #define AUDIT_GET_FEATURE       1019    /* Get which features are enabled */
 #endif
 
+#ifndef AUDIT_CONTAINER_ID
+#define AUDIT_CONTAINER_ID	1020    /* Container creation notice */
+#endif
+
 #ifndef AUDIT_MMAP
 #define AUDIT_MMAP		1323 /* Descriptor and flags in mmap */
 #endif
diff --git a/lib/msg_typetab.h b/lib/msg_typetab.h
index 966865f..e94bfb2 100644
--- a/lib/msg_typetab.h
+++ b/lib/msg_typetab.h
@@ -44,6 +44,7 @@ _S(AUDIT_LOGIN,                      "LOGIN"                         )
 //_S(AUDIT_TTY_SET,                    "TTY_SET"                       )
 //_S(AUDIT_SET_FEATURE,                "SET_FEATURE"                   )
 //_S(AUDIT_GET_FEATURE,                "GET_FEATURE"                   )
+_S(AUDIT_CONTAINER_ID,               "CONTAINER_ID"                  )
 _S(AUDIT_USER_AUTH,                  "USER_AUTH"                     )
 _S(AUDIT_USER_ACCT,                  "USER_ACCT"                     )
 _S(AUDIT_USER_MGMT,                  "USER_MGMT"                     )
diff --git a/lib/netlink.c b/lib/netlink.c
index 5b2028f..ef35bdd 100644
--- a/lib/netlink.c
+++ b/lib/netlink.c
@@ -184,6 +184,7 @@ static int adjust_reply(struct audit_reply *rep, int len)
 			break;
 		case AUDIT_USER:
 		case AUDIT_LOGIN:
+		case AUDIT_CONTAINER_ID:
 		case AUDIT_KERNEL:
 		case AUDIT_FIRST_USER_MSG...AUDIT_LAST_USER_MSG:
 		case AUDIT_FIRST_USER_MSG2...AUDIT_LAST_USER_MSG2:
-- 
1.8.3.1
