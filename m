Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbeDXXsX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 19:48:23 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:33980 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeDXXsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 19:48:21 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Date: Tue, 24 Apr 2018 18:46:40 -0500
Message-ID: <87k1sww4kf.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fB7fI-0000CI-Ng;;;mid=<87k1sww4kf.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+GNo6rElbfctgrk/kHUzhHq9ffO/6UBZo=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_12 obfuscated drug references
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  1.0 T_XMDrugObfuBody_04 obfuscated drug references
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15039 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.0 (0.0%), b_tie_ro: 2.1 (0.0%), parse: 0.96 (0.0%),
        extract_message_metadata: 24 (0.2%), get_uri_detail_list: 2.9 (0.0%),
        tests_pri_-1000: 2.9 (0.0%), tests_pri_-950: 1.15 (0.0%), tests_pri_-900:
        0.96 (0.0%), tests_pri_-400: 21 (0.1%), check_bayes: 20 (0.1%), b_tokenize: 6
        (0.0%), b_tok_get_all: 7 (0.0%), b_comp_prob: 1.96 (0.0%), b_tok_touch_all:
        3.3 (0.0%), b_finish: 0.63 (0.0%), tests_pri_0: 128 (0.9%),
        check_dkim_signature: 0.55 (0.0%), check_dkim_adsp: 2.9 (0.0%),
        tests_pri_500: 14854 (98.8%), poll_dns_idle: 14839 (98.7%), rewrite_mail:
        0.00 (0.0%)
Subject: [GIT PULL] userns bug fix for 4.17-rc3
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the userns-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git userns-linus

   HEAD: 1f5781725dcbb026438e77091c91a94f678c3522 commoncap: Handle memory allocation failure

Just a small fix to properly set the return code on error.

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Tue, 10 Apr 2018 15:15:16 +0900
Subject: [PATCH] commoncap: Handle memory allocation failure.

syzbot is reporting NULL pointer dereference at xattr_getsecurity() [1],
for cap_inode_getsecurity() is returning sizeof(struct vfs_cap_data) when
memory allocation failed. Return -ENOMEM if memory allocation failed.

[1] https://syzkaller.appspot.com/bug?id=a55ba438506fe68649a5f50d2d82d56b365e0107

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: 8db6c34f1dbc8e06 ("Introduce v3 namespaced file capabilities")
Reported-by: syzbot <syzbot+9369930ca44f29e60e2d@syzkaller.appspotmail.com>
Cc: stable <stable@vger.kernel.org> # 4.14+
Acked-by: Serge E. Hallyn <serge@hallyn.com>
Acked-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 security/commoncap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/commoncap.c b/security/commoncap.c
index 48620c93d697..1ce701fcb3f3 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -449,6 +449,8 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
 				magic |= VFS_CAP_FLAGS_EFFECTIVE;
 			memcpy(&cap->data, &nscap->data, sizeof(__le32) * 2 * VFS_CAP_U32);
 			cap->magic_etc = cpu_to_le32(magic);
+		} else {
+			size = -ENOMEM;
 		}
 	}
 	kfree(tmpbuf);
-- 
2.14.1
