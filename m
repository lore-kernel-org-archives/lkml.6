Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750917AbeCHVYI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 16:24:08 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:48907 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbeCHVYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 16:24:06 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org,
        <linux-fsdevel@vger.kernel.org>, Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>, Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <cover.1512741134.git.dongsu@kinvolk.io>
        <878tbmf5vl.fsf@xmission.com> <87po4rz4ui.fsf_-_@xmission.com>
        <87r2p287i8.fsf_-_@xmission.com>
Date: Thu, 08 Mar 2018 15:23:23 -0600
In-Reply-To: <87r2p287i8.fsf_-_@xmission.com> (Eric W. Biederman's message of
        "Fri, 02 Mar 2018 15:58:23 -0600")
Message-ID: <87ina6ntx0.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1eu31A-0005lW-S3;;;mid=<87ina6ntx0.fsf_-_@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18BsDmYrUi0OoPnQewiO1TFQoQ1X2wqqkw=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 179 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.9 (2.7%), b_tie_ro: 3.9 (2.2%), parse: 0.62 (0.3%),
        extract_message_metadata: 2.5 (1.4%), get_uri_detail_list: 1.16 (0.6%),
        tests_pri_-1000: 2.9 (1.6%), tests_pri_-950: 1.10 (0.6%), tests_pri_-900:
        0.89 (0.5%), tests_pri_-400: 21 (11.9%), check_bayes: 20 (11.4%), b_tokenize:
        5 (2.9%), b_tok_get_all: 7 (4.1%), b_comp_prob: 1.95 (1.1%), b_tok_touch_all:
        3.5 (1.9%), b_finish: 0.68 (0.4%), tests_pri_0: 136 (75.7%),
        check_dkim_signature: 0.39 (0.2%), check_dkim_adsp: 2.7 (1.5%),
        tests_pri_500: 3.6 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v9 0/4] fuse: mounts from non-init user namespaces
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

Since v8 I have:
- Dropped and postponed the unification of the uncached and the cached
  posix acls case.  The code is not hard but tricky enough it needs
  to be considered on it's own on it's own merits.

Miklos can you take a look and see what you think?

Miklos if you could pick these up I would appreciate it.  If not I can
merge these through the userns tree.

These changes are also available at:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git userns-fuse-v9

Eric W. Biederman (3):
      fuse: Remove the buggy retranslation of pids in fuse_dev_do_read
      fuse: Fail all requests with invalid uids or gids
      fuse: Support fuse filesystems outside of init_user_ns

Seth Forshee (1):
      fuse: Restrict allow_other to the superblock's namespace or a descendant

 fs/fuse/acl.c           |  4 ++--
 fs/fuse/cuse.c          |  7 ++++++-
 fs/fuse/dev.c           | 30 +++++++++++++++++-------------
 fs/fuse/dir.c           | 16 ++++++++--------
 fs/fuse/fuse_i.h        |  6 +++++-
 fs/fuse/inode.c         | 31 +++++++++++++++++++------------
 kernel/user_namespace.c |  1 +
 7 files changed, 58 insertions(+), 37 deletions(-)
