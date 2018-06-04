Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751688AbeFDDpK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 23:45:10 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:54066 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbeFDDpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 23:45:08 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>
Date: Sun, 03 Jun 2018 22:45:01 -0500
Message-ID: <878t7vp64i.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fPgQd-0008Dq-4b;;;mid=<878t7vp64i.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+BkLaQZKl0murUv8AxUwIlHIbl4S8j1C4=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 203 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.3 (1.6%), b_tie_ro: 2.3 (1.1%), parse: 0.82 (0.4%),
        extract_message_metadata: 3.3 (1.6%), get_uri_detail_list: 1.49 (0.7%),
        tests_pri_-1000: 3.5 (1.7%), tests_pri_-950: 1.18 (0.6%), tests_pri_-900:
        0.96 (0.5%), tests_pri_-400: 18 (8.7%), check_bayes: 17 (8.2%), b_tokenize: 5
        (2.5%), b_tok_get_all: 5 (2.7%), b_comp_prob: 1.76 (0.9%), b_tok_touch_all:
        2.5 (1.2%), b_finish: 0.62 (0.3%), tests_pri_0: 158 (77.9%),
        check_dkim_signature: 0.42 (0.2%), check_dkim_adsp: 24 (11.8%),
        tests_pri_500: 5 (2.7%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] userns 
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the userns-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git userns-linus

   HEAD: f3f1a18330ac1b717cd7a32adff38d965f365aa2 fs: Allow CAP_SYS_ADMIN in s_user_ns to freeze and thaw filesystems

This is the last couple of vfs bits to enable root in a user namespace
to mount and manipulate a filesystem with backing store (AKA not a
virtual filesystem like proc, but a filesystem where the unprivileged
user controls the content).   The target filesystem for this work
is fuse, and Miklos should be sending you the pull request for the
fuse bits this merge window.

The two key patches are " evm: Don't update hmacs in user ns mounts" and
"vfs: Don't allow changing the link count of an inode with an invalid
uid or gid".  Those close small gaps in the vfs that would be a problem
if an unprivileged fuse filesystem is mounted.

The rest of the changes are things that are now safe to allow a root
user in a user namespace to do with a filesystem they have mounted.  The
most interesting development is that remount is now safe.

Eric W. Biederman (5):
      vfs: Don't allow changing the link count of an inode with an invalid uid or gid
      vfs: Allow userns root to call mknod on owned filesystems.
      fs: Allow superblock owner to replace invalid owners of inodes
      fs: Allow superblock owner to access do_remount_sb()
      capabilities: Allow privileged user in s_user_ns to set security.* xattrs

Seth Forshee (2):
      evm: Don't update hmacs in user ns mounts
      fs: Allow CAP_SYS_ADMIN in s_user_ns to freeze and thaw filesystems

Eric
