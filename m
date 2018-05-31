Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755435AbeEaOut (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 10:50:49 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:40622 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755254AbeEaOur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 10:50:47 -0400
X-Google-Smtp-Source: ADUXVKKMhoR7Z7odOJ16DwAHcVRLrFW31ojmkB86i8PuQUfdhB2ujnJ6okdOzF3fmFdQUvGBkn256w==
From: Tycho Andersen <tycho@tycho.ws>
To: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org
Cc: Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        "Tobin C . Harding" <me@tobin.cc>, Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH v3 0/4] seccomp trap to userspace
Date: Thu, 31 May 2018 08:49:45 -0600
Message-Id: <20180531144949.24995-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's a v3 of the seccomp trap to userspace, with all the nits from v2
fixed. Open questions from v2 are still:

1. is it ok not to use netlink?
2. what should the fd passing API look like? (see patch notes on this
   one for details of why the current one might (?) be a problem)

As an added bonus, I've also written some stress testing, with lots of
tasks and listeners (1000 of each) sharing the same notification thread,
and not found any issues so far. Code is here:
https://github.com/tych0/kernel-utils/blob/master/seccomp/notify_stress.c
although I haven't included it in the patchset.

v2: https://lkml.org/lkml/2018/5/17/627

Tycho Andersen (4):
  seccomp: add a return code to trap to userspace
  seccomp: make get_nth_filter available outside of CHECKPOINT_RESTORE
  seccomp: add a way to get a listener fd from ptrace
  seccomp: add support for passing fds via USER_NOTIF

 arch/Kconfig                                  |   7 +
 include/linux/seccomp.h                       |  14 +-
 include/uapi/linux/ptrace.h                   |   2 +
 include/uapi/linux/seccomp.h                  |  20 +-
 kernel/ptrace.c                               |   4 +
 kernel/seccomp.c                              | 477 +++++++++++++++++-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 373 +++++++++++++-
 7 files changed, 889 insertions(+), 8 deletions(-)

-- 
2.17.0
