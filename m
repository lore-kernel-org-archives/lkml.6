Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F18C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4921720B6F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4921720B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732861AbeGJWpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 18:45:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732253AbeGJWpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 18:45:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C50A407446D;
        Tue, 10 Jul 2018 22:44:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC80C2026D6B;
        Tue, 10 Jul 2018 22:44:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 28/32] vfs: Add some logging to the core users of the
 fs_context log [ver #9]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Date:   Tue, 10 Jul 2018 23:44:35 +0100
Message-ID: <153126267542.14533.6980789669902598087.stgit@warthog.procyon.org.uk>
In-Reply-To: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 10 Jul 2018 22:44:36 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 10 Jul 2018 22:44:36 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some logging to the core users of the fs_context log so that
information can be extracted from them as to the reason for failure.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/super.c                |    4 +++-
 kernel/cgroup/cgroup-v1.c |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index bbef5a5057c0..3fe5d12b7697 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1735,8 +1735,10 @@ int vfs_get_tree(struct fs_context *fc)
 	struct super_block *sb;
 	int ret;
 
-	if (fc->fs_type->fs_flags & FS_REQUIRES_DEV && !fc->source)
+	if (fc->fs_type->fs_flags & FS_REQUIRES_DEV && !fc->source) {
+		errorf(fc, "Filesystem requires source device");
 		return -ENOENT;
+	}
 
 	if (fc->root)
 		return -EBUSY;
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 749ccf5c0690..b3d0f37dc80a 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -16,7 +16,7 @@
 
 #include <trace/events/cgroup.h>
 
-#define cg_invalf(fc, fmt, ...) ({ pr_err(fmt, ## __VA_ARGS__); -EINVAL; })
+#define cg_invalf(fc, fmt, ...) invalf(fc, fmt, ## __VA_ARGS__)
 
 /*
  * pidlists linger the following amount before being destroyed.  The goal

