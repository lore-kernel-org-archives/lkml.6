Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753304AbeCNFsI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 01:48:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751155AbeCNFsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 01:48:07 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>, Kees Cook <keescook@chromium.org>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak21 V3 0/2] audit: address ANOM_LINK excess records
Date: Wed, 14 Mar 2018 01:42:58 -0400
Message-Id: <cover.1521005283.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This V3 is a supplement to patches 1 and 2 of v1 already merged.

Audit link denied events were being unexpectedly produced in a disjoint
way when audit was disabled, and when they were expected, there were
duplicate PATH records.  This patchset addresses both issues for
symlinks and hardlinks.

This was introduced with
	commit b24a30a7305418ff138ff51776fc555ec57c011a
	("audit: fix event coverage of AUDIT_ANOM_LINK")
	commit a51d9eaa41866ab6b4b6ecad7b621f8b66ece0dc
	("fs: add link restriction audit reporting")

Here are the resulting events:

symlink:
type=PROCTITLE msg=audit(03/12/2018 02:21:49.578:310) : proctitle=ls ./my-passwd 
type=PATH msg=audit(03/12/2018 02:21:49.578:310) : item=0 name=./my-passwd inode=17090 dev=00:27 mode=link,777 ouid=rgb ogid=rgb rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0 nametype=NORMAL cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 
type=CWD msg=audit(03/12/2018 02:21:49.578:310) : cwd=/tmp 
type=SYSCALL msg=audit(03/12/2018 02:21:49.578:310) : arch=x86_64 syscall=stat success=no exit=EACCES(Permission denied) a0=0x7ffd79950dda a1=0x563f658a03c8 a2=0x563f658a03c8 a3=0x79950d00 items=2 ppid=552 pid=629 auid=root uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=ttyS0 ses=1 comm=ls exe=/usr/bin/ls subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null) 
type=ANOM_LINK msg=audit(03/12/2018 02:21:49.578:310) : op=follow_link ppid=552 pid=629 auid=root uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=ttyS0 ses=1 comm=ls exe=/usr/bin/ls subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 res=no 
----
hardlink:
type=PROCTITLE msg=audit(03/12/2018 02:24:39.813:314) : proctitle=ln test test-ln 
type=PATH msg=audit(03/12/2018 02:24:39.813:314) : item=1 name=/tmp inode=13529 dev=00:27 mode=dir,sticky,777 ouid=root ogid=root rdev=00:00 obj=system_u:object_r:tmp_t:s0 nametype=PARENT cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 
type=PATH msg=audit(03/12/2018 02:24:39.813:314) : item=0 name=test inode=18112 dev=00:27 mode=file,700 ouid=root ogid=root rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0 nametype=NORMAL cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 
type=CWD msg=audit(03/12/2018 02:24:39.813:314) : cwd=/tmp 
type=SYSCALL msg=audit(03/12/2018 02:24:39.813:314) : arch=x86_64 syscall=linkat success=no exit=EPERM(Operation not permitted) a0=0xffffff9c a1=0x7ffccba77629 a2=0xffffff9c a3=0x7ffccba7762e items=2 ppid=605 pid=638 auid=rgb uid=rgb gid=rgb euid=rgb suid=rgb fsuid=rgb egid=rgb sgid=rgb fsgid=rgb tty=pts0 ses=4 comm=ln exe=/usr/bin/ln subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null) 
type=ANOM_LINK msg=audit(03/12/2018 02:24:39.813:314) : op=linkat ppid=605 pid=638 auid=rgb uid=rgb gid=rgb euid=rgb suid=rgb fsuid=rgb egid=rgb sgid=rgb fsgid=rgb tty=pts0 ses=4 comm=ln exe=/usr/bin/ln subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 res=no 

See: https://github.com/linux-audit/audit-kernel/issues/21
See also: https://github.com/linux-audit/audit-kernel/issues/51

Changelog:
v3:
- rebase on previously accepted 1/4 and 2/4 patches and drop them
- drop parent record audit_log_symlink_denied()
v2:
- remove now supperfluous struct path * parameter from audit_log_link_denied()
- refactor audit_log_symlink_denied() to properly free memory (pathname, filename)

Richard Guy Briggs (2):
  audit: remove path param from link denied function
  audit: add refused symlink to audit_names

 fs/namei.c            | 3 ++-
 include/linux/audit.h | 6 ++----
 kernel/audit.c        | 3 +--
 3 files changed, 5 insertions(+), 7 deletions(-)

-- 
1.8.3.1
