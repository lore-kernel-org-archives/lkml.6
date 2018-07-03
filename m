Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E57C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123672075E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c7XyDSeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 123672075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753225AbeGCVFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 17:05:09 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33269 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752910AbeGCVFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 17:05:07 -0400
Received: by mail-wm0-f67.google.com with SMTP id z6-v6so11415994wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 14:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0IDm6gwOsbQCV83l17tXjfNEAWMlRnRL+28KqAxDQ7g=;
        b=c7XyDSeYxXprlWpALdslH9K33e+qFfkFWxLGZRjw1W+ZIqKTrxF+8X4pOWBKdcmZVw
         2yV3JBhchBE3AVJU6hqFxUUt2eAPwnusnNli4SGhQ85KIahdwyGdwc8Pd5eoVh+inyzW
         0TZfietl94YdgH8QV/siPZirjkj8qy2DwcsdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0IDm6gwOsbQCV83l17tXjfNEAWMlRnRL+28KqAxDQ7g=;
        b=A8TOZIR5nVXQ1qFGLLBrw7tLmmLL+XHQuEhWZcGfSJ+m7Wm5C9YAXoFANopdiqkW7L
         njN6h9CWgb69F3k2W3cFLzTojjb2Cz+HTTukwG7aw5746S+qOcMN5BwSDUBVawGS5vit
         tTeMRJ5q9BQIKYTtF3E7OMKPKpbUXNtUhYbFcWEXqn3LFef2WGfDDxFidafy7I7B8irc
         RyDPdexOQtdnX8C8wvO4biihnJpS0sb3pBJRqTZPGSNSgVt5PuMKtnO8sYNc4BBQZeba
         lZrs/znzMhdps9N1hlUII7rEvx9gY0W4pgKvr0ovydaO5Ynt2iF9b7wuS1Ri0Df79h6s
         f57A==
X-Gm-Message-State: APt69E0raoXCe84ZlmjN8yPRJZClxVPL9XaNCqHb/V4siSvPNfx1Ofde
        LUS8ZnNxJL8VbnKNgsfKMrcc6z5sk31NmzUk1ikiRQ==
X-Google-Smtp-Source: AAOMgpeEjjOn/bUwZxZbYuYh4VSWRT5cIniffDj7vTQbYPRpiZ0ABC3xnzIHWZDaqUQJH+Pz4guENTGBQ+qBSbctDRc=
X-Received: by 2002:a1c:6f06:: with SMTP id k6-v6mr2164828wmc.1.1530651906609;
 Tue, 03 Jul 2018 14:05:06 -0700 (PDT)
MIME-Version: 1.0
From:   Rafael Tinoco <rafael.tinoco@linaro.org>
Date:   Tue, 3 Jul 2018 18:04:30 -0300
Message-ID: <CADtBP2AaVMgmYGsvBjsVjw9M4hCiYOcMMbPu6nS3Fmo8i4wY3w@mail.gmail.com>
Subject: nfs: possible sync issue between nfs_call_unlink <-> nfs_async_unlink_release
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG: https://bugs.linaro.org/show_bug.cgi?id=3731

During Linaro's Kernel Functional tests, we have observed the
following situation:

[   52.651490] DEBUG_LOCKS_WARN_ON(sem->owner != ((struct task_struct *)1UL))
[   52.651506] WARNING: CPU: 2 PID: 1457 at
./kernel/locking/rwsem.c:217 up_read_non_owner+0x5d/0x70
[   52.674398] Modules linked in: x86_pkg_temp_thermal fuse
[   52.679719] CPU: 2 PID: 1457 Comm: kworker/2:2 Not tainted 4.16.0 #1
[   52.687448] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[   52.694922] Workqueue: nfsiod rpc_async_release
[   52.699454] RIP: 0010:up_read_non_owner+0x5d/0x70
[   52.704157] RSP: 0018:ffff9cbf81a23dd0 EFLAGS: 00010282
[   52.709376] RAX: 0000000000000000 RBX: ffff8dc1983c76c0 RCX: 0000000000000000
[   52.716500] RDX: ffffffffbd2d26c9 RSI: 0000000000000001 RDI: ffffffffbd2d2889
[   52.723652] RBP: ffff9cbf81a23dd8 R08: 0000000000000000 R09: 0000000000000000
[   52.730782] R10: ffff9cbf81a23dd0 R11: 0000000000000000 R12: ffff8dc19abf8600
[   52.737906] R13: ffff8dc19b6c0000 R14: 0000000000000000 R15: ffff8dc19bacad80
[   52.745029] FS:  0000000000000000(0000) GS:ffff8dc1afd00000(0000)
knlGS:0000000000000000
[   52.753108] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   52.758845] CR2: 00007f33794665d8 CR3: 000000016c41e006 CR4: 00000000003606e0
[   52.765968] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   52.773091] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   52.780215] Call Trace:
[   52.782695]  nfs_async_unlink_release+0x32/0x80
[   52.787220]  rpc_free_task+0x30/0x50
[   52.790789]  rpc_async_release+0x12/0x20
[   52.794707]  process_one_work+0x25e/0x660
[   52.798713]  worker_thread+0x4b/0x410
[   52.802377]  kthread+0x10d/0x140
[   52.805600]  ? rescuer_thread+0x3a0/0x3a0
[   52.809652]  ? kthread_create_worker_on_cpu+0x70/0x70
[   52.814702]  ? do_syscall_64+0x69/0x1b0
[   52.818540]  ret_from_fork+0x3a/0x50

TEST RUNS:

https://lkft.validation.linaro.org/scheduler/job/167146#L2361
https://lkft.validation.linaro.org/scheduler/job/177145#L883

COMMENTS:

This started happening after commit 5149cbac4235 (locking/rwsem: Add
DEBUG_RWSEMS to look for lock/unlock mismatches) introduced checks for
the semaphores.

After some investigations (in Bug: #3731), the feedback, and assumptions, are:

Function "nfs_rmdir()" acquires the write semaphore in order to
guarantee that no unlink operations will happen to inodes inside the
directory to be unlinked, making it safe to unlink a directory on NFS.
The parent's dentry (read) semaphore serve as a synchronization
(mutual exclusive) for rmdir (read/write), to guarantee there are no
files being unlinked inside the directory when this is being unlinked.

The logic "nfs_call_unlink() -> nfs_do_call_unlink()" acquires the
inode's (that was unlinked) parent dentry->rmdir_sem (read) until the
inode's nfs_unlinkdata (needed for silly unlink) is finally
asynchronously (rpc call) cleaned by nfs_async_unlink_release() call,
the same place where inode's parent dentry->rmdir_sem is released, as
originally described in commit: 884be175351e. Purpose of this is to
guarantee that the parent directory won't be unlinked while the inode
is being async unlinked.

Unfortunately it seems that there is some condition that either made
the read semaphore (from inode's parent dentry) to be released (by the
same async logic ?) before nfs_async_unlink_release() ran through RPC
call OR the inode was moved (rmdir_sem doesn't seem to be acquired in
other situations) to a different directory (caching a new dentry
without the read semaphore acquired), making the DEBUG_LOCKS_WARN_ON
to have caught this.

Thank you for reviewing this.
-- 
Linaro LKFT
https://lkft.linaro.org
