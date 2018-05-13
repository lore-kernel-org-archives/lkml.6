Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeEMB7c (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 21:59:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751398AbeEMB7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 21:59:30 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux NetDev Upstream Mailing List <netdev@vger.kernel.org>,
        Netfilter Devel List <netfilter-devel@vger.kernel.org>,
        Linux Security Module list
        <linux-security-module@vger.kernel.org>,
        Integrity Measurement Architecture
        <linux-integrity@vger.kernel.org>,
        SElinux list <selinux@tycho.nsa.gov>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak81 RFC V2 0/5] audit: group task params
Date: Sat, 12 May 2018 21:58:17 -0400
Message-Id: <cover.1526173613.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group the audit parameters for each task into one structure.
In particular, remove the loginuid and sessionid values and the audit
context pointer from the task structure, replacing them with an audit
task information structure to contain them.  Use access functions to
access audit values.

Note:  Use static allocation of the audit task information structure
initially.  Dynamic allocation was considered and attempted, but isn't
ready yet.  Static allocation has the limitation that future audit task
information structure changes would cause a visible change to the rest
of the kernel, whereas dynamic allocation would mostly hide any future
changes.

The first four access normalization patches could stand alone.

Passes audit-testsuite.

Changelog:
v2
- p2/5: add audit header to init/init_task.c to quiet kbuildbot
- audit_signal_info(): fetch loginuid once
- remove task_struct from audit_context() param list
- remove extra task_struct local vars
- do nothing on request to set audit context when audit is disabled

Richard Guy Briggs (5):
  audit: normalize loginuid read access
  audit: convert sessionid unset to a macro
  audit: use inline function to get audit context
  audit: use inline function to set audit context
  audit: collect audit task parameters

 MAINTAINERS                          |  2 +-
 include/linux/audit.h                | 28 ++++++++---
 include/linux/audit_task.h           | 31 ++++++++++++
 include/linux/sched.h                |  6 +--
 include/net/xfrm.h                   |  4 +-
 include/uapi/linux/audit.h           |  1 +
 init/init_task.c                     |  8 ++-
 kernel/audit.c                       |  6 +--
 kernel/audit_watch.c                 |  2 +-
 kernel/auditsc.c                     | 97 +++++++++++++++++-------------------
 kernel/fork.c                        |  2 +-
 net/bridge/netfilter/ebtables.c      |  2 +-
 net/core/dev.c                       |  2 +-
 net/netfilter/x_tables.c             |  2 +-
 net/netlabel/netlabel_user.c         |  2 +-
 security/integrity/ima/ima_api.c     |  2 +-
 security/integrity/integrity_audit.c |  2 +-
 security/lsm_audit.c                 |  2 +-
 security/selinux/hooks.c             |  4 +-
 security/selinux/selinuxfs.c         |  6 +--
 security/selinux/ss/services.c       | 12 ++---
 21 files changed, 133 insertions(+), 90 deletions(-)
 create mode 100644 include/linux/audit_task.h

-- 
1.8.3.1
