Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA534C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860EB2174D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860EB2174D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732679AbeHCM05 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:26:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732233AbeHCM05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:26:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8092D4015A56;
        Fri,  3 Aug 2018 10:31:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-78.rdu2.redhat.com [10.10.120.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 495551D085;
        Fri,  3 Aug 2018 10:31:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <47c34fad-5d11-53b0-4386-61be890163c5@virtuozzo.com>
References: <47c34fad-5d11-53b0-4386-61be890163c5@virtuozzo.com> <153320759911.18959.8842396230157677671.stgit@localhost.localdomain> <20180802134723.ecdd540c7c9338f98ee1a2c6@linux-foundation.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, vdavydov.dev@gmail.com,
        mhocko@suse.com, aryabinin@virtuozzo.com, ying.huang@intel.com,
        penguin-kernel@I-love.SAKURA.ne.jp, willy@infradead.org,
        shakeelb@google.com, jbacik@fb.com, linux-mm@kvack.org
Subject: Re: [PATCH] mm: Move check for SHRINKER_NUMA_AWARE to do_shrink_slab()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8346.1533292272.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 03 Aug 2018 11:31:12 +0100
Message-ID: <8347.1533292272@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 03 Aug 2018 10:31:15 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 03 Aug 2018 10:31:15 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reproducer can be reduced to:

	#define _GNU_SOURCE
	#include <endian.h>
	#include <stdint.h>
	#include <string.h>
	#include <stdio.h>
	#include <sys/syscall.h>
	#include <sys/stat.h>
	#include <sys/mount.h>
	#include <unistd.h>
	#include <fcntl.h>

	const char path[] = "./file0";

	int main()
	{
		mkdir(path, 0);
		mount(path, path, "cgroup2", 0, 0);
		chroot(path);
		umount2(path, 0);
		return 0;
	}

and I've found two bugs (see attached patch).  The issue is that
do_remount_sb() is called with fc == NULL from umount(), but both
cgroup_reconfigure() and do_remount_sb() dereference fc unconditionally.

But!  I'm not sure why the reproducer works at all because the umount2() call
is *after* the chroot, so should fail on ENOENT before it even gets that far.
In fact, umount2() can be called multiple times, apparently successfully, and
doesn't actually unmount anything.

David
---
diff --git a/fs/super.c b/fs/super.c
index 3fe5d12b7697..321fbc244570 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -978,7 +978,10 @@ int do_remount_sb(struct super_block *sb, int sb_flags, void *data,
 	    sb->s_op->remount_fs) {
 		if (sb->s_op->reconfigure) {
 			retval = sb->s_op->reconfigure(sb, fc);
-			sb_flags = fc->sb_flags;
+			if (fc)
+				sb_flags = fc->sb_flags;
+			else
+				sb_flags = sb->s_flags;
 			if (retval == 0)
 				security_sb_reconfigure(fc);
 		} else {
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index f3238f38d152..48275fdce053 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1796,9 +1796,11 @@ static void apply_cgroup_root_flags(unsigned int root_flags)
 
 static int cgroup_reconfigure(struct kernfs_root *kf_root, struct fs_context *fc)
 {
-	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
+	if (fc) {
+		struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
 
-	apply_cgroup_root_flags(ctx->flags);
+		apply_cgroup_root_flags(ctx->flags);
+	}
 	return 0;
 }
 
