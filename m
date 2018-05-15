Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752916AbeEORjH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 13:39:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752101AbeEORjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 13:39:05 -0400
From: Waiman Long <longman@redhat.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Oleg Nesterov <oleg@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, Waiman Long <longman@redhat.com>
Subject: [PATCH v3 0/2] locking/rwsem: Fix DEBUG_RWSEM warning from thaw_super()
Date: Tue, 15 May 2018 13:38:02 -0400
Message-Id: <1526405884-4860-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
 - Modify patch 1 to not expose any new rwsem owner related function.
 - Modify patch 2 to make percpu_rwsem_release() and
   percpu_rwsem_acquire() set the owner field directly, if applicable.

This patchset aims to fix the DEBUG_RWSEM warning in the filesystem
freezing/thawing code. A new macro RWSEM_OWNER_UNKNOWN (-1) is exposed in
the linux/rwsem.h file to indicate that a rwsem is currently owned by an
unknown writer. Other than that, there is no externally visible changes.

The new RWSEM_OWNER_UNKNOWN macro has no dependency on internal rwsem
header. What is important is that bit 1 of the owner field is set which
is the marker used by the internal rwsem code to determine if the owner
is unknown or not.

The original code of clearing the owner field in percpu_rwsem_release()
isn't correct as a NULL owner field should correspond to an unlocked
rwsem which is not the case here. In addition, optimistic spinning
won't be stopped by a NULL owner value.

Testings are welcome.

Waiman Long (2):
  locking/rwsem: Add a new RWSEM_ANONYMOUSLY_OWNED flag
  locking/percpu-rwsem: Annotate rwsem ownership transfer by setting
    RWSEM_OWNER_UNKNOWN

 include/linux/percpu-rwsem.h |  6 +++++-
 include/linux/rwsem.h        |  5 +++++
 kernel/locking/rwsem-xadd.c  | 17 ++++++++---------
 kernel/locking/rwsem.c       |  5 ++---
 kernel/locking/rwsem.h       | 33 ++++++++++++++++++++++++---------
 5 files changed, 44 insertions(+), 22 deletions(-)

-- 
1.8.3.1
