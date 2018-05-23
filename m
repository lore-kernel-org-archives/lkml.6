Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935142AbeEWX0n (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 19:26:43 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:56739 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934671AbeEWX0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 19:26:41 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Linux Containers <containers@lists.linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>, linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 23 May 2018 18:25:34 -0500
Message-Id: <20180523232538.4880-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87o9h6554f.fsf@xmission.com>
References: <87o9h6554f.fsf@xmission.com>
X-XM-SPF: eid=1fLd9F-0004ID-Kh;;;mid=<20180523232538.4880-2-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+fAn2sq8mnivDR6zl//L8yQoi6KgBI1lU=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Linux Containers <containers@lists.linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15022 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.7 (0.0%), b_tie_ro: 1.91 (0.0%), parse: 0.74 (0.0%),
        extract_message_metadata: 9 (0.1%), get_uri_detail_list: 0.69 (0.0%),
        tests_pri_-1000: 2.8 (0.0%), tests_pri_-950: 1.15 (0.0%), tests_pri_-900:
        0.97 (0.0%), tests_pri_-400: 17 (0.1%), check_bayes: 16 (0.1%), b_tokenize: 6
        (0.0%), b_tok_get_all: 4.8 (0.0%), b_comp_prob: 1.43 (0.0%), b_tok_touch_all:
        2.3 (0.0%), b_finish: 0.58 (0.0%), tests_pri_0: 106 (0.7%),
        check_dkim_signature: 0.42 (0.0%), check_dkim_adsp: 3.3 (0.0%),
        tests_pri_500: 14880 (99.1%), poll_dns_idle: 14869 (99.0%), rewrite_mail:
        0.00 (0.0%)
Subject: [REVIEW][PATCH 2/6] vfs: Allow userns root to call mknod on owned filesystems.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These filesystems already always set SB_I_NODEV so mknod will not be
useful for gaining control of any devices no matter their permissions.
This will allow overlayfs and applications to fakeroot to use device
nodes to represent things on disk.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/namei.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 942c1f096f6b..20335896dcce 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3679,7 +3679,8 @@ int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
 	if (error)
 		return error;
 
-	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD))
+	if ((S_ISCHR(mode) || S_ISBLK(mode)) &&
+	    !ns_capable(dentry->d_sb->s_user_ns, CAP_MKNOD))
 		return -EPERM;
 
 	if (!dir->i_op->mknod)
-- 
2.14.1
