Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033580AbeCARoO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 12:44:14 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1033521AbeCARoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 12:44:08 -0500
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Waiman Long <longman@redhat.com>
Subject: [PATCH v3 0/6] ipc: Clamp *mni to the real IPCMNI limit
Date: Thu,  1 Mar 2018 12:43:34 -0500
Message-Id: <1519926220-7453-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

  Kernel parameter "shmmni" was set out of range [0, 32768], clamped to 32768.

Reading the values back will show 32768 instead of some fake values.

Waiman Long (6):
  proc/sysctl: Fix typo in sysctl_check_table_array()
  sysctl: Add kdoc comments to do_proc_do{u}intvec_minmax_conv_param
  sysctl: Add flags to support min/max range clamping
  sysctl: Warn when a clamped sysctl parameter is set out of range
  ipc: Clamp msgmni and shmmni to the real IPCMNI limit
  ipc: Clamp semmni to the real IPCMNI limit

 fs/proc/proc_sysctl.c  |   2 +-
 include/linux/sysctl.h |  17 +++++++++
 ipc/ipc_sysctl.c       |  33 ++++++++++++++--
 ipc/sem.c              |  28 ++++++++++++++
 ipc/util.h             |   4 ++
 kernel/sysctl.c        | 102 ++++++++++++++++++++++++++++++++++++++++++++-----
 6 files changed, 172 insertions(+), 14 deletions(-)

-- 
1.8.3.1
