Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0B8C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D3A20855
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D3A20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeLIVzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:55:14 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34548 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726313AbeLIVzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:09 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Y-0002ic-Qi; Sun, 09 Dec 2018 21:55:06 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72X-0003CO-Ro; Sun, 09 Dec 2018 21:55:05 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "=?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?=" <omosnace@redhat.com>,
        "Paul Moore" <paul@paul-moore.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.990599676@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 004/328] audit: Fix extended comparison of GID/EGID
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ondrej Mosnáček <omosnace@redhat.com>

commit af85d1772e31fed34165a1b3decef340cf4080c0 upstream.

The audit_filter_rules() function in auditsc.c used the in_[e]group_p()
functions to check GID/EGID match, but these functions use the current
task's credentials, while the comparison should use the credentials of
the task given to audit_filter_rules() as a parameter (tsk).

Note that we can use group_search(cred->group_info, ...) as a
replacement for both in_group_p and in_egroup_p as these functions only
compare the parameter to cred->fsgid/egid and then call group_search.

In fact, the usage of in_group_p was even more incorrect: it compares to
cred->fsgid (which is usually equal to cred->egid) and not cred->gid.

GitHub issue:
https://github.com/linux-audit/audit-kernel/issues/82

Fixes: 37eebe39c973 ("audit: improve GID/EGID comparation logic")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/auditsc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -489,20 +489,20 @@ static int audit_filter_rules(struct tas
 			result = audit_gid_comparator(cred->gid, f->op, f->gid);
 			if (f->op == Audit_equal) {
 				if (!result)
-					result = in_group_p(f->gid);
+					result = groups_search(cred->group_info, f->gid);
 			} else if (f->op == Audit_not_equal) {
 				if (result)
-					result = !in_group_p(f->gid);
+					result = !groups_search(cred->group_info, f->gid);
 			}
 			break;
 		case AUDIT_EGID:
 			result = audit_gid_comparator(cred->egid, f->op, f->gid);
 			if (f->op == Audit_equal) {
 				if (!result)
-					result = in_egroup_p(f->gid);
+					result = groups_search(cred->group_info, f->gid);
 			} else if (f->op == Audit_not_equal) {
 				if (result)
-					result = !in_egroup_p(f->gid);
+					result = !groups_search(cred->group_info, f->gid);
 			}
 			break;
 		case AUDIT_SGID:

