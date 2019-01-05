Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95357C43612
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 19:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5F72232D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 19:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfAETbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 14:31:41 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:54640 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfAETbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 14:31:40 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gfrfW-0003jT-PG; Sat, 05 Jan 2019 12:31:39 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gfrfU-0000lw-SL; Sat, 05 Jan 2019 12:31:38 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org
References: <20190104192648.GO2217@ZenIV.linux.org.uk>
Date:   Sat, 05 Jan 2019 13:31:21 -0600
In-Reply-To: <20190104192648.GO2217@ZenIV.linux.org.uk> (Al Viro's message of
        "Fri, 4 Jan 2019 19:26:48 +0000")
Message-ID: <87ef9qdhpy.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gfrfU-0000lw-SL;;;mid=<87ef9qdhpy.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ppuJetrfSPU9t+J/Nz715Su/dviSKCyU=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [git pull] vfs.git mount.part1
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> 	mount API prereqs.  Mostly that's LSM mount options cleanups.
> One trivial conflict in security/selinux/hooks.c, resolved by taking
> the variant from this branch - the method has been split, leaving
> only the part that used to be conditional upon "it's not an internal
> mount" and check has been moved into the caller of the remaining piece.
> The last commit in this pile ("mount_fs: suppress MAC on MS_SUBMOUNT as
> well as MS_KERNMOUNT") is an equivalent of the conflict-creating
> mainline change.
> 	There are several minor fixes in there, but nothing
> earth-shattering (leaks on failure exits, mostly).

Am I completely blind or has this code never been posted for reivew?

I know you stuffed something in linux-next, and I saw quite a bit of
consternation from several of the security folks at the time when
testing on linux-next started reporting failures.

Currently on the linux-security-module list there is an unanswered
question by Casey Schaufler <casey@schaufler-ca.com> of which
tree this work is being performed on.

I know I asked you explicitly when you would be posting this code
for review and did not get an answer.

I know I saw bug activity on your tree right up to the day Linus made
his stable release.  I keeping an eye out in the hopes that there would
be something to review.

Not having had a chance to review this code I can't really comment on
the quality of this code.  What I do know from a glance is that
you have not removed FS_BINARY_MOUNTDATA.  Which is the root cause
of some of the crazy security mount option processing, and is an if
not greater mess than what the security options have been doing with
mount options.

The FS_BINARY_MOUNTDATA flag is only relevant for coda and for nfs
backwards compatiblity.  The FS_BINARY_MOUNTDATA flag is only set on
btrfs to allow calling mount_subtree.

I have a set of patches that is finally reasonablly stable and cleans up
all of the mess in the current internal mount apis that should allow
implementing the new mount api to be much less error prone.  My plan is
to start posting it as soon as the merge window closes.

I would really appreciate it if we can work together on this the next
development cycle, and not try and rush and get things out and merged
without proper review, and care.  That has already led to problems.

Eric


> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
>
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git mount.part1
>
> for you to fetch changes up to 718c43038f287e843c2f63d946977de90014cb11:
>
>   mount_fs: suppress MAC on MS_SUBMOUNT as well as MS_KERNMOUNT (2018-12-21 11:51:23 -0500)
>
> ----------------------------------------------------------------
> Al Viro (25):
>       exofs_mount(): fix leaks on failure exits
>       selinux: expand superblock_doinit() calls
>       smack: make smack_parse_opts_str() clean up on failure
>       LSM: lift parsing LSM options into the caller of ->sb_kern_mount()
>       LSM: lift extracting and parsing LSM options into the caller of ->sb_remount()
>       new helper: security_sb_eat_lsm_opts()
>       LSM: split ->sb_set_mnt_opts() out of ->sb_kern_mount()
>       selinux; don't open-code a loop in sb_finish_set_opts()
>       btrfs: sanitize security_mnt_opts use
>       nfs_remount(): don't leak, don't ignore LSM options quietly
>       LSM: turn sb_eat_lsm_opts() into a method
>       selinux: kill selinux_sb_get_mnt_opts()
>       LSM: hide struct security_mnt_opts from any generic code
>       selinux: switch to private struct selinux_mnt_opts
>       smack: switch to private smack_mnt_opts
>       LSM: bury struct security_mnt_opts
>       selinux: new helper - selinux_add_opt()
>       selinux: switch away from match_token()
>       selinux: regularize Opt_... names a bit
>       selinux: rewrite selinux_sb_eat_lsm_opts()
>       LSM: new method: ->sb_add_mnt_opt()
>       smack: take the guts of smack_parse_opts_str() into a new helper
>       smack: get rid of match_token()
>       smack: rewrite smack_sb_eat_lsm_opts()
>       mount_fs: suppress MAC on MS_SUBMOUNT as well as MS_KERNMOUNT
>
> David Howells (2):
>       vfs: Suppress MS_* flag defs within the kernel unless explicitly enabled
>       vfs: Separate changing mount flags full remount
>
>  arch/arc/kernel/setup.c       |   1 +
>  arch/arm/kernel/atags_parse.c |   1 +
>  arch/sh/kernel/setup.c        |   1 +
>  arch/sparc/kernel/setup_32.c  |   1 +
>  arch/sparc/kernel/setup_64.c  |   1 +
>  arch/x86/kernel/setup.c       |   1 +
>  drivers/base/devtmpfs.c       |   1 +
>  fs/btrfs/ctree.h              |   4 -
>  fs/btrfs/super.c              |  82 +----
>  fs/exofs/super.c              |  37 +-
>  fs/namespace.c                | 156 ++++++---
>  fs/nfs/internal.h             |   2 +-
>  fs/nfs/super.c                |  34 +-
>  fs/pnode.c                    |   1 +
>  fs/super.c                    |  24 +-
>  include/linux/lsm_hooks.h     |  17 +-
>  include/linux/mount.h         |   2 +-
>  include/linux/security.h      |  82 +----
>  include/uapi/linux/fs.h       |  56 +--
>  include/uapi/linux/mount.h    |  58 +++
>  init/do_mounts.c              |   1 +
>  init/do_mounts_initrd.c       |   1 +
>  security/apparmor/lsm.c       |   1 +
>  security/apparmor/mount.c     |   1 +
>  security/security.c           |  39 ++-
>  security/selinux/hooks.c      | 799 ++++++++++++++++--------------------------
>  security/smack/smack_lsm.c    | 359 ++++++++-----------
>  security/tomoyo/mount.c       |   1 +
>  28 files changed, 724 insertions(+), 1040 deletions(-)
>  create mode 100644 include/uapi/linux/mount.h
