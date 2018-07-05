Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C60C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2687E23FF6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2687E23FF6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753859AbeGEPwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:52:44 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51860 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbeGEPwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:52:43 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so12100648wmc.1;
        Thu, 05 Jul 2018 08:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Eqent5nR+zaQimmN5TYVKsUX7wsvJDEoBZQlTeORiIk=;
        b=IKcd18PNSAOCj3P+46TKHPS+qlL5Jgf+JEpRosrkJJ2SjAxML3pa4bibJiq7d4M8+T
         3t9Ad+dTZ2bFR8xZ5/2G/o+bUvsWO29ZkI3JWFdnPdPIoyPmqV8FUoJFu4MwXuVaIUXV
         bSi8buGfMimZJ3fbYto3oDfB3iLgTyQtJ9Ui0TTvHc3gVVlyFBfjZP3Y51hkkjRPW72/
         kaXZr52KKZajVAW55NZ3OUbQH9Oa1iFaqLFjM4/nzF9FG6OwXw05wOyACOxX+inFM9Zz
         LFoS4UW+q/a0GIPo73PgMvuuN72R268ZCgEjB4HPuWxjbVc5HNfjQnLOAGy5O5Ydi84q
         zv8w==
X-Gm-Message-State: APt69E0EmAYTykqaGaeuBU9dlDb9Keb5bJ+NH7Q2adnqsXLQ//KXTbAM
        8MwPBp7EEnsvJ7x38uEHOF+x2VCd
X-Google-Smtp-Source: AAOMgpepK8LI8a5ca8PYLc6KFWa/s9WDD0sdyndRsnLVbLy07gNtJRbt4330n+ZVaLpVuHcXBckQ4g==
X-Received: by 2002:a1c:6f06:: with SMTP id k6-v6mr4293104wmc.1.1530805961864;
        Thu, 05 Jul 2018 08:52:41 -0700 (PDT)
Received: from localhost.localdomain (u-086-c115.eap.uni-tuebingen.de. [134.2.86.115])
        by smtp.gmail.com with ESMTPSA id r14-v6sm9922542wrl.4.2018.07.05.08.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 08:52:40 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        seth.forshee@canonical.com, serge@hallyn.com,
        containers@lists.linux-foundation.org
Cc:     Christian Brauner <christian@brauner.io>
Subject: [PATCH] Revert "vfs: Allow userns root to call mknod on owned filesystems."
Date:   Thu,  5 Jul 2018 17:51:20 +0200
Message-Id: <20180705155120.22102-1-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 55956b59df336f6738da916dbb520b6e37df9fbd.

commit 55956b59df33 ("vfs: Allow userns root to call mknod on owned filesystems.")
enabled mknod() in user namespaces for userns root if CAP_MKNOD is
available. However, these device nodes are useless since any filesystem
mounted from a non-initial user namespace will set the SB_I_NODEV flag on
the filesystem. Now, when a device node s created in a non-initial user
namespace a call to open() on said device node will fail due to:

bool may_open_dev(const struct path *path)
{
        return !(path->mnt->mnt_flags & MNT_NODEV) &&
                !(path->mnt->mnt_sb->s_iflags & SB_I_NODEV);
}

The problem with this is that as of the aforementioned commit mknod()
creates partially functional device nodes in non-initial user namespaces.
In particular, it has the consequence that as of the aforementioned commit
open() will be more privileged with respect to device nodes than mknod().
Before it was the other way around. Specifically, if mknod() succeeded
then it was transparent for any userspace application that a fatal error
must have occured when open() failed.

All of this breaks multiple userspace workloads and a widespread assumption
about how to handle mknod(). Basically, all container runtimes and systemd
live by the slogan "ask for forgiveness not permission" when running user
namespace workloads. For mknod() the assumption is that if the syscall
succeeds the device nodes are useable irrespective of whether it succeeds
in a non-initial user namespace or not. This logic was chosen explicitly
to allow for the glorious day when mknod() will actually be able to create
fully functional device nodes in user namespaces.
A specific problem people are already running into when running 4.18 rc
kernels are failing systemd services. For any distro that is run in a
container systemd services started with the PrivateDevices= property set
will fail to start since the device nodes in question cannot be
opened (cf. the arguments in [1]).

Full disclosure, Seth made the very sound argument that it is already
possible to end up with partially functional device nodes. Any filesystem
mounted with MS_NODEV set will allow mknod() to succeed but will not allow
open() to succeed. The difference to the case here is that the MS_NODEV
case is transparent to userspace since it is an explicitly set mount option
while the SB_I_NODEV case is an implicit property enforced by the kernel
and hence opaque to userspace.

[1]: https://github.com/systemd/systemd/pull/9483

Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Seth Forshee <seth.forshee@canonical.com>
Cc: Serge Hallyn <serge@hallyn.com>
---
 fs/namei.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 734cef54fdf8..389e48e93542 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3711,8 +3711,7 @@ int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
 	if (error)
 		return error;
 
-	if ((S_ISCHR(mode) || S_ISBLK(mode)) &&
-	    !ns_capable(dentry->d_sb->s_user_ns, CAP_MKNOD))
+	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD))
 		return -EPERM;
 
 	if (!dir->i_op->mknod)
-- 
2.17.1

