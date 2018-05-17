Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeEQPMu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 11:12:50 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39878 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbeEQPMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 11:12:49 -0400
X-Google-Smtp-Source: AB8JxZpzVlf/Zohy7woVJ2eTp7GwY9LQxQv+XvkbjkFN6MtBFz2XGZw6tfhLxPEHsVl7w9NAJl0hHw==
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
Subject: [PATCH v2 0/4] seccomp trap to userspace
Date: Thu, 17 May 2018 09:12:14 -0600
Message-Id: <20180517151218.12850-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After a while focusing on other things, I finally managed ot get a v2 of
this series prepared. I believe I've addressed all the feedback from v1,
except for one major point: switching the communication protocol over
the fd to nlattr. I looked into doing this, but the kernel stuff for
dealing with nlattr seems to require an skb (via nlmsg_{new,put} and
netlink_unicast), which means we need to deal with the netlink sequence
numbers, portids, and create a socket protocol. I can do this if we
still think nlattr is necessary, but based on looking at it, it seems
like a lot of extra code for no real benefit.

I've also added support for passing fds. The code itself is simple, but
the API could/should probably be different, see patch 4 for discussion.

Tycho

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
 kernel/seccomp.c                              | 480 +++++++++++++++++-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 359 ++++++++++++-
 7 files changed, 878 insertions(+), 8 deletions(-)

-- 
2.17.0
