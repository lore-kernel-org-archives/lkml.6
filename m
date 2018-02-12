Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933635AbeBLKJS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 05:09:18 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933560AbeBLKJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 05:09:16 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH] audit: session ID should not set arch quick field pointer
Date: Mon, 12 Feb 2018 05:04:53 -0500
Message-Id: <8bd4cb1d24af27d9ace70f03300d5033e38e5a48.1518429770.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bug was introduced in 8fae47705685fcaa75a1fe4c8c3e18300a702979
("audit: add support for session ID user filter")
See: https://github.com/linux-audit/audit-kernel/issues/4

When setting a session ID filter, the session ID filter field overwrote
the quick pointer reference to the arch field, potentially causing the
arch field to be misinterpreted.

Passes audit-testsuite.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/auditfilter.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 4a1758a..739a6d2 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -496,7 +496,6 @@ static struct audit_entry *audit_data_to_entry(struct audit_rule_data *data,
 			if (!gid_valid(f->gid))
 				goto exit_free;
 			break;
-		case AUDIT_SESSIONID:
 		case AUDIT_ARCH:
 			entry->rule.arch_f = f;
 			break;
-- 
1.8.3.1
