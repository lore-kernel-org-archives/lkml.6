Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753278AbeBSQyY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:54:24 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753012AbeBSQyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:54:22 -0500
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Waiman Long <longman@redhat.com>
Subject: [PATCH 0/3] ipc: Clamp msgmni and shmmni to the real IPC_MNI limit
Date: Mon, 19 Feb 2018 11:53:48 -0500
Message-Id: <1519059231-2456-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sysctl parameters msgmni and shmmni have an inherent limit of
IPC_MNI (32k). However, users may not be aware of that because they
can write a value much higher than that without getting any error or
notification. Reading the parameters back will show the newly written
values which are not real.

Enforcing the limit by failing sysctl parameter write, however,
can break existing user applications. To address this delemma, the
following new sysctl range clamping APIs are added:
  - proc_dointvec_clamp_minmax()
  - proc_douintvec_clamp_minmax()

This new set of APIs is then used to set the real limit for msgmni and
shmmni without breaking existing applications. If any out of range
value is written to those sysctl parameters, the following warning
will be printed instead.

  Kernel parameter "shmmni" was set out of range [0, 32768], clamped to 32768.

Reading the values back will show 32768 instead of some fake values.

Waiman Long (3):
  sysctl: Add range clamping intvec helper functions
  sysctl: Warn when a clamped sysctl parameter is set out of range
  ipc: Clamp msgmni and shmmni to the real IPC_MNI limit

 include/linux/sysctl.h |   6 +++
 ipc/ipc_sysctl.c       |  10 ++--
 kernel/sysctl.c        | 123 ++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 129 insertions(+), 10 deletions(-)

-- 
1.8.3.1
