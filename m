Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932605AbeCBV7D (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 16:59:03 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:49899 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932569AbeCBV7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 16:59:01 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org,
        <linux-fsdevel@vger.kernel.org>, Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>, Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <cover.1512741134.git.dongsu@kinvolk.io>
        <878tbmf5vl.fsf@xmission.com> <87po4rz4ui.fsf_-_@xmission.com>
Date: Fri, 02 Mar 2018 15:58:23 -0600
In-Reply-To: <87po4rz4ui.fsf_-_@xmission.com> (Eric W. Biederman's message of
        "Mon, 26 Feb 2018 17:52:21 -0600")
Message-ID: <87r2p287i8.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ershe-0006lJ-RE;;;mid=<87r2p287i8.fsf_-_@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+s5wLDADP7mLWQABM5LCRr53Gr5EqmRkY=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1239 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 6 (0.5%), b_tie_ro: 4.8 (0.4%), parse: 1.08 (0.1%),
        extract_message_metadata: 4.4 (0.4%), get_uri_detail_list: 2.3 (0.2%),
        tests_pri_-1000: 3.2 (0.3%), tests_pri_-950: 1.31 (0.1%), tests_pri_-900:
        1.07 (0.1%), tests_pri_-400: 24 (1.9%), check_bayes: 22 (1.8%), b_tokenize: 7
        (0.6%), b_tok_get_all: 7 (0.6%), b_comp_prob: 2.3 (0.2%), b_tok_touch_all:
        3.1 (0.3%), b_finish: 0.65 (0.1%), tests_pri_0: 1185 (95.6%),
        check_dkim_signature: 0.51 (0.0%), check_dkim_adsp: 2.4 (0.2%),
        tests_pri_500: 4.8 (0.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v8 0/6] fuse: mounts from non-init user namespaces
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patchset builds on the work by Donsu Park and Seth Forshee and is
reduced to the set of patches that just affect fuse.  The non-fuse
vfs patches are far enough along we can ignore them except possibly for the
question of when does FS_USERNS_MOUNT get set in fuse_fs_type.

Fuse with a block device has been left as an exercise for a later time.

Since v5 I changed the core of this patchset around as the previous
patches were showing signs of bitrot.  Some important explanations were
missing, some important functionality was missing, and xattr handling
was completely absent.

Since v6 I have:
- Removed the failure case from fuse_get_req_nofail_nopages that I
  added.
- Updated fuse to always to use posix_acl_access_xattr_handler, and
  posix_acl_default_xattr_handler, by teaching fuse to set
  ACL_DONT_CACHE when FUSE_POSIX_ACL is not set.

Since v7 I have:
- Rethought and reworked how I am unifying the cached and the non-cached
  posix acl case so the code is cleaner and simpler.
  - I have dropped enhancements to caching negative acls when
    fc->no_getxattr is set.
  - Removed the need to wrap forget_all_cached_acls in fuse.
- Reorder the patches so the posix acl work comes first

Miklos can you take a look and see what you think?

I think this much of the fuse changes are ready, and as such I would
like to get them in this development cycle if possible.

These changes are also available at:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git userns-fuse-v8

Eric W. Biederman (5):
      fs/posix_acl: Update the comments and support lightweight cache skipping
      fuse: Simplfiy the posix acl handling logic.
      fuse: Remove the buggy retranslation of pids in fuse_dev_do_read
      fuse: Fail all requests with invalid uids or gids
      fuse: Support fuse filesystems outside of init_user_ns

Seth Forshee (1):
      fuse: Restrict allow_other to the superblock's namespace or a descendant


 fs/fuse/acl.c             | 10 ++++++----
 fs/fuse/cuse.c            |  7 ++++++-
 fs/fuse/dev.c             | 30 ++++++++++++++++------------
 fs/fuse/dir.c             | 18 ++++++++---------
 fs/fuse/fuse_i.h          |  9 ++++++---
 fs/fuse/inode.c           | 34 +++++++++++++++++++-------------
 fs/fuse/xattr.c           |  5 -----
 fs/posix_acl.c            | 50 ++++++++++++++++++++++++++++++++---------------
 include/linux/posix_acl.h | 17 ++++++++++++++++
 kernel/user_namespace.c   |  1 +
 10 files changed, 116 insertions(+), 65 deletions(-)
