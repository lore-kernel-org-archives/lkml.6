Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E31C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B2A2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B2A2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbeLJWSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:18:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729036AbeLJWSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:18:34 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 983393082E51;
        Mon, 10 Dec 2018 22:18:34 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FA5F60BF1;
        Mon, 10 Dec 2018 22:18:32 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>
Cc:     Eric Paris <eparis@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Steve Grubb <sgrubb@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak59 V3 1/4] audit: give a clue what CONFIG_CHANGE op was involved
Date:   Mon, 10 Dec 2018 17:17:48 -0500
Message-Id: <d4c6aae31213ad17fd82f546ab5e1ee0efc985d0.1544477629.git.rgb@redhat.com>
In-Reply-To: <cover.1544477629.git.rgb@redhat.com>
References: <cover.1544477629.git.rgb@redhat.com>
In-Reply-To: <cover.1544477629.git.rgb@redhat.com>
References: <cover.1544477629.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 10 Dec 2018 22:18:34 +0000 (UTC)
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
index 779671883349..0e8026423fbd 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -400,7 +400,7 @@ static int audit_log_config_change(char *function_name, u32 new, u32 old,
 	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
 	if (unlikely(!ab))
 		return rc;
-	audit_log_format(ab, "%s=%u old=%u ", function_name, new, old);
+	audit_log_format(ab, "op=set %s=%u old=%u ", function_name, new, old);
 	audit_log_session_info(ab);
 	rc = audit_log_task_context(ab);
 	if (rc)
@@ -1363,7 +1363,9 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 			return -EINVAL;
 		if (audit_enabled == AUDIT_LOCKED) {
 			audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
-			audit_log_format(ab, " audit_enabled=%d res=0", audit_enabled);
+			audit_log_format(ab, " op=%s audit_enabled=%d res=0",
+					 msg_type == AUDIT_ADD_RULE ? "add_rule" : "remove_rule",
+					 audit_enabled);
 			audit_log_end(ab);
 			return -EPERM;
 		}
-- 
1.8.3.1

