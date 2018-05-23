Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935180AbeEWX0z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 19:26:55 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:48370 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935144AbeEWX0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 19:26:47 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Linux Containers <containers@lists.linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>, linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 23 May 2018 18:25:36 -0500
Message-Id: <20180523232538.4880-4-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87o9h6554f.fsf@xmission.com>
References: <87o9h6554f.fsf@xmission.com>
X-XM-SPF: eid=1fLd9a-0004ID-DJ;;;mid=<20180523232538.4880-4-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+ox6BYEU36ruf3Jktpvotef8Xvub+1C4Q=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Linux Containers <containers@lists.linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 209 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 3.8 (1.8%), b_tie_ro: 2.6 (1.3%), parse: 1.30 (0.6%),
        extract_message_metadata: 22 (10.3%), get_uri_detail_list: 2.2 (1.1%),
        tests_pri_-1000: 11 (5.4%), tests_pri_-950: 1.65 (0.8%), tests_pri_-900: 1.31
        (0.6%), tests_pri_-400: 20 (9.7%), check_bayes: 19 (9.1%), b_tokenize: 7
        (3.4%), b_tok_get_all: 5 (2.6%), b_comp_prob: 2.0 (1.0%), b_tok_touch_all:
        2.5 (1.2%), b_finish: 0.64 (0.3%), tests_pri_0: 139 (66.5%),
        check_dkim_signature: 0.51 (0.2%), check_dkim_adsp: 5.0 (2.4%),
        tests_pri_500: 4.4 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 4/6] fs: Allow superblock owner to access do_remount_sb()
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Superblock level remounts are currently restricted to global
CAP_SYS_ADMIN, as is the path for changing the root mount to
read only on umount. Loosen both of these permission checks to
also allow CAP_SYS_ADMIN in any namespace which is privileged
towards the userns which originally mounted the filesystem.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Acked-by: Serge Hallyn <serge.hallyn@canonical.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/namespace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 5f75969adff1..8ddd14806799 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1590,7 +1590,7 @@ static int do_umount(struct mount *mnt, int flags)
 		 * Special case for "unmounting" root ...
 		 * we just try to remount it readonly.
 		 */
-		if (!capable(CAP_SYS_ADMIN))
+		if (!ns_capable(sb->s_user_ns, CAP_SYS_ADMIN))
 			return -EPERM;
 		down_write(&sb->s_umount);
 		if (!sb_rdonly(sb))
@@ -2333,7 +2333,7 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
 	down_write(&sb->s_umount);
 	if (ms_flags & MS_BIND)
 		err = change_mount_flags(path->mnt, ms_flags);
-	else if (!capable(CAP_SYS_ADMIN))
+	else if (!ns_capable(sb->s_user_ns, CAP_SYS_ADMIN))
 		err = -EPERM;
 	else
 		err = do_remount_sb(sb, sb_flags, data, 0);
-- 
2.14.1
