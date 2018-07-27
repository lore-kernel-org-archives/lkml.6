Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98FAC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C9F20673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C9F20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389445AbeG0VPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:15:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45846 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389225AbeG0VPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:15:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB5E440216FE;
        Fri, 27 Jul 2018 19:51:52 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-17.rdu2.redhat.com [10.10.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F35F111E415;
        Fri, 27 Jul 2018 19:51:51 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak59 V2 3/6] audit: exclude user records from syscall context
Date:   Fri, 27 Jul 2018 15:48:14 -0400
Message-Id: <5e97337b412d117309e3f02ef45c7fe00d613520.1532709911.git.rgb@redhat.com>
In-Reply-To: <cover.1532709911.git.rgb@redhat.com>
References: <cover.1532709911.git.rgb@redhat.com>
In-Reply-To: <cover.1532709911.git.rgb@redhat.com>
References: <cover.1532709911.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 27 Jul 2018 19:51:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 27 Jul 2018 19:51:52 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the function audit_log_common_recv_msg() is shared by a number of
AUDIT_CONFIG_CHANGE and the entire range of AUDIT_USER_* record types,
and since the AUDIT_CONFIG_CHANGE message type has been converted to a
syscall accompanied record type, special-case the AUDIT_USER_* range of
messages so they remain standalone records.

See: https://github.com/linux-audit/audit-kernel/issues/59
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/audit.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 6cfe3c9..62ada1b 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1054,7 +1054,8 @@ static int audit_netlink_ok(struct sk_buff *skb, u16 msg_type)
 	return err;
 }
 
-static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
+static void __audit_log_common_recv_msg(struct audit_context *context,
+					struct audit_buffer **ab, u16 msg_type)
 {
 	uid_t uid = from_kuid(&init_user_ns, current_uid());
 	pid_t pid = task_tgid_nr(current);
@@ -1064,7 +1065,7 @@ static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
 		return;
 	}
 
-	*ab = audit_log_start(audit_context(), GFP_KERNEL, msg_type);
+	*ab = audit_log_start(context, GFP_KERNEL, msg_type);
 	if (unlikely(!*ab))
 		return;
 	audit_log_format(*ab, "pid=%d uid=%u", pid, uid);
@@ -1072,6 +1073,11 @@ static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
 	audit_log_task_context(*ab);
 }
 
+static inline void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
+{
+	__audit_log_common_recv_msg(audit_context(), ab, msg_type);
+}
+
 int is_audit_feature_set(int i)
 {
 	return af.features & AUDIT_FEATURE_TO_MASK(i);
@@ -1338,7 +1344,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 				if (err)
 					break;
 			}
-			audit_log_common_recv_msg(&ab, msg_type);
+			__audit_log_common_recv_msg(NULL, &ab, msg_type);
 			if (msg_type != AUDIT_USER_TTY)
 				audit_log_format(ab, " msg='%.*s'",
 						 AUDIT_MESSAGE_TEXT_MAX,
-- 
1.8.3.1

