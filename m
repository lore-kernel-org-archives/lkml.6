Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 297E3C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABD5208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DABD5208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755445AbeFNUXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 16:23:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47644 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754695AbeFNUXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 16:23:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 81EDC406E897;
        Thu, 14 Jun 2018 20:23:11 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-45.rdu2.redhat.com [10.10.112.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 288C31116700;
        Thu, 14 Jun 2018 20:23:09 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Alexander Viro <aviro@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [RFC PATCH ghak59 V1 1/6] audit: give a clue what CONFIG_CHANGE op was involved
Date:   Thu, 14 Jun 2018 16:21:11 -0400
Message-Id: <17f22b579c28c6cd9475a57e792b5d4fb4dde1dc.1529003588.git.rgb@redhat.com>
In-Reply-To: <cover.1529003588.git.rgb@redhat.com>
References: <cover.1529003588.git.rgb@redhat.com>
In-Reply-To: <cover.1529003588.git.rgb@redhat.com>
References: <cover.1529003588.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 14 Jun 2018 20:23:11 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 14 Jun 2018 20:23:11 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The failure to add an audit rule due to audit locked gives no clue
what CONFIG_CHANGE operation failed.
Similarly the set operation is the only other operation that doesn't
give the "op=" field to indicate the action.
All other CONFIG_CHANGE records include an op= field to give a clue as
to what sort of configuration change is being executed.

Since these are the only CONFIG_CHANGE records that that do not have an
op= field, add them to bring them in line with the rest.

Old records:
type=CONFIG_CHANGE msg=audit(1519812997.781:374): pid=610 uid=0 auid=0 ses=1 subj=... audit_enabled=2 res=0
type=CONFIG_CHANGE msg=audit(2018-06-14 14:55:04.507:47) : audit_enabled=1 old=1 auid=unset ses=unset subj=... res=yes

New records:
type=CONFIG_CHANGE msg=audit(1520958477.855:100): pid=610 uid=0 auid=0 ses=1 subj=... op=add_rule audit_enabled=2 res=0

type=CONFIG_CHANGE msg=audit(2018-06-14 14:55:04.507:47) : op=set audit_enabled=1 old=1 auid=unset ses=unset subj=... res=yes

See: https://github.com/linux-audit/audit-kernel/issues/59
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/audit.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index e7478cb..ad54339 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -403,7 +403,7 @@ static int audit_log_config_change(char *function_name, u32 new, u32 old,
 	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
 	if (unlikely(!ab))
 		return rc;
-	audit_log_format(ab, "%s=%u old=%u", function_name, new, old);
+	audit_log_format(ab, "op=set %s=%u old=%u", function_name, new, old);
 	audit_log_session_info(ab);
 	rc = audit_log_task_context(ab);
 	if (rc)
@@ -1365,7 +1365,9 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 			return -EINVAL;
 		if (audit_enabled == AUDIT_LOCKED) {
 			audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
-			audit_log_format(ab, " audit_enabled=%d res=0", audit_enabled);
+			audit_log_format(ab, " op=%s_rule audit_enabled=%d res=0",
+					 msg_type == AUDIT_ADD_RULE ? "add" : "remove",
+					 audit_enabled);
 			audit_log_end(ab);
 			return -EPERM;
 		}
-- 
1.8.3.1

