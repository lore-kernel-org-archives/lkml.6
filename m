Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E48AECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F7521566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F7521566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391134AbeIUWXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:23:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbeIUWXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:23:37 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0CB0C804E5;
        Fri, 21 Sep 2018 16:33:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACCEB308BE75;
        Fri, 21 Sep 2018 16:33:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 28/34] vfs: Add some logging to the core users of the
 fs_context log [ver #12]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Date:   Fri, 21 Sep 2018 17:33:56 +0100
Message-ID: <153754763694.17872.12476648577324287426.stgit@warthog.procyon.org.uk>
In-Reply-To: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 21 Sep 2018 16:33:59 +0000 (UTC)
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
index de43b140bbb1..021cbdcc0e6e 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1771,8 +1771,10 @@ int vfs_get_tree(struct fs_context *fc)
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
index d8b325c3c2eb..d5ae888b8c57 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -17,7 +17,7 @@
 
 #include <trace/events/cgroup.h>
 
-#define cg_invalf(fc, fmt, ...) ({ pr_err(fmt, ## __VA_ARGS__); -EINVAL; })
+#define cg_invalf(fc, fmt, ...) invalf(fc, fmt, ## __VA_ARGS__)
 
 /*
  * pidlists linger the following amount before being destroyed.  The goal

