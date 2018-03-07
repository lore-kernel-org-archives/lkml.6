Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964940AbeCGUfx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:35:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934327AbeCGUfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:35:08 -0500
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Waiman Long <longman@redhat.com>
Subject: [PATCH 0/5] sysctl: Enable easy addition of range showing sysctl parameters
Date: Wed,  7 Mar 2018 15:34:24 -0500
Message-Id: <1520454869-13871-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is to be applied on top of the patch
series "ipc: Clamp *mni to the real IPCMNI limit"
(https://lkml.org/lkml/2018/3/1/716).

The purpose of this patch series is to enable easy addition of new
auxillary sysctl parameters that can be read to display ranges of
other sysctl parameters they are associated with.

With this patch series applied, a developer can add a range-showing
auxillary sysctl entries by just setting the CTL_FLAGS_SHOW_RANGE
flag in the ctl_table entry that has a range to show and add one more
to the number of reserved range entries in the CTL_RESERVE_RANGES()
macro before the terminating null entry. The new auxillary sysctl
parameters will have the "_range" suffix added.

The number of ctl_table entries that have the CTL_FLAGS_SHOW_RANGE flag
should match the number of reserved entries in the CTL_RESERVE_RANGES()
macro. Otherwise, warning or error like below will be logged in the
kernel ring buffer.

  Warning: Too many reserved ctl_table range entries ("shmmax")!

  Error: Insufficient reserved ctl_table range entries ("shmmax")!

The IPC sysctl parameters msgmni and shmmni are extended to have
those auxillary sysctl entries. As a result, one can now find out
the range of allowable value by looking at the corresponding
auxillary _range sysctl parameters. For example,

  % cat msgmni_range
  [0, 32768]

That means the msgmni sysctl parameter has to be within the 0 - 32768
range inclusively.

Patch 1 clarifies how the ctl_table.flags field should be used.

Patch 2 adds a new proc_show_minmax() handler to display a min/max
range.

Patch 3 defines the new CTL_FLAGS_SHOW_RANGE flag and the
CTL_RESERVE_RANGES() macro.

Patch 4 modifies the proc_sysctl.c file to handle the
CTL_FLAGS_SHOW_RANGE in ctl_table registration and un-registration.

Patch 5 extends msgmni and shmmni to have their corresponding range
showing sysctl parameters.

Waiman Long (5):
  sysctl: Clarify how the ctl_table.flags should be set
  sysctl: Add a new handler proc_show_minmax()
  sysctl: Add a new ctl_table flag to show min/max range
  proc/sysctl: Handle CTL_FLAGS_SHOW_RANGE ctl_table flag
  ipc: Show ranges of msgmni and shmmni with CTL_FLAGS_SHOW_RANGE

 fs/proc/proc_sysctl.c  | 99 +++++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/sysctl.h | 52 +++++++++++++++++++++++++-
 ipc/ipc_sysctl.c       |  5 ++-
 kernel/sysctl.c        | 91 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 238 insertions(+), 9 deletions(-)

-- 
1.8.3.1
