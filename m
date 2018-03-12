Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932408AbeCLURw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:17:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932171AbeCLUQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:16:09 -0400
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Waiman Long <longman@redhat.com>
Subject: [PATCH v4 0/6] ipc: Clamp *mni to the real IPCMNI limit
Date: Mon, 12 Mar 2018 16:15:38 -0400
Message-Id: <1520885744-1546-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3->v4:
 - Remove v3 patches 1 & 2 as they have been merged into the mm tree.
 - Change flags from uint16_t to unsigned int.
 - Remove CTL_FLAGS_OOR_WARNED and use pr_warn_ratelimited() instead.
 - Simplify the warning message code.
 - Add a new patch to fail the ctl_table registration with invalid flag.
 - Add a test case for range clamping in sysctl selftest.

v2->v3:
 - Fix kdoc comment errors.
 - Incorporate comments and suggestions from Luis R. Rodriguez.
 - Add a patch to fix a typo error in fs/proc/proc_sysctl.c.

v1->v2:
 - Add kdoc comments to the do_proc_do{u}intvec_minmax_conv_param
   structures.
 - Add a new flags field to the ctl_table structure for specifying
   whether range clamping should be activated instead of adding new
   sysctl parameter handlers.
 - Clamp the semmni value embedded in the multi-values sem parameter.

v1 patch: https://lkml.org/lkml/2018/2/19/453
v2 patch: https://lkml.org/lkml/2018/2/27/627

The sysctl parameters msgmni, shmmni and semmni have an inherent limit
of IPC_MNI (32k). However, users may not be aware of that because they
can write a value much higher than that without getting any error or
notification. Reading the parameters back will show the newly written
values which are not real.

Enforcing the limit by failing sysctl parameter write, however, can
break existing user applications. To address this delemma, a new flags
field is introduced into the ctl_table. The value CTL_FLAGS_CLAMP_RANGE
can be added to any ctl_table entries to enable a looser range clamping
without returning any error. For example,

  .flags = CTL_FLAGS_CLAMP_RANGE,

This flags value are now used for the range checking of shmmni,
msgmni and semmni without breaking existing applications. If any out
of range value is written to those sysctl parameters, the following
warning will be printed instead.

  sysctl: "shmmni" was set out of range [0, 32768], clamped to 32768.

Reading the values back will show 32768 instead of some fake values.

Waiman Long (6):
  sysctl: Add flags to support min/max range clamping
  proc/sysctl: Check for invalid flags bits
  sysctl: Warn when a clamped sysctl parameter is set out of range
  ipc: Clamp msgmni and shmmni to the real IPCMNI limit
  ipc: Clamp semmni to the real IPCMNI limit
  test_sysctl: Add range clamping test

 fs/proc/proc_sysctl.c                    | 12 +++++
 include/linux/sysctl.h                   | 15 ++++++
 ipc/ipc_sysctl.c                         | 22 +++++++--
 ipc/sem.c                                | 28 +++++++++++
 ipc/util.h                               |  4 ++
 kernel/sysctl.c                          | 80 ++++++++++++++++++++++++++++----
 tools/testing/selftests/sysctl/sysctl.sh | 43 +++++++++++++++++
 7 files changed, 192 insertions(+), 12 deletions(-)

-- 
1.8.3.1
