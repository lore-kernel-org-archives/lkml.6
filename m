Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753043AbeEGU7Y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:59:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752950AbeEGU7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:59:21 -0400
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v7 0/4] ipc: IPCMNI limit check for *mni & increase that limit
Date: Mon,  7 May 2018 16:59:08 -0400
Message-Id: <1525726752-29281-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v6->v7:
 - Drop the range clamping code and just return error instead for now
   until there is user request for clamping support.
 - Fix compilation error when CONFIG_SYSVIPC_SYSCTL isn't defined.

v5->v6:
 - Consolidate the 3 ctl_table flags into 2.
 - Make similar changes to proc_doulongvec_minmax() and its associates
   to complete the clamping change.
 - Remove the sysctl registration failure test patch for now for later
   consideration.
 - Add extra braces to patch 1 to reduce code diff in a later patch.

v4->v5:
 - Revert the flags back to 16-bit so that there will be no change to
   the size of ctl_table.
 - Enhance the sysctl_check_flags() as requested by Luis to perform more
   checks to spot incorrect ctl_table entries.
 - Change the sysctl selftest to use dummy sysctls instead of production
   ones & enhance it to do more checks.
 - Add one more sysctl selftest for registration failure.
 - Add 2 ipc patches to add an extended mode to increase IPCMNI from
   32k to 2M.
 - Miscellaneous change to incorporate feedback comments from
   reviewers.

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

v4 patch: https://lkml.org/lkml/2018/3/12/867
v5 patch: https://lkml.org/lkml/2018/3/16/1106
v6 patch: https://lkml.org/lkml/2018/4/27/1094

The sysctl parameters msgmni, shmmni and semmni have an inherent limit
of IPC_MNI (32k). However, users may not be aware of that because they
can write a value much higher than that without getting any error or
notification. Reading the parameters back will show the newly written
values which are not real.

The real IPCMNI limit is now enforced to make sure that users won't
put in an unrealistic value. The first 2 patches enforce the limits.

There are also users out there requesting increase in the IPCMNI value.
The last 2 patches attempt to do that by using a boot kernel parameter
"ipcmni_extend" to increase the IPCMNI limit from 32k to 2M if the users
really want the extended value.

Waiman Long (4):
  ipc: IPCMNI limit check for msgmni and shmmni
  ipc: IPCMNI limit check for semmni
  ipc: Allow boot time extension of IPCMNI from 32k to 2M
  ipc: Conserve sequence numbers in extended IPCMNI mode

 Documentation/admin-guide/kernel-parameters.txt |  3 ++
 include/linux/ipc_namespace.h                   |  1 +
 ipc/ipc_sysctl.c                                | 42 +++++++++++++++++++--
 ipc/util.c                                      | 41 ++++++++++++++-------
 ipc/util.h                                      | 49 +++++++++++++++++++++----
 5 files changed, 112 insertions(+), 24 deletions(-)

-- 
1.8.3.1
