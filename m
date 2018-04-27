Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759302AbeD0VAy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 17:00:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1759077AbeD0VAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 17:00:51 -0400
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
Subject: [PATCH v6 0/8] ipc: Clamp *mni to the real IPCMNI limit & increase that limit
Date: Fri, 27 Apr 2018 17:00:30 -0400
Message-Id: <1524862838-8247-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

v1 patch: https://lkml.org/lkml/2018/2/19/453
v2 patch: https://lkml.org/lkml/2018/2/27/627
v3 patch: https://lkml.org/lkml/2018/3/1/716 
v4 patch: https://lkml.org/lkml/2018/3/12/867
v5 patch: https://lkml.org/lkml/2018/3/16/1106

The sysctl parameters msgmni, shmmni and semmni have an inherent limit
of IPC_MNI (32k). However, users may not be aware of that because they
can write a value much higher than that without getting any error or
notification. Reading the parameters back will show the newly written
values which are not real.

Enforcing the limit by failing sysctl parameter write, however, may
cause regressions if existing user setup scripts set those parameters
above 32k as those scripts will now fail in this case.

To address this delemma, a new flags field is introduced into
the ctl_table. The value CTL_FLAGS_CLAMP_RANGE can be added to any
ctl_table entries to enable a looser range clamping without returning
any error. For example,

  .flags = CTL_FLAGS_CLAMP_RANGE,

This flags value are now used for the range checking of shmmni,
msgmni and semmni without breaking existing applications. If any out
of range value is written to those sysctl parameters, the following
warning will be printed instead.

  sysctl: "shmmni" was set out of range [0, 32768], clamped to 32768.

Reading the values back will show 32768 instead of some fake values.

New sysctl selftests are added to exercise new code added by this
patchset.

There are users out there requesting increase in the IPCMNI value.
The last 2 patches attempt to do that by using a boot kernel parameter
"ipcmni_extend" to increase the IPCMNI limit from 32k to 2M.

Eric Biederman had posted an RFC patch to just scrap the IPCMNI limit
and open up the whole positive integer space for IPC IDs. A major
issue that I have with this approach is that SysV IPC had been in use
for over 20 years. We just don't know if there are user applications
that have dependency on the way that the IDs are built. So drastic
change like this may have the potential of breaking some applications.

I prefer a more conservative approach where users will observe no
change in behavior unless they explictly opt in to enable the extended
mode. I could open up the whole positive integer space in this case
like what Eric did, but that will make the code more complex.  So I
just extend IPCMNI to 2M in this case and keep similar ID generation
logic.


Waiman Long (8):
  sysctl: Add flags to support min/max range clamping
  proc/sysctl: Provide additional ctl_table.flags checks
  sysctl: Warn when a clamped sysctl parameter is set out of range
  ipc: Clamp msgmni and shmmni to the real IPCMNI limit
  ipc: Clamp semmni to the real IPCMNI limit
  test_sysctl: Add range clamping test
  ipc: Allow boot time extension of IPCMNI from 32k to 2M
  ipc: Conserve sequence numbers in extended IPCMNI mode

 Documentation/admin-guide/kernel-parameters.txt |   3 +
 fs/proc/proc_sysctl.c                           |  60 ++++++++++++++
 include/linux/ipc_namespace.h                   |   1 +
 include/linux/sysctl.h                          |  32 ++++++++
 ipc/ipc_sysctl.c                                |  33 +++++++-
 ipc/sem.c                                       |  25 ++++++
 ipc/util.c                                      |  41 +++++++---
 ipc/util.h                                      |  35 ++++++--
 kernel/sysctl.c                                 | 104 +++++++++++++++++++++---
 lib/test_sysctl.c                               |  29 +++++++
 tools/testing/selftests/sysctl/sysctl.sh        |  52 ++++++++++++
 11 files changed, 379 insertions(+), 36 deletions(-)

-- 
1.8.3.1
