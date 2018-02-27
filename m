Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbeB0UuC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 15:50:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751721AbeB0UuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 15:50:01 -0500
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/5] ipc: Clamp *mni to the real IPCMNI limit
Date: Tue, 27 Feb 2018 15:49:46 -0500
Message-Id: <1519764591-27456-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1->v2:
 - Add kdoc comments to the do_proc_do{u}intvec_minmax_conv_param
   structures.
 - Add a new flags field to the ctl_table structure for specifying
   whether range clamping should be activated instead of adding new
   sysctl parameter handlers.
 - Clamp the semmni value embedded in the multi-values sem parameter.

v1 patch: https://lkml.org/lkml/2018/2/19/453

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

Waiman Long (5):
  sysctl: Add kdoc comments to do_proc_do{u}intvec_minmax_conv_param
  sysctl: Add flags to support min/max range clamping
  sysctl: Warn when a clamped sysctl parameter is set out of range
  ipc: Clamp msgmni and shmmni to the real IPCMNI limit
  ipc: Clamp semmni to the real IPCMNI limit

 include/linux/sysctl.h |   7 ++++
 ipc/ipc_sysctl.c       |  29 +++++++++++--
 ipc/sem.c              |  33 +++++++++++++++
 ipc/util.h             |   4 ++
 kernel/sysctl.c        | 111 +++++++++++++++++++++++++++++++++++++++++++++----
 5 files changed, 173 insertions(+), 11 deletions(-)

-- 
1.8.3.1
