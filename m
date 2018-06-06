Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932970AbeFFAso (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 20:48:44 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38948 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932958AbeFFAsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 20:48:42 -0400
X-Google-Smtp-Source: ADUXVKKM31M5EXF1WdfDoSJ5qxbmzvi36lAyg88pyEmFsVQoDhK4xuZMmiKo8rLRZR1Wz2lgosqsX1JJoWKfzdfnMZA=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 5 Jun 2018 20:48:40 -0400
Message-ID: <CAHC9VhTyw3TwfUcoNUHE4_X8oLpidx56GVgRvsC-HtwMz-1s7A@mail.gmail.com>
Subject: [GIT PULL] Audit patches for v4.18
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w560nPFY027409

Hi Linus,

Another reasonable chunk of audit changes for v4.18, thirteen patches
in total.  The thirteen patches can mostly be broken down into one of
four categories: general bug fixes, accessor functions for audit state
stored in the task_struct, negative filter matches on executable
names, and extending the (relatively) new seccomp logging knobs to the
audit subsystem.  The main driver for the accessor functions from
Richard are the changes we're working on to associate audit events
with containers, but I think they have some standalone value too so I
figured it would be good to get them in now.  The seccomp/audit
patches from Tyler apply the seccomp logging improvements from a few
releases ago to audit's seccomp logging; starting with this patchset
the changes in /proc/sys/kernel/seccomp/actions_logged should apply to
both the standard kernel logging and audit.

As usual, everything passes the audit-testsuite and it happens to
merge cleanly with your tree.

Please pull, thanks.
-Paul

--
The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

 Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20180605

for you to fetch changes up to 5b71388663c0920848c0ee7de946970a2692b76d:

 audit: Fix wrong task in comparison of session ID
   (2018-05-21 14:27:43 -0400)

----------------------------------------------------------------
audit/stable-4.18 PR 20180605

----------------------------------------------------------------
Ondrej Mosnáček (2):
     audit: allow not equal op for audit by executable
     audit: Fix wrong task in comparison of session ID

Richard Guy Briggs (7):
     audit: add syscall information to FEATURE_CHANGE records
     audit: convert sessionid unset to a macro
     audit: use inline function to get audit context
     audit: use inline function to set audit context
     audit: use new audit_context access funciton for seccomp_actions_logged
     audit: normalize loginuid read access
     audit: use existing session info function

Tyler Hicks (4):
     seccomp: Separate read and write code for actions_logged sysctl
     seccomp: Configurable separator for the actions_logged string
     seccomp: Audit attempts to modify the actions_logged sysctl
     seccomp: Don't special case audited processes when logging

Documentation/userspace-api/seccomp_filter.rst |   7 --
include/linux/audit.h                          |  39 ++++---
include/net/xfrm.h                             |   4 +-
include/uapi/linux/audit.h                     |   1 +
init/init_task.c                               |   3 +-
kernel/audit.c                                 |   6 +-
kernel/audit_watch.c                           |   2 +-
kernel/auditfilter.c                           |   6 +-
kernel/auditsc.c                               | 135 ++++++++++++++++---------
kernel/fork.c                                  |   2 +-
kernel/seccomp.c                               | 126 ++++++++++++++++-------
net/bridge/netfilter/ebtables.c                |   2 +-
net/core/dev.c                                 |  18 ++--
net/netfilter/x_tables.c                       |   2 +-
net/netlabel/netlabel_user.c                   |   2 +-
security/integrity/ima/ima_api.c               |   2 +-
security/integrity/integrity_audit.c           |   2 +-
security/lsm_audit.c                           |   2 +-
security/selinux/hooks.c                       |   7 +-
security/selinux/selinuxfs.c                   |   6 +-
security/selinux/ss/services.c                 |  12 +--
21 files changed, 242 insertions(+), 144 deletions(-)

-- 
paul moore
www.paul-moore.com
