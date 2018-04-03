Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752650AbeDCTRQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 15:17:16 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:51309 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeDCTRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 15:17:15 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <james.morris@microsoft.com>
Date: Tue, 03 Apr 2018 14:16:04 -0500
Message-ID: <87k1tonlsb.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f3RQe-0002Cz-FA;;;mid=<87k1tonlsb.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=67.3.145.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+s6X6vcpNTmIGN5lZ5EDSgbJjCaJWlgak=
X-SA-Exim-Connect-IP: 67.3.145.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 749 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.2 (0.4%), b_tie_ro: 2.2 (0.3%), parse: 1.21 (0.2%),
        extract_message_metadata: 7 (1.0%), get_uri_detail_list: 4.5 (0.6%),
        tests_pri_-1000: 6 (0.8%), tests_pri_-950: 2.2 (0.3%), tests_pri_-900: 1.74
        (0.2%), tests_pri_-400: 41 (5.5%), check_bayes: 39 (5.2%), b_tokenize: 15
        (2.1%), b_tok_get_all: 11 (1.4%), b_comp_prob: 6 (0.7%), b_tok_touch_all: 3.4
        (0.4%), b_finish: 0.87 (0.1%), tests_pri_0: 656 (87.6%),
        check_dkim_signature: 0.87 (0.1%), check_dkim_adsp: 5 (0.7%), tests_pri_500:
        9 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] namespace changes for 4.17-rc1
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the userns-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git userns-linus

   HEAD: 2236d4d39035b9839944603ec4b65ce71180a9ea ipc/shm: Fix pid freeing.

There was a lot of work this cycle fixing bugs that were discovered after
the merge window and getting everything ready where we can reasonably
support fully unprivileged fuse.   The bug fixes you already have and
much of the unprivileged fuse work is coming in via other trees.

Still left for fully unprivileged fuse is figuring out how to cleanly
handle .set_acl and .get_acl in the legacy case, and properly handling
of evm xattrs on unprivileged mounts.

Included in the tree is a cleanup from Alexely that replaced a linked
list with a statically allocated fix sized array for the pid caches,
which simplifies and speeds things up.

Then there is are some cleanups and fixes for the ipc namespace.  The
motivation was that in reviewing other code it was discovered that
access ipc objects from different pid namespaces recorded pids in such a
way that when asked the wrong pids were returned.  In the worst case
there has been a mearsured 30% performance impact for sysvipc
semaphores.  Other test cases showed no measurable performance impact.
Manfred Spraul and Davidlohr Bueso who tend to work on sysvipc
performance both gave the nod that this is good enough.

Casey Schaufler and James Morris have given their approval to the LSM
side of the changes.

I simplified the types and the code dealing with sysvipc to pass just
kern_ipc_perm for all three types of ipc.  Which reduced the header
dependencies throughout the kernel and simplified the lsm code.

Which let me work on the pid fixes without having to worry about trivial
changes causing complete kernel recompiles.

When merging you may see a trivial conflict with the syscalls tree
where adjacent lines in the sysvipc code were touched.

Alexey Dobriyan (1):
      pidns: simpler allocation of pid_* caches

Eric W. Biederman (14):
      sem/security: Pass kern_ipc_perm not sem_array into the sem security hooks
      shm/security: Pass kern_ipc_perm not shmid_kernel into the shm security hooks
      msg/security: Pass kern_ipc_perm not msg_queue into the msg_queue security hooks
      sem: Move struct sem and struct sem_array into ipc/sem.c
      shm: Move struct shmid_kernel into ipc/shm.c
      msg: Move struct msg_queue into ipc/msg.c
      ipc: Move IPCMNI from include/ipc.h into ipc/util.h
      ipc/util: Helpers for making the sysvipc operations pid namespace aware
      ipc/shm: Fix shmctl(..., IPC_STAT, ...) between pid namespaces.
      ipc/msg: Fix msgctl(..., IPC_STAT, ...) between pid namespaces
      ipc/sem: Fix semctl(..., GETPID, ...) between pid namespaces
      ipc: Directly call the security hook in ipc_ops.associate
      ipc/smack: Tidy up from the change in type of the ipc security hooks
      ipc/shm: Fix pid freeing.

Stephen Rothwell (1):
      ipc/shm: fix up for struct file no longer being available in shm.h

 include/linux/ipc.h        |   2 -
 include/linux/lsm_hooks.h  |  32 ++++----
 include/linux/msg.h        |  18 -----
 include/linux/security.h   |  67 ++++++++-------
 include/linux/sem.h        |  40 +--------
 include/linux/shm.h        |  22 +----
 ipc/msg.c                  |  62 ++++++++------
 ipc/sem.c                  |  81 ++++++++++++-------
 ipc/shm.c                  |  68 ++++++++++------
 ipc/util.c                 |   9 +++
 ipc/util.h                 |  12 +++
 kernel/pid_namespace.c     |  67 ++++++---------
 security/security.c        |  32 ++++----
 security/selinux/hooks.c   |  92 ++++++++++-----------
 security/smack/smack_lsm.c | 197 +++++++++++++--------------------------------
 15 files changed, 346 insertions(+), 455 deletions(-)
