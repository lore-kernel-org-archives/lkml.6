Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935130AbeEWX00 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 19:26:26 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:56728 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934671AbeEWX0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 19:26:24 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Linux Containers <containers@lists.linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>, linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 23 May 2018 18:25:33 -0500
Message-Id: <20180523232538.4880-1-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87o9h6554f.fsf@xmission.com>
References: <87o9h6554f.fsf@xmission.com>
X-XM-SPF: eid=1fLd9C-0004ID-Ux;;;mid=<20180523232538.4880-1-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19eKqJt0cpioD/yT+QSQ6u7kRu9a0uqwD4=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;Linux Containers <containers@lists.linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 564 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.0 (0.5%), b_tie_ro: 2.0 (0.4%), parse: 1.20 (0.2%),
        extract_message_metadata: 25 (4.4%), get_uri_detail_list: 2.2 (0.4%),
        tests_pri_-1000: 10 (1.8%), tests_pri_-950: 2.2 (0.4%), tests_pri_-900: 1.81
        (0.3%), tests_pri_-400: 27 (4.8%), check_bayes: 25 (4.5%), b_tokenize: 10
        (1.7%), b_tok_get_all: 6 (1.1%), b_comp_prob: 3.4 (0.6%), b_tok_touch_all:
        2.6 (0.5%), b_finish: 0.88 (0.2%), tests_pri_0: 480 (85.1%),
        check_dkim_signature: 0.81 (0.1%), check_dkim_adsp: 4.7 (0.8%),
        tests_pri_500: 9 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 1/6] vfs: Don't allow changing the link count of an inode with an invalid uid or gid
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changing the link count of an inode via unlink or link will cause a
write back of that inode.  If the uids or gids are invalid (aka not known
to the kernel) writing the inode back may change the uid or gid in the
filesystem.   To prevent possible filesystem and to avoid the need for
filesystem maintainers to worry about it don't allow operations on
inodes with an invalid uid or gid.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/namei.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 186bd2464fd5..942c1f096f6b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -984,13 +984,15 @@ static bool safe_hardlink_source(struct inode *inode)
  */
 static int may_linkat(struct path *link)
 {
-	struct inode *inode;
+	struct inode *inode = link->dentry->d_inode;
+
+	/* Inode writeback is not safe when the uid or gid are invalid. */
+	if (!uid_valid(inode->i_uid) || !gid_valid(inode->i_gid))
+		return -EOVERFLOW;
 
 	if (!sysctl_protected_hardlinks)
 		return 0;
 
-	inode = link->dentry->d_inode;
-
 	/* Source inode owner (or CAP_FOWNER) can hardlink all they like,
 	 * otherwise, it must be a safe source.
 	 */
@@ -2749,6 +2751,11 @@ static int may_delete(struct inode *dir, struct dentry *victim, bool isdir)
 	BUG_ON(!inode);
 
 	BUG_ON(victim->d_parent->d_inode != dir);
+
+	/* Inode writeback is not safe when the uid or gid are invalid. */
+	if (!uid_valid(inode->i_uid) || !gid_valid(inode->i_gid))
+		return -EOVERFLOW;
+
 	audit_inode_child(dir, victim, AUDIT_TYPE_CHILD_DELETE);
 
 	error = inode_permission(dir, MAY_WRITE | MAY_EXEC);
-- 
2.14.1
