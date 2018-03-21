Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbeCUIrp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 04:47:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751411AbeCUIrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 04:47:41 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>, Kees Cook <keescook@chromium.org>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak21 V4 0/2] audit: address ANOM_LINK excess records
Date: Wed, 21 Mar 2018 04:42:19 -0400
Message-Id: <cover.1521620371.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This V4 is a supplement to patches 1 and 2 of v1 already merged.

Audit link denied events were being unexpectedly produced in a disjoint
way when audit was disabled, and when they were expected, there were
duplicate PATH records.  This patchset addresses both issues for
symlinks and hardlinks.

This was introduced with
	commit b24a30a7305418ff138ff51776fc555ec57c011a
	("audit: fix event coverage of AUDIT_ANOM_LINK")
	commit a51d9eaa41866ab6b4b6ecad7b621f8b66ece0dc
	("fs: add link restriction audit reporting")

Here are the original events for symlink and hardlink for each of
CWD!=PARENT and CWD=PARENT on 4.15.7-300.fc27.x86_64:
----
type=PROCTITLE msg=audit(2018-03-21 04:15:45.353:285) : proctitle=ls /tmp/my-passwd 
type=PATH msg=audit(2018-03-21 04:15:45.353:285) : item=0 name=/tmp/my-passwd nametype=UNKNOWN cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 
type=CWD msg=audit(2018-03-21 04:15:45.353:285) : cwd=/root 
type=SYSCALL msg=audit(2018-03-21 04:15:45.353:285) : arch=x86_64 syscall=stat success=no exit=EACCES(Permission denied) a0=0x7ffddb7c4de7 a1=0x557b4bb5f3c0 a2=0x557b4bb5f3c0 a3=0xdb7c4d00 items=1 ppid=621 pid=676 auid=root uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=ttyS0 ses=1 comm=ls exe=/usr/bin/ls subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null) 
type=PATH msg=audit(2018-03-21 04:15:45.353:285) : item=0 name=/tmp/my-passwd inode=20618 dev=00:29 mode=link,777 ouid=rgb ogid=rgb rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0 nametype=NORMAL cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 
type=ANOM_LINK msg=audit(2018-03-21 04:15:45.353:285) : op=follow_link ppid=621 pid=676 auid=root uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=ttyS0 ses=1 comm=ls exe=/usr/bin/ls subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 res=no 
----
type=PROCTITLE msg=audit(2018-03-21 04:15:45.356:286) : proctitle=ls my-passwd 
type=PATH msg=audit(2018-03-21 04:15:45.356:286) : item=0 name=my-passwd nametype=UNKNOWN cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 
type=CWD msg=audit(2018-03-21 04:15:45.356:286) : cwd=/tmp 
type=SYSCALL msg=audit(2018-03-21 04:15:45.356:286) : arch=x86_64 syscall=stat success=no exit=EACCES(Permission denied) a0=0x7ffe24d26de0 a1=0x55de0254b3c0 a2=0x55de0254b3c0 a3=0x24d26d00 items=1 ppid=621 pid=677 auid=root uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=ttyS0 ses=1 comm=ls exe=/usr/bin/ls subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null) 
type=PATH msg=audit(2018-03-21 04:15:45.356:286) : item=0 name=/tmp/my-passwd inode=20618 dev=00:29 mode=link,777 ouid=rgb ogid=rgb rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0 nametype=NORMAL cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 
type=ANOM_LINK msg=audit(2018-03-21 04:15:45.356:286) : op=follow_link ppid=621 pid=677 auid=root uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=ttyS0 ses=1 comm=ls exe=/usr/bin/ls subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 res=no 
----
type=PROCTITLE msg=audit(2018-03-21 04:15:56.688:287) : proctitle=ln /tmp/test /tmp/test-ln 
type=PATH msg=audit(2018-03-21 04:15:56.688:287) : item=1 name=/tmp/ inode=15168 dev=00:29 mode=dir,sticky,777 ouid=root ogid=root rdev=00:00 obj=system_u:object_r:tmp_t:s0 nametype=PARENT cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 
type=PATH msg=audit(2018-03-21 04:15:56.688:287) : item=0 name=/tmp/test inode=20018 dev=00:29 mode=file,700 ouid=root ogid=root rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0 nametype=NORMAL cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 
type=CWD msg=audit(2018-03-21 04:15:56.688:287) : cwd=/home/rgb 
type=SYSCALL msg=audit(2018-03-21 04:15:56.688:287) : arch=x86_64 syscall=linkat success=no exit=EPERM(Operation not permitted) a0=0xffffff9c a1=0x7fff7f3ac62e a2=0xffffff9c a3=0x7fff7f3ac638 items=2 ppid=650 pid=680 auid=rgb uid=rgb gid=rgb euid=rgb suid=rgb fsuid=rgb egid=rgb sgid=rgb fsgid=rgb tty=pts0 ses=3 comm=ln exe=/usr/bin/ln subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null) 
type=PATH msg=audit(2018-03-21 04:15:56.688:287) : item=0 name=/tmp/test inode=20018 dev=00:29 mode=file,700 ouid=root ogid=root rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0 nametype=NORMAL cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 
type=ANOM_LINK msg=audit(2018-03-21 04:15:56.688:287) : op=linkat ppid=650 pid=680 auid=rgb uid=rgb gid=rgb euid=rgb suid=rgb fsuid=rgb egid=rgb sgid=rgb fsgid=rgb tty=pts0 ses=3 comm=ln exe=/usr/bin/ln subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 res=no 
----
type=PROCTITLE msg=audit(2018-03-21 04:15:56.691:288) : proctitle=ln test test-ln 
type=PATH msg=audit(2018-03-21 04:15:56.691:288) : item=1 name=/tmp inode=15168 dev=00:29 mode=dir,sticky,777 ouid=root ogid=root rdev=00:00 obj=system_u:object_r:tmp_t:s0 nametype=PARENT cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 
type=PATH msg=audit(2018-03-21 04:15:56.691:288) : item=0 name=test inode=20018 dev=00:29 mode=file,700 ouid=root ogid=root rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0 nametype=NORMAL cap_fp=no ne cap_fi=none cap_fe=0 cap_fver=0 
type=CWD msg=audit(2018-03-21 04:15:56.691:288) : cwd=/tmp 
type=SYSCALL msg=audit(2018-03-21 04:15:56.691:288) : arch=x86_64 syscall=linkat success=no exit=EPERM(Operation not permitted) a0=0xffffff9c a1=0x7ffd01e3e62c a2=0xffffff9c a3=0x7ffd01e3e631 items=2 ppid=650 pid=681 auid=rgb uid=rgb gid=rgb euid=rgb suid=rgb fsuid=rgb egid=rgb sgid=rgb fsgid=rgb tty=pts0 ses=3 comm=ln exe=/usr/bin/ln subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null) 
type=PATH msg=audit(2018-03-21 04:15:56.691:288) : item=0 name=/tmp/test inode=20018 dev=00:29 mode=file,700 ouid=root ogid=root rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0 nametype=NORMAL cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 
type=ANOM_LINK msg=audit(2018-03-21 04:15:56.691:288) : op=linkat ppid=650 pid=681 auid=rgb uid=rgb gid=rgb euid=rgb suid=rgb fsuid=rgb egid=rgb sgid=rgb fsgid=rgb tty=pts0 ses=3 comm=ln exe=/usr/bin/ln subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 res=no 
----

