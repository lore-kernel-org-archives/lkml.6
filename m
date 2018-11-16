Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D771C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD462086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD462086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390199AbeKQDrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 22:47:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729140AbeKQDrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 22:47:35 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AD50458E27;
        Fri, 16 Nov 2018 17:34:18 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A04960E1C;
        Fri, 16 Nov 2018 17:34:12 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     linux-fsdevel@vger.kernel.org, viro@ZenIV.linux.org.uk,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [RFC PATCH ghak100 V1 2/2] audit: moar filter PATH records keyed on filesystem magic
Date:   Fri, 16 Nov 2018 12:33:14 -0500
Message-Id: <208a86c97cd93181ffd7db2e5f95da012ab41a48.1542149969.git.rgb@redhat.com>
In-Reply-To: <cover.1542149969.git.rgb@redhat.com>
References: <cover.1542149969.git.rgb@redhat.com>
In-Reply-To: <cover.1542149969.git.rgb@redhat.com>
References: <cover.1542149969.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 16 Nov 2018 17:34:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like 42d5e37654e4 ("audit: filter PATH records keyed on filesystem magic")

Any user or remote filesystem could become unavailable and effectively
block on a forced unmount.

    -a always,exit -S umount2 -F key=umount2

Provide a method to ignore these user and remote filesystems to prevent
them from being impossible to unmount.

Extend the "AUDIT_FILTER_FS" filter that uses the field type
AUDIT_FSTYPE keying off the filesystem 4-octet hexadecimal magic
identifier to filter specific filesystems to cover audit_inode() to address
this blockage.

An example rule would look like:
    -a never,filesystem -F fstype=0x517B -F key=ignore_smb
    -a never,filesystem -F fstype=0x6969 -F key=ignore_nfs

Arguably the better way to address this issue is to disable auditing
processes that touch removable filesystems.

Please see the github issue tracker
https://github.com/linux-audit/audit-kernel/issues/100

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/auditsc.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index d39a7fbaf944..59d6d3fbc00e 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1777,10 +1777,33 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
 	struct inode *inode = d_backing_inode(dentry);
 	struct audit_names *n;
 	bool parent = flags & AUDIT_INODE_PARENT;
+	struct audit_entry *e;
+	struct list_head *list = &audit_filter_list[AUDIT_FILTER_FS];
+	int i;
 
 	if (!context->in_syscall)
 		return;
 
+	rcu_read_lock();
+	if (!list_empty(list)) {
+		list_for_each_entry_rcu(e, list, list) {
+			for (i = 0; i < e->rule.field_count; i++) {
+				struct audit_field *f = &e->rule.fields[i];
+
+				if (f->type == AUDIT_FSTYPE) {
+					if (audit_comparator(inode->i_sb->s_magic,
+					    f->op, f->val)) {
+						if (e->rule.action == AUDIT_NEVER) {
+							rcu_read_unlock();
+							return;
+						}
+					}
+				}
+			}
+		}
+	}
+	rcu_read_unlock();
+
 	if (!name)
 		goto out_alloc;
 
-- 
1.8.3.1

