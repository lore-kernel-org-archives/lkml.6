Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F54DC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59AC9218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358161;
	bh=duGUUSRAk2aDiZgkaCLu9fA0RM7SnJZUVIWAXxJEkV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sGIFhX4I6f7xjb5idhZJEP0r1A1bHTi4bv4yo0Duug5tcvVXXozjAWCfqlLwM1eTv
	 gevxF45gzjKWQxZZE3B7XY3UDhJ/0ifddHRzEUVj6TGs/6+ZT9X0//bNwCsBt5i+IH
	 N+yzgweGIifUMVXcv4nxBjhgkOtaVuc5GN0XJMRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbfAXT3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:29:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:56206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731113AbfAXT3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:29:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FC90218E2;
        Thu, 24 Jan 2019 19:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358149;
        bh=duGUUSRAk2aDiZgkaCLu9fA0RM7SnJZUVIWAXxJEkV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j3h3oxDBFILgDyPVvGDXmZfokTXL4u8U5v76YHyLLl+Va65vJX6vv6Ftj3yVbdZ5B
         ZKSESlTQGkbw8CJy55dMBXou9q1DC0vF9bcssZlSSYuSm94NJAmf83LPDyUUry3BXU
         YAtw0kHF6XYeB9VhjJgO+1V/HM1ddgQeAvA6E74c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 11/39] selinux: always allow mounting submounts
Date:   Thu, 24 Jan 2019 20:20:14 +0100
Message-Id: <20190124190448.630960639@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190448.232316246@linuxfoundation.org>
References: <20190124190448.232316246@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 2cbdcb882f97a45f7475c67ac6257bbc16277dfe ]

If a superblock has the MS_SUBMOUNT flag set, we should always allow
mounting it. These mounts are done automatically by the kernel either as
part of mounting some parent mount (e.g. debugfs always mounts tracefs
under "tracing" for compatibility) or they are mounted automatically as
needed on subdirectory accesses (e.g. NFS crossmnt mounts). Since such
automounts are either an implicit consequence of the parent mount (which
is already checked) or they can happen during regular accesses (where it
doesn't make sense to check against the current task's context), the
mount permission check should be skipped for them.

Without this patch, attempts to access contents of an automounted
directory can cause unexpected SELinux denials.

In the current kernel tree, the MS_SUBMOUNT flag is set only via
vfs_submount(), which is called only from the following places:
 - AFS, when automounting special "symlinks" referencing other cells
 - CIFS, when automounting "referrals"
 - NFS, when automounting subtrees
 - debugfs, when automounting tracefs

In all cases the submounts are meant to be transparent to the user and
it makes sense that if mounting the master is allowed, then so should be
the automounts. Note that CAP_SYS_ADMIN capability checking is already
skipped for (SB_KERNMOUNT|SB_SUBMOUNT) in:
 - sget_userns() in fs/super.c:
	if (!(flags & (SB_KERNMOUNT|SB_SUBMOUNT)) &&
	    !(type->fs_flags & FS_USERNS_MOUNT) &&
	    !capable(CAP_SYS_ADMIN))
		return ERR_PTR(-EPERM);
 - sget() in fs/super.c:
        /* Ensure the requestor has permissions over the target filesystem */
        if (!(flags & (SB_KERNMOUNT|SB_SUBMOUNT)) && !ns_capable(user_ns, CAP_SYS_ADMIN))
                return ERR_PTR(-EPERM);

Verified internally on patched RHEL 7.6 with a reproducer using
NFS+httpd and selinux-tesuite.

Fixes: 93faccbbfa95 ("fs: Better permission checking for submounts")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8ded80867b92..d293b546a2aa 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2758,7 +2758,7 @@ static int selinux_sb_kern_mount(struct super_block *sb, int flags, void *data)
 		return rc;
 
 	/* Allow all mounts performed by the kernel */
-	if (flags & MS_KERNMOUNT)
+	if (flags & (MS_KERNMOUNT | MS_SUBMOUNT))
 		return 0;
 
 	ad.type = LSM_AUDIT_DATA_DENTRY;
-- 
2.19.1