Here are the resulting events for symlink and hardlink for each of CWD!=PARENT
and CWD=PARENT based on audit/next 11dd266:
----
type=PROCTITLE msg=audit(2018-03-21 04:29:41.556:315) : proctitle=ls --color=auto /tmp/my-passwd 
type=PATH msg=audit(2018-03-21 04:29:41.556:315) : item=0 name=/tmp/my-passwd inode=19641 dev=00:26 mode=link,777 ouid=rgb ogid=rgb rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0 nametype=NORMAL cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 
type=CWD msg=audit(2018-03-21 04:29:41.556:315) : cwd=/root 
type=SYSCALL msg=audit(2018-03-21 04:29:41.556:315) : arch=x86_64 syscall=stat success=no exit=EACCES(Permission denied) a0=0x7ffd4585565a a1=0x5649fb468fd0 a2=0x5649fb468fd0 a3=0x45855600 items=1 ppid=694 pid=714 auid=root uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=pts0 ses=6 comm=ls exe=/usr/bin/ls subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null) 
type=ANOM_LINK msg=audit(2018-03-21 04:29:41.556:315) : op=follow_link ppid=694 pid=714 auid=root uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=pts0 ses=6 comm=ls exe=/usr/bin/ls subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 res=no 
----
type=PROCTITLE msg=audit(2018-03-21 04:29:41.562:316) : proctitle=ls --color=auto my-passwd 
type=PATH msg=audit(2018-03-21 04:29:41.562:316) : item=0 name=my-passwd inode=19641 dev=00:26 mode=link,777 ouid=rgb ogid=rgb rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0 nametype=NORMAL cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 
type=CWD msg=audit(2018-03-21 04:29:41.562:316) : cwd=/tmp 
type=SYSCALL msg=audit(2018-03-21 04:29:41.562:316) : arch=x86_64 syscall=stat success=no exit=EACCES(Permission denied) a0=0x7fff7fe3c653 a1=0x55d9f875dfd0 a2=0x55d9f875dfd0 a3=0x7fe3c600 items=1 ppid=694 pid=715 auid=root uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=pts0 ses=6 comm=ls exe=/usr/bin/ls subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null) 
type=ANOM_LINK msg=audit(2018-03-21 04:29:41.562:316) : op=follow_link ppid=694 pid=715 auid=root uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=pts0 ses=6 comm=ls exe=/usr/bin/ls subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 res=no 
----
type=PROCTITLE msg=audit(2018-03-21 04:29:54.709:317) : proctitle=ln /tmp/test /tmp/test-ln 
type=PATH msg=audit(2018-03-21 04:29:54.709:317) : item=1 name=/tmp/ inode=13038 dev=00:26 mode=dir,sticky,777 ouid=root ogid=root rdev=00:00 obj=system_u:object_r:tmp_t:s0 nametype=PARENT cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 
type=PATH msg=audit(2018-03-21 04:29:54.709:317) : item=0 name=/tmp/test inode=18720 dev=00:26 mode=file,700 ouid=root ogid=root rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0 nametype=NORMAL cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 
type=CWD msg=audit(2018-03-21 04:29:54.709:317) : cwd=/home/rgb 
type=SYSCALL msg=audit(2018-03-21 04:29:54.709:317) : arch=x86_64 syscall=linkat success=no exit=EPERM(Operation not permitted) a0=0xffffff9c a1=0x7ffc468b2dbb a2=0xffffff9c a3=0x7ffc468b2dc5 items=2 ppid=661 pid=718 auid=rgb uid=rgb gid=rgb euid=rgb suid=rgb fsuid=rgb egid=rgb sgid=rgb fsgid=rgb tty=ttyS0 ses=5 comm=ln exe=/usr/bin/ln subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null) 
type=ANOM_LINK msg=audit(2018-03-21 04:29:54.709:317) : op=linkat ppid=661 pid=718 auid=rgb uid=rgb gid=rgb euid=rgb suid=rgb fsuid=rgb egid=rgb sgid=rgb fsgid=rgb tty=ttyS0 ses=5 comm=ln exe=/usr/bin/ln subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 res=no 
----
type=PROCTITLE msg=audit(2018-03-21 04:29:54.714:318) : proctitle=ln test test-ln 
type=PATH msg=audit(2018-03-21 04:29:54.714:318) : item=1 name=/tmp inode=13038 dev=00:26 mode=dir,sticky,777 ouid=root ogid=root rdev=00:00 obj=system_u:object_r:tmp_t:s0 nametype=PARENT cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 
type=PATH msg=audit(2018-03-21 04:29:54.714:318) : item=0 name=test inode=18720 dev=00:26 mode=file,700 ouid=root ogid=root rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0 nametype=NORMAL cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 
type=CWD msg=audit(2018-03-21 04:29:54.714:318) : cwd=/tmp 
type=SYSCALL msg=audit(2018-03-21 04:29:54.714:318) : arch=x86_64 syscall=linkat success=no exit=EPERM(Operation not permitted) a0=0xffffff9c a1=0x7ffc06b99db9 a2=0xffffff9c a3=0x7ffc06b99dbe items=2 ppid=661 pid=719 auid=rgb uid=rgb gid=rgb euid=rgb suid=rgb fsuid=rgb egid=rgb sgid=rgb fsgid=rgb tty=ttyS0 ses=5 comm=ln exe=/usr/bin/ln subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null) 
type=ANOM_LINK msg=audit(2018-03-21 04:29:54.714:318) : op=linkat ppid=661 pid=719 auid=rgb uid=rgb gid=rgb euid=rgb suid=rgb fsuid=rgb egid=rgb sgid=rgb fsgid=rgb tty=ttyS0 ses=5 comm=ln exe=/usr/bin/ln subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 res=no 
----

See: https://github.com/linux-audit/audit-kernel/issues/21
See also: https://github.com/linux-audit/audit-kernel/issues/51

Changelog:
v4:
- fix call from may_follow_link() to audit_log_link_denied() param count
v3:
- rebase on previously accepted 1/4 and 2/4 patches and drop them
- drop parent record audit_log_symlink_denied()
v2:
- remove now supperfluous struct path * parameter from audit_log_link_denied()
- refactor audit_log_symlink_denied() to properly free memory (pathname, filename)

Richard Guy Briggs (2):
  audit: remove path param from link denied function
  audit: add refused symlink to audit_names

 fs/namei.c            | 5 +++--
 include/linux/audit.h | 6 ++----
 kernel/audit.c        | 3 +--
 3 files changed, 6 insertions(+), 8 deletions(-)

-- 
1.8.3.1
