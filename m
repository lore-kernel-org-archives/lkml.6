Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbeBUUZB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:25:01 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:50725 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbeBUUY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:24:59 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org,
        <linux-fsdevel@vger.kernel.org>, Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>, Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <cover.1512741134.git.dongsu@kinvolk.io>
Date: Wed, 21 Feb 2018 14:24:30 -0600
In-Reply-To: <cover.1512741134.git.dongsu@kinvolk.io> (Dongsu Park's message
        of "Fri, 22 Dec 2017 15:32:24 +0100")
Message-ID: <878tbmf5vl.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1eoawj-0001dF-1H;;;mid=<878tbmf5vl.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+jcfQKZdGS5vlztOY2WkGdzhKKMfacnjQ=
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
X-Spam-Timing: total 197 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.5 (1.8%), b_tie_ro: 2.5 (1.3%), parse: 0.80 (0.4%),
        extract_message_metadata: 3.1 (1.6%), get_uri_detail_list: 1.33 (0.7%),
        tests_pri_-1000: 4.0 (2.0%), tests_pri_-950: 1.24 (0.6%), tests_pri_-900:
        1.04 (0.5%), tests_pri_-400: 22 (11.2%), check_bayes: 21 (10.7%), b_tokenize:
        6 (3.2%), b_tok_get_all: 7 (3.7%), b_comp_prob: 2.4 (1.2%), b_tok_touch_all:
        2.9 (1.5%), b_finish: 0.60 (0.3%), tests_pri_0: 150 (76.1%),
        check_dkim_signature: 0.48 (0.2%), check_dkim_adsp: 2.8 (1.4%),
        tests_pri_500: 3.7 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v6 0/6] fuse: mounts from non-init user namespaces
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

I had to change the core of this patchset around some as the previous
patches were showing signs of bitrot.  Some important explanations were
missing, some important functionality was missing, and xattr handling
was completely absent.

Miklos can you take a look and see what you think?

I think this much of the fuse changes are ready, and as such I would
like to get them in this development cycle if possible.

My apologies if I have lost someone's ack or review somewhere.  Let me
know and I will fix it.

These changes are also available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git userns-fuse-v6
  
Eric W. Biederman (4):
      fuse: Remove the buggy retranslation of pids in fuse_dev_do_read
      fuse: Fail all requests with invalid uids or gids
      fuse: Support fuse filesystems outside of init_user_ns
      fuse: Ensure posix acls are translated outside of init_user_ns

Seth Forshee (1):
      fuse: Restrict allow_other to the superblock's namespace or a descendant

 fs/fuse/acl.c           |  4 ++--
 fs/fuse/cuse.c          |  7 ++++++-
 fs/fuse/dev.c           | 26 +++++++++++++-------------
 fs/fuse/dir.c           | 16 ++++++++--------
 fs/fuse/fuse_i.h        |  7 ++++++-
 fs/fuse/inode.c         | 38 ++++++++++++++++++++++++++------------
 fs/fuse/xattr.c         | 43 +++++++++++++++++++++++++++++++++++++++++++
 kernel/user_namespace.c |  1 +
 8 files changed, 105 insertions(+), 37 deletions(-)

Eric
