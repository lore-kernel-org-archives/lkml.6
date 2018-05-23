Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935191AbeEWXln (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 19:41:43 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:49855 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935015AbeEWXlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 19:41:40 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linux Containers <containers@lists.linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>, linux-kernel@vger.kernel.org
References: <87o9h6554f.fsf@xmission.com>
        <20180523232538.4880-3-ebiederm@xmission.com>
Date: Wed, 23 May 2018 18:41:29 -0500
In-Reply-To: <20180523232538.4880-3-ebiederm@xmission.com> (Eric
        W. Biederman's message of "Wed, 23 May 2018 18:25:35 -0500")
Message-ID: <87bmd6549i.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fLdNx-0006Lt-8b;;;mid=<87bmd6549i.fsf_-_@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+e5/KwyvILWLBIc+aryMSwj8fEFaC69pg=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linux Containers <containers@lists.linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1825 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.4 (0.2%), b_tie_ro: 2.3 (0.1%), parse: 1.44 (0.1%),
        extract_message_metadata: 32 (1.8%), get_uri_detail_list: 5 (0.3%),
        tests_pri_-1000: 14 (0.8%), tests_pri_-950: 2.0 (0.1%), tests_pri_-900: 1.66
        (0.1%), tests_pri_-400: 43 (2.3%), check_bayes: 41 (2.2%), b_tokenize: 17
        (1.0%), b_tok_get_all: 10 (0.6%), b_comp_prob: 6 (0.3%), b_tok_touch_all: 3.2
        (0.2%), b_finish: 0.76 (0.0%), tests_pri_0: 1716 (94.0%),
        check_dkim_signature: 0.90 (0.0%), check_dkim_adsp: 7 (0.4%), tests_pri_500:
        7 (0.4%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH v2 3/6] fs: Allow superblock owner to replace invalid owners of inodes
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Allow users with CAP_SYS_CHOWN over the superblock of a filesystem to
chown files when inode owner is invalid.  Ordinarily the
capable_wrt_inode_uidgid check is sufficient to allow access to files
but when the underlying filesystem has uids or gids that don't map to
the current user namespace it is not enough, so the chown permission
checks need to be extended to allow this case.

Calling chown on filesystem nodes whose uid or gid don't map is
necessary if those nodes are going to be modified as writing back
inodes which contain uids or gids that don't map is likely to cause
filesystem corruption of the uid or gid fields.

Once chown has been called the existing capable_wrt_inode_uidgid
checks are sufficient to allow the owner of a superblock to do anything
the global root user can do with an appropriate set of capabilities.

An ordinary filesystem mountable by a userns root will limit all uids
and gids in s_user_ns or the INVALID_UID and INVALID_GID to flag all
others.  So having this added permission limited to just INVALID_UID
and INVALID_GID is sufficient to handle every case on an ordinary filesystem.

Of the virtual filesystems at least proc is known to set s_user_ns to
something other than &init_user_ns, while at the same time presenting
some files owned by GLOBAL_ROOT_UID.  Those files the mounter of proc
in a user namespace should not be able to chown to get access to.
Limiting the relaxation in permission to just the minimum of allowing
changing INVALID_UID and INVALID_GID prevents problems with cases like
that.

The original version of this patch was written by: Seth Forshee.  I
have rewritten and rethought this patch enough so it's really not the
same thing (certainly it needs a different description), but he
deserves credit for getting out there and getting the conversation
started, and finding the potential gotcha's and putting up with my
semi-paranoid feedback.

Inspired-by: Seth Forshee <seth.forshee@canonical.com>
Acked-by: Seth Forshee <seth.forshee@canonical.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

Sigh.  In simplifying this change so it would not require a change to
proc (or any other similar filesystem) I accidentally introduced some
badly placed semicolons.  The kbuild test robot was very nice and found
those for me.  Resend with those unnecessary semicolons removed.

 fs/attr.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 12ffdb6fb63c..d0b4d34878fb 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -18,6 +18,32 @@
 #include <linux/evm.h>
 #include <linux/ima.h>
 
+static bool chown_ok(const struct inode *inode, kuid_t uid)
+{
+	if (uid_eq(current_fsuid(), inode->i_uid) &&
+	    uid_eq(uid, inode->i_uid))
+		return true;
+	if (capable_wrt_inode_uidgid(inode, CAP_CHOWN))
+		return true;
+	if (uid_eq(inode->i_uid, INVALID_UID) &&
+	    ns_capable(inode->i_sb->s_user_ns, CAP_CHOWN))
+		return true;
+	return false;
+}
+
+static bool chgrp_ok(const struct inode *inode, kgid_t gid)
+{
+	if (uid_eq(current_fsuid(), inode->i_uid) &&
+	    (in_group_p(gid) || gid_eq(gid, inode->i_gid)))
+		return true;
+	if (capable_wrt_inode_uidgid(inode, CAP_CHOWN))
+		return true;
+	if (gid_eq(inode->i_gid, INVALID_GID) &&
+	    ns_capable(inode->i_sb->s_user_ns, CAP_CHOWN))
+		return true;
+	return false;
+}
+
 /**
  * setattr_prepare - check if attribute changes to a dentry are allowed
  * @dentry:	dentry to check
@@ -52,17 +78,11 @@ int setattr_prepare(struct dentry *dentry, struct iattr *attr)
 		goto kill_priv;
 
 	/* Make sure a caller can chown. */
-	if ((ia_valid & ATTR_UID) &&
-	    (!uid_eq(current_fsuid(), inode->i_uid) ||
-	     !uid_eq(attr->ia_uid, inode->i_uid)) &&
-	    !capable_wrt_inode_uidgid(inode, CAP_CHOWN))
+	if ((ia_valid & ATTR_UID) && !chown_ok(inode, attr->ia_uid))
 		return -EPERM;
 
 	/* Make sure caller can chgrp. */
-	if ((ia_valid & ATTR_GID) &&
-	    (!uid_eq(current_fsuid(), inode->i_uid) ||
-	    (!in_group_p(attr->ia_gid) && !gid_eq(attr->ia_gid, inode->i_gid))) &&
-	    !capable_wrt_inode_uidgid(inode, CAP_CHOWN))
+	if ((ia_valid & ATTR_GID) && !chgrp_ok(inode, attr->ia_gid))
 		return -EPERM;
 
 	/* Make sure a caller can chmod. */
