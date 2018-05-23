Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935082AbeEWXXJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 19:23:09 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:47865 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934671AbeEWXXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 19:23:07 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linux Containers <containers@lists.linux-foundation.org>
Cc: <linux-fsdevel@vger.kernel.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        <linux-kernel@vger.kernel.org>
Date: Wed, 23 May 2018 18:22:56 -0500
Message-ID: <87o9h6554f.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fLd5z-0005QO-VP;;;mid=<87o9h6554f.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18gA29VGk1RUOs/zesLWKoUnvF0aKxl7N8=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Linux Containers <containers@lists.linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 445 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.1 (0.7%), b_tie_ro: 2.1 (0.5%), parse: 1.20 (0.3%),
        extract_message_metadata: 5 (1.1%), get_uri_detail_list: 2.5 (0.6%),
        tests_pri_-1000: 5 (1.1%), tests_pri_-950: 2.2 (0.5%), tests_pri_-900: 1.62
        (0.4%), tests_pri_-400: 29 (6.5%), check_bayes: 27 (6.1%), b_tokenize: 10
        (2.3%), b_tok_get_all: 7 (1.5%), b_comp_prob: 4.3 (1.0%), b_tok_touch_all:
        2.7 (0.6%), b_finish: 0.82 (0.2%), tests_pri_0: 370 (83.1%),
        check_dkim_signature: 0.80 (0.2%), check_dkim_adsp: 6 (1.4%), tests_pri_500:
        6 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 0/6] Wrapping up the vfs support for unprivileged mounts
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Very slowly the work has been progressing to ensure the vfs has the
necessary support for mounting filesystems without privilege.

This patchset contains one more core piece of that work, ensuring a few
more operations that would write back an inode and confuse an exisiting
filesystem are denied.

The rest of the changes actually enable userns root to do things with
filesystems that the userns root has mounted.  Most of these have been
waiting in the wings a long time, held back because I wanted the core
of the patchset to be solid before I started allowing additional
behavor.

It is definitely time for these changes so the effect of s_user_ns
becomes less theoretical.

The change to allow mknod is new, but consistent with everything else
and harmless as device nodes on filesystems mounted without privilege
are ignored.

Unless problems show up in the during review I plan to merge these changes.

These changes are also available at:
  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git userns-test

Eric W. Biederman (5):
      vfs: Don't allow changing the link count of an inode with an invalid uid or gid
      vfs: Allow userns root to call mknod on owned filesystems.
      fs: Allow superblock owner to replace invalid owners of inodes
      fs: Allow superblock owner to access do_remount_sb()
      capabilities: Allow privileged user in s_user_ns to set security.* xattrs

Seth Forshee (1):
      fs: Allow CAP_SYS_ADMIN in s_user_ns to freeze and thaw filesystems

 fs/attr.c            | 36 ++++++++++++++++++++++++++++--------
 fs/ioctl.c           |  4 ++--
 fs/namei.c           | 16 ++++++++++++----
 fs/namespace.c       |  4 ++--
 security/commoncap.c |  8 ++++++--
 5 files changed, 50 insertions(+), 18 deletions(-)

Eric
