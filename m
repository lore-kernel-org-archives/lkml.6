Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbeBZXw5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 18:52:57 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:36991 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeBZXw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 18:52:56 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org,
        <linux-fsdevel@vger.kernel.org>, Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>, Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <cover.1512741134.git.dongsu@kinvolk.io>
        <878tbmf5vl.fsf@xmission.com>
Date: Mon, 26 Feb 2018 17:52:21 -0600
In-Reply-To: <878tbmf5vl.fsf@xmission.com> (Eric W. Biederman's message of
        "Wed, 21 Feb 2018 14:24:30 -0600")
Message-ID: <87po4rz4ui.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1eqSZh-0004f2-4Y;;;mid=<87po4rz4ui.fsf_-_@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18vo70VSKMXeRayPK8eJxrUWOV8taSsguk=
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
X-Spam-Timing: total 214 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.2 (1.5%), b_tie_ro: 2.1 (1.0%), parse: 1.05 (0.5%),
        extract_message_metadata: 3.6 (1.7%), get_uri_detail_list: 1.64 (0.8%),
        tests_pri_-1000: 3.9 (1.8%), tests_pri_-950: 1.14 (0.5%), tests_pri_-900:
        0.97 (0.5%), tests_pri_-400: 23 (10.6%), check_bayes: 22 (10.1%), b_tokenize:
        6 (2.9%), b_tok_get_all: 9 (4.1%), b_comp_prob: 1.97 (0.9%), b_tok_touch_all:
        2.8 (1.3%), b_finish: 0.63 (0.3%), tests_pri_0: 163 (76.4%),
        check_dkim_signature: 0.62 (0.3%), check_dkim_adsp: 2.5 (1.2%),
        tests_pri_500: 6 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v7 0/7] fuse: mounts from non-init user namespaces
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patchset builds on the work by Donsu Park and Seth Forshee and is
reduced to the set of patches that just affect fuse.  The non-fuse
patches are far enough along we can ignore them except possibly for the
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

Miklos can you take a look and see what you think?

I think this much of the fuse changes are ready, and as such I would
like to get them in this development cycle if possible.

These changes are also available at:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git userns-fuse-v7

Eric W. Biederman (6):
      fuse: Remove the buggy retranslation of pids in fuse_dev_do_read
      fuse: Fail all requests with invalid uids or gids
      fs/posix_acl: Document that get_acl respects ACL_DONT_CACHE
      fuse: Cache a NULL acl when FUSE_GETXATTR returns -ENOSYS
      fuse: Simplfiy the posix acl handling logic.
      fuse: Support fuse filesystems outside of init_user_ns

Seth Forshee (1):
      fuse: Restrict allow_other to the superblock's namespace or a descendant

 fs/fuse/acl.c           | 10 +++++-----
 fs/fuse/cuse.c          |  7 ++++++-
 fs/fuse/dev.c           | 30 +++++++++++++++++-------------
 fs/fuse/dir.c           | 27 +++++++++++++--------------
 fs/fuse/fuse_i.h        | 11 ++++++++---
 fs/fuse/inode.c         | 44 +++++++++++++++++++++++++++++---------------
 fs/fuse/xattr.c         |  6 +-----
 fs/posix_acl.c          |  7 +++++--
 kernel/user_namespace.c |  1 +
 9 files changed, 85 insertions(+), 58 deletions(-)

Eric
