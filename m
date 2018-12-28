Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A5AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840AF2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545998021;
	bh=hfIooJuRbVP9B1zNLi8EjiZv9ubQYED0hzyHYuod8I8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pxzc3TgbhQvHz7t5q21y3zIUpDpK3hpE8Vc7hjvQTbQEDT6XzA3p7ZpFv63gJWwUt
	 blItH4qg6xv/ZPPqKMlscowWCiRHWh/1Bmwj3GxRYCB6HmvxbKu8FeqVMep8ex6Q9o
	 goCWUjxD1xrLVplw5oAPkYdN17OZsIMVCFy2FqWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbeL1Lxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 06:53:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:53440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732311AbeL1Lxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 06:53:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00B1E20879;
        Fri, 28 Dec 2018 11:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545998016;
        bh=hfIooJuRbVP9B1zNLi8EjiZv9ubQYED0hzyHYuod8I8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vjRYzyshQkyzVvQNsykdwzGHXOvGbGXu1K+eKVw9TtDVy5NDXwA2bGh+d0S2GwVWz
         nS9CcI7R1fDirbAaBoEYplJ8Emdo6tmibe2lBxltBKJBKzIMIAsnSOBuGdo+Li28cM
         pzT6kjw0hXaBdzBFhDo4HfASCg1/6JCMlZhyoxvQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Serge Hallyn <serge@hallyn.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 02/46] Revert "vfs: Allow userns root to call mknod on owned filesystems."
Date:   Fri, 28 Dec 2018 12:51:56 +0100
Message-Id: <20181228113125.063988618@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Brauner <christian@brauner.io>

commit 94f82008ce30e2624537d240d64ce718255e0b80 upstream.

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
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/namei.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3701,8 +3701,7 @@ int vfs_mknod(struct inode *dir, struct
 	if (error)
 		return error;
 
-	if ((S_ISCHR(mode) || S_ISBLK(mode)) &&
-	    !ns_capable(dentry->d_sb->s_user_ns, CAP_MKNOD))
+	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD))
 		return -EPERM;
 
 	if (!dir->i_op->mknod)


