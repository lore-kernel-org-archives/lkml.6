Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEBDC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA1620894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA1620894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403853AbeHARMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:12:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59982 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389725AbeHARMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:12:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E4C574023461;
        Wed,  1 Aug 2018 15:26:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4AECC2026D68;
        Wed,  1 Aug 2018 15:26:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 22/33] vfs: Remove kern_mount_data() [ver #11]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 01 Aug 2018 16:26:35 +0100
Message-ID: <153313719580.13253.10449818927537069378.stgit@warthog.procyon.org.uk>
In-Reply-To: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 01 Aug 2018 15:26:36 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 01 Aug 2018 15:26:36 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kern_mount_data() isn't used any more so remove it.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/namespace.c     |    7 -------
 include/linux/fs.h |    1 -
 2 files changed, 8 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 51a6799c3f61..ea07066a2731 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3347,13 +3347,6 @@ struct vfsmount *kern_mount(struct file_system_type *type)
 }
 EXPORT_SYMBOL_GPL(kern_mount);
 
-struct vfsmount *kern_mount_data(struct file_system_type *type,
-				 void *data, size_t data_size)
-{
-	return vfs_kern_mount(type, SB_KERNMOUNT, type->name, data, data_size);
-}
-EXPORT_SYMBOL_GPL(kern_mount_data);
-
 /*
  * Move a mount from one place to another.
  * In combination with open_tree(OPEN_TREE_CLONE [| AT_RECURSIVE]) it can be
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 00a24f4b2f0b..3e661d033163 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2214,7 +2214,6 @@ mount_pseudo(struct file_system_type *fs_type, char *name,
 extern int register_filesystem(struct file_system_type *);
 extern int unregister_filesystem(struct file_system_type *);
 extern struct vfsmount *kern_mount(struct file_system_type *);
-extern struct vfsmount *kern_mount_data(struct file_system_type *, void *, size_t);
 extern void kern_unmount(struct vfsmount *mnt);
 extern int may_umount_tree(struct vfsmount *);
 extern int may_umount(struct vfsmount *);

