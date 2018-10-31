Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DF1C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54292080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54292080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbeKADoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:44:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729785AbeKADoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:44:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CE8D758E2A;
        Wed, 31 Oct 2018 18:45:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 687EF19744;
        Wed, 31 Oct 2018 18:45:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <7505.1541011140@warthog.procyon.org.uk>
References: <7505.1541011140@warthog.procyon.org.uk> <87a7mut9cm.fsf@xmission.com> <20181031053355.GQ32577@ZenIV.linux.org.uk>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     dhowells@redhat.com, Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] vfs: Fix incorrect user_ns assignment in proc and mqueue
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7825.1541011504.1@warthog.procyon.org.uk>
Date:   Wed, 31 Oct 2018 18:45:04 +0000
Message-ID: <7826.1541011504@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 31 Oct 2018 18:45:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    
The user namespace set on a proc superblock should derive from the pid_ns
that the superblock is associated with and, similarly, an mqueue superblock
should derive from the ipc_ns that that is associated with.

Fix both of these to set the proposed user_ns appropriately in the
respective get_tree() functions.

Fixes: a593f22857a3 ("proc: Add fs_context support to procfs")
Fixes: ec772aa43dc7 ("ipc: Convert mqueue fs to fs_context")
Reported-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/root.c |    2 ++
 ipc/mqueue.c   |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/proc/root.c b/fs/proc/root.c
index b0627e622850..3033a900d421 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -162,6 +162,8 @@ static int proc_get_tree(struct fs_context *fc)
 {
 	struct proc_fs_context *ctx = fc->fs_private;
 
+	put_user_ns(fc->user_ns);
+	fc->user_ns = get_user_ns(ctx->pid_ns->user_ns);
 	fc->s_fs_info = ctx->pid_ns;
 	return vfs_get_super(fc, vfs_get_keyed_super, proc_fill_super);
 }
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 869687d586a2..9e793c02f350 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -354,6 +354,8 @@ static int mqueue_get_tree(struct fs_context *fc)
 {
 	struct mqueue_fs_context *ctx = fc->fs_private;
 
+	put_user_ns(fc->user_ns);
+	fc->user_ns = get_user_ns(ctx->ipc_ns->user_ns);
 	fc->s_fs_info = ctx->ipc_ns;
 	return vfs_get_super(fc, vfs_get_keyed_super, mqueue_fill_super);
 }
