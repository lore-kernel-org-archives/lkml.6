Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032935AbeBNQt5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:49:57 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032861AbeBNQt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:49:56 -0500
From: Steve Grubb <sgrubb@redhat.com>
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Paul Moore <paul@paul-moore.com>, Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH ghak21 0/4] audit: address ANOM_LINK excess records
Date: Wed, 14 Feb 2018 11:49:54 -0500
Message-ID: <2183890.x51U8tdCGl@x2>
Organization: Red Hat
In-Reply-To: <cover.1518603831.git.rgb@redhat.com>
References: <cover.1518603831.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, February 14, 2018 11:18:20 AM EST Richard Guy Briggs wrote:
> Audit link denied events were being unexpectedly produced in a disjoint
> way when audit was disabled, and when they were expected, there were
> duplicate PATH records.  This patchset addresses both issues for
> symlinks and hardlinks.
> 
> This was introduced with
> 	commit b24a30a7305418ff138ff51776fc555ec57c011a
> 	("audit: fix event coverage of AUDIT_ANOM_LINK")
> 	commit a51d9eaa41866ab6b4b6ecad7b621f8b66ece0dc
> 	("fs: add link restriction audit reporting")
> 
> Here are the resulting events:

Have these been tested with ausearch-test?

> symlink:
> type=PROCTITLE msg=audit(02/14/2018 04:40:21.635:238) : proctitle=cat
> my-passwd type=PATH msg=audit(02/14/2018 04:40:21.635:238) : item=1
> name=/tmp/my-passwd inode=17618 dev=00:27 mode=link,777 ouid=rgb ogid=rgb
> rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0 nametype=NORMAL
> cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 type=PATH msg=audit(02/14/2018
> 04:40:21.635:238) : item=0 name=/tmp inode=13446 dev=00:27
> mode=dir,sticky,777 ouid=root ogid=root rdev=00:00
> obj=system_u:object_r:tmp_t:s0 nametype=PARENT cap_fp=none cap_fi=none
> cap_fe=0 cap_fver=0 type=CWD msg=audit(02/14/2018 04:40:21.635:238) :
> cwd=/tmp
> type=SYSCALL msg=audit(02/14/2018 04:40:21.635:238) : arch=x86_64
> syscall=openat success=no exit=EACCES(Permission denied) a0=0xffffff9c
> a1=0x7ffc6c1acdda a2=O_RDONLY a3=0x0 items=2 ppid=549 pid=606 auid=root
> uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root
> fsgid=root tty=ttyS0 ses=1 comm= cat exe=/usr/bin/cat
> subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
> type=ANOM_LINK msg=audit(02/14/2018 04:40:21.635:238) : op=follow_link
> ppid=549 pid=606 auid=root uid=root gid=root euid=root suid=root
> fsuid=root egid=roo t sgid=root fsgid=root tty=ttyS0 ses=1 comm=cat
> exe=/usr/bin/cat
> subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 res=no

This record duplicates the SYSCALL event except for the op field. I would 
suggest that is the only field needed.

> ----
> hardlink:
> type=PROCTITLE msg=audit(02/14/2018 04:40:25.373:239) : proctitle=ln test
> test-ln type=PATH msg=audit(02/14/2018 04:40:25.373:239) : item=1
> name=/tmp inode=13446 dev=00:27 mode=dir,sticky,777 ouid=root ogid=root
> rdev=00:00 obj=system_u:object_r:tmp_t:s0 nametype=PARENT cap_fp=none
> cap_fi=none cap_fe=0 cap_fver=0 type=PATH msg=audit(02/14/2018
> 04:40:25.373:239) : item=0 name=test inode=17619 dev=00:27 mode=file,700
> ouid=root ogid=root rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0
> nametype=NORMAL cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 type=CWD
> msg=audit(02/14/2018 04:40:25.373:239) : cwd=/tmp
> type=SYSCALL msg=audit(02/14/2018 04:40:25.373:239) : arch=x86_64
> syscall=linkat success=no exit=EPERM(Operation not permitted)
> a0=0xffffff9c a1=0x7fffe6c3f628 a2=0xffffff9c a3=0x7fffe6c3f62d items=2
> ppid=578 pid=607 auid=rgb uid=rgb gid=rgb euid=rgb suid=rgb fsuid=rgb
> egid=rgb sgid=rgb fsgid=rgb tty=pts0 ses=3 comm=ln exe=/usr/bin/ln
> subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
> type=ANOM_LINK msg=audit(02/14/2018 04:40:25.373:239) : op=linkat ppid=578
> pid=607 auid=rgb uid=rgb gid=rgb euid=rgb suid=rgb fsuid=rgb egid=rgb
> sgid=rgb fsgid=rgb tty=pts0 ses=3 comm=ln exe=/usr/bin/ln
> subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 res=no
> 
> The remaining problem is how to address this when syscall logging is
> disabled since it needs a parent path record and/or a CWD record to
> complete it.  It could also use a proctitle record too.  In fact, it
> looks like we need a way to have multiple auxiliary records to support
> an arbitrary record.  Comments please.

Perhaps this can only be emitted correctly with SYSCALL auditing enabled. 
Otherwise, the event should stand completely on its own without syscall and 
path records. The information from them can be added, but it risks hitting 
the record size limit.

-Steve

> See: https://github.com/linux-audit/audit-kernel/issues/21
> See also: https://github.com/linux-audit/audit-kernel/issues/51
> 
> Richard Guy Briggs (4):
>   audit: make ANOM_LINK obey audit_enabled and audit_dummy_context
>   audit: link denied should not directly generate PATH record
>   audit: add refused symlink to audit_names
>   audit: add parent of refused symlink to audit_names
> 
>  fs/namei.c     | 10 ++++++++++
>  kernel/audit.c | 13 ++-----------
>  2 files changed, 12 insertions(+), 11 deletions(-)
